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
            return ["post":lr,"type":"link","trendTopic":res]
        }
        else{
            return ["post":dr,"type":"document","trendTopic":res]
        }

    }
    def ratePost(session,params){
        Users user=Users.findByUserName(session.sessionId)
        if(params.postType=="link"){
//            LinkResource lr=LinkResource.findByIdAndRatedBy(params.postId,user)
            LinkResource linkResource=LinkResource.get(params.postId)
            ResourceRating rr=ResourceRating.createCriteria().get{
                eq('linkResource',linkResource)
                'ratedBy' {
                    eq('id',user.id)
                }
            }
            if(rr==null) {
//                LinkResource lr1=LinkResource.findById(params.postId)
//                lr1.totalRating += params.int("rating")
//                lr1.totalRatedBy += 1
//                lr1.ratedBy=user
//                lr1.save(flush: true, failOnError: true)
//                return true
                ResourceRating resourceRating=new ResourceRating()
                resourceRating.linkResource=linkResource
                resourceRating.addToRatedBy(user)
                resourceRating.totalRating+=params.int("rating")
                resourceRating.totalRatedBy+=1
                resourceRating.save(flush:true,failOnError: true)
                return true
            }
            else{
                return false
            }

        }
        else{
//            DocumentResource dr=DocumentResource.findByIdAndRatedBy(params.postId,user)
            DocumentResource documentResource=DocumentResource.get(params.postId)
            ResourceRating rr=ResourceRating.createCriteria().get{
                eq('documentResource',documentResource)
                'ratedBy' {
                    eq('id',user.id)
                }
            }
            if(rr==null){
//                DocumentResource dr1=DocumentResource.findById(params.postId)
//                dr1.totalRating+=params.int("rating")
//                dr1.totalRatedBy+=1
//                dr1.ratedBy=user
//                dr1.save(flush:true,failOnError:true)
//                return true
                ResourceRating resourceRating=new ResourceRating()
                resourceRating.documentResource=documentResource

                resourceRating.totalRating+=params.int("rating")
                resourceRating.totalRatedBy+=1
                resourceRating.addToRatedBy(user)
                resourceRating.save(flush:true,failOnError: true)
                return true
            }
            else{
                return false
            }
        }
    }

    def deletePost(session,params){
        if(params.postType=="link"){
            LinkResource lr=LinkResource.get(params.postId)
            if(session.isAdmin || lr.resource.createdBy.userName==session.sessionId) {
                if(ResourceRating.findByLinkResource(lr)){
                    ResourceRating.findByLinkResource(lr).delete()
                }
                lr.delete()
                return true
            }
            else{
                return false
            }
        }
        else{
            DocumentResource dr=DocumentResource.get(params.postId)
            if(session.isAdmin || dr.resource.createdBy.userName==session.sessionId) {
                if(ResourceRating.findByDocumentResource(dr)){
                    ResourceRating.findByDocumentResource(dr).delete()
                }
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
        ReadingItem readingItem=ReadingItem.get(params.postId)
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
}
