package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class UsersService {

    def changeStatus(params,flash) {
        Users user=Users.findById(params.userId)
        println params.userId
        println params.status.getClass()
        if(params.status=='1'){
            user.active=false
            user.save(flush:true,failOnError:true)
            flash.message="User has been deactivated"
        }
        else{
            user.active=true
            user.save(flush:true,failOnError:true)
            flash.message="User has been activated"
        }
        return true

    }

    def userUpdate(session,params,flash) {
        Users user=Users.findByUserName(session.sessionId)
        user.firstName=params.firstName
        user.lastName=params.lastName
        user.userName=params.userName
        user.photo=params.photo.bytes
        user.save(flush:true,failOnError: true);
        flash.message="Your profile has been updated"
        session.sessionId=params.userName
        return true
    }

    def changePass(session,params,flash) {
        Users user = Users.findByUserName(session.sessionId)
        user.password=params.password
        user.save(flush: true, failOnError: true);
        println user.properties
        flash.message = "Your password has been updated"
        return true
    }
}
