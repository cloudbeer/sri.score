package sri.score

import org.springframework.dao.DataIntegrityViolationException
import sri.score.common.Constants

import java.text.SimpleDateFormat

class TProjectController {

    static allowedMethods = [save: "POST", update: "POST", give_score_save: "POST"]
    ProjectService projectService

    def afterInterceptor = {
        flash.menu_flag = "project"
    }
    def beforeInterceptor = {
        if (!session.user) {
            redirect(action: 'to_login', controller: 'account')
            return false
        }
    }


    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {

        def q_param = [:]
        def cond = "from TProject where (creator=:uid or manager=:uid) and xtype=:type"
        int me_id = session?.user?.id ?: 0
        q_param.put("uid", me_id)
        q_param.put("type", Constants.PROJECTTYPES_TASK)

        def ds_count = TProject.executeQuery("select count(*) as cnt " + cond, q_param);
        int xcount = 0
        if (ds_count)
            xcount = ds_count[0]


        params.max = Math.min(max ?: 40, 100)
//        params.sort = "id"
//        params.order = "asc"
        [TProjectInstanceList: TProject.findAll(cond + " order by id desc", q_param, params),
                TProjectInstanceTotal: xcount]
    }

    def create() {
        [TProjectInstance: new TProject(params)]
    }

    def apply() {
        [TProjectInstance: new TProject(params)]
    }

    def save() {
        def TProjectInstance = new TProject(params)
        def formatter = new SimpleDateFormat("yyyy-MM-dd");
        if (params.end_date_temp1)
            TProjectInstance.end_date1 = formatter.parse(params.end_date_temp1)
        TProjectInstance.creator = session.user?.id ?: 0
        if (!TProjectInstance.save(flush: true)) {
            render(view: "create", model: [TProjectInstance: TProjectInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'TProject.label', default: 'TProject'), TProjectInstance.id])
        redirect(action: "show", id: TProjectInstance.id)
    }

    def save_manager() {
        def col = params.col
        def user_id = params.user_id?.toInteger()
        def project_id = params.id?.toLong()
        def xproject = TProject.get(project_id)
        //xproject.id = project_id
        if (col == "manager")
            xproject.manager = user_id
        else
            xproject.approver = user_id

        if (!xproject.save(flush: true)) {
            render 0
        } else {
            render 1
        }
    }

    def show(Long id) {
        def TProjectInstance = TProject.get(id)
        if (!TProjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TProject.label', default: 'TProject'), id])
            redirect(action: "list")
            return
        }

        def tasks_query = TIssue.where { project_id == id };
        def tasks = tasks_query.list(sort: "score", order: "desc")

        [TProjectInstance: TProjectInstance, tasks: tasks]
    }

    def edit(Long id) {
        def TProjectInstance = TProject.get(id)
        if (!TProjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TProject.label', default: 'TProject'), id])
            redirect(action: "list")
            return
        }

        [TProjectInstance: TProjectInstance]
    }

    def update(Long id, Long version) {
        def TProjectInstance = TProject.get(id)
        if (!TProjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TProject.label', default: 'TProject'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (TProjectInstance.version > version) {
                TProjectInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'TProject.label', default: 'TProject')] as Object[],
                        "Another user has updated this TProject while you were editing")
                render(view: "edit", model: [TProjectInstance: TProjectInstance])
                return
            }
        }

        TProjectInstance.properties = params

        if (!TProjectInstance.save(flush: true)) {
            render(view: "edit", model: [TProjectInstance: TProjectInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'TProject.label', default: 'TProject'), TProjectInstance.id])
        redirect(action: "show", id: TProjectInstance.id)
    }

    def delete(Long id) {
        def TProjectInstance = TProject.get(id)
        if (!TProjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TProject.label', default: 'TProject'), id])
            redirect(action: "list")
            return
        }

        def onIssue = TIssue.findByProject_id(id)
        if (onIssue) {
            flash.message = "此任务包存在子任务，不能被删除"
            redirect(action: "show", id: id)
            return
        }

        try {
            TProjectInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'TProject.label', default: 'TProject'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'TProject.label', default: 'TProject'), id])
            redirect(action: "show", id: id)
        }
    }

    def save_approve(long project_id, String a_comment, int a_status) {
        def xproject = TProject.get(project_id)
        if ((xproject.pre_score ?: 0) <= 0) {
            render "该任务没有子任务，无法审批"
            return
        }
        def formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String s_date = formatter.format(new Date());
        String xres = "审批未通过"
        if (a_status > 0) {
            xproject.xstatus = Constants.PROJECTSTATUS_APPROVED
            xres = "审批通过"
        }
        xproject.comment += "<div class='a_comment'>" + a_comment + " [" + xres + "-" + s_date + "]" + "</div>"

        xproject.save()
        TIssue.executeUpdate("update TIssue set xstatus=:sts where project_id=:pid", [sts: Constants.PROJECTSTATUS_APPROVED, pid: project_id])
        render 1

    }

    def save_score(long project_id, String a_comment, int a_status) {
        projectService.give_score(project_id, a_comment, a_status, session.user?.id)
        render 1
    }

    def set_finish(long id) {
        def project = TProject.get(id)
        if (project) {
            project.xstatus = Constants.PROJECTSTATUS_FINISHED
            project.end_date2 = new Date()
            project.save()
            TIssue.executeUpdate("update TIssue set xstatus=:sts where project_id=:pid", [sts: Constants.PROJECTSTATUS_FINISHED, pid: id])

        }
        render 1
    }

    def give_score(long id) {
        if (!session.user.is_admin() && !session.user.is_approver()) {
            flash.message = "您没有权限进行此操作"
            return redirect(controller: "message", action: "tips")
        }
        def TProjectInstance = TProject.get(id)
        def canScore = TProjectInstance.xstatus == Constants.PROJECTSTATUS_FINISHED && (session.user.is_admin() || TProjectInstance.is_approver(session.user))
        if (!canScore) {
            flash.message = "该任务包不能被您操作"
            return redirect(controller: "message", action: "tips")
        }

        [TProjectInstance: TProjectInstance, tasks: TIssue.findAllByProject_id(id)]
    }

    def give_score_save(long id) {
        if (!session.user.is_admin() && !session.user.is_approver()) {
            flash.message = "您没有权限进行此操作"
            return redirect(controller: "message", action: "tips")
        }
        def TProjectInstance = TProject.get(id)
        def canScore = TProjectInstance.xstatus == Constants.PROJECTSTATUS_FINISHED && (session.user.is_admin() || TProjectInstance.is_approver(session.user))
        if (!canScore) {
            flash.message = "该任务包不能被您操作"
            return redirect(controller: "message", action: "tips")
        }



        try {
            projectService.give_score_custom(id, session.user.id, params)
        }
        catch (e) {
            //throw e
            flash.message = e.cause.message
            return redirect(controller: "message", action: "tips")
        }

        flash.message = "发分完成"
        return redirect(controller: "message", action: "tips")
    }

    def test() {
        projectService.test()
        render 1
    }
}
