import org.springframework.context.support.StaticApplicationContext

class Resources {
    String description
    Users createdBy
    Topic topic
    Date dateCreated
    Date lastUpdated
    static hasMany = [linkResources:LinkResource,documentResources:DocumentResource]
    static belongsTo=[topic:Topic]
     static constraints = {

     }
}
