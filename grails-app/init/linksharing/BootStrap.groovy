package linksharing
//import org.springframework.security.core.userdetails.User

class BootStrap {

    def init = { servletContext ->
//        def md = MessageDigest.getInstance("MD5")
//
//        def file = new File('/home/nitesh/GrailsProject/LinkSharing/img1.jpeg')
//        def fileBytes = FileUtils.readFileToByteArray(file)
//        def fileDigest = md.digest(fileBytes)
//        BufferedImage bImage = ImageIO.read(new File("/home/nitesh/grailsProject/LinkSharing/img1.jpeg"));
//        ByteArrayOutputStream bos = new ByteArrayOutputStream();
//        ImageIO.write(bImage, "jpg", bos );
//        byte [] fileBytes = bos.toByteArray();
//        Users user1=new Users(email:"niteshkumarrai1234@gmail.com",password:"123",firstName:"nitesh",lastName:"rai",
//                photo:'fileBytes',admin:true,active:true,userName:"immortal")
//        user1.save(failOnError:true,flush:true)
//        if(!Role.findByAuthority("ROLE_ADMIN")){
//            Role role = new Role()
//            role.authority = "ROLE_ADMIN"
//            if(role.save(flush: true)) {
//                println "Role Created"
//            } else {
//                println "Error in creating role"
//            }
//        } else {
//            println "Role Exists"
//        }
//        if(!User.count()) {
//            User user = new User()
//            user.username = "shubham.sharma"
//            user.password = "sharmagShubham"
//            if(user.save(flush: true)){
//                println "User created"
//                println "Assigning Role"
//                Role role = Role.findByAuthority("ROLE_ADMIN")
//                UserRole userRole = new UserRole()
//                userRole.user = user
//                userRole.role = role
//                if(userRole.save(flush: true)) {
//                    println "Role Assigned"
//                } else {
//                    println "Error in assinging role"
//                }
//            } else {
//                println "Error in creating User"
//            }
//        } else {
//            println "User Exists"
//        }


    }
    def destroy = {
    }
}
