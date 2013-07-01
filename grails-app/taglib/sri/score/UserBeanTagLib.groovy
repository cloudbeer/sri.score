package sri.score

import sri.score.common.Constants

class UserBeanTagLib {
    def usernick = { attrs, body ->
        int id = attrs.user_id?.toInteger()
        if (id > 0) {
            def xuser = TUser.findById(id)
            out << xuser?.nick
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
        long project_id =  attrs.project_id?.toInteger()
        def level_scores = attrs.level_scores
        def res = level_scores.find { obj ->
            obj.level_id == level_id && obj.project_id==project_id }
        out << res?.score ?: 0
    }

    def levelname = { attrs, body ->
        int level_id = attrs.level_id?.toInteger()
        def res = TLevel.get(level_id)
        out << res?.title
    }
}
