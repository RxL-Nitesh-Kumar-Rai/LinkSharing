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
//        render([success:resourcesService.deletePost(session,params)] as JSON)
        success:resourcesService.deletePost(session,params,flash)
        redirect(controller: 'dashBoard',action: 'dashboard')
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
    def searchPage(){
        render(controller:"reosources",view:"searchPage",model:resourcesService.searchPage(session,params))
    }

    def sendInvitation() {


            render([success: resourcesService.sendInvitation(params)] as JSON)
        }
    def allPosts(){

        render(controller:'resources',view:'allPosts',model: resourcesService.allPosts())
    }



}
