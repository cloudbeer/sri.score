package sri.score



import org.junit.*
import grails.test.mixin.*

@TestFor(TLevelController)
@Mock(TLevel)
class TLevelControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/TLevel/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.TLevelInstanceList.size() == 0
        assert model.TLevelInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.TLevelInstance != null
    }

    void testSave() {
        controller.save()

        assert model.TLevelInstance != null
        assert view == '/TLevel/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/TLevel/show/1'
        assert controller.flash.message != null
        assert TLevel.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/TLevel/list'

        populateValidParams(params)
        def TLevel = new TLevel(params)

        assert TLevel.save() != null

        params.id = TLevel.id

        def model = controller.show()

        assert model.TLevelInstance == TLevel
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/TLevel/list'

        populateValidParams(params)
        def TLevel = new TLevel(params)

        assert TLevel.save() != null

        params.id = TLevel.id

        def model = controller.edit()

        assert model.TLevelInstance == TLevel
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/TLevel/list'

        response.reset()

        populateValidParams(params)
        def TLevel = new TLevel(params)

        assert TLevel.save() != null

        // test invalid parameters in update
        params.id = TLevel.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/TLevel/edit"
        assert model.TLevelInstance != null

        TLevel.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/TLevel/show/$TLevel.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        TLevel.clearErrors()

        populateValidParams(params)
        params.id = TLevel.id
        params.version = -1
        controller.update()

        assert view == "/TLevel/edit"
        assert model.TLevelInstance != null
        assert model.TLevelInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/TLevel/list'

        response.reset()

        populateValidParams(params)
        def TLevel = new TLevel(params)

        assert TLevel.save() != null
        assert TLevel.count() == 1

        params.id = TLevel.id

        controller.delete()

        assert TLevel.count() == 0
        assert TLevel.get(TLevel.id) == null
        assert response.redirectedUrl == '/TLevel/list'
    }
}
