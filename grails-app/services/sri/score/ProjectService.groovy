package sri.score

import org.springframework.transaction.annotation.Transactional
import sri.score.common.Constants
import sri.score.common.Helper

import java.text.SimpleDateFormat

class ProjectService {

    @Transactional
    void give_score(long project_id, String a_comment, int a_status, int opt_id) {
        def xproject = TProject.get(project_id)
        def formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String s_date = formatter.format(new Date());
        String xres = "扣分"
        xproject.xstatus = Constants.PROJECTSTATUS_SCORED
        if (a_status == 1) {
            xres = "加分"
        } else if (a_status == 0) {
            xres = "扣分"
        }
        xproject.comment += "<div class='a_comment'>" + a_comment + " [" + xres + "-" + s_date + "]" + "</div>"
        xproject.updater = opt_id
        xproject.update_date = new Date()

        def tasks = TIssue.findAllByProject_id(project_id)
        tasks.each { task ->
            //def xsore = task.pre_score ?: 0
            def xuser = TUser.get(task.user_id)

            //task.score = xsore
            def pre_score = 0.0
            if (a_status == 1) {
                pre_score = task.pre_score
            } else if (a_status == 0) {
                pre_score = -task.pre_score
            }
            xuser.score += pre_score
            task.score = pre_score
            task.update_date = new Date()

            task.xstatus = Constants.PROJECTSTATUS_SCORED
            task.save()
            xuser.save()
            Helper.update_level(xuser)
        }
        xproject.save()

    }


    @Transactional
    void give_score_custom(long project_id, int opt_id, def params) {
        def formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String s_date = formatter.format(new Date());


        def tasks = TIssue.findAllByProject_id(project_id)

        Boolean checkScore = true
        String error_message = "<br />给分不合理 <br />"
        tasks.each { task ->
            def pre_score = task.pre_score
            def r_score = params["r_" + task.id]?.toBigDecimal()

            if (r_score.abs() > pre_score) {
                error_message += "分值 [" + r_score + "] 超出 [" + pre_score + "]<br />"
                checkScore = false
            }
        }
        if (!checkScore) {
            throw new Exception(error_message)
        } else {

            tasks.each { task ->
                def xuser = TUser.get(task.user_id)
                def r_score = params["r_" + task.id]?.toBigDecimal()

                xuser.score += r_score
                task.score = r_score

                task.xstatus = Constants.PROJECTSTATUS_SCORED
                task.update_date = new Date()
                task.save()
                xuser.save()
                Helper.update_level(xuser)
            }
            def xproject = TProject.get(project_id)
            xproject.xstatus = Constants.PROJECTSTATUS_SCORED
            xproject.update_date = new Date()

            xproject.comment += "<div class='a_comment'>" + params.a_comment + " [发分 -" + s_date + "]" + "</div>"
            xproject.updater = opt_id
            xproject.save()
        }

    }

    def test() {
        println "11111"
    }
}
