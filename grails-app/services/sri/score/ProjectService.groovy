package sri.score

import org.springframework.transaction.annotation.Transactional
import sri.score.common.Constants
import sri.score.common.Helper

import java.text.SimpleDateFormat

class ProjectService {

    //static transactional = true

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

            if (a_status == 1) {
                xuser.score += task.score
            } else if (a_status == 0) {
                xuser.score = xuser.score - task.score
                task.score = -task.score
            }
            task.xstatus = Constants.PROJECTSTATUS_SCORED
            task.save()
            xuser.save()
            Helper.update_level(xuser)
        }
        xproject.save()

    }

    def test(){
        println "11111"
    }
}
