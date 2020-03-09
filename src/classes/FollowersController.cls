public class FollowersController {
    @AuraEnabled(cacheable=true)
    public static List<User> getFollowers(Id recordId) {
        List<Id> followers = new List<Id>();        
        for (EntitySubscription sub : [SELECT SubscriberId FROM EntitySubscription WHERE ParentId = :recordId])
            followers.add(sub.SubscriberId);
        return [SELECT Id, Name, FirstName, LastName, MediumPhotoUrl FROM User WHERE Id IN :followers];
    }
}