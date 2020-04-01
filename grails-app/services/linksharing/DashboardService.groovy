//package linksharing
//
//import grails.converters.JSON
//import grails.gorm.transactions.Transactional
//
//@Transactional
//class DashboardService {
//
//    def serviceMethod() {
//
//    }
//
//    def createtopic(session, params, flash) {
//        Users user = Users.findByUserName(session.sessionId)
//        Topic topic = Topic.findByName(params.tName)
//
//        if (topic != null) {
//            Users creator = topic.createdBy
//            if (creator == user) {
//                flash.error = "You have already created a topic with this topic name"
//            }
//        } else {
//            Topic topicSave = new Topic(name: params.tName, createdBy: user, visibility: params.tType)
//            Subscriptions subs = new Subscriptions(topic: topicSave, seriousness: 'verySerious', user: user)
//            user.addToSubscriptions(subs)
//            topicSave.addToSubscriptions(subs)
//            user.addToTopics(topicSave)
//            user.save(flush: true, failOnError: true)
//            flash.message = "Topic has been created and you have subscribed to it"
//        }
//        return (["user":user,"topic":topic] as JSON)
//
//    }
//
//    def createlink(session, params, flash) {
//        Users user = Users.findByUserName(session.sessionId)
//        Topic topic = Topic.findById(params.topiclink)
//        Resources resource = Resources.findByTopicAndCreatedBy(topic, user)
//        if (resource == null) {
//            Resources res = new Resources(description: params.linkdescription, createdBy: user, topic: topic)
//            LinkResource lr = new LinkResource(url: params.linkurl, description: params.linkdescription)
//            res.addToLinkResources(lr)
//            topic.addToResources(res)
//            topic.save(flush: true, failOnError: true)
//            flash.message = "Your link resource has been added"
//        } else {
//            LinkResource lr = new LinkResource(url: params.linkurl, description: params.linkdescription)
//            resource.addToLinkResources(lr)
//            topic.addToTesources(lr)
//            topic.save(flush: true, failOnError: true)
//            flash.message = "your link resource has been added"
//        }
//        return true
//    }
//
//    def createdocument(session, params, flash, request) {
//        Users user = Users.findByUserName(session.sessionId)
//        Topic topic = Topic.findById(params.topicdocument)
//        Resources resource = Resources.findByTopicAndCreatedBy(topic, user)
//        def file1 = request.getFile("documentfile")
////        File file1=params.documentfile
//        String dir1 = new Date()
//        String dir2 = dir1.split(" ").join("")
//        String dir = "/home/nitesh/GrailsProject/LinkSharing/DocumentResource/${session.sessionId}${dir2}.pdf"
//        file1.transferTo(new File(dir))
//        if (resource == null) {
//            Resources res = new Resources(description: params.documentdescription, createdBy: user, topic: topic)
//            DocumentResource dr = new DocumentResource(filePath: dir, description: params.documentdescription)
//            res.addToDocumentResources(dr)
//            topic.addToResources(res)
//            topic.save(flush: true, failOnError: true)
//            flash.message = "Your document resource has been added"
//        } else {
//            DocumentResource dr = new DocumentResource(filePath: dir, description: params.documentdescription)
//            resource.addToDocumentResources(dr)
//            topic.addToResources(resource)
//            topic.save(flush: true, failOnError: true)
//            flash.message = "your document resource has been added"
//        }
//        return true
//    }
//
//    def changestatus(session, params, flash) {
//        Users user = Users.findById(params.userId)
//        println params.userId
//        println params.status.getClass()
//        if (params.status == '1') {
//            user.active = false
//            user.save(flush: true, failOnError: true)
//            flash.message = "User has been deactivated"
//        } else {
//            user.active = true
//            user.save(flush: true, failOnError: true)
//            flash.message = "User has been activated"
//        }
//        return true
//    }
//
//    def subscribe(session,params,flash) {
//        Topic topic = Topic.findById(params.sub)
//        Users user = Users.findByUserName(session.sessionId)
//        Subscriptions sub = Subscriptions.findByTopicAndUser(topic, user)
//        if (sub == null) {
//            Subscriptions subs0 = new Subscriptions(topic: topic, user: user, seriousness: params.seriousness)
//            topic.addToSubscriptions(subs0)
//            user.addToTopics(topic)
//            user.save(flush: true, failOnError: true)
//            flash.message = "You have subscribed this topic with seriousness ${params.seriousness}"
//            Resources resource = Resources.findByTopic(topic)
//            List<LinkResource> linkResource = LinkResource.findAllByResource(resource)
//            List<DocumentResource> documentResource = DocumentResource.findAllByResource(resource)
//            List<Subscriptions> subs = Subscriptions.findAllByTopic(topic)
//            return (["searchtopic": topic, "linkResource": linkResource, "subscription": subs, "documentResource": documentResource])
//        } else {
//            Resources resource = Resources.findByTopic(topic)
//            List<LinkResource> linkResource = LinkResource.findAllByResource(resource)
//            List<DocumentResource> documentResource = DocumentResource.findAllByResource(resource)
//            List<Subscriptions> subs = Subscriptions.findAllByTopic(topic)
//            return (["searchtopic": topic, "linkResource": linkResource, "subscription": subs, "documentResource": documentResource])
//
//        }
//    }
//
//    def unsubscribe(session, params, flash) {
//        Topic topic=Topic.findById(params.sub)
//        Users user = Users.findByUserName(session.sessionId)
//        Subscriptions sub=Subscriptions.findByTopicAndUser(topic,user)
//        if(sub!=null) {
//            sub.delete(flush: true, failOnError: true)
//            flash.error="You have unsubscribed this topic"
//        }
//
//        Resources resource=Resources.findByTopic(topic)
//        List<LinkResource> linkResource=LinkResource.findAllByResource(resource)
//        List<DocumentResource> documentResource=DocumentResource.findAllByResource(resource)
//        List<Subscriptions>subs=Subscriptions.findAllByTopic(topic)
//        return(["searchtopic":topic, "linkResource":linkResource, "subscription":subs,"documentResource":documentResource])
//    }
//
//    def userupdate(session, params, flash) {
//        Users user = Users.findByUserName(session.sessionId)
//        user.properties = params
//        user.save(flush: true, failOnError: true);
//        flash.message = "Your profile has been updated"
//        session.sessionId = params.userName
//        return true
//    }
//
//    def changepass(session, params, flash) {
//        Users user = Users.findByUserName(session.sessionId)
//        user.password = params.password
//        user.save(flush: true, failOnError: true);
//        println user.properties
//        flash.message = "Your password has been updated"
//
//    }
//}