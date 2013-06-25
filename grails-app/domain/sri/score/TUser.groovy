package sri.score

class TUser {
    int id
    int xtype
    int xstatus
    Date create_date
    int creator
    Date update_date
    int updater
    String user_name
    String password
    String salt
    String email
    long ref_id
    String user_code
    int level_id
    BigDecimal score
    int group_id

    static constraints = {
    }
}
