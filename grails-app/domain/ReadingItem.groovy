class ReadingItem {
    LinkResource linkResource
    DocumentResource documentResource
    Resources resource
    Users user
    Topic topic
    boolean isRead
    static belongsTo = [user:Users,resource:Resources]
    static constraints = {
        linkResource nullable:true
        documentResource nullable:true
    }
}
