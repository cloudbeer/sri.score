package sri.score

import org.springframework.dao.DataIntegrityViolationException

class TProjectController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [TProjectInstanceList: TProject.list(params), TProjectInstanceTotal: TProject.count()]
    }

    def create() {
        [TProjectInstance: new TProject(params)]
    }

    def apply(){
        [TProjectInstance: new TProject(params)]
    }

    def save() {
        def TProjectInstance = new TProject(params)
        if (!TProjectInstance.save(flush: true)) {
            render(view: "create", model: [TProjectInstance: TProjectInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'TProject.label', default: 'TProject'), TProjectInstance.id])
        redirect(action: "show", id: TProjectInstance.id)
    }

    def show(Long id) {
        def TProjectInstance = TProject.get(id)
        if (!TProjectInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TProject.label', default: 'TProject'), id])
            redirect(action: "list")
            return
        }

        [TProjectInstance: TProjectInstance]
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
}
