package sri.score

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class TGroupController {

    HelperService helperService
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

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

    def index() {
        redirect(action: "list", params: params)
    }


    def list() {
        def groups = TGroup.list()
        def rtn = new StringBuilder()
        recursionGroupHtml(groups, 0, rtn)
        [groupHTML: rtn]
    }

    private void recursionGroupHtml(List<TGroup> groups, int parent_id, StringBuilder container) {
        def myLevels = groups.findAll { grp ->
            grp.parent_id == parent_id
        }
        //throw new Exception(""+myLevels.size())

        if (myLevels.size() > 0) {
            myLevels.each { grp ->
                //myLevels.title = myLevels
                container.append("<ul>")
                container.append("<li data-id='" + grp.id + "'>")
                container.append("<span class='grp_name'>"+grp.title+"</span>")
                container.append("<div class='btn-group'>")
                container.append("<a href='" + createLink(action: "create", id: grp.id) + "' class='btn btn-small'>创建子部门</a>")
                container.append("<a href='" + createLink(action: "edit", id: grp.id) + "' class='btn btn-small'>修改</a>")
                //container.append("<a href='#' class='btn btn-small btn-danger delete_group'>删除</a>")
                container.append("</div>")
                container.append("</li>")
                recursionGroupHtml(groups, grp.id, container)
                container.append("</ul>")
            }
        }
    }
    def create(int id) {
        def grp = new TGroup(params)
        grp.parent_id = id ?: 0
        [TGroupInstance: grp]
    }

    def save() {
        def TGroupInstance = new TGroup(params)
        if (!TGroupInstance.save(flush: true)) {
            render(view: "create", model: [TGroupInstance: TGroupInstance])
            return
        }

        redirect(action: "list")
//        flash.message = message(code: 'default.created.message', args: [message(code: 'TGroup.label', default: 'TGroup'), TGroupInstance.id])
//        redirect(action: "show", id: TGroupInstance.id)
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

        redirect(action: "list")
//        flash.message = message(code: 'default.updated.message', args: [message(code: 'TGroup.label', default: 'TGroup'), TGroupInstance.id])
//        redirect(action: "show", id: TGroupInstance.id)
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
