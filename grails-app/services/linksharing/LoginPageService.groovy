package linksharing

import grails.gorm.transactions.Transactional

import javax.servlet.http.HttpSession

@Transactional
class LoginPageService {

    def defaultLogin(session,params,flash){
        List resTpLr=LinkResource.list()
        List resTpDr=DocumentResource.list()
        List resourceList=resTpLr+resTpDr
        Map rat=resourceList.collectEntries{it->
            int tRat=0
            it.resourceRatings.each{it2->tRat+=it2.rating}
            [it,tRat]
        }
        Map tempRat=rat.sort{-it.value}
        List tempRat2=[]
        tempRat.each{tempRat2.add(it.key)}
        List resTp=tempRat2[0..<((tempRat2.size()<5)?tempRat2.size():5)]

        if(Resources.list().size()>=5) {
            List topic = Topic.createCriteria().list(offset: 0, max: 5, sort: "lastUpdated", order: "desc") {
                eq("visibility", Topic.Visibility.'Public')
            }
            List res1 = []
            topic.each { res1.add(it.resources.linkResources) }
            topic.each { res1.add(it.resources.documentResources) }
            List res = res1.flatten().sort { a, b -> b.'lastUpdated' <=> a.'lastUpdated' }[0..<(res1.flatten().size()<5?res1.flatten().size():5)]

            return ["post":res,"topPost":resTp]
        }
        else if(Topic.list().size()>0 &&Topic.list().size()<5){
            List topic = Topic.createCriteria().list(offset: 0, max: 5, sort: "lastUpdated", order: "desc") {
                eq("visibility", Topic.Visibility.'Public')
            }
            List res1 = []
            topic.each { res1.add(it.resources.linkResources) }
            topic.each { res1.add(it.resources.documentResources) }
            List res = res1.flatten().sort { a, b -> b.'lastUpdated' <=> a.'lastUpdated' }[0..<res1.flatten().size()]

            return ["post":res,"topPost":resTp]
        }
        else{
            List res=[]
            return ["post":res,"topPost":resTp]
        }

    }

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

//        def file =request.getFile("rgPhoto")
//        byte[] photo = file.bytes
        byte[] photo
        if (request.getFile("rgPhoto").bytes.size() > 0) {
            def file = request.getFile("photo")
            photo = file.bytes
        }
        else{
            File file=new File("/home/nitesh/GrailsProject/LinkSharing/grails-app/assets/images/profile.png")
            photo=file.bytes
        }
        String email=params.rgEmail
        String userName=params.rgName
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
                    email: params.rgEmail, photo: photo, admin: false, active: true, userName: params.rgName)
            user.validate()
            if(user.errors.hasFieldErrors('email')){
                flash.error="Enter a valid email"
                return true
            }
            else {
                user.save(failOnError: true, flush: true)
            }
            flash.message="Successfully registered now you can login"
        }
        return true

    }
    def forgotPassword(params,flash){
        String val=params.loginDetail
        Users user1=Users.findByEmail(val)
        Users user2=Users.findByUserName(val)
        Users user=user1?user1:user2
        String token=UUID.randomUUID().toString()
        if(user){
            InviteLink inviteLink=new InviteLink(userId:user.id,token:token)
            inviteLink.save(flush:true,failOnError:true)
            sendMail  {
                to user.email
                subject "Link to change password"
//                body "Your password is->\n ${user.password}"
                body "http://localhost:9090/loginPage/changePass/?token=${token}&userId=${user.id}"
            }
            flash.message="Link to change your password has been sent to your email account"
        }
        else{
            flash.error="Wrong username/email"
        }
        return true
    }
    def changePass(params){
        InviteLink inviteLink=InviteLink.findByUserIdAndToken(params.userId,params.token)
        if(inviteLink!=null){
            inviteLink.delete()
            return true
        }
        else{
            return false
        }
    }
    def updatePassword(params){
        Users user=Users.findByUserName(params.userName)
        if(user!=null){
            user.password=params.password
            return true
        }
        else{
            return false
        }
    }
}
