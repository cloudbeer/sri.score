package sri.score

import org.springframework.dao.DataIntegrityViolationException
import sri.score.common.Constants

import java.text.SimpleDateFormat

class TProjectController {

    static allowedMethods = [save: "POST", update: "POST"]
    ProjectService projectService

    def afterInterceptor = {
        flash.menu_flag = "project"
    }
    def beforeInterceptor = {
        if (!session.user) {
            redirect(action: 'login', controller: 'account')
            return false
        }
    }


    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {

        def q_param = [:]
        def cond = "from TProject as ti where (ti.creator=:uid or ti.manager=:uid) and xtype=:type"
        int me_id = session?.user?.id ?: 0
        q_param.put("uid", me_id)
        q_param.put("type", Constants.PROJECTTYPES_TASK)

        def ds_count = TProject.executeQuery("select count(*) as cnt " + cond, q_param);
        int xcount = 0
        if (ds_count)
            xcount = ds_count[0]


        params.max = Math.min(max ?: 10, 100)
        [TProjectInstanceList: TProject.findAll(cond, q_param, [max: 50, order: "desc", sort: "id"]),
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
        TProjectInstance.end_date1 = Date.parse("y-M-d", params.end_date_temp1)
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
        def formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String s_date = formatter.format(new Date());
        String xres = "审批未通过"
        if (a_status > 0) {
            xproject.xstatus = Constants.PROJECTSTATUS_APPROVED
            xres = "审批通过"
        }
        xproject.comment += "<div class='a_comment'>" + a_comment + " [" + xres + "-" + s_date + "]" + "</div>"

        xproject.save()
        render 1

    }

    def save_score(long project_id, String a_comment, int a_status) {
        projectService.give_score(project_id, a_comment, a_status, session.user?.id)
        render 1
    }

    def set_finish(long id) {
        def project = TProject.get(id)
        if (project) {
            project.end_date2 = new Date()
            project.save()
        }
        render 1
    }

    def test() {
        projectService.test()
        render 1
    }
}
