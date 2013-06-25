package sri.score

class TLevel {
    int id
    int xtype
    int xstatus
    Date create_date
    int creator
    Date update_date
    int updater
    String title
    long min_score
    String method
    BigDecimal coefficient
    String score_config

    static constraints = {
        title blank: false
    }
}
