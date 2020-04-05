package linksharing

class InviteLinkController {

    def index() {
    }
    def sendInvite(){
        Topic topic=Topic.get(params.emailTopic)
        InviteLink inviteLink=new InviteLink(email:params.emailInvite,topic:topic,token:true)
        inviteLink.save(flush:true,failOnError:true)
        sendMail  {
            to params.emailInvite
            subject "Link to subscribe to topic"
            body 'Please login first then click on this link to subscribee\n' +
                    'http://localhost:9090/inviteLink/receiveInvite?email='+params.emailInvite+'&topicId='+params.emailTopic+'&user'
        }
        return true
    }
    def receiveInvite(){
        InviteLink inviteLink=InviteLink.findByEmailAndTopicAndToken(params.email,Topic.get(params.topicId),true)
        if(inviteLink!=null){
            params.sub=params.topicId
            println params.sub
            params.seriousness="casual"
            inviteLink.delete(flush:true)
            /////
            Topic topic = Topic.findById(params.topicId)
            Users user = Users.findByUserName(session.sessionId)
            Subscriptions sub = Subscriptions.findByTopicAndUser(topic, user)
            if (sub == null) {
                Subscriptions subs0 = new Subscriptions(topic: topic, user: user, seriousness: params.seriousness)
                topic.addToSubscriptions(subs0)
                topic.save(flush: true, failOnError: true)
                Resources resource = Resources.findByTopic(topic)
                List<LinkResource> linkResource = LinkResource.findAllByResource(resource)
                List<DocumentResource> documentResource = DocumentResource.findAllByResource(resource)
                List<Subscriptions> subs = Subscriptions.findAllByTopic(topic)
                if (linkResource) {
                    linkResource.each { LinkResource alr ->
                        ReadingItem readingItem = new ReadingItem()
                        readingItem.linkResource = alr
                        readingItem.user = user
                        readingItem.topic = topic
                        readingItem.isRead = false
                        resource.addToReadingItems(readingItem)
                        resource.save(flush:true,failOnError: true)
                        user.addToReadingItems(readingItem)
                        user.save(flush: true, failOnError: true)
                        readingItem.save(flush: true, failOnError: true)
                    }
                }
                if (documentResource) {
                    documentResource.each { DocumentResource adr ->
                        ReadingItem readingItem = new ReadingItem()
                        readingItem.documentResource = adr
                        readingItem.user = user
                        readingItem.topic = topic
                        readingItem.isRead = false
                        resource.addToReadingItems(readingItem)
                        resource.save(flush:true,failOnError: true)
                        user.addToReadingItems(readingItem)
                        user.save(flush: true, failOnError: true)
                        readingItem.save(flush: true, failOnError: true)
                    }
                }
//            return (["searchtopic": topic, "linkResource": linkResource, "subscription": subs, "documentResource": documentResource])
                return true
            }
            else {
                Resources resource = Resources.findByTopic(topic)
                List<LinkResource> linkResource = LinkResource.findAllByResource(resource)
                List<DocumentResource> documentResource = DocumentResource.findAllByResource(resource)
                List<Subscriptions> subs = Subscriptions.findAllByTopic(topic)
//            return (["searchtopic": topic, "linkResource": linkResource, "subscription": subs, "documentResource": documentResource])
                return false
            }
        }
        else{
            render "Your link has expired"
        }
    }
}
