package linksharing

import grails.testing.web.interceptor.InterceptorUnitTest
import spock.lang.Specification

class DemoInterceptorSpec extends Specification implements InterceptorUnitTest<DemoInterceptor> {

    def setup() {
    }

    def cleanup() {

    }

    void "Test demo interceptor matching"() {
        when:"A request matches the interceptor"
            withRequest(controller:"demo")

        then:"The interceptor does match"
            interceptor.doesMatch()
    }
}
