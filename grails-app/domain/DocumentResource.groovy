class DocumentResource {
    String filePath
    String description
    Date dateCreated
    Date lastUpdated
//    int totalRating=0
//    int totalRatedBy
//    Users ratedBy
//    static hasMany = [ratedBy:Users]
    static belongsTo=[resource:Resources]
    static constraints = {
//        ratedBy nullable: true
//        totalRatedBy nullable: true
    }

}
