package linksharing

import grails.converters.JSON


class DashBoardController {
    def topicService
    def linkResourceService
    def documentResourceService
    def usersService
    def subscriptionsService

    static defaultAction = "dashboard"

    def index() {
    }

    def dashboard() {
        Users user = Users.findByUserName(session.sessionId)
        //Reading item
        List readingItem=[]

        if(user.readingItems.size()>=5) {
             readingItem = ReadingItem.createCriteria().list(offset: 0, max: 5) {
                eq('user', user)
                eq('isRead', false)
            }
        }
            else if(user.readingItems.size()>0 && user.readingItems.size()<5){
            readingItem = ReadingItem.createCriteria().list(offset: 0, max: user.readingItems.size()) {
                eq('user', user)
                eq('isRead', false)
            }
        }
        else{
             readingItem=[]
        }
        //Trending topic
        List trendingTopic=[]
        List topicList = Topic.list()
        def temp = topicList.collectEntries { it ->
            [it, it.resources.linkResources.size() + it.resources.documentResources.size()]
        }
        def temp2 = temp.sort { -it.value }
        List temp3 = []
        temp2.each { temp3.add(it.key) }
        if(temp3.size()>=5) {
             trendingTopic = temp3[0..<5]
        }
        else if(temp3.size()>0 && temp3.size()<5){
             trendingTopic=temp3[0..<temp3.size()]
        }
        else{
             trendingTopic=[]
        }

        render(view: 'dashboard', model: ["user": user, 'readingItem': readingItem, 'trendingTopic': trendingTopic])
    }

    def logout() {
        session.invalidate()
        flash.message = "You have logged out successfully"
        redirect(controller: 'loginPage', action: 'index')

    }

    def createTopic() {
        render([success: topicService.createTopic(session, params)] as JSON)

    }

    def createLink() {

        render([success: linkResourceService.createLink(session, params)] as JSON)

    }

    def createDocument() {
        documentResourceService.createDocument(session, params, flash, request)
        redirect(controller: "dashBoard", action: "dashboard")


    }

    def allusers() {
        List<Users> users = Users.createCriteria().list {
            ne("userName", session.sessionId)
        }
        render(view: 'allusers', model: ['users': users])
    }

    def changestatus() {
        usersService.changeStatus(params, flash)
        redirect(controller: "dashBoard", action: "dashboard")
    }

    def alltopics() {
        List<Topic> topics = Topic.list(sort: 'name')
        render(view: 'alltopics', model: ['topics': topics])
    }

    def allposts() {
        List<LinkResource> lres = LinkResource.list
    }

    def searchtopic() {
        Topic topic = Topic.findById(params.searchtopic)
        Resources resource = Resources.findByTopic(topic)
        List<LinkResource> linkResource = LinkResource.findAllByResource(resource)
        List<DocumentResource> documentResource = DocumentResource.findAllByResource(resource)
        List<Subscriptions> subs = Subscriptions.findAllByTopic(topic)
//        , "linkResource":linkResource,
//        "subscription":subs,"documentResource":documentResource
        render(controller: 'dashBoard', view: 'searchtopic', model: ["searchtopic": topic])
    }

    def subscribe() {

        render(controller: 'dashBoard', view: 'searchtopic', model: subscriptionsService.subscribe(session, params, flash))
    }

    def unsubscribe() {

        render(controller: 'dashBoard', view: 'searchtopic', model: subscriptionsService.unsubscribe(session, params, flash))

    }

    def userprofile() {
        Users user = Users.findByUserName(params.userName)
        List<Topic> topics = Topic.findAllByUser(user)
        List subs = []
        topics.each {
            subs.add(Subscriptions.findAllByUserAndTopic(user, it))


            render(view: 'userprofile', model: ["user": user, "topics": topics, "subs": subs])
        }
    }
    def userupdate() {
//        Users user=Users.findByUserName(session.sessionId)
//        user.properties=params
//        user.save(flush:true,failOnError: true);
//        flash.message="Your profile has been updated"
//        session.sessionId=params.userName
            usersService.userUpdate(session, params, flash)
            redirect(action: 'userprofile')

        }
    def changepass() {
//        Users user = Users.findByUserName(session.sessionId)
//        user.properties=params
//        user.save(flush: true, failOnError: true);
//        flash.message = "Your password has been updated"
            usersService.changePass(session, params, flash)
//        dashboardService.changepass(session,params,flash)
            redirect(action: 'userprofile')
        }
    def editTopic(){

        render([success: topicService.editTopic(session,params)] as JSON)
    }
    def changeTopicSeriousness(){
        render([success: topicService.changeTopicSeriousness(session,params)] as JSON)
    }
    def deleteTopic(){
        render([success: topicService.deleteTopic(session,params)] as JSON)
    }

    }
