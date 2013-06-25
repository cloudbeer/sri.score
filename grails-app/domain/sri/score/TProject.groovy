package sri.score

class TProject {
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
    BigDecimal total
    BigDecimal base_score
    int category_id
    String code
    int approver
    int manager
    String comment
    long zentao_id

    static constraints = {
    }
}
