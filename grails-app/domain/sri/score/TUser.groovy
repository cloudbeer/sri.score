package sri.score

import sri.score.common.Constants

class TUser {
    int id
    int xtype = 1
    int xstatus = 1
    Date create_date = new Date()
    int creator = 0
    Date update_date = new Date()
    int updater = 0
    String user_name = ""
    String nick
    String password = ""
    String salt = ""
    String email
    long ref_id = 0
    String user_code
    int level_id = 1
    BigDecimal score = 0
    int group_id = 0

    static constraints = {
        nick blank: false, nullable: true
        email email: true, unique: true, nullable: true
        salt blank: true
        xtype display: false
        xstatus display: false
        create_date display: false
        creator display: false
        update_date display: false
        updater display: false
        level_id display: false
        updater display: false
        score display: false
        group_id display: false
        user_code  unique: true, nullable: true
    }

    def is_admin() {
        return xtype == Constants.USERTYPES_ADMINISTRATOR
    }

    def is_approver() {
        return xtype == Constants.USERTYPES_APPROVER
    }

}
