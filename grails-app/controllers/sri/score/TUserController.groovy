package sri.score

import org.springframework.dao.DataIntegrityViolationException

class TUserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

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

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [TUserInstanceList: TUser.list(params), TUserInstanceTotal: TUser.count()]
    }

    def create() {
        [TUserInstance: new TUser(params)]
    }

    def save() {
        def TUserInstance = new TUser(params)
        TUserInstance.creator = session.user?.id?:0
        if (!TUserInstance.save(flush: true)) {
            render(view: "create", model: [TUserInstance: TUserInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'TUser.label', default: 'TUser'), TUserInstance.id])
        redirect(action: "show", id: TUserInstance.id)
    }

    def set_type(int id, int type) {
        def TUserInstance = TUser.get(id)
        TUserInstance.updater = session.user?.id?:0
        TUserInstance.xtype = type
        try {
            TUserInstance.save()
            render 1
            return
        } catch (Exception ex) {

        }
        return 0
    }

    def show(Long id) {
        def TUserInstance = TUser.get(id)
        if (!TUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TUser.label', default: 'TUser'), id])
            redirect(action: "list")
            return
        }

        [TUserInstance: TUserInstance]
    }

    def edit(Long id) {
        def TUserInstance = TUser.get(id)
        if (!TUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TUser.label', default: 'TUser'), id])
            redirect(action: "list")
            return
        }

        [TUserInstance: TUserInstance]
    }

    def update(Long id, Long version) {
        def TUserInstance = TUser.get(id)
        if (!TUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TUser.label', default: 'TUser'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (TUserInstance.version > version) {
                TUserInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'TUser.label', default: 'TUser')] as Object[],
                        "Another user has updated this TUser while you were editing")
                render(view: "edit", model: [TUserInstance: TUserInstance])
                return
            }
        }

        TUserInstance.properties = params

        if (!TUserInstance.save(flush: true)) {
            render(view: "edit", model: [TUserInstance: TUserInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'TUser.label', default: 'TUser'), TUserInstance.id])
        redirect(action: "show", id: TUserInstance.id)
    }

    def delete(Long id) {
        def TUserInstance = TUser.get(id)
        if (!TUserInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TUser.label', default: 'TUser'), id])
            redirect(action: "list")
            return
        }

        try {
            TUserInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'TUser.label', default: 'TUser'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'TUser.label', default: 'TUser'), id])
            redirect(action: "show", id: id)
        }
    }

}
