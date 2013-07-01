package sri.score

import sri.score.common.Constants

class AccountController {
    static allowedMethods = [save: "POST", update: "POST", delete: "POST", logon: "POST"]


    def login() {
    }

    def logon() {
        def email = params.email
        def xuser = TUser.findByEmail(email)
        if (xuser) {
            session.user = xuser
            redirect(controller: "Mine")
        } else {
            flash.message = "登录失败"
            redirect(action: 'login')
        }
    }

    def create_data() {
        def u_t = TUser.findByEmail("xie@coocaa.com")
        if (!u_t) {
            def u1 = new TUser(nick: '谢正伟', email: 'xie@coocaa.com', xtype: Constants.USERTYPES_ADMINISTRATOR)
            u1.save()
            def u2 = new TUser(nick: '邱志武', email: 'qiu@coocaa.com', xtype: Constants.USERTYPES_NORMAL)
            u2.save()
            def u3 = new TUser(nick: '吴旭', email: 'wu@coocaa.com', xtype: Constants.USERTYPES_APPROVER)
            u3.save()
            render "数据已经存在！！----"
        }
        render "创建了3 条数据。   xie@coocaa.com - USERTYPES_ADMINISTRATOR  和 qiu@coocaa.com  -- USERTYPES_NORMAL  和 wu@coocaa.com --USERTYPES_APPROVER"
    }

    def logout() {
        session.removeAttribute("user")
        redirect(controller: "Mine")
    }
}
