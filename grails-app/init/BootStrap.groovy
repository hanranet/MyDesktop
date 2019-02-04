import com.hanranet.mydesktop.security.Role
import com.hanranet.mydesktop.security.User
import com.hanranet.mydesktop.security.UserRole

class BootStrap {

    def init = { servletContext ->
//        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
//        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
//
//        def testUser = new User(username: 'thanrahan', enabled: true, password: 'murphy2000', firstname: "Tom", lastname: "Hanrahan")
//        testUser.save(flush: true)
//
//        UserRole.create testUser, adminRole, true
//
//        def anotherTestUser = new User(username: 'mhanrahan', enabled: true, password: 'murphy2000', firstname: "Megan", lastname: "Hanrahan")
//        anotherTestUser.save(flush: true)
//
//        UserRole.create anotherTestUser, userRole, true

//        assert User.count() == 2
//        assert Role.count() == 2
//        assert UserRole.count() == 2

    }
    def destroy = {
    }
}
