class ResourceRating {
    LinkResource linkResource
    DocumentResource documentResource
    Integer totalRating=0
    Integer totalRatedBy=0
    static hasMany=[ratedBy:Users]
//    static belongsTo = [ratedBy: Users]

    static constraints = {
        linkResource nullable:true
        documentResource nullable:true
    }
}
