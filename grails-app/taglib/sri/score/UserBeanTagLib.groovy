package sri.score

import sri.score.common.Constants

class UserBeanTagLib {
    def usernick = { attrs, body ->
        int id = attrs.user_id?.toInteger()
        def users = attrs.users
        if (id > 0) {
            if (users) {
                def xuser = users.find { it.id == id }
                out << xuser?.nick
            } else {
                def xuser = TUser.findById(id)
                out << xuser?.nick
            }
        } else {
            out << ""
        }
    }
    def projectname = { attrs, body ->
        long id = attrs.project_id?.toLong()
        if (id > 0) {
            def xuser = TProject.findById(id)
            out << xuser?.title
        } else {
            out << ""
        }
    }

    def usertype = { attrs, body ->
        int type = attrs.type?.toInteger()
        switch (type) {
            case Constants.USERTYPES_APPROVER:
                out << '审批经理'
                break
            case Constants.USERTYPES_NORMAL:
                out << '普通用户'
                break
            case Constants.USERTYPES_ADMINISTRATOR:
                out << '系统管理员'
                break
        }

    }
    def issue_type = { attrs, body ->
        int type = attrs.type?.toInteger()
        switch (type) {
            case Constants.PROJECTTYPES_STATIC:
                out << '事务'
                break
            case Constants.PROJECTTYPES_LEVEL:
                out << '定级'
                break
            case Constants.PROJECTTYPES_ATTENDANCE:
                out << '考勤'
                break
            case Constants.PROJECTTYPES_TASK:
                out << '任务'
                break
            case Constants.PROJECTTYPES_CUSTOM:
                out << '自定义'
                break
        }

    }

    def projectstatus = { attrs, body ->
        int type = attrs.status?.toInteger()
        switch (type) {
            case Constants.PROJECTSTATUS_APPROVED:
                out << '已审批'
                break
            case Constants.PROJECTSTATUS_FINISHED:
                out << '已完成'
                break
            case Constants.PROJECTSTATUS_OUTSTANDING:
                out << '未处理'
                break
            case Constants.PROJECTSTATUS_SCORED:
                out << '已发分'
                break
        }

    }

    def levelscore = { attrs, body ->
        int level_id = attrs.level_id?.toInteger()
        long project_id = attrs.project_id?.toInteger()
        def level_scores = attrs.level_scores
        def res = level_scores.find { obj ->
            obj.level_id == level_id && obj.project_id == project_id }
        out << res?.score ?: 0
    }

    def levelname = { attrs, body ->
        int level_id = attrs.level_id?.toInteger()
        def levels = attrs.levels
        int userid = attrs.user_id?.toInteger()
        def users = attrs.users
        if (levels && level_id) {
            def res = levels.find { it.id == level_id }
            out << res?.title
        } else if (levels && userid && users) {
            def user = users.find { it.id == userid }
            def level = levels.find { it.id == user?.level_id?:0 }
            out << level?.title
        } else if (userid && users) {
            def user = TUser.get(userid)
            def level = TLevel.get(user?.level_id?:0)
            out << level?.title
        } else {
            def res = TLevel.get(level_id)
            out << res?.title
        }
    }

    def group_name = { attrs, body ->
        def groups = attrs.groups
        int groupid = attrs.group_id?.toInteger()
        int userid = attrs.user_id?.toInteger()
        def users = attrs.users
        //TODO 这里应该递归，显示父亲等信息
        if (groupid > 0) {
            def group = groups.find { it.id == groupid }
            out << group?.title
        } else if (userid > 0) {
            if (users) {
                def user = users.find { it.id == userid }
                def group = groups.find { it.id == user?.group_id?:0 }
                out << group?.title
            } else {
                def user = TUser.get(userid)
                def group = groups.find { it.id == user.group_id }
                out << group?.title
            }
        } else {
            out << ""
        }
    }
}
