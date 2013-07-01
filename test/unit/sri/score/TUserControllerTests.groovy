package sri.score



import org.junit.*
import grails.test.mixin.*

@TestFor(TUserController)
@Mock(TUser)
class TUserControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/TUser/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.TUserInstanceList.size() == 0
        assert model.TUserInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.TUserInstance != null
    }

    void testSave() {
        controller.save()

        assert model.TUserInstance != null
        assert view == '/TUser/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/TUser/show/1'
        assert controller.flash.message != null
        assert TUser.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/TUser/list'

        populateValidParams(params)
        def TUser = new TUser(params)

        assert TUser.save() != null

        params.id = TUser.id

        def model = controller.show()

        assert model.TUserInstance == TUser
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/TUser/list'

        populateValidParams(params)
        def TUser = new TUser(params)

        assert TUser.save() != null

        params.id = TUser.id

        def model = controller.edit()

        assert model.TUserInstance == TUser
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/TUser/list'

        response.reset()

        populateValidParams(params)
        def TUser = new TUser(params)

        assert TUser.save() != null

        // test invalid parameters in update
        params.id = TUser.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/TUser/edit"
        assert model.TUserInstance != null

        TUser.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/TUser/show/$TUser.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        TUser.clearErrors()

        populateValidParams(params)
        params.id = TUser.id
        params.version = -1
        controller.update()

        assert view == "/TUser/edit"
        assert model.TUserInstance != null
        assert model.TUserInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/TUser/list'

        response.reset()

        populateValidParams(params)
        def TUser = new TUser(params)

        assert TUser.save() != null
        assert TUser.count() == 1

        params.id = TUser.id

        controller.delete()

        assert TUser.count() == 0
        assert TUser.get(TUser.id) == null
        assert response.redirectedUrl == '/TUser/list'
    }
}
