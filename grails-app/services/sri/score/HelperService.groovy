package sri.score

import sri.score.common.Constants
import sri.score.common.Helper

import java.text.SimpleDateFormat

class HelperService {

    void import_levels(levels) {
        for (level in levels) {
            if (!TLevel.findByFlag_id(level.flag_id)) {
                TLevel u = new TLevel(level)
                u.save()
            }
        }

    }

    void import_users(users) {
        for (user in users) {
            if (!TUser.findByEmail(user.email)) {
                TUser u = new TUser(user)
                TLevel level = TLevel.findByFlag_id(user.level)
                if (level) {
                    u.level_id = level.id
                    u.score = level.min_score
                }
                u.save()

                if (level) {
                    def issue = new TIssue()
                    issue.score = level.min_score
                    issue.title = "等级评定加分"
                    issue.xtype = Constants.PROJECTTYPES_LEVEL
                    issue.user_id = u.id
                    issue.xstatus = Constants.PROJECTSTATUS_SCORED
                    issue.save()
                }
            }
        }

    }

    void import_event_score(evts) {
        for (evt in evts) {
            if (!TProject.findByCode(evt.code)) {
                TProject project = new TProject(evt)
                project.xtype = Constants.PROJECTTYPES_STATIC
                project.save()

                for (iKey in 0..20) {
                    TLevel tlevel = TLevel.findByFlag_id(iKey)
                    if (tlevel) {
                        TLevelProjectScore xscore = new TLevelProjectScore()
                        xscore.level_id = tlevel.id
                        xscore.score = evt[iKey]
                        xscore.project_id = project.id
                        xscore.save()

                    }


                }
            }
        }

    }



    void import_attendance(atts, int year, int month) {

        if (atts.size() <= 0) {
            throw new Exception( "没有可导入到数据，请核对Excel格式。")
            return
        }
        TProject attPro = TProject.findByCode("Z1")
        if (!attPro) {
            throw new Exception("没有Code为Z1的考勤分值，请导入事物积分表先。")
            return
        }


        def scores = TLevelProjectScore.findAllByProject_id(attPro.id)
        if (!scores) {
            throw new Exception("对应的等级没有分，请导入。")
            return
        }

        def users = TUser.findAll()

        for (att in atts) {
            TUser me = users.find { a -> a.user_code == att.code }
            if (me) {
                TLevelProjectScore tLevelProjectScore = scores.find { b ->
                    b.level_id == me.level_id && b.project_id == attPro.id
                }
                if (tLevelProjectScore) {
                    def levelScore = tLevelProjectScore.score ?: 0
                    def sumScore = (levelScore * att.days ?: 0) + (levelScore * att.addDays ?: 0)
                    def issue = new TIssue()
                    issue.score = sumScore
                    issue.title = "考勤 [出勤：" + att.days + ", 加班：" + att.addDays + "] @" + year + "-" + month
                    issue.xtype = Constants.PROJECTTYPES_ATTENDANCE
                    issue.user_id = me.id
                    issue.xstatus = Constants.PROJECTSTATUS_SCORED
                    issue.save()

                    me.score = me.score + sumScore
                    me.save()
                    Helper.update_level(me)
                }
            }
        }
    }


    void recursionGroupHtml(List<TGroup> groups, int parent_id, StringBuilder container) {
        def myLevels = groups.findAll { grp ->
            grp.parent_id == parent_id
        }
        //throw new Exception(""+myLevels.size())

        if (myLevels.size() > 0) {
            myLevels.each { grp ->
                //myLevels.title = myLevels
                container.append("<ul>")
                container.append("<li>")
                container.append("<a href='#' class='grp_name' data-id='" + grp.id + "'>"+grp.title+"</a>")
                container.append("</li>")
                recursionGroupHtml(groups, grp.id, container)
                container.append("</ul>")
            }
        }
    }
}
