class ReadingItem {
    LinkResource linkResource
    DocumentResource documentResource
    Resources resource
    Users user
    Topic topic
    boolean isRead
    static belongsTo = [user:Users]
    static constraints = {
        linkResource nullable:true
        documentResource nullable:true
    }
}
