package linksharing


class AuthInterceptor {
    AuthInterceptor() {
        matchAll()
                .excludes(controller:"loginPage")
                .excludes(controller: 'dashBoard',action: 'userprofile')
                .excludes(controller: 'dashBoard',action: 'searchtopic')
                .excludes(controller: 'resources',action: 'searchPage')
                .excludes(controller: 'resources',action: 'viewPost')
                .excludes(controller:"dashboard",action:['allusers','alltopics'])
                .excludes(controller: 'resources',action: 'allPosts')
    }

    boolean before() {
        if(session.getAttribute("validUser") ){
            response.setHeader("Cache-Control", "no-cache, no-store")
            response.setHeader("Pragma", "no-cache")
            true
        }
        else{
            flash.error="Please login first"
            redirect(controller:'loginPage',action:'index')
            false
        }

    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}
