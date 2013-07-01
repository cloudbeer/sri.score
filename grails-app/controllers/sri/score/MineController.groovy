package sri.score

import sri.score.common.Constants

class MineController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", logon: "POST"]

    def afterInterceptor = {
    }
    def beforeInterceptor = {
        if (!session.user) {
            redirect(action: 'login', controller: 'account')
            return false
        }
        flash.menu_flag = "project"
    }


    def index() {
        def q_param = [:]
        def cond = "from TIssue as ti where ti.user_id=:uid and xtype=:type"
        int me_id = session.user?.id ?: 0
        q_param.put("uid", me_id)
        q_param.put("type", Constants.PROJECTTYPES_TASK)

        flash.menu_flag = "mine"
        def mytasks = TIssue.findAll(cond, q_param, [max: 20, sort: "id", order: 'desc'])
        def approve_count = TProject.countByApproverAndXstatusAndXtype(me_id, Constants.PROJECTSTATUS_OUTSTANDING, Constants.PROJECTTYPES_TASK);



        def q_param_project = [:]
        def cond_project = "from TProject as ti where (ti.creator=:uid or ti.manager=:uid) and xtype=:type"
        q_param_project.put("uid", me_id)
        q_param_project.put("type", Constants.PROJECTTYPES_TASK)
        def myprojects = TProject.findAll(cond_project, q_param_project, [max: 50, order: "desc", sort: "id"]);

        def myissues = TIssue.findAllByUser_idAndXstatusAndScoreGreaterThanEquals(me_id, Constants.PROJECTSTATUS_SCORED, 0, [max:20, sort:"id", order:"desc"])
        def myissues_minus = TIssue.findAllByUser_idAndXstatusAndScoreLessThan(me_id, Constants.PROJECTSTATUS_SCORED, 0, [max:20, sort:"id", order:"desc"])



        [mytasks: mytasks, approve_count: approve_count, myprojects: myprojects,myissues:myissues, myissues_minus:myissues_minus]
    }


    def tasks(Integer max) {
        def q_param = [:]
        def cond = "from TIssue as ti where ti.user_id=:uid and xtype=:type"
        int me_id = session?.user?.id ?: 0
        q_param.put("uid", me_id)
        q_param.put("type", Constants.PROJECTTYPES_TASK)

        max = Math.min(max ?: 10, 100)

        [TIssueInstanceList: TIssue.findAll(cond, q_param, [max: max, sort: "id", order: 'desc']),
                TIssueInstanceTotal: TIssue.countByUser_id(me_id)]
    }

    def query_user(String q, int tp) {
        def q_param = [:]
        def cond = "from TUser as u where 1=1"
        if (q?.length() > 0) {
            cond += " and (u.nick like :q or u.email like :q)"
            q_param.put("q", '%' + q + '%')
        }
        if (tp > 0) {
            cond += " and u.xtype>=:tp"
            q_param.put("tp", tp)
        }
        def mUsers = TUser.findAll(cond, q_param, [max: 50]);
        StringBuilder sb = new StringBuilder();
        mUsers.each { xuser ->
            sb.append("<span rel='" + xuser.id + "'>")
            sb.append(xuser.nick)
            sb.append("</span>")
        }
        render sb
    }

    def approve_list(){
        int me_id = session.user?.id ?: 0
        def TProjectInstanceList = TProject.findAllByApproverAndXtypeAndXstatus(me_id, Constants.PROJECTTYPES_TASK, Constants.PROJECTSTATUS_OUTSTANDING)
        [TProjectInstanceList:TProjectInstanceList]
    }

}