package sri.score

import sri.score.common.Constants

class HomeController {

    def afterInterceptor = {
        flash.menu_flag="home"
    }
    def beforeInterceptor ={
        if (!session.user) {
            redirect(action: 'login', controller: 'account')
            return false
        }
    }


    def browse() {
        def projects = TProject.findAllByXtype(Constants.PROJECTTYPES_TASK , [max:40, order:"desc", sort: "id"])
        def top10Users = TUser.list([max:10, sort:'score', order: 'desc'])

        def cal = Calendar.getInstance()


        [projects: projects, top10Users:top10Users]
    }
}
