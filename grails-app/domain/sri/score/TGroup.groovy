package sri.score

class TGroup {
    int id
    int xtype
    int xstatus
    Date create_date = new Date()
    int creator
    Date update_date = new Date()
    int updater
    String title
    long parent_id
    int leader
    static constraints = {
        title blank: false
        xtype display: false
        xstatus display: false
        create_date display: false
        creator display: false
        update_date display: false
        updater display: false
        leader display: false
    }}

