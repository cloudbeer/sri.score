package sri.score

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class TIssueController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def beforeInterceptor = {
        if (!session.user) {
            redirect(action: 'login', controller: 'account')
            return false
        }
    }
    def afterInterceptor = {
        flash.menu_flag = "sys"
    }

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [TIssueInstanceList: TIssue.list(params), TIssueInstanceTotal: TIssue.count()]
    }

    def create() {
        [TIssueInstance: new TIssue(params)]
    }

    def save() {
        def TIssueInstance = new TIssue(params)
        if (!TIssueInstance.save(flush: true)) {
            render(view: "create", model: [TIssueInstance: TIssueInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'TIssue.label', default: 'TIssue'), TIssueInstance.id])
        redirect(action: "show", id: TIssueInstance.id)
    }

    def save_task() {
        def TIssueInstance
        def xid = params.id?.toLong()
        if (xid > 0) {
            TIssueInstance = TIssue.get(xid)
            TIssueInstance.updater = session?.user?.id ?: 0
            TIssueInstance.update_date = new Date()
            TIssueInstance.properties = params
        } else {
            TIssueInstance = new TIssue(params)
            TIssueInstance.creator = session.user?.id ?: 0
        }


        if (!TIssueInstance.save(flush: true)) {
            render 0
            return
        }
        TProject.executeUpdate("update TProject set pre_score=(select sum(score) from TIssue where project_id=?) where id=?",
                [TIssueInstance.project_id, TIssueInstance.project_id])
        render 1

    }

    def remove_task() {
        def task_id = params.task_id?.toLong()
        def TIssueInstance = TIssue.get(task_id)
        try {
            TIssueInstance.delete(flush: true)
            TProject.executeUpdate("update TProject set pre_score=(select sum(score) from TIssue where project_id=?) where id=?",
                    [TIssueInstance.project_id, TIssueInstance.project_id])
            render 1
            return

        } catch (Exception ex) {
        }
        render 0

    }


    def show(Long id) {
        def TIssueInstance = TIssue.get(id)
        if (!TIssueInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TIssue.label', default: 'TIssue'), id])
            redirect(action: "list")
            return
        }

        [TIssueInstance: TIssueInstance]
    }

    def edit(Long id) {
        def TIssueInstance = TIssue.get(id)
        if (!TIssueInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TIssue.label', default: 'TIssue'), id])
            redirect(action: "list")
            return
        }

        [TIssueInstance: TIssueInstance]
    }

    def update(Long id, Long version) {
        def TIssueInstance = TIssue.get(id)
        if (!TIssueInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TIssue.label', default: 'TIssue'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (TIssueInstance.version > version) {
                TIssueInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'TIssue.label', default: 'TIssue')] as Object[],
                        "Another user has updated this TIssue while you were editing")
                render(view: "edit", model: [TIssueInstance: TIssueInstance])
                return
            }
        }

        TIssueInstance.properties = params

        if (!TIssueInstance.save(flush: true)) {
            render(view: "edit", model: [TIssueInstance: TIssueInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'TIssue.label', default: 'TIssue'), TIssueInstance.id])
        redirect(action: "show", id: TIssueInstance.id)
    }

    def delete(Long id) {
        def TIssueInstance = TIssue.get(id)
        if (!TIssueInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TIssue.label', default: 'TIssue'), id])
            redirect(action: "list")
            return
        }

        try {
            TIssueInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'TIssue.label', default: 'TIssue'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'TIssue.label', default: 'TIssue'), id])
            redirect(action: "show", id: id)
        }
    }

    def get_task(long task_id) {
        def task = TIssue.get(task_id)
        def xuser = TUser.get(task.user_id)
        def res = [title: task.title, score: task.score, user_id: task.user_id, nick: xuser.nick]
        render res as JSON
    }
}
