package linksharing

import grails.events.subscriber.Subscription
import grails.rest.Resource
import org.dom4j.Document
import org.dom4j.io.DocumentResult

class DashBoardController {
    static defaultAction = "dashboard"

    def index() {
    }

    def dashboard(){
        render(view: 'dashboard')
    }
    def logout(){
        session.invalidate()
        redirect(controller: 'loginPage',action: 'index')

    }

    def createtopic() {
        Users user = Users.findByUserName(session.sessionId)
        Topic topic = Topic.findByName(params.tName)

        if (topic != null) {
            Users creator = topic.createdBy
            if(creator == user) {
                flash.error = "You have already created a topic with this topic name"
            }
        } else {
            Topic topicSave = new Topic(name: params.tName, createdBy: user, visibility: params.tType)
            Subscriptions subs=new Subscriptions(topic:topicSave,seriousness:'verySerious',user:user)
            user.addToSubscriptions(subs)
            topicSave.addToSubscriptions(subs)
            user.addToTopics(topicSave)
            user.save(flush:true,failOnError: true)
            flash.message = "Topic has been created and you have subscribed to it"
        }

        redirect(action:'dashboard')

    }
    def createlink(){
        Users user = Users.findByUserName(session.sessionId)
        Topic topic=Topic.findById(params.topiclink)
        Resources resource=Resources.findByTopicAndCreatedBy(topic,user)
        if(resource==null){
            Resources res=new Resources(description:params.linkdescription,createdBy: user, topic: topic)
            LinkResource lr=new LinkResource(url:params.linkurl,description:params.linkdescription)
            res.addToLinkResources(lr)
            topic.addToResources(res)
            topic.save(flush:true,failOnError: true)
            flash.message="Your link resource has been added"
        }
        else{
            LinkResource lr=new LinkResource(url:params.linkurl,description:params.linkdescription)
            resource.addToLinkResources(lr)
            topic.addToTesources(lr)
            topic.save(flush:true,failOnError: true)
            flash.message="your link resource has been added"
        }
        redirect(action:'dashboard')
    }
    def createdocument(){
        Users user = Users.findByUserName(session.sessionId)
        Topic topic=Topic.findById(params.topicdocument)
        Resources resource=Resources.findByTopicAndCreatedBy(topic,user)
        def file1=request.getFile("documentfile")
        String dir1=new Date()
        String dir2=dir1.split(" ").join("")
        String dir= "/home/nitesh/GrailsProject/LinkSharing/DocumentResource/${session.sessionId}${dir2}.pdf"
        file1.transferTo(new File(dir))
        if(resource==null){
            Resources res=new Resources(description:params.documentdescription,createdBy: user, topic: topic)
            DocumentResource dr=new DocumentResource(filePath:dir,description:params.documentdescription)
            res.addToDocumentResources(dr)
            topic.addToResources(res)
            topic.save(flush:true,failOnError: true)
            flash.message="Your document resource has been added"
        }
        else{
            DocumentResource dr=new DocumentResource(filePath:dir,description:params.documentdescription)
            resource.addToDocumentResources(dr)
            topic.addToResources(resource)
            topic.save(flush:true,failOnError: true)
            flash.message="your document resource has been added"
        }
        redirect(action:'dashboard')
    }
     def allusers(){
         List<Users> users=Users.createCriteria().list{
             ne("userName",session.sessionId)
         }
         render(view: 'allusers',model:['users':users])
     }
    def changestatus(){
        Users user=Users.findById(params.userId)
        println params.userId
        println params.status.getClass()
        if(params.status=='1'){
            user.active=false
            user.save(flush:true,failOnError:true)
            flash.message="User has been deactivated"
        }
        else{
            user.active=true
            user.save(flush:true,failOnError:true)
            flash.message="User has been activated"
        }
        redirect(action: 'allusers')
    }

    def alltopics(){
        List<Topic> topics=Topic.list(sort:'name')
        render(view: 'alltopics',model:['topics':topics])
    }
    def allposts(){
        List<LinkResource> lres=LinkResource.list
    }

    def searchtopic(){
            Topic topic=Topic.findById(params.searchtopic)
            Resources resource=Resources.findByTopic(topic)
            List<LinkResource> linkResource=LinkResource.findAllByResource(resource)
            List<DocumentResource> documentResource=DocumentResource.findAllByResource(resource)
            List<Subscriptions>subs=Subscriptions.findAllByTopic(topic)

        render (controller:'dashBoard',view: 'searchtopic',model:["searchtopic":topic, "linkResource":linkResource,
                                                                  "subscription":subs,"documentResource":documentResource])
    }
    def subscribe(){
        Topic topic=Topic.findById(params.sub)
        Users user = Users.findByUserName(session.sessionId)
        Subscriptions subs0=new Subscriptions(topic:topic,user:user,seriousness: params.seriousness)
        topic.addToSubscriptions(subs0)
        user.addToTopics(topic)
        user.save(flush:true,failOnError: true)
        flash.message="You have subscribed this topic with seriousness casual"
        Resources resource=Resources.findByTopic(topic)
        List<LinkResource> linkResource=LinkResource.findAllByResource(resource)
        List<DocumentResource> documentResource=DocumentResource.findAllByResource(resource)
        List<Subscriptions>subs=Subscriptions.findAllByTopic(topic)
        render (controller:'dashBoard',view: 'searchtopic',model:["searchtopic":topic, "linkResource":linkResource,
                                                                  "subscription":subs,"documentResource":documentResource])

    }

    def unsubscribe(){
        Topic topic=Topic.findById(params.unsub)
        Users user = Users.findByUserName(session.sessionId)
//        Subscriptions subs0=new Subscriptions(topic:topic,user:user,seriousness: params.seriousness)
        Subscriptions sub=Subscriptions.findByTopicAndUser(topic,user)
        println sub.properties
        sub.delete(flush:true,failOnError: true)
        println "????????????????????????"
        println sub
//        topic.addToSubscriptions(subs0)
//        user.addToTopics(topic)
//        user.save(flush:true,failOnError: true)
        flash.error="You have unsubscribed this topic"
        Resources resource=Resources.findByTopic(topic)
        List<LinkResource> linkResource=LinkResource.findAllByResource(resource)
        List<DocumentResource> documentResource=DocumentResource.findAllByResource(resource)
        List<Subscriptions>subs=Subscriptions.findAllByTopic(topic)
        render (controller:'dashBoard',view: 'searchtopic',model:["searchtopic":topic, "linkResource":linkResource,
                                                                  "subscription":subs,"documentResource":documentResource])

    }

}
