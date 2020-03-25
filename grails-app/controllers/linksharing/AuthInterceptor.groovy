//package linksharing
//
//
//class AuthInterceptor {
//    AuthInterceptor() {
//        matchAll()
//                .excludes(controller:"loginPage")
//                .excludes(controller: 'dashBoard',action: 'searchtopic')
//
//    }
//
//    boolean before() {
//        println "pop"
//        if(session.getAttribute("validUser") ){
//            println "lol"
//            true
//        }
//        else{
//            flash.error="Please login first"
//            redirect(controller:'loginPage',action:'index')
//            false
//        }
//
//    }
//
//    boolean after() { true }
//
//    void afterView() {
//        // no-op
//    }
//}
