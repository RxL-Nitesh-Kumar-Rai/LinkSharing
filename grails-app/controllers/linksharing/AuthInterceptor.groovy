//package linksharing
//
//
//class AuthInterceptor {
//    AuthInterceptor() {
//        matchAll()
//                .excludes(controller:"loginPage")
////                .excludes(controller: 'dashBoard',action: 'searchtopic')
//
//    }
//
//    boolean before() {
//        println "Bye"
//        if(session.getAttribute("validUser") ){
//            println "lol"
//            true
//        }
//        else{
//            flash.error="Please login first"
//            redirect(controller:'loginPage',action:'index')
//            println "pop"
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
