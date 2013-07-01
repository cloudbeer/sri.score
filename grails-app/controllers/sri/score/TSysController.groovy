package sri.score

import sri.score.common.Constants
import sri.score.common.Helper

class TSysController {
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

        [TProjectInstanceList: TProject.findAll(cond, q_param, [max: 500, order: "asc", sort: "code"]),
                TProjectInstanceTotal: xcount]

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
            TProjectInstance = TProject.get(params.id)
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

        render 0
        return
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
}

