package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class LinkResourceService {

    def createLink(session,params) {
        Users user = Users.findByUserName(session.sessionId)
        Topic topic=Topic.findById(params.topicLink)
        Resources resource=Resources.findByTopicAndCreatedBy(topic,user)
        if(resource==null){
            Resources res=new Resources(description:params.linkDescription,createdBy: user, topic: topic)
            LinkResource lr=new LinkResource(url:params.linkUrl,description:params.linkDescription)
            res.addToLinkResources(lr)
            topic.addToResources(res)
            topic.save(flush:true,failOnError: true)
        }
        else{
            LinkResource lr=new LinkResource(url:params.linkUrl,description:params.linkDescription)
            resource.addToLinkResources(lr)
            topic.addToResources(resource)
            topic.save(flush:true,failOnError: true)
        }
        return true
    }
}
