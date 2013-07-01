package sri.score

class TLevelProjectScore {

    long id
    int xtype = 1
    int xstatus = 1
    Date create_date = new Date()
    long creator = 0
    Date update_date = new Date()
    long updater = 0
    long project_id = 0
    int level_id = 0
    int score = 0

    static constraints = {
    }
}
