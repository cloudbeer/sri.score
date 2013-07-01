package sri.score

import org.springframework.dao.DataIntegrityViolationException

class TGroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def beforeInterceptor ={
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
        flash.menu_flag="sys"
    }
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [TGroupInstanceList: TGroup.list(params), TGroupInstanceTotal: TGroup.count()]
    }

    def create() {
        [TGroupInstance: new TGroup(params)]
    }

    def save() {
        def TGroupInstance = new TGroup(params)
        if (!TGroupInstance.save(flush: true)) {
            render(view: "create", model: [TGroupInstance: TGroupInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'TGroup.label', default: 'TGroup'), TGroupInstance.id])
        redirect(action: "show", id: TGroupInstance.id)
    }

    def show(Long id) {
        def TGroupInstance = TGroup.get(id)
        if (!TGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TGroup.label', default: 'TGroup'), id])
            redirect(action: "list")
            return
        }

        [TGroupInstance: TGroupInstance]
    }

    def edit(Long id) {
        def TGroupInstance = TGroup.get(id)
        if (!TGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TGroup.label', default: 'TGroup'), id])
            redirect(action: "list")
            return
        }

        [TGroupInstance: TGroupInstance]
    }

    def update(Long id, Long version) {
        def TGroupInstance = TGroup.get(id)
        if (!TGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TGroup.label', default: 'TGroup'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (TGroupInstance.version > version) {
                TGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'TGroup.label', default: 'TGroup')] as Object[],
                          "Another user has updated this TGroup while you were editing")
                render(view: "edit", model: [TGroupInstance: TGroupInstance])
                return
            }
        }

        TGroupInstance.properties = params

        if (!TGroupInstance.save(flush: true)) {
            render(view: "edit", model: [TGroupInstance: TGroupInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'TGroup.label', default: 'TGroup'), TGroupInstance.id])
        redirect(action: "show", id: TGroupInstance.id)
    }

    def delete(Long id) {
        def TGroupInstance = TGroup.get(id)
        if (!TGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TGroup.label', default: 'TGroup'), id])
            redirect(action: "list")
            return
        }

        try {
            TGroupInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'TGroup.label', default: 'TGroup'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'TGroup.label', default: 'TGroup'), id])
            redirect(action: "show", id: id)
        }
    }
}
