package linksharing


class DashboardInterceptor {
    DashboardInterceptor(){
        match(controller:"dashboard",action:['allusers','alltopics'])
        match(controller: 'resources',action: 'allPosts')
    }
    boolean before() {
        if(session.isAdmin ){
            true
        }
        if(!session.isAdmin){
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
