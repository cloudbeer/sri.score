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
    int parent_id
    int leader     = 0
    static constraints = {
        title blank: false
        xtype display: false
        xstatus display: false
        create_date display: false
        creator display: false      , nullable: true
        update_date display: false  , nullable: true
        updater display: false        , nullable: true
        leader display: false
    }
}

