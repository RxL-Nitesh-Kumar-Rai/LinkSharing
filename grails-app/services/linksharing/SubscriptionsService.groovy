package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class SubscriptionsService {

    def subscribe(session, params) {
        Topic topic = Topic.findById(params.sub)
        Users user = Users.findByUserName(session.sessionId)
        Subscriptions sub = Subscriptions.findByTopicAndUser(topic, user)
        if (sub == null) {
            Subscriptions subs0 = new Subscriptions(topic: topic, user: user, seriousness: params.seriousness)
            topic.addToSubscriptions(subs0)
            topic.save(flush: true, failOnError: true)
            List<Resources> resource = Resources.findAllByTopic(topic)
            List<LinkResource> tempLinkResource=[]
            List<LinkResource> tempDocumentResource=[]
            resource.each{it->
                tempLinkResource.add(LinkResource.findAllByResource(it))
                tempDocumentResource.add( DocumentResource.findAllByResource(it))
            }
            List<LinkResource> linkResource=tempLinkResource.flatten()
            List<DocumentResource> documentResource=tempDocumentResource.flatten()

            List<Subscriptions> subs = Subscriptions.findAllByTopic(topic)
            if (linkResource.size()>0) {
                linkResource.each { LinkResource alr ->
//                    resource.addToReadingItems(readingItem)
                    resource.each{it2->
                        it2.linkResources.each{it22->
                            if(it22==alr){
                                ReadingItem readingItem = new ReadingItem()
                                readingItem.linkResource = alr
                                readingItem.user = user
                                readingItem.topic = topic
                                readingItem.isRead = false
                                readingItem.resource=it2
                                readingItem.save(flush: true, failOnError: true)
                                user.addToReadingItems(readingItem)
                                it2.addToReadingItems(readingItem)
                                it2.save(flush:true,failOnError: true)
                                user.save(flush: true, failOnError: true)
                            }
                        }
                    }


                }
            }
            if (documentResource.size()>0) {
                documentResource.each { DocumentResource adr ->

//                    resource.addToReadingItems(readingItem)
                    resource.each{it3->
                        it3.documentResources.each{it33->
                            if(it33==adr){
                                ReadingItem readingItem = new ReadingItem()
                                readingItem.documentResource = adr
                                readingItem.user = user
                                readingItem.topic = topic
                                readingItem.isRead = false
                                readingItem.resource=it3
                                readingItem.save(flush: true, failOnError: true)
                                it3.addToReadingItems(readingItem)
                                it3.save(flush:true,failOnError: true)
                                user.save(flush: true, failOnError: true)
                            }
                        }
                    }


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



    def unsubscribe(session,params){
        Topic topic=Topic.findById(params.sub)
        Users user = Users.findByUserName(session.sessionId)
        Subscriptions sub=Subscriptions.findByTopicAndUser(topic,user)
        sub.delete(slush:true,failOnError:true)
        if(sub!=null) {


            List resource=ReadingItem.findAllByTopicAndUser(topic,user)
            resource.each{
                it.delete(flush:true,failOnError:true)
            }
        }
//        Rsources resource=Resources.findByTopic(topic)
//        List<LinkResource> linkResource=LinkResource.findAllByResource(resource)
//        List<DocumentResource> documentResource=DocumentResource.findAllByResource(resource)
//        List<Subscriptions>subs=Subscriptions.findAllByTopic(topic)
//        return(["searchtopic":topic, "linkResource":linkResource, "subscription":subs,"documentResource":documentResource])
        return true
    }
}
