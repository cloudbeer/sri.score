package sri.score

class TSiteConfig {
    long id
    int xtype = 1
    int xstatus = 1
    Date create_date = new Date()
    int creator = 0
    Date update_date  =    new Date()
    int updater = 0
    String xkey
    String xvalue
    static constraints = {
        update_date nullable: true
    }
}
