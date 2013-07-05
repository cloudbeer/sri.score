package sri.score

class TIssue {
    long id
    int xtype = 1
    int xstatus = 1
    Date create_date = new Date()
    int creator = 0
    Date update_date = new Date()
    int updater = 0
    String title
    String description = ""
    BigDecimal pre_score = 0
    BigDecimal score = 0
    int user_id = 0
    long project_id = 0
    int ref_user = 0
    long ref_issue = 0

    static constraints = {
        title blank: false, size: 0..300
        xtype display: false
        xstatus display: false
        create_date display: false
        creator display: false
        update_date display: false         , nullable: true
        updater display: false            , nullable: true
        project_id display: false        , nullable: true
        updater display: false             , nullable: true
        ref_user display: false         , nullable: true
        ref_issue display: false   , nullable: true
        score display: false
    }
    static mapping = {
        description type: "text"
    }
}
