package linksharing


class DashboardInterceptor {
    DashboardInterceptor(){
        match(controller:"dashboard",action:['allusers','alltopics'])
    }
    boolean before() {
        println "pop"
        if(session.getAttribute("validUser") ){
            println "lol"
            true
        }
        if(!session.getAttribute("validUser")){
            flash.error="You don't have access to this"
            redirect(controller:'dashBoard',action:'dashboard')
            false
        }
        true }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}
