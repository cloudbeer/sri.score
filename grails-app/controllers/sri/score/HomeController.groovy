package sri.score

import grails.converters.JSON
import sri.score.common.Constants

import java.text.SimpleDateFormat

class HomeController {
    HelperService helperService

    def afterInterceptor = {
        flash.menu_flag = "home"
    }
    def beforeInterceptor = {
        if (!session.user) {
            redirect(action: 'login', controller: 'account')
            return false
        }
    }


    def browse() {
        def projects = TProject.findAllByXtype(Constants.PROJECTTYPES_TASK, [max: 40, order: "desc", sort: "id"])

        def top10Users = TUser.list([max: 10, sort: 'score', order: 'desc'])


        def calWeek1 = Calendar.getInstance()
        def calWeek7 = Calendar.getInstance()
        def calNow = Calendar.getInstance()
        int maxDay = calNow.getActualMaximum(Calendar.DAY_OF_MONTH)
        def calMonth1 = Calendar.getInstance()
        calMonth1.set(Calendar.DAY_OF_MONTH, 1)
        def calMonth30 = Calendar.getInstance()
        calMonth30.set(Calendar.DAY_OF_MONTH, maxDay)

        int dayDiff = calWeek1.get(Calendar.DAY_OF_WEEK)
        calWeek1.add(Calendar.DATE, -7)
        //calWeek7.add(Calendar.DATE, 7 - dayDiff)

//        calMonth1.add(Calendar.DATE, -calMonth1.get(Calendar.DAY_OF_MONTH))
//        calMonth1.add(Calendar.DATE, -calMonth1.get(Calendar.DAY_OF_MONTH))

        //def week1 = cal.get(Calendar.DAY_OF_WEEK)
        //def now = cal.getTime()
        //cal.add(Calendar.DATE, -week1)
//        render calWeek1.getTime().toLocaleString() + "<br>"
//        render calWeek7.getTime().toLocaleString() + "<br>"
//        render calMonth1.getTime().toLocaleString() + "<br>"
//        render calMonth30.getTime().toLocaleString() + "<br>"
//        return

        def allWeek = TIssue.findAllByXstatusAndUpdate_dateBetweenAndXtypeNotEqual(Constants.PROJECTSTATUS_SCORED,
                calWeek1.getTime(), calWeek7.getTime(), Constants.PROJECTTYPES_LEVEL)
        def allMonth = TIssue.findAllByXstatusAndUpdate_dateBetweenAndXtypeNotEqual(Constants.PROJECTSTATUS_SCORED,
                calMonth1.getTime(), calMonth30.getTime(), Constants.PROJECTTYPES_LEVEL)

        def xweek = allWeek.groupBy { it.user_id }
        def weekSTS = []
        xweek.each { uid, recs ->
            def uScore = [:]
            uScore.put("user_id", uid)
            uScore.put("total", recs.sum { it.score })
            weekSTS.add(uScore)
        }
        def xmonth = allMonth.groupBy { it.user_id }
        def monthSTS = []
        xmonth.each { uid, recs ->
            def uScore = [:]
            uScore.put("user_id", uid)
            uScore.put("total", recs.sum { it.score })
            monthSTS.add(uScore)
        }


        [projects: projects, top10Week: weekSTS.sort { -it.total }.take(20), top10Month: monthSTS.sort { -it.total }.take(20), top10Users: top10Users]
    }

    private void getChildenGroups(List<TGroup> groups, int mid, StringBuilder container) {
        //println mid
        container.append("," + mid)
        def sons = groups.findAll {
            it.parent_id == mid
        }
        if (sons) {
            sons.each {
                getChildenGroups(groups, it.id, container)
            }
        }
    }

    def rank(int group_id, String q_from_date, String q_to_date) {
        def map = [:]
        String sql = "from TIssue where xtype<>:xtype and xstatus=:xstatus"
        map.put("xtype", Constants.PROJECTTYPES_LEVEL)
        map.put("xstatus", Constants.PROJECTSTATUS_SCORED)
        def groups = TGroup.list()
        if (group_id > 0) {
            StringBuilder container = new StringBuilder()
            getChildenGroups(groups, group_id, container)
            sql += " and user_id in (select id from TUser where group_id in (-1" + container + "))"

        }
        def formatter = new SimpleDateFormat("yyyy-MM-dd");
        if (q_from_date) {
            def fromDate = formatter.parse(q_from_date)
            if (fromDate) {
                sql += " and update_date>=:fromDate"
            }
            map.put("fromDate", fromDate)
        }
        if (q_to_date) {
            def toDate = formatter.parse(q_to_date)
            if (toDate) {
                sql += " and update_date<=:toDate"
            }
            map.put("toDate", toDate)
        }
        def allIssue = TIssue.findAll(sql, map)

        def xIssues = allIssue.groupBy { it.user_id }
        def allSTS = []
        xIssues.each { uid, recs ->
            def uScore = [:]
            uScore.put("user_id", uid)
            uScore.put("total", recs.sum { it.score })
            allSTS.add(uScore)
        }
        def rtn = new StringBuilder()
        helperService.recursionGroupHtml(groups, 0, rtn)
        def users = TUser.list()
        def levels = TLevel.list()
        [topRank: allSTS.sort { -it.total }, groups: groups, users: users, levels: levels, groupHTML: rtn, params: params]
    }

    def projects(int manager, int approver, int status) {
        def map = [:]
        String sql = "from TProject where xtype=:xtype"
        map.put("xtype", Constants.PROJECTTYPES_TASK)
        if ((manager ?: 0) > 0) {
            sql += " and Manager=:manager"
            map.put("manager", manager)
        }
        if ((approver ?: 0) > 0) {
            sql += " and Approver=:approver"
            map.put("approver", approver)
        }
        if ((status ?: 0) > 0) {
            sql += " and xstatus=:xstatus"
            map.put("xstatus", status)
        }

        params.max = 40

        def projects = TProject.findAll(sql + " order by id desc", map, params)
        def ds_count = TUser.executeQuery("select count(*) as cnt " + sql, map)
        int xcount = 0
        if (ds_count)
            xcount = ds_count[0]
        [projects: projects, total: xcount, approvers: TUser.findAllByXtype(Constants.USERTYPES_APPROVER)]
    }
}
