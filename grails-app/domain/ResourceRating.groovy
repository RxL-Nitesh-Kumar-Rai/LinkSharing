class ResourceRating {
    LinkResource linkResource
    DocumentResource documentResource
//    Integer totalRating=0
//    Integer totalRatedBy=0
//    static hasMany=[ratedBy:Users]
    Integer rating
    Users ratedBy
    static belongsTo = [linkResource:LinkResource,documentResource:DocumentResource]
    static constraints = {
        linkResource nullable:true
        documentResource nullable:true
    }
}
