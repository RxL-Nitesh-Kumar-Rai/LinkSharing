package linksharing


import javax.servlet.http.HttpSession

//import grails.plugin.springsecurity.annotation.Secured

class LoginPageController {
//    static allowedMethods = [searchtopic:['POST','GET']]
//    @Secured(['ROLE_ADMIN'])
    def loginPageService
    def index() {
        List resTp=ResourceRating.list(offset:0,max:5,sort:'totalRating',order:"desc").each{it->
            if(it.linkResource){
                println it.linkResource.resource.topic.visibility
            }
            else{
                println it.documentResource.resource.topic.visibility
            }
        }


        if(Resources.list().size()>=5) {
            List topic = Topic.createCriteria().list(offset: 0, max: 5, sort: "lastUpdated", order: "desc") {
                eq("visibility", Topic.Visibility.'Public')
            }

            List res1 = []
            topic.each { res1.add(it.resources.linkResources) }

            topic.each { res1.add(it.resources.documentResources) }
            List res = res1.flatten().sort { a, b -> b.'lastUpdated' <=> a.'lastUpdated' }[0..<(res1.flatten().size()<5?res1.flatten().size():5)]

//            List topLr = LinkResource.list(offset: 0, max: 5, sort: 'totalRating', order: 'desc')
//            List topDr = DocumentResource.list(offset: 0, max: 5, sort: 'totalRating', order: 'desc')
//            List tempTp = topLr + topDr
//            List resTp = tempTp.sort { a, b -> b.'totalRating' <=> a.'totalRating' }[0..<5]
//            List resTp=ResourceRating.list(offset:0,max:5,sort:'totalRating',order:"desc")
            render(view:"loginpage",model:["post":res,"topPost":resTp])
        }
            else if(Topic.list().size()>0 &&Topic.list().size()<5){
            List topic = Topic.createCriteria().list(offset: 0, max: 5, sort: "lastUpdated", order: "desc") {
                eq("visibility", Topic.Visibility.'Public')
            }

            List res1 = []
            topic.each { res1.add(it.resources.linkResources) }

            topic.each { res1.add(it.resources.documentResources) }
            List res = res1.flatten().sort { a, b -> b.'lastUpdated' <=> a.'lastUpdated' }[0..<res1.flatten().size()]

//            List topLr = LinkResource.list(offset: 0, max: 5, sort: 'totalRating', order: 'desc')
//            List topDr = DocumentResource.list(offset: 0, max: 5, sort: 'totalRating', order: 'desc')
//            List tempTp = topLr + topDr
//            List resTp = tempTp.sort { a, b -> b.'totalRating' <=> a.'totalRating' }[0..<Topic.list().size()]
//            List resTp=ResourceRating.list(offset:0,max:5,sort:'totalRating',order:"desc")
            render(view:"loginpage",model:["post":res,"topPost":resTp])
        }
        else{
            List res=[]
//            List resTp=ResourceRating.list(offset:0,max:5,sort:'totalRating',order:"desc")
            render(view:"loginpage",model:["post":res,"topPost":resTp])
        }


    }
    def register(){
            loginPageService.register(params,flash,request)
        redirect(action:'index')
    }

    def login(){
        boolean flag=loginPageService.login(params,flash,request)

        if(flag==true){
            redirect(controller:'dashBoard',action:'dashboard')
        }
        else{
            redirect (controller: 'loginPage',action: 'index')
        }
    }
    def viewImage(){
        def user = Users.get(params.userId)
        byte[] imageInByte = user.photo
        response.contentType = 'image/png' // or the appropriate image content type
        response.outputStream << imageInByte
        response.outputStream.flush()
    }




}
