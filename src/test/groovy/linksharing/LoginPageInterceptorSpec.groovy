package linksharing

import grails.testing.web.interceptor.InterceptorUnitTest
import spock.lang.Specification

class LoginPageInterceptorSpec extends Specification implements InterceptorUnitTest<LoginPageInterceptor> {

    def setup() {
    }

    def cleanup() {

    }

    void "Test loginPage interceptor matching"() {
        when:"A request matches the interceptor"
            withRequest(controller:"loginPage")

        then:"The interceptor does match"
            interceptor.doesMatch()
    }
}
