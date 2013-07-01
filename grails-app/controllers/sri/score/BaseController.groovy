package sri.score


class BaseController {

//    def beforeInterceptor ={
//        if (!session.user) {
//            redirect(action: 'login', controller: 'account')
//            return false
//        }
//    }

    def auth(){
        if (!session.user) {
            redirect(action: 'login', controller: 'account')
            return false
        }
    }

}
