package sri.score



import org.junit.*
import grails.test.mixin.*

@TestFor(TIssueController)
@Mock(TIssue)
class TIssueControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/TIssue/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.TIssueInstanceList.size() == 0
        assert model.TIssueInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.TIssueInstance != null
    }

    void testSave() {
        controller.save()

        assert model.TIssueInstance != null
        assert view == '/TIssue/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/TIssue/show/1'
        assert controller.flash.message != null
        assert TIssue.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/TIssue/list'

        populateValidParams(params)
        def TIssue = new TIssue(params)

        assert TIssue.save() != null

        params.id = TIssue.id

        def model = controller.show()

        assert model.TIssueInstance == TIssue
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/TIssue/list'

        populateValidParams(params)
        def TIssue = new TIssue(params)

        assert TIssue.save() != null

        params.id = TIssue.id

        def model = controller.edit()

        assert model.TIssueInstance == TIssue
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/TIssue/list'

        response.reset()

        populateValidParams(params)
        def TIssue = new TIssue(params)

        assert TIssue.save() != null

        // test invalid parameters in update
        params.id = TIssue.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/TIssue/edit"
        assert model.TIssueInstance != null

        TIssue.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/TIssue/show/$TIssue.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        TIssue.clearErrors()

        populateValidParams(params)
        params.id = TIssue.id
        params.version = -1
        controller.update()

        assert view == "/TIssue/edit"
        assert model.TIssueInstance != null
        assert model.TIssueInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/TIssue/list'

        response.reset()

        populateValidParams(params)
        def TIssue = new TIssue(params)

        assert TIssue.save() != null
        assert TIssue.count() == 1

        params.id = TIssue.id

        controller.delete()

        assert TIssue.count() == 0
        assert TIssue.get(TIssue.id) == null
        assert response.redirectedUrl == '/TIssue/list'
    }
}
