package sri.score

class TProject {
    long id
    int xtype = 1
    int xstatus = 1
    Date create_date = new Date()
    int creator = 0
    Date update_date = new Date()
    int updater = 0
    String title
    String description = ""
    BigDecimal pre_score = 0.0
    BigDecimal total = 0.0
    BigDecimal base_score = 0.0
    int category_id = 0
    String code = ""
    int approver = 0
    int manager = 0
    String comment = ""
    long zentao_id = 0

    static constraints = {
        title blank: false
        description maxSize: 20000
        xtype display: false
        xstatus display: false
        create_date display: false
        creator display: false
        update_date display: false
        updater display: false

    }

    def is_manager(user) {
        if (!user)
            return false
        if (user.id == creator || user.id == manager)
            return true
        return false
    }

    def is_approver(user) {
        if (!user)
            return false
        if (user.id == approver)
            return true
        return false

    }
}
