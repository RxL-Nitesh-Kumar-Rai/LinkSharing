package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class DocumentResourceService {

    def createDocument(session,params,flash,request) {
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
            return true
        }
        else{
            DocumentResource dr=new DocumentResource(filePath:dir,description:params.documentdescription)
            resource.addToDocumentResources(dr)
            topic.addToResources(resource)
            topic.save(flush:true,failOnError: true)
            flash.message="your document resource has been added"
            return true
        }

    }
}
