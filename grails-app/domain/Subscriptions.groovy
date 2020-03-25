class Subscriptions {
    Topic topic
//    static hasMany = [users:Users]
    Users user
    Date dateCreated
    Seriousness seriousness
    static belongsTo = [topic:Topic,user:Users]
    enum Seriousness{
        casual(1),
        serious(2),
        verySerious(3)
        final int id
        private Seriousness(int id){
            this.id=id
        }
    }
    static mapping = {
        seriousness enumType: 'String'
    }
}



