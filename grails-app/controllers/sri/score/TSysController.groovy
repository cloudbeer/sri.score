package sri.score

import grails.converters.JSON
import jxl.Cell
import jxl.Sheet
import jxl.Workbook
import sri.score.common.Constants
import sri.score.common.Helper

class TSysController {
    HelperService helperService

    def beforeInterceptor = {
        if (!session.user) {
            redirect(action: 'login', controller: 'account')
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
                    prep_dict.put("code", code)
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
            throw e
            //flash.message = e.dump() + ".."
        }
        return redirect(controller: "Message", action: "tips")


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
        def q_param = [:]
        def cond = "from TProject as ti where xtype=:type"
        q_param.put("type", Constants.PROJECTTYPES_STATIC)

        [projects: TProject.findAllByXtype(Constants.PROJECTTYPES_STATIC, [sort: "code"])]
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
        for (rowIndex in 3..rowCount - 1) {
            //render rowIndex
            try {
                def prep_dict = [:]
                def nick = sheet.getCell(5, rowIndex).getContents()
                def user_code = sheet.getCell(6, rowIndex).getContents()
                def email = sheet.getCell(7, rowIndex).getContents()
                def level = sheet.getCell(8, rowIndex).getContents()
                if (user_code && nick && email && level) {
                    if (email.endsWith("@")) {
                        email = email + "skyworth.com"
                    }
                    prep_dict.put("user_code", user_code)
                    prep_dict.put("nick", nick)
                    prep_dict.put("email", email)
                    prep_dict.put("user_name", email)
                    prep_dict.put("level", level.toInteger())
                    all.add(prep_dict)
                }
            } catch (e) {

            }
        }

//        render all as JSON
//        return
        helperService.import_users(all)
        flash.message = "用户导入成功"
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
        sb.append("<tr><td class='key'>将要发生的</td><td class='value'>" +p.title + "</td></tr>")
        sb.append("<tr><td class='key'>分数</td><td class='value'>" +my_score.score + "</td></tr>")
        sb.append("</table>")

        render sb

    }

}

