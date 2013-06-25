package sri.score

class TIssue {
    long id
    int xtype
    int xstatus
    Date create_date
    int creator
    Date update_date
    int updater
    String title
    String description
    BigDecimal pre_score
    BigDecimal score
    int user_id
    long project_id
    int ref_user
    long ref_issue

    static constraints = {
    }
}
