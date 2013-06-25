package sri.score

import org.springframework.dao.DataIntegrityViolationException

class TLevelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [TLevelInstanceList: TLevel.list(params), TLevelInstanceTotal: TLevel.count()]
    }

    def create() {
        [TLevelInstance: new TLevel(params)]
    }

    def save() {
        def TLevelInstance = new TLevel(params)
        if (!TLevelInstance.save(flush: true)) {
            render(view: "create", model: [TLevelInstance: TLevelInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'TLevel.label', default: 'TLevel'), TLevelInstance.id])
        redirect(action: "show", id: TLevelInstance.id)
    }

    def show(Long id) {
        def TLevelInstance = TLevel.get(id)
        if (!TLevelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TLevel.label', default: 'TLevel'), id])
            redirect(action: "list")
            return
        }

        [TLevelInstance: TLevelInstance]
    }

    def edit(Long id) {
        def TLevelInstance = TLevel.get(id)
        if (!TLevelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TLevel.label', default: 'TLevel'), id])
            redirect(action: "list")
            return
        }

        [TLevelInstance: TLevelInstance]
    }

    def update(Long id, Long version) {
        def TLevelInstance = TLevel.get(id)
        if (!TLevelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TLevel.label', default: 'TLevel'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (TLevelInstance.version > version) {
                TLevelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'TLevel.label', default: 'TLevel')] as Object[],
                          "Another user has updated this TLevel while you were editing")
                render(view: "edit", model: [TLevelInstance: TLevelInstance])
                return
            }
        }

        TLevelInstance.properties = params

        if (!TLevelInstance.save(flush: true)) {
            render(view: "edit", model: [TLevelInstance: TLevelInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'TLevel.label', default: 'TLevel'), TLevelInstance.id])
        redirect(action: "show", id: TLevelInstance.id)
    }

    def delete(Long id) {
        def TLevelInstance = TLevel.get(id)
        if (!TLevelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'TLevel.label', default: 'TLevel'), id])
            redirect(action: "list")
            return
        }

        try {
            TLevelInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'TLevel.label', default: 'TLevel'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'TLevel.label', default: 'TLevel'), id])
            redirect(action: "show", id: id)
        }
    }
}
