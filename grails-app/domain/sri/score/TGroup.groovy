package sri.score

class TGroup {
    int id
    int xtype
    int xstatus
    Date create_date
    int creator
    Date update_date
    int updater
    String title
    long parent_id
    int leader
    static constraints = {
        title blank: false

    }
}
