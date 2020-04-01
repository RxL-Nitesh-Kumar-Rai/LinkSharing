class Users {
    String email
    String password
//    String userId
    String firstName
    String lastName
    String fullName
    String userName
//    byte [] photo
    byte [] photo
    boolean admin
    boolean active
    Date dateCreated
    Date lastUpdated
    static transients=["fullName"]
    String getFullName(){
        return "${firstName} ${lastName}"
    }

    static constraints={
        email(unique:true)
        photo nullable:true
        userName unique: true



    }
    static mapping = {
        table 'Users'
//        photo column: 'image_bytes', sqlType: 'longblob'
    }
    static hasMany = [topics:Topic,subscriptions:Subscriptions,readingItems:ReadingItem]
}
