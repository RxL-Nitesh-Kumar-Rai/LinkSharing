package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class SubscriptionsService {

    def subscribe(session, params, flash) {
        Topic topic = Topic.findById(params.sub)
        Users user = Users.findByUserName(session.sessionId)
        Subscriptions sub = Subscriptions.findByTopicAndUser(topic, user)
        if (sub == null) {
            Subscriptions subs0 = new Subscriptions(topic: topic, user: user, seriousness: params.seriousness)
            topic.addToSubscriptions(subs0)
//            user.addToTopics(topic)
            topic.save(flush: true, failOnError: true)
            flash.message = "You have subscribed this topic with seriousness casual"
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
            return (["searchtopic": topic, "linkResource": linkResource, "subscription": subs, "documentResource": documentResource])
        }
        else {
            Resources resource = Resources.findByTopic(topic)
            List<LinkResource> linkResource = LinkResource.findAllByResource(resource)
            List<DocumentResource> documentResource = DocumentResource.findAllByResource(resource)
            List<Subscriptions> subs = Subscriptions.findAllByTopic(topic)
            return (["searchtopic": topic, "linkResource": linkResource, "subscription": subs, "documentResource": documentResource])

        }
    }



    def unsubscribe(session,params,flash){
        Topic topic=Topic.findById(params.sub)
        Users user = Users.findByUserName(session.sessionId)
        Subscriptions sub=Subscriptions.findByTopicAndUser(topic,user)
        if(sub!=null) {
            sub.delete(flush: true, failOnError: true)
            Resources resource = Resources.findByTopic(topic)
            List<LinkResource> linkResource = LinkResource.findAllByResource(resource)
            List<DocumentResource> documentResource = DocumentResource.findAllByResource(resource)
            if(linkResource){
                linkResource.each{LinkResource dlr->
                    ReadingItem lri=ReadingItem.findByLinkResourceAndUser(dlr,user)
                    lri.delete()
                }
            }
            if(documentResource){
                documentResource.each{DocumentResource ddr->
                    ReadingItem dri=ReadingItem.findByDocumentResourceAndUser(ddr,user)
                    dri.delete()
                }
            }
            flash.error="You have unsubscribed this topic"
        }

        Resources resource=Resources.findByTopic(topic)
        List<LinkResource> linkResource=LinkResource.findAllByResource(resource)
        List<DocumentResource> documentResource=DocumentResource.findAllByResource(resource)
        List<Subscriptions>subs=Subscriptions.findAllByTopic(topic)
        return(["searchtopic":topic, "linkResource":linkResource, "subscription":subs,"documentResource":documentResource])

    }
}
