package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class UsersService {

    def changeStatus(params, flash) {
        Users user = Users.findById(params.userId)
        println params.userId
        println params.status.getClass()
        if (params.status == '1') {
            user.active = false
            user.save(flush: true, failOnError: true)
            flash.message = "User has been deactivated"
        } else {
            user.active = true
            user.save(flush: true, failOnError: true)
            flash.message = "User has been activated"
        }
        return true

    }

    def userUpdate(session, params, flash, request) {
        Users user = Users.findByUserName(session.sessionId)
        user.firstName = params.firstName
        user.lastName = params.lastName
        Users user2 = Users.findByUserName(params.userName)
        if (params.userName != user.userName && user2 != null) {
            flash.error = "Username already exist"
            return true
        } else {
            user.userName = params.userName
        }
        if (request.getFile("photo").bytes.size() > 0) {
            def file = request.getFile("photo")
            byte[] photo = file.bytes
            user.photo = photo
        }

        user.save(flush: true, failOnError: true);
        flash.message = "Your profile has been updated"
        session.sessionId = params.userName
        return true
    }

    def changePass(session, params) {
        Users user = Users.findByUserName(session.sessionId)
        user.password = params.password
        user.save(flush: true, failOnError: true);
        return true
    }

    def userProfile(session, params) {
        Users user = Users.findByUserName(params.userName)
        Users currentUser = Users.findByUserName(session.sessionId)
        List<Topic> topics
        List subs
//        List posts
            if ((session.sessionId)&&(currentUser.admin == true || currentUser == user)) {
                topics = Topic.findAllByCreatedBy(user)
                subs = Subscriptions.findAllByUser(user)
                List posts = topics.collect { it ->
                    Resources.createCriteria().list { it2 ->
                        eq('topic', it)
                        eq('createdBy', user)
                    }
                }.flatten()
                List resTemp = []
                posts.each {
                    resTemp.add(it.linkResources)
                    resTemp.add(it.documentResources)
                }
                List resPosts = resTemp.flatten()
                return ["user": user, "topics": topics, "subs": subs, 'posts': resPosts]
            }
        else {
            topics = Topic.findAllByCreatedByAndVisibility(user, Topic.Visibility.'Public')
            topics.each { println it.visibility }
            subs = Subscriptions.createCriteria().list {
                eq('user', user)
                'topic' {
                    eq('visibility', Topic.Visibility.'Public')
                }
            }
            List posts = topics.collect { it ->
                Resources.createCriteria().list { it2 ->
                    eq('topic', it)
                    eq('createdBy', user)
                }
            }.flatten()
            List resTemp = []
            posts.each {
                resTemp.add(it.linkResources)
                resTemp.add(it.documentResources)
            }
            List resPosts = resTemp.flatten()
            return ["user": user, "topics": topics, "subs": subs, 'posts': resPosts]
        }
    }
}
