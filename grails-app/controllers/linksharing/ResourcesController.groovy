package linksharing

import grails.converters.JSON

class ResourcesController {
    def resourcesService
    def index() { }


    def viewPost(){

        render(controller:"resources",view: "viewPost",model:resourcesService.viewPost(session,params))
    }
    def ratePost(){
        render([success:resourcesService.ratePost(session,params)] as JSON)
    }

    def deletePost(){
        render([success:resourcesService.deletePost(session,params)] as JSON)
    }

    def downloadPost(){
        render([success:resourcesService.downloadPost(params,response)] as JSON)
    }
    def markAsReadPost(){
        render([success:resourcesService.markAsReadPost(session,params)] as JSON)
    }
    def editPost(){
        render([success:resourcesService.editPost(session,params)] as JSON)
    }

}
