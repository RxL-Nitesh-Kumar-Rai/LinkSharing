package linksharing

import grails.gorm.services.Service

@Service(Subscriptions)
interface SubscriptionService {

    Subscriptions get(Serializable id)

    List<Subscriptions> list(Map args)

    Long count()

    void delete(Serializable id)

    Subscriptions save(Subscriptions subscriptions)

}