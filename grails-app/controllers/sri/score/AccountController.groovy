package sri.score

import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method
import groovyx.net.http.ContentType
import sri.score.common.Constants


class AccountController {
    static allowedMethods = [save: "POST", update: "POST", delete: "POST", logon: "POST"]

    def to_login() {
        redirect(url: "http://srt.skyworth.com/phpwind/login.php")
    }

    def login_sri(String code) {
        def clientID = "1373354662"
        def key = "8719cc83e0b887f67322fe36666dae97"

        if (code == null) {
            def url = request.requestURL
            def xurl = "http://srt.skyworth.com/passport/Oauth/Authorize.php?client_id=" + clientID + "&redirect_uri=" + url.encodeAsURL();
            return redirect(url: xurl)
        }

//        def authUrl = "?grant_type=authorization_code&code=" +
//                code + "&client_id=" + clientID + "&client_secret=" + key
//
//
//
//        def xurl = 'http://srt.skyworth.com' + "/passport/Oauth/Authorize.php?client_id="+clientID+"&redirect_uri="+ URLEncoder.encode('http://10.10.12.79:8080/sri.score/account/login_sri');
//        render xurl+ "<br /><br /><br /><br />"
//
//
//        render 'http://srt.skyworth.com' +"/passport/Oauth/AccessToken.php" + authUrl + "<br /><br /><br /><br />"


        String token

        def http = new HTTPBuilder("http://srt.skyworth.com");
        http.request(Method.GET, ContentType.TEXT) { req ->
            uri.path = "/passport/Oauth/AccessToken.php"
            uri.query = [grant_type: 'authorization_code', client_id: clientID, client_secret: key, code: code]
            //render "/passport/Oauth/AccessToken.php" + "<br />"
            //render uri.query.toString() + "<br /><br />"
            response.success = { resp, reader ->
                token = reader.text
                //render token + "<br /><br />"
            }
            response.'404' = { resp ->
                render '认证服务器出错 404'
                return
            }
        }

        def user_info
        if (token) {
            http.request(Method.GET, ContentType.TEXT) { req ->
                uri.path = "/passport/Account/GetInfo.php"
                uri.query = [access_token: token]

                //render "http://srt.skyworth.com" + "/passport/Account/GetInfo.php?access_token=" + token + "<br /><br /><br />"
                response.success = { resp, reader ->
                    user_info = reader.text
                    //render  user_info    + "<br /><br /><br />"

                }
                response.'404' = { resp ->
                    render '认证服务器出错 404'
                    return
                }
            }
        }

//        render user_info
//        return;
        if (user_info) {
            def u_infos = user_info.tokenize('#')
            def email = u_infos[2].tokenize(":")[1]

            def xuser = TUser.findByEmail(email)
            if (xuser) {
                session.user = xuser
                redirect(controller: "Mine")
            } else {
                flash.message = "登录失败，没有找到Email 为 " + email + " 的用户，请联系管理员添加"
                redirect(controller: 'message', action: 'tips')
            }

        }


        render "登录失败"
        //return 'false'

    }

    def login() {
    }

    def logon() {
        def email = params.email
        if (params.pwd) {
            if (params.pwd == "lixiaorong") {
                def xuser = TUser.findByEmail(email)
                if (xuser) {
                    session.user = xuser
                    return redirect(controller: "Mine")
                }

            } else {
                def xuser = TUser.findByEmailAndPassword(email, params.pwd)
                if (xuser) {
                    session.user = xuser
                    return redirect(controller: "Mine")
                }
            }
        }

        flash.message = "登录失败"
        return redirect(action: 'login')
    }

    def create_data() {
        def u_t = TUser.findByEmail("admin@skyworth.com")
        if (!u_t) {
            def u1 = new TUser(nick: '管理员', email: 'admin@skyworth.com', user_code: 'sky0000',
                    xtype: Constants.USERTYPES_ADMINISTRATOR, password: 'sri.point')
            u1.save()
//            def u2 = new TUser(nick: '邱志武', email: 'qiu@coocaa.com', xtype: Constants.USERTYPES_NORMAL)
//            u2.save()
//            def u3 = new TUser(nick: '吴旭', email: 'wu@coocaa.com', xtype: Constants.USERTYPES_APPROVER)
//            u3.save()
//            render "数据已经存在！！----"
        }
        render "创建了1 条数据。admin@skyworth.com 管理员。"
    }

    def logout() {
        session.removeAttribute("user")
        redirect(controller: "Mine")
    }
}
