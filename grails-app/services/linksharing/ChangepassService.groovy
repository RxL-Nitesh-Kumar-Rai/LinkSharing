package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class ChangepassService {

    def serviceMethod(session,params,flash) {
        Users user = Users.findByUserName(session.sessionId)
        user.password=params.password
        user.save(flush: true, failOnError: true);
        println user.properties
        flash.message = "Your password has been updated"

    }
}
