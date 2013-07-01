package sri.score.common

import sri.score.TLevel
import sri.score.TUser

/**
 * Created with IntelliJ IDEA.
 * User: Cloudbeer
 * Date: 13-7-1
 * Time: 下午4:47
 * To change this template use File | Settings | File Templates.
 */
class Helper {
    def static update_level(TUser user) {

        def levels = TLevel.list([sort: "min_score", order: 'desc'])
        def xlevel = levels.find { obj ->
            user.score >= obj.min_score
        }

        //println(xlevel.min_score)
        if (xlevel) {
            user.level_id=xlevel.id
            user.save()
            //TUser.executeUpdate("update tuser set level_id=" + xlevel.id + " where id=" + user.id)
            //println("update TUser set level_id=" + xlevel.id + " where id=" + user.id)
        }
    }
}
