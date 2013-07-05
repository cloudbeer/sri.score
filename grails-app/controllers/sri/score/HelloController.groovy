package sri.score

import sri.score.common.Constants

class HelloController {
                   TestService  testService
    def index() {
        [mm: "hello world 世界我日"]
    }

    def test() {
        Calendar calFrom = Calendar.getInstance()
        calFrom.set(Calendar.MINUTE, 0)
        calFrom.set(Calendar.HOUR, 0)
        calFrom.set(Calendar.SECOND, 0)
        calFrom.set(Calendar.DAY_OF_MONTH, 1)

        Calendar calTo = Calendar.getInstance()
        calTo.set(Calendar.MINUTE, 0)
        calTo.set(Calendar.HOUR, 0)
        calTo.set(Calendar.SECOND, 0)
        calTo.set(Calendar.DAY_OF_MONTH, 1)
        calTo.set(Calendar.MONTH, calTo.get(Calendar.MONTH) + 1)

        render calTo.getTime()
    }
}
