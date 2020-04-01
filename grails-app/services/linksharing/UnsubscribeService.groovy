package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class UnsubscribeService {

    def serviceMethod(session,params,flash) {
        Topic topic=Topic.findById(params.sub)
        Users user = Users.findByUserName(session.sessionId)
        Subscriptions sub=Subscriptions.findByTopicAndUser(topic,user)
        if(sub!=null) {
            sub.delete(flush: true, failOnError: true)
            flash.error="You have unsubscribed this topic"
        }

        Resources resource=Resources.findByTopic(topic)
        List<LinkResource> linkResource=LinkResource.findAllByResource(resource)
        List<DocumentResource> documentResource=DocumentResource.findAllByResource(resource)
        List<Subscriptions>subs=Subscriptions.findAllByTopic(topic)
        return(["searchtopic":topic, "linkResource":linkResource, "subscription":subs,"documentResource":documentResource])

    }
}
