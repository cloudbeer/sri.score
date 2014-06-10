package sri.score

import sri.score.common.Constants

class MineController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", logon: "POST"]

    def afterInterceptor = {
    }
    def beforeInterceptor = {
        if (!session.user) {
            redirect(action: 'to_login', controller: 'account')
            return false
        }
        flash.menu_flag = "project"
    }


    def index() {
        flash.menu_flag = "mine"

        def q_param = [:]
        def cond = "from TIssue as ti where ti.user_id=:uid and ti.xtype=:type order by ti.id desc"
        int me_id = session.user?.id ?: 0
        q_param.put("uid", me_id)
        q_param.put("type", Constants.PROJECTTYPES_TASK)

        def mytasks = TIssue.findAll(cond, q_param, [max: 20])
        def approve_count = TProject.countByApproverAndXstatusAndXtype(me_id, Constants.PROJECTSTATUS_OUTSTANDING, Constants.PROJECTTYPES_TASK);
        def score_count = TProject.countByApproverAndXstatusAndXtype(me_id, Constants.PROJECTSTATUS_FINISHED, Constants.PROJECTTYPES_TASK);
        def approved_count = TProject.countByApproverAndXstatusAndXtype(me_id, Constants.PROJECTSTATUS_APPROVED, Constants.PROJECTTYPES_TASK);

        Calendar calFrom = Calendar.getInstance()
        calFrom.set(Calendar.MINUTE, 0)
        calFrom.set(Calendar.HOUR, 0)
        calFrom.set(Calendar.SECOND, 0)
        calFrom.set(Calendar.DAY_OF_MONTH, 1)

        Calendar calTo = Calendar.getInstance()
        calTo.set(Calendar.MINUTE, 0)
        calTo.set(Calendar.HOUR, 0)
        calTo.set(Calendar.SECOND, 0)
        calTo.set(Calendar.DAY_OF_MONTH, 1)
        calTo.set(Calendar.MONTH, calTo.get(Calendar.MONTH) + 1)

        def month_issues = TIssue.findAll("from TIssue as ti where ti.user_id=:uid and ti.xstatus=:status and ti.create_date>=:start_date and ti.create_date<:end_date and ti.xtype <> :attend",
                [uid: me_id, status: Constants.PROJECTSTATUS_SCORED, start_date: calFrom.getTime(), end_date: calTo.getTime(), attend:Constants.PROJECTTYPES_LEVEL])

        def score_month = month_issues.sum { obj ->
            obj.score
        }
        def score_month_minus = month_issues.findAll{obj->obj.score<0}.sum{obj->obj.score}


        def q_param_project = [:]
        def cond_project = "from TProject as ti where ti.manager=:uid and xtype=:type"
        def cond_project_i_created = "from TProject as ti where ti.creator=:uid and xtype=:type"
        q_param_project.put("uid", me_id)
        q_param_project.put("type", Constants.PROJECTTYPES_TASK)
        def myprojects = TProject.findAll(cond_project, q_param_project, [max: 50, order: "desc", sort: "id"]);
        def my_created_projects = TProject.findAll(cond_project_i_created, q_param_project, [max: 50, order: "desc", sort: "id"]);

        def myissues = TIssue.findAllByUser_idAndXstatusAndScoreGreaterThanEquals(me_id, Constants.PROJECTSTATUS_SCORED, 0, [max: 20, sort: "id", order: "desc"])
        def myissues_minus = TIssue.findAllByUser_idAndXstatusAndScoreLessThan(me_id, Constants.PROJECTSTATUS_SCORED, 0, [max: 20, sort: "id", order: "desc"])



        [mytasks: mytasks, approve_count: approve_count,approved_count:approved_count, score_count: score_count, score_month: score_month,  score_month_minus:score_month_minus,
                myprojects: myprojects, myissues: myissues, myissues_minus: myissues_minus, my_created_projects:my_created_projects]
    }


    def tasks(Integer max) {
        def q_param = [:]
        def cond = "from TIssue as ti where ti.user_id=:uid and ti.xtype=:type"
        int me_id = session?.user?.id ?: 0
        q_param.put("uid", me_id)
        q_param.put("type", Constants.PROJECTTYPES_TASK)

        params.max = Math.min(max ?: 20, 100)

        [TIssueInstanceList: TIssue.findAll(cond + " order by ti.id desc", q_param, params),
                TIssueInstanceTotal: TIssue.countByUser_idAndXtype(me_id, Constants.PROJECTTYPES_TASK)]
    }

    def issues(String id,  Integer max) {
        def q_param = [:]
        def cond = "from TIssue as ti where ti.user_id=:uid and ti.xstatus=:sts"
        int me_id = session?.user?.id ?: 0
        q_param.put("uid", me_id)
        q_param.put("sts", Constants.PROJECTSTATUS_SCORED)
        def total = 0
        params.max = Math.min(max ?: 20, 100)

        if (id=="up"){
            cond+= " and ti.score>=0"
            total =  TIssue.countByUser_idAndXstatusAndScoreGreaterThanEquals(me_id, Constants.PROJECTSTATUS_SCORED, 0)
        }   else if (id=="down"){
            cond+= " and ti.score<0"
            total =  TIssue.countByUser_idAndXstatusAndScoreLessThan(me_id, Constants.PROJECTSTATUS_SCORED, 0)
        }
        else{
            total =  TIssue.countByUser_idAndXstatus(me_id, Constants.PROJECTSTATUS_SCORED)
        }

        [TIssueInstanceList: TIssue.findAll(cond + " order by ti.id desc", q_param, params),
                TIssueInstanceTotal: total]
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
            sb.append("<li rel='" + xuser.id + "'>")
            sb.append(xuser.nick)
            sb.append("</li>")
        }
        render sb
    }

    def approve_list() {
        int me_id = session.user?.id ?: 0
        def TProjectInstanceList = TProject.findAllByApproverAndXtypeAndXstatus(me_id, Constants.PROJECTTYPES_TASK, Constants.PROJECTSTATUS_OUTSTANDING)
        [TProjectInstanceList: TProjectInstanceList]
    }
    def approved_list() {
        int me_id = session.user?.id ?: 0
        def TProjectInstanceList = TProject.findAllByApproverAndXtypeAndXstatus(me_id, Constants.PROJECTTYPES_TASK, Constants.PROJECTSTATUS_APPROVED)
        [TProjectInstanceList: TProjectInstanceList]
    }

    def score_project_list() {
        int me_id = session.user?.id ?: 0
        def TProjectInstanceList = TProject.findAllByApproverAndXtypeAndXstatus(me_id, Constants.PROJECTTYPES_TASK, Constants.PROJECTSTATUS_FINISHED)
        [TProjectInstanceList: TProjectInstanceList]
    }


}