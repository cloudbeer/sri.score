package sri.score

class TLevel {
    int id
    int xtype = 1
    int xstatus = 1
    Date create_date = new Date()
    int creator = 0
    Date update_date = new Date()
    int updater = 0
    String title
    int min_score
    String method = ""
    BigDecimal coefficient = 1.0
    String score_config = ""
    int flag_id = 0

    static constraints = {
        title blank: false
        update_date blank: true
        method blank: true
        score_config blank: true
        coefficient min: 1.0
        min_score min: 0
    }
    static mapping = {
        score_config type: "text"
    }
}
