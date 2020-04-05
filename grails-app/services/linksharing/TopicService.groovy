package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class TopicService {


    def createTopic(session, params) {
        Users user = Users.findByUserName(session.sessionId)
        Topic topic = Topic.findByName(params.tName)
        if (topic != null) {
            Users creator = topic.createdBy
            if (creator == user) {
                return false
            }
        } else {
            Topic topicSave = new Topic(name: params.tName, createdBy: user, visibility: params.tType)
            Subscriptions subs = new Subscriptions(topic: topicSave, seriousness: 'verySerious', user: user)
            user.addToSubscriptions(subs)
            topicSave.addToSubscriptions(subs)
            user.addToTopics(topicSave)
            user.save(flush: true, failOnError: true)
            return true
        }
    }
    def editTopic(session,params){
        Topic topic=Topic.get(params.topicId)
        if(session.isAdmin || session.sessionId==topic.createdBy) {
            topic.name = params.topicName
            topic.visibility = params.topicType
            return true
        }
        else{
            return false
        }
    }
    def changeTopicSeriousness(session,params){
        Topic topic=Topic.findById(params.topicId)
        Users user = Users.findByUserName(session.sessionId)
        Subscriptions subs = Subscriptions.findByTopicAndUser(topic, user)
        if(subs!=null) {
            subs.seriousness = params.topicSeriousness
            return true
        }
        else{
            return false
        }
    }
    def deleteTopic(session,params){
        Topic topic=Topic.get(params.topicId)
        if(session.isAdmin || session.sessionId==topic.createdBy) {
            topic.delete()
            return true
        }
        else{
            return false
        }
    }
}