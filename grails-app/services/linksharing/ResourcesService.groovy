package linksharing

import grails.gorm.transactions.Transactional
import grails.rest.Resource
import org.dom4j.Document

@Transactional
class ResourcesService {

    def index(params,flash){



    }

    def viewPost(session,params) {
        LinkResource lr=LinkResource.findById(params.postId)
        DocumentResource dr=DocumentResource.findById(params.postId)
        List t=Topic.createCriteria().list{
            eq ("visibility" ,Topic.Visibility.'Public')
        }
        def n=t.collectEntries{it->
            [it,it.resources.linkResources.size()+it.resources.documentResources.size()]
        }
        def m=n.sort{-it.value}
        def l=[]
        m.each{l.add( it.key)}
        def res=[]
        if(l.size()>=5) {
             res = l[0..<5]
        }
        else if(l.size()>0 && l.size()<5){
            res=l[0..<l.size()]
        }
        if (lr!=null){
            println lr
            return ["post":lr,"type":"link","trendTopic":res]
        }
        else{
            println dr
            return ["post":dr,"type":"document","trendTopic":res]
        }
    }
    def ratePost(session,params){
        Users user=Users.findByUserName(session.sessionId)
        if(user!=null){
            if(params.postType=="link"){
                LinkResource linkResource=LinkResource.get(params.postId)
                ResourceRating rr=ResourceRating.createCriteria().get{
                    eq('linkResource',linkResource)
                    'ratedBy' {
                        eq('id',user.id)
                    }
                }
                if(rr==null) {
                    ResourceRating resourceRating=new ResourceRating()
                    resourceRating.linkResource=linkResource
                    resourceRating.ratedBy=user
                    resourceRating.rating=params.int("rating")
                    linkResource.addToResourceRatings(resourceRating)
                    linkResource.save(flush:true,failOnError:true)
                    return true
                }
                else{
                    rr.rating=params.int("rating")
                    return true
                }

            }
            else{
                DocumentResource documentResource=DocumentResource.get(params.postId)
                ResourceRating rr=ResourceRating.createCriteria().get{
                    eq('documentResource',documentResource)
                    'ratedBy' {
                        eq('id',user.id)
                    }
                }
                if(rr==null){
                    ResourceRating resourceRating=new ResourceRating()
                    resourceRating.documentResource=documentResource
                    resourceRating.rating=params.int("rating")
                    resourceRating.ratedBy=user
                    documentResource.addToResourceRatings(resourceRating)
                    documentResource.save(flush:true,failOnError:true)

                    return true
                }
                else{
                    rr.rating=params.int("rating")
                    return true
                }
            }
        }
        else{
            return false
        }
    }

    def deletePost(session,params,flash){
        if(params.postType=="link"){
            LinkResource lr=LinkResource.get(params.postId)
            if(session.isAdmin || lr.resource.createdBy.userName==session.sessionId) {
//                if(ResourceRating.findByLinkResource(lr)){
//                    ResourceRating.findByLinkResource(lr).delete()
//                }
                lr.delete()
                flash.message="Your post has been deleted"
                return true
            }
            else{
                return false
            }
        }
        else{
            DocumentResource dr=DocumentResource.get(params.postId)
            if(session.isAdmin || dr.resource.createdBy.userName==session.sessionId) {
//                if(ResourceRating.findByDocumentResource(dr)){
//                    ResourceRating.findByDocumentResource(dr).delete()
//                }
                dr.delete()
                return true
            }
            else{
                return false
            }
        }

    }

    def downloadPost(params,response){
        DocumentResource  dr=DocumentResource.get(params.postId)
        File file = new File(dr.filePath)
        byte [] orderPDF=file.bytes      //getBytes()
        response.setHeader("Content-disposition", "attachment; filename=" + file.name)
        response.contentType = "application/octet-stream"  //file-mime-type
        response.contentLength = orderPDF.length
        response.outputStream << orderPDF
        response.outputStream.flush()
        response.outputStream.close()
        return
    }

    def markAsReadPost(session,params){
        ReadingItem readingItem
        LinkResource linkResource=LinkResource.get(params.postId)
        DocumentResource documentResource=DocumentResource.get(params.postId)
        if(linkResource!=null) {
             readingItem = ReadingItem.findByLinkResource(linkResource)
        }
        else{
             readingItem = ReadingItem.findByDocumentResource(documentResource)
        }
        if(readingItem.user.userName==session.sessionId) {
            readingItem.isRead = true
            return true
        }
        else{
            return false
        }
    }
    def editPost(session,params){
        LinkResource linkResource=LinkResource.get(params.postId)
        DocumentResource documentResource=DocumentResource.get(params.postId)
        if(linkResource!=null){
            if(session.isAdmin || linkResource.resource.createdBy.userName==session.sessionId) {
                linkResource.description = params.postDescription
                return true
            }
            else{
                return false
            }
        }
        else{
            if(session.isAdmin || documentResource.resource.createdBy.userName==session.sessionId) {
                documentResource.description = params.postDescription
                return true
            }
            else{
                return false
            }
        }
        return false
    }
    def sendInvitation(params){
        sendMail  {
            to params.emailInvite
            subject "Link to subscribe to topic"
            body 'Please login first then click on this link to subscribe\n' +
                    'http://localhost:9090/dashBoard/subscribe?sub='+params.emailTopic+'&seriousness=verySerious'
        }
        return true
    }
    def searchPage(session,params){
        //Trending topic
        List trendingTopic=[]
        List topicList = Topic.list()
        def temp = topicList.collectEntries { it ->
            [it, it.resources.linkResources.size() + it.resources.documentResources.size()]
        }
        def temp2 = temp.sort { -it.value }
        List temp3 = []
        temp2.each { temp3.add(it.key) }
        if(temp3.size()>=5) {
            trendingTopic = temp3[0..<5]
        }
        else if(temp3.size()>0 && temp3.size()<5){
            trendingTopic=temp3[0..<temp3.size()]
        }
        //Top post
        List resTpLr=LinkResource.list()
        List resTpDr=DocumentResource.list()
        List resourceList=resTpLr+resTpDr
        def rat=resourceList.collectEntries{it->
            def tRat=0
            it.resourceRatings.each{it2->tRat+=it2.rating}
            [it,tRat]
        }
        def tempRat=rat.sort{-it.value}
        def tempRat2=[]
        tempRat.each{tempRat2.add(it.key)}
        def resTp=tempRat2[0..<((tempRat2.size()<5)?tempRat2.size():5)]
        //Search users by name
        String search=params.search
        List<Users> users=Users.createCriteria().list(sort:'userName'){
            ilike('userName','%'+search+'%')
        }
        //To search
        List posts
        List topics
        if(!session.sessionId) {
            //Search topic by name
            topics = Topic.createCriteria().list {
                ilike('name', '%' + search + '%')
                eq('visibility', Topic.Visibility.'Public')
            }
            List<LinkResource> linkResource = LinkResource.createCriteria().list() {
                ilike('description', '%' +search+ '%')
                'resource'{
                    'topic'{
                        eq('visibility',Topic.Visibility.'Public')
                    }
                }
            }
            List<DocumentResource> documentResource = DocumentResource.createCriteria().list() {
                ilike('description', '%' +search+ '%')
                'resource'{
                    'topic'{
                        eq('visibility',Topic.Visibility.'Public')
                    }
                }
            }
            posts = linkResource + documentResource
        }
        else if(session.sessionId && !session.isAdmin){
            //Search topic by name
            topics = Topic.createCriteria().list{
                ilike('name', '%' + search + '%')
                eq('visibility', Topic.Visibility.'Public')
            }
            List<LinkResource> linkResource = LinkResource.createCriteria().list() {
                ilike('description', '%' +search+ '%')
                'resource'{
                    'topic'{
                        eq('visibility',Topic.Visibility.'Public')
                    }
                }
            }
            List<DocumentResource> documentResource = DocumentResource.createCriteria().list() {
                ilike('description', '%' +search+ '%')
                'resource'{
                    'topic'{
                        eq('visibility',Topic.Visibility.'Public')
                    }
                }
            }
            posts = linkResource + documentResource
        }
        else{
            topics=Topic.createCriteria().list{
                ilike('name','%'+search+'%')
            }
            List linkResource=LinkResource.createCriteria().list{
                ilike('description','%'+search+'%')
            }
            List documentResource=DocumentResource.createCriteria().list{
                ilike('description','%'+search+'%')
            }
            posts=linkResource+documentResource

        }
        return ["topPost":resTp,"trendingTopic":trendingTopic,'users':users,'topics':topics,'posts':posts]
    }
    def allPosts(){
        def posts
        List linkResource=LinkResource.list()
        List documentResource=DocumentResource.list()
        posts=linkResource+documentResource
        return ['posts':posts]
    }
}
