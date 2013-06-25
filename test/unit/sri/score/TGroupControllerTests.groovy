package sri.score



import org.junit.*
import grails.test.mixin.*

@TestFor(TGroupController)
@Mock(TGroup)
class TGroupControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/TGroup/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.TGroupInstanceList.size() == 0
        assert model.TGroupInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.TGroupInstance != null
    }

    void testSave() {
        controller.save()

        assert model.TGroupInstance != null
        assert view == '/TGroup/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/TGroup/show/1'
        assert controller.flash.message != null
        assert TGroup.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/TGroup/list'

        populateValidParams(params)
        def TGroup = new TGroup(params)

        assert TGroup.save() != null

        params.id = TGroup.id

        def model = controller.show()

        assert model.TGroupInstance == TGroup
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/TGroup/list'

        populateValidParams(params)
        def TGroup = new TGroup(params)

        assert TGroup.save() != null

        params.id = TGroup.id

        def model = controller.edit()

        assert model.TGroupInstance == TGroup
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/TGroup/list'

        response.reset()

        populateValidParams(params)
        def TGroup = new TGroup(params)

        assert TGroup.save() != null

        // test invalid parameters in update
        params.id = TGroup.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/TGroup/edit"
        assert model.TGroupInstance != null

        TGroup.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/TGroup/show/$TGroup.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        TGroup.clearErrors()

        populateValidParams(params)
        params.id = TGroup.id
        params.version = -1
        controller.update()

        assert view == "/TGroup/edit"
        assert model.TGroupInstance != null
        assert model.TGroupInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/TGroup/list'

        response.reset()

        populateValidParams(params)
        def TGroup = new TGroup(params)

        assert TGroup.save() != null
        assert TGroup.count() == 1

        params.id = TGroup.id

        controller.delete()

        assert TGroup.count() == 0
        assert TGroup.get(TGroup.id) == null
        assert response.redirectedUrl == '/TGroup/list'
    }
}
