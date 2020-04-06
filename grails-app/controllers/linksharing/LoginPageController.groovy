package linksharing


import javax.servlet.http.HttpSession

//import grails.plugin.springsecurity.annotation.Secured

class LoginPageController {
//    static allowedMethods = [searchtopic:['POST','GET']]
//    @Secured(['ROLE_ADMIN'])
    def loginPageService
    def index() {
        render(view:"loginpage",model:loginPageService.defaultLogin(session,params,flash))

    }
    def register(){
            loginPageService.register(params,flash,request)
        redirect(action:'index')
    }

    def login(){
        boolean flag=loginPageService.login(params,flash,request)

        if(flag==true){
            redirect(controller:'dashBoard',action:'dashboard')
        }
        else{
            redirect (controller: 'loginPage',action: 'index')
        }
    }
    def viewImage(){
        def user = Users.get(params.userId)
        byte[] imageInByte = user.photo
        response.contentType = 'image/png' // or the appropriate image content type
        response.outputStream << imageInByte
        response.outputStream.flush()
    }
    def forgotPassword(){
        loginPageService.forgotPassword(params,flash)
        redirect(controller: 'loginPage', action: "index")
    }
    def viewChangePassForm(){
        render(controller:'loginPage',view:'changePass')
    }
    def changePass(){
        boolean flag=loginPageService.changePass(params)

        if(flag==true){
            forward(controller: 'loginPage',action: 'viewChangePassForm')
        }
        else{
            flash.message="Invalid link"
            redirect(controller: 'loginPage', action: "index")
        }
    }
    def updatePassword(){
        boolean flag=loginPageService.updatePassword(params)
        if(flag==true){
            flash.message="Your password has been updated"
            redirect(controller: 'loginPage',action: 'index')
        }
        else{
            flash.error="Wrong username"
            redirect(controller: 'loginPage',action: 'index')
        }
    }



}
