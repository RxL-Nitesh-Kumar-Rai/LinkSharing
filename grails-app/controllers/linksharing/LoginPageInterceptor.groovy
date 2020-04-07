//package linksharing
//
//
//class LoginPageInterceptor {
//    LoginPageInterceptor(){
//        match(controller: 'loginPage',action: 'index')
//    }
//    boolean before() {
//        if(session.sessionId!=null){
//            response.setHeader("Cache-Control", "no-cache, no-store")
//            response.setHeader("Pragma", "no-cache")
//            redirect(controller: 'dashBoard',action: 'dashboard')
//        }
//        true }
//
//    boolean after() {
//        response.setHeader("Cache-Control", "no-cache, no-store")
//        response.setHeader("Pragma", "no-cache")
//        true }
//
//    void afterView() {
//        // no-op
//    }
//}
