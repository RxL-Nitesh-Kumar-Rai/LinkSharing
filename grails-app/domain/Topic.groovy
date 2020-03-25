class Topic {
    String name
    Users createdBy
//    String description
    Date dateCreated
    Date lastUpdated
    Visibility visibility
    enum Visibility{
        Private(0),
        Public(1)
        final int id
        private Visibility(int id){
            this.id=id
        }
    }


    static mapping = {
        visibility enumType: 'String'
    }

    static hasMany=[resources:Resources,subscriptions:Subscriptions]
    static belongsTo = [user:Users]

}
