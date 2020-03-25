package linksharing

//import grails.plugin.springsecurity.annotation.Secured

class LoginPageController {
//    static allowedMethods = [searchtopic:['POST','GET']]
//    @Secured(['ROLE_ADMIN'])
    def index() {
        List<Topic> topic=Topic.createCriteria().list(offset:0,max:5,sort:'lastUpdated',order:'desc'){
            eq ("visibility" ,Topic.Visibility.'Public')
        }
        render(view:"loginpage",model:["topic":topic])
    }
    def register(){
            def file =request.getFile("rgPhoto")
            byte[] photo = file.bytes
//            byte [] photo=params.rgPhoto.bytes



            def email=params.rgEmail
            def userName=params.rgName
            Users usere=Users.findByEmail(email)
            Users usern=Users.findByUserName(userName)
            if( usere!=null && usern!=null){
                flash.error="Email and username both exist"
                redirect(action: index())
            }
            else if(usere!=null && usern==null){
                flash.error="Email exist"
                redirect(action: 'index')
            }
            else if(usere==null && usern!=null){
                flash.error="Username exist"
                redirect(action: index())
            }
        else if(usere==null && usern==null) {


                Users user = new Users(firstName: params.rgFname, lastName: params.rgLname, password: params.rgPassword,
                        email: params.rgEmail, photo: photo, admin: true, active: true, userName: params.rgName)
                    user.save(failOnError: true, flush: true)
                flash.message="Successfully registered now you can login"
                redirect(action: index())

            }
    }

    def login(){
        Users usere=Users.findByEmailAndPassword("${params.lgName}","${params.lgPassword}")
        Users usern=Users.findByUserNameAndPassword("${params.lgName}","${params.lgPassword}")
        println usere
        println usern
        println "++++++++++++++++++++++++++++++++"
        if((usere!=null || usern!=null)){
            session.setAttribute("sessionId",(usern!=null)?usern.userName:usere.userName)
            session.setAttribute("validUser",true)
            session.setAttribute("isAdmin",(usern!=null)?usern.admin:usere.admin)
            redirect(controller:'dashBoard',action:'dashboard')
        }
        else {
            flash.error="wrong email/username or your account has been deactivated"
                redirect (action: 'index')
            }
    }



}
