package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class SubscribeService {

    def unsubscribe(session,params,flash) {
        Topic topic = Topic.findById(params.sub)
        Users user = Users.findByUserName(session.sessionId)
        Subscriptions sub = Subscriptions.findByTopicAndUser(topic, user)
        if (sub == null) {
            Subscriptions subs0 = new Subscriptions(topic: topic, user: user, seriousness: params.seriousness)
            topic.addToSubscriptions(subs0)
            user.addToTopics(topic)
            user.save(flush: true, failOnError: true)
            flash.message = "You have subscribed this topic with seriousness casual"
            Resources resource = Resources.findByTopic(topic)
            List<LinkResource> linkResource = LinkResource.findAllByResource(resource)
            List<DocumentResource> documentResource = DocumentResource.findAllByResource(resource)
            List<Subscriptions> subs = Subscriptions.findAllByTopic(topic)
            return (["searchtopic": topic, "linkResource": linkResource, "subscription": subs, "documentResource": documentResource])
        } else {
            Resources resource = Resources.findByTopic(topic)
            List<LinkResource> linkResource = LinkResource.findAllByResource(resource)
            List<DocumentResource> documentResource = DocumentResource.findAllByResource(resource)
            List<Subscriptions> subs = Subscriptions.findAllByTopic(topic)
            return (["searchtopic": topic, "linkResource": linkResource, "subscription": subs, "documentResource": documentResource])

        }
    }
}
