package sri.score

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
        def projects = TProject.list(max:20, order:"desc", sort: "id")

        [projects: projects]
    }
}
