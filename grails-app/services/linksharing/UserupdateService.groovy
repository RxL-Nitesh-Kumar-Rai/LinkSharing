package linksharing

import grails.gorm.transactions.Transactional

@Transactional
class UserupdateService {

    def serviceMethod(session,params,flash) {
        Users user=Users.findByUserName(session.sessionId)
        user.properties=params
        user.save(flush:true,failOnError: true);
        flash.message="Your profile has been updated"
        session.sessionId=params.userName
        return true
    }
}
