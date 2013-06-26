package sri.score



import org.junit.*
import grails.test.mixin.*

@TestFor(TProjectController)
@Mock(TProject)
class TProjectControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/TProject/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.TProjectInstanceList.size() == 0
        assert model.TProjectInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.TProjectInstance != null
    }

    void testSave() {
        controller.save()

        assert model.TProjectInstance != null
        assert view == '/TProject/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/TProject/show/1'
        assert controller.flash.message != null
        assert TProject.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/TProject/list'

        populateValidParams(params)
        def TProject = new TProject(params)

        assert TProject.save() != null

        params.id = TProject.id

        def model = controller.show()

        assert model.TProjectInstance == TProject
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/TProject/list'

        populateValidParams(params)
        def TProject = new TProject(params)

        assert TProject.save() != null

        params.id = TProject.id

        def model = controller.edit()

        assert model.TProjectInstance == TProject
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/TProject/list'

        response.reset()

        populateValidParams(params)
        def TProject = new TProject(params)

        assert TProject.save() != null

        // test invalid parameters in update
        params.id = TProject.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/TProject/edit"
        assert model.TProjectInstance != null

        TProject.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/TProject/show/$TProject.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        TProject.clearErrors()

        populateValidParams(params)
        params.id = TProject.id
        params.version = -1
        controller.update()

        assert view == "/TProject/edit"
        assert model.TProjectInstance != null
        assert model.TProjectInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/TProject/list'

        response.reset()

        populateValidParams(params)
        def TProject = new TProject(params)

        assert TProject.save() != null
        assert TProject.count() == 1

        params.id = TProject.id

        controller.delete()

        assert TProject.count() == 0
        assert TProject.get(TProject.id) == null
        assert response.redirectedUrl == '/TProject/list'
    }
}
