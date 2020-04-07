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
        readingItem = ReadingItem.createCriteria().list() {
            eq('user', user)
            eq('isRead', false)
        }
        //Trending topic
        List trendingTopic=[]
        List topicList=Topic.createCriteria().list{
            eq ("visibility" ,Topic.Visibility.'Public')
        }
        Map temp = topicList.collectEntries { it ->
            [it, it.resources.linkResources.flatten().size() + it.resources.documentResources.flatten().size()]
        }
        Map temp2 = temp.sort { -it.value }
        List temp3 = []
        temp2.each { temp3.add(it.key) }
        if(temp3.size()>=5) {
             trendingTopic = temp3[0..<5]
        }
        else if(temp3.size()>0 && temp3.size()<5){
             trendingTopic=temp3[0..<temp3.size()]
        }
        //Subscriptions
        List<Subscriptions> tempSub1=Subscriptions.findAllByUser(user)
        List tempSub2=[]
        tempSub1.each{tempSub2.add(it.topic)}
        tempSub2.sort{it.resources.linkResources.lastUpdated && it.resources.documentResources.lastUpdated}
        int length=(tempSub2.size()>=5)?5:tempSub2.size()
        List resSub=tempSub2.reverse()[0..<length]

        render(view: 'dashboard', model: ["user": user, 'readingItem': readingItem, 'trendingTopic': trendingTopic,'subs':resSub])
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

        render([success: subscriptionsService.subscribe(session, params)] as JSON)
    }

    def unsubscribe() {

        render([success: subscriptionsService.unsubscribe(session, params)] as JSON)
    }

    def userprofile(session,params) {
        render(view: 'userprofile', model:usersService.userProfile(session,params))
    }

    def userupdate() {
        usersService.userUpdate(session, params, flash,request)
        redirect(controller: 'dashBoard',action: userprofile(session,params))
        }

    def changepass() {
//        usersService.changePass(session, params, flash)
//        render(controller: 'dashBoard',action: userprofile(session,params))
        render([success: usersService.changePass(session, params)] as JSON)

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
    def allCreatedTopics(){
        render(view:'viewTopics',model: topicService.allCreatedTopics(session))
    }
    def allSubscribedTopics(){
        render(view:'viewTopics',model: topicService.allSubscribedTopics(session))
    }
    def allUserTopics(){
        render(view:'viewTopics',model: topicService.allUserTopics(session))
    }
    }
