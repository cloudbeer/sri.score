package sri.score

import grails.converters.JSON
import jxl.Cell
import jxl.Sheet
import jxl.Workbook
import sri.score.common.Constants
import sri.score.common.Helper

import java.text.SimpleDateFormat

class TSysController {
    HelperService helperService

    def beforeInterceptor = {
        if (!session.user) {
            redirect(action: 'to_login', controller: 'account')
            return false
        }
        if (!session.user.is_admin()) {
            flash.tips_title = "权限不足"
            flash.message = "请确认您是否有权限，如果有问题请联系管理员。"
            redirect(action: 'tips', controller: 'message')
            //throw new Exception("没有权限")
            //render "没有权限"
            return false
        }
    }
    def afterInterceptor = {
        flash.menu_flag = "sys"
    }

    def index() {}

    def projects() {
        def q_param = [:]
        def cond = "from TProject as ti where xtype=:type"
        q_param.put("type", Constants.PROJECTTYPES_STATIC)


        def ds_count = TProject.executeQuery("select count(*) as cnt " + cond, q_param);
        int xcount = 0
        if (ds_count)
            xcount = ds_count[0]

        params.max = 20
        params.order = 'asc'
        params.order = 'code'

        def allScores = TLevelProjectScore.list()

        [TProjectInstanceList: TProject.findAll(cond, q_param, params),
                TProjectInstanceTotal: xcount, allScores: allScores]

    }

    def create_project() {
        if (params.id) {
            [TProjectInstance: TProject.get(params.id)]
        } else {
            [TProjectInstance: new TProject()]
        }
    }

    def save_project() {

        def TProjectInstance
        def xid = params.id?.toLong()
        if (xid > 0) {
            TProjectInstance = TProject.get(xid)
            TProjectInstance.updater = session?.user?.id ?: 0
            TProjectInstance.update_date = new Date()
            TProjectInstance.properties = params
        } else {
            TProjectInstance = new TProject(params)
            TProjectInstance.creator = session.user?.id ?: 0
        }
        if (!TProjectInstance.save(flush: true)) {
            render(view: "create_project", model: [TProjectInstance: TProjectInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'TProject.label', default: 'TProject'), TProjectInstance.title])
        redirect(action: "projects")
    }

    def delete_project(long id) {
        if (id > 0) {
            TLevelProjectScore.executeUpdate("delete from TLevelProjectScore where project_id=" + id)
            TProject.executeUpdate("delete from TProject where id=" + id)
        }

        render "1"
    }

    def project_score(long id) {
        def levels = TLevel.list([order: 'asc', sort: 'min_score'])
        //[TProjectInstance: TProject.get(id), levels: levels]
        def project_level_scores = TLevelProjectScore.findAllByProject_id(id)
        //render project_level_scores.length()
        [TProjectInstance: TProject.get(id), levels: levels, project_level_scores: project_level_scores]

    }

    def project_score_save(long id) {
        def scores = params.xscore
        def level_ids = params.xlevel_id
        scores.eachWithIndex { obj, i ->
            int score = obj.toInteger()
            int level_id = level_ids[i].toInteger()

            TLevelProjectScore level = TLevelProjectScore.findByProject_idAndLevel_id(id, level_id)
            if (!level) {
                level = new TLevelProjectScore()
                level.level_id = level_id
                level.project_id = id
            }
            level.score = score
            level.save()
        }
        redirect(action: "projects")
    }

    def import_attendance() {
        def cal = Calendar.getInstance()

        [year: cal.get(Calendar.YEAR)]

    }

    def save_attendance_excel() {
        int year = params.xyear?.toInteger()
        int month = params.xmonth?.toInteger()

        Calendar cal = Calendar.getInstance()
        def nowYear = cal.get(Calendar.YEAR)

        if (TIssue.findByXtypeAndTitleLike(Constants.PROJECTTYPES_ATTENDANCE, "%" + year + "-" + month + "%")) {
            flash.message = "指定的日期的记录已经存在"
            return redirect(controller: "Message", action: "tips")

        }

        if (!year || !month) {
            flash.message = "必须指定年和月"
            return redirect(controller: "Message", action: "tips")
        }

        if (nowYear - year > 1 || nowYear < year) {
            flash.message = "错误的年份，您最多能倒入去年的记录。"
            return redirect(controller: "Message", action: "tips")
        }
        if (month > 12 || month < 1) {
            flash.message = "错误的月份"
            return redirect(controller: "Message", action: "tips")
        }

        def f = request.getFile("xlsFile")
        if (f.empty) {
            flash.message = '必须输入一个符合格式的 Excel 文件。'
            redirect(action: "import_attendance")
            return
        }

        Workbook workbook = Workbook.getWorkbook(f.getInputStream())
        Sheet sheet = workbook.getSheet(0);
        int rowCount = sheet.getRows()

        def all = []
        for (rowIndex in 2..rowCount - 1) {
            try {
                def prep_dict = [:]
                def code = sheet.getCell(1, rowIndex).getContents()
                //def nick = sheet.getCell(2, rowIndex).getContents()
                def day = sheet.getCell(4, rowIndex).getContents()
                def addDay = sheet.getCell(20, rowIndex).getContents()
                //println addDay
                if (code && day) {
                    prep_dict.put("code", code?.toLowerCase())
                    //prep_dict.put("nick", nick)
                    prep_dict.put("days", day?.toBigDecimal())
                    prep_dict.put("addDays", addDay?.toBigDecimal())
                    all.add(prep_dict)
                }
            } catch (e) {
//                render e.message
//                return

            }
        }

        try {
            helperService.import_attendance(all, year, month)
            flash.message = "考勤导入成功。"
        } catch (Exception e) {
            def emsg = e.cause.message
            flash.message = emsg
            return redirect(action: "import_attendance")
        }
        return redirect(action: "listAttendance", params: [key: "" + year + "-" + month])


    }


    def init_level(Integer max, String q) {
        params.max = Math.min(max ?: 10, 100)
        params.order = "asc"
        params.sort = "score"
        def q_param = [:]
        def cond = "from TUser as u where 1=1"

        if (q?.length() > 0) {
            cond += " and (u.nick like :q or u.email like :q)"
            q_param.put("q", '%' + q + '%')
        }

        def levels = TLevel.findAll([order: "asc", sort: "min_score"])

        [TUserInstanceList: TUser.findAll(cond, q_param, params), TUserInstanceTotal: TUser.count(), levels: levels]

    }

    def set_level(int user_id, int level_id) {
        def level = TLevel.get(level_id)
        def user = TUser.get(user_id)
        user.score += level.min_score
        user.save()

        Helper.update_level(user)

//        render 0
//        return
        def issue = new TIssue()
        issue.score = level.min_score
        issue.title = "等级评定加分"
        issue.xtype = Constants.PROJECTTYPES_LEVEL
        issue.user_id = user.id
        issue.xstatus = Constants.PROJECTSTATUS_SCORED
        issue.save()


        render 1
    }

    def score() {
//        def q_param = [:]
//        def cond = "from TProject as ti where ti.xtype=:type and ti.code<>'Z1'"
//        q_param.put("type", Constants.PROJECTTYPES_STATIC)

        [projects: TProject.findAllByXtypeAndCodeNotEqual(Constants.PROJECTTYPES_STATIC, 'Z1', [sort: "code"])]
    }

    def score_save() {
        def user_id = params.user_id?.toInteger()
        def project_id = params.project_id?.toLong()
        def xproject = TProject.get(project_id)
        def xuser = TUser.get(user_id)
        if (xuser.level_id <= 0) {
            flash.message = "此用户没有进行等级初始化，请到”<a href='" +
                    createLink(controller: "TSys", action: "init_level", id: project_id) + "'>管理->等级初始化->...</a>“中设置用户等级。"
            return redirect(controller: "Message", action: "tips")

        }
        def x_project_score = TLevelProjectScore.findByProject_idAndLevel_id(project_id, xuser.level_id)
        if (!x_project_score) {
            flash.message = "尚未定义此用户级别的在此事物中的分值，请到”<a href='" +
                    createLink(controller: "TSys", action: "project_score", id: project_id) + "'>管理->积分条目->...</a>“中设置分值。"

            return redirect(controller: "Message", action: "tips")
        }

        xuser.score += x_project_score.score;
        xuser.save()

        Helper.update_level(xuser)

        TIssue xissue = new TIssue()
        xissue.title = "[" + xproject.code + "]" + xproject.title
        xissue.score = x_project_score.score
        xissue.description = params.remark ?: ""
        xissue.user_id = xuser.id
        xissue.xstatus = Constants.PROJECTSTATUS_SCORED
        xissue.xtype = Constants.PROJECTTYPES_STATIC
        xissue.save()

        flash.message = "更新成功。"
        return redirect(controller: "Message", action: "tips")


    }

    def temp_import() {

    }

    def save_user_excel() {
        def f = request.getFile("xlsFile")
        if (f.empty) {
            flash.message = '必须输入一个符合格式的 Excel 文件。'
            redirect(action: "temp_import")
            return
        }


        Workbook workbook = Workbook.getWorkbook(f.getInputStream())
        Sheet sheet = workbook.getSheet(0);
        int rowCount = sheet.getRows()
        def all = []
        for (rowIndex in 2..rowCount - 1) {
            //render rowIndex
            try {
                def prep_dict = [:]
                def nick = sheet.getCell(3, rowIndex).getContents()
                //def user_code = "" // sheet.getCell(6, rowIndex).getContents()
                def email = sheet.getCell(4, rowIndex).getContents()
                def level = sheet.getCell(5, rowIndex).getContents() ?: "0"
                if (nick && email) {
                    if (email.endsWith("@")) {
                        email = email + "skyworth.com"
                    }
                    prep_dict.put("user_code", null)
                    prep_dict.put("nick", nick)
                    prep_dict.put("email", email)
                    prep_dict.put("user_name", email)
                    prep_dict.put("level", level.toInteger())
                    all.add(prep_dict)
                }
            } catch (e) {
                throw e
            }
        }

//        render all as JSON
//        return
        try {
            helperService.import_users(all)
            flash.message = "用户导入成功"
        } catch (e) {
            render e as JSON
            return

            //flash.message = e.cause.message
        }
        return redirect(controller: "message", action: "tips")

    }

    def save_level_excel() {
        def f = request.getFile("xlsFile")
        if (f.empty) {
            flash.message = '必须输入一个符合格式的 Excel 文件。'
            redirect(action: "temp_import")
            return
        }


        Workbook workbook = Workbook.getWorkbook(f.getInputStream())
        Sheet sheet = workbook.getSheet(0);
        int rowCount = sheet.getRows()
        def all = []
        for (rowIndex in 4..rowCount - 1) {
            try {
                def prep_dict = [:]
                def level = sheet.getCell(3, rowIndex).getContents()
                def score = sheet.getCell(5, rowIndex).getContents().toInteger()
                if (level) {
                    prep_dict.put("flag_id", level.toInteger())
                    prep_dict.put("title", level)
                    prep_dict.put("min_score", score)
                    all.add(prep_dict)
                }
            } catch (e) {

            }
        }

        helperService.import_levels(all)
        flash.message = "等级导入成功"
        return redirect(controller: "message", action: "tips")

    }


    def save_event_score() {
        def f = request.getFile("xlsFile")
        if (f.empty) {
            flash.message = '必须输入一个符合格式的 Excel 文件。'
            redirect(action: "temp_import")
            return
        }


        Workbook workbook = Workbook.getWorkbook(f.getInputStream())
        Sheet sheet = workbook.getSheet(0);
        int rowCount = sheet.getRows()
        def all = []
        for (rowIndex in 4..rowCount - 1) {
            try {
                def prep_dict = [:]
                def level_code = sheet.getCell(2, rowIndex).getContents()
                def level_name = sheet.getCell(3, rowIndex).getContents()
                def level_desc = sheet.getCell(25, rowIndex).getContents()
                if (level_code && level_name) {
                    for (leIndex in 4..24) {
                        prep_dict.put(leIndex - 4, sheet.getCell(leIndex, rowIndex).getContents().toInteger())
                    }
                    prep_dict.put("code", level_code)
                    prep_dict.put("title", level_name)
                    prep_dict.put("description", level_desc)
                    all.add(prep_dict)
                }
            } catch (e) {

            }
        }

        helperService.import_event_score(all)
        flash.message = "综合事务积分导入成功"
        return redirect(controller: "message", action: "tips")

    }

    def save_temp_task() {
        def f = request.getFile("xlsFile")
        if (f.empty) {
            flash.message = '必须输入一个符合格式的 Excel 文件。'
            redirect(action: "temp_import")
            return
        }
        String fileName = f.originalFilename

        def formatter = new SimpleDateFormat("yyyy-MM-dd");
        def fromDate
        try {
            fromDate = formatter.parse(fileName)
        } catch (e) {
            flash.message = "错误的文件名，请重命名如：2013-07-05"
            return redirect(controller: "message", action: "tips")
        }


        Workbook workbook = Workbook.getWorkbook(f.getInputStream())
        Sheet sheet = workbook.getSheet(0);
        int rowCount = sheet.getRows()
        def p_title = sheet.getCell(0, 3).getContents()

        def zengXianhuiID = 61

        TProject project = new TProject()
        project.title = p_title
        project.manager = zengXianhuiID
        project.approver = zengXianhuiID
        project.end_date1 = fromDate
        project.end_date2 = fromDate
        project.update_date = fromDate
        project.xstatus = Constants.PROJECTSTATUS_SCORED
        project.xtype = Constants.PROJECTTYPES_TASK

        project.save()


        def projectSum = 0
        def msg = new StringBuilder()
        for (rowIndex in 3..rowCount - 1) {
            try {

                def p_nick = sheet.getCell(1, rowIndex).getContents()
                def t_title = sheet.getCell(2, rowIndex).getContents()
                def score_up = 0
                try {
                    score_up = sheet.getCell(3, rowIndex).getContents()?.toInteger() ?: 0
                } catch (e) {}
                def score_down = 0
                try {
                    score_down = sheet.getCell(4, rowIndex).getContents()?.toInteger() ?: 0
                } catch (e) {}

                def xuser = TUser.findByNick(p_nick.trim())

                if (xuser) {
                    def xsum = score_up + score_down
                    TIssue issue = new TIssue()
                    issue.project_id = project.id
                    issue.title = t_title
                    issue.score = xsum
                    projectSum += xsum
                    issue.user_id = xuser.id;
                    issue.update_date = fromDate
                    issue.pre_score = xsum
                    issue.xstatus = Constants.PROJECTSTATUS_SCORED
                    issue.xtype = Constants.PROJECTTYPES_TASK
                    issue.save()

                    xuser.score = xuser.score + xsum
                    xuser.save()
                    Helper.update_level(xuser)

                    msg.append(p_nick.trim() + " 导入成功 <br />")
                } else {
                    msg.append(p_nick.trim() + " 没有找到 <br />")
                }

            } catch (e) {
                throw e

            }

        }
        project.pre_score = projectSum
        project.save()
        msg.append("导入成功！")
        flash.message = msg.toString()
        return redirect(controller: "message", action: "tips")


    }

    def save_user_code() {
        def f = request.getFile("xlsFile")
        if (f.empty) {
            flash.message = '必须输入一个符合格式的 Excel 文件。'
            redirect(action: "temp_import")
            return
        }


        Workbook workbook = Workbook.getWorkbook(f.getInputStream())
        Sheet sheet = workbook.getSheet(0);
        int rowCount = sheet.getRows()

        for (rowIndex in 2..rowCount - 1) {
            try {
                def code = sheet.getCell(1, rowIndex).getContents()
                def name = sheet.getCell(2, rowIndex).getContents()

                def xuser = TUser.findByNick(name)
                if (xuser) {
                    xuser.user_code = code.toLowerCase()
                    xuser.save()
                }
            } catch (e) {

            }
        }
        //return
        flash.message = "员工工号更新成功"
        return redirect(controller: "message", action: "tips")

    }

    def query_pre_score(long pid, int uid) {
        StringBuilder sb = new StringBuilder()


        TUser u = TUser.get(uid)
        TProject p = TProject.get(pid)
        if (!u || !p) {
            render "错误的事物条目或者用户"
        }
        def level = TLevel.get(u.level_id)
        def my_score = TLevelProjectScore.findByProject_idAndLevel_id(pid, u.level_id)

        sb.append("<table class='show'>")
        sb.append("<tr><td class='key'>姓名</td><td class='value'>" + u.nick + "</td></tr>")
        sb.append("<tr><td class='key'>总分</td><td class='value'>" + u.score + "</td></tr>")
        sb.append("<tr><td class='key'>等级</td><td class='value'>" + level.title + "</td></tr>")
        sb.append("<tr><td class='key'>将要发生的</td><td class='value'>" + p.title + "</td></tr>")
        sb.append("<tr><td class='key'>分数</td><td class='value'>" + my_score.score + "</td></tr>")
        sb.append("</table>")

        render sb

    }

    def config() {
        def configs = TSiteConfig.list()
//        render configs
//        return
        [configs: configs]
    }

    def save_config() {

        params.each { k, v ->
            if (k.startsWith("CFG_")) {
                //String x = "1"
                def lK = k.substring(4)
                def xConfig = TSiteConfig.findByXkey(lK);
                if (!xConfig) {
                    xConfig = new TSiteConfig()
                    xConfig.xkey = lK
//                    print 'not find'
                }
                xConfig.xvalue = v
                if (!xConfig.save(flush: true)) {
                    //print 'error save'
                }
//                println lK
//                println v
            }
        }

        return redirect(action: 'config')
    }

    def listAttendance(String key) {
        if (!key) {
            Calendar cal = Calendar.getInstance();
            key = "" + cal.get(Calendar.YEAR) + '-' + cal.get(Calendar.MONTH)
            //println key
        }
        def atts = TIssue.findAllByXtypeAndTitleLike(Constants.PROJECTTYPES_ATTENDANCE, '%@' + key + '%')
        //def atts = TIssue.findAllByXtype(Constants.PROJECTTYPES_ATTENDANCE)
        [TIssueInstanceList: atts, key: key]
    }

}

