package linksharing

import grails.gorm.transactions.Transactional

import javax.servlet.http.HttpSession

@Transactional
class LoginPageService {

    def login(params,flash,request) {

        Users usere=Users.findByEmailAndPassword("${params.lgName}","${params.lgPassword}")
        Users usern=Users.findByUserNameAndPassword("${params.lgName}","${params.lgPassword}")
        Users user=(usern!=null)?usern:usere
        if(user!=null && user.active){
            HttpSession session = request.getSession()
            session.setAttribute("sessionId",user.userName)
            session.setAttribute("validUser",true)
            session.setAttribute("isAdmin",(usern!=null)?usern.admin:usere.admin)
            return true

        }
        else {
            flash.error="wrong email/username or your account has been deactivated"
            return false

        }

    }

    def register(params,flash,request){

        def file =request.getFile("rgPhoto")
        byte[] photo = file.bytes
        def email=params.rgEmail
        def userName=params.rgName
        Users usere=Users.findByEmail(email)
        Users usern=Users.findByUserName(userName)
        if( usere!=null && usern!=null){
            flash.error="Email and username both exist"
        }
        else if(usere!=null && usern==null){
            flash.error="Email exist"
        }
        else if(usere==null && usern!=null){
            flash.error="Username exist"
        }
        else if(usere==null && usern==null) {
            Users user = new Users(firstName: params.rgFname, lastName: params.rgLname, password: params.rgPassword,
                    email: params.rgEmail, photo: photo, admin: true, active: true, userName: params.rgName)
            user.save(failOnError: true, flush: true)
            flash.message="Successfully registered now you can login"
        }
        return true

    }
}
