package sri.score

import sri.score.common.Constants

class HelloController {

    def index() {
        [mm: "hello world 世界我日"]
    }

    def test() {
        render 1<<2
        //render Constants.USERTYPES_ADMINISTRATOR | Constants.USERTYPES_APPROVER
    }
}
