@isTest
public with sharing class FollowersControllerTest {
    @TestSetup
    static void makeData(){
        // create an account
        Account a = new Account( Name = 'Ohana, LLC' );
        insert a;
        
        // create user
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@none.com.test';
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = new User(
            Alias = 'standt',
            Email = 'standarduser@testorg.com',
            EmailEncodingKey = 'UTF-8',
            FirstName = 'Jordan',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ProfileId = p.Id,
            TimeZoneSidKey = 'America/New_York',
            UserName = uniqueUserName
        );
        insert u;
    }

    @isTest
    public static void testPositiveCase() {
        // get record to check for subscribers
        Account a = [SELECT Id FROM Account LIMIT 1];

        // get user record to subscribe
        User u = [SELECT Id, Name, FirstName, LastName, MediumPhotoUrl FROM User WHERE LastName = 'Testing'];
        
        Test.startTest();
        // create an entity subscription
        EntitySubscription es = new EntitySubscription(
            ParentId = a.Id,
            SubscriberId = u.Id
        );
        insert es;

        // get subscriber information
        List<User> userList = FollowersController.getFollowers(a.Id);
        Test.stopTest();
        
        // validate against expectations
        system.assertEquals(1, userList.size());
        system.assertEquals('Jordan', userList.get(0).FirstName);
        system.assertEquals('Testing', userList.get(0).LastName);
        system.assert(userList.get(0).MediumPhotoUrl != null);
    }

    @isTest
    public static void testNegativeCase(){
        // get record to check for subscribers
        Account a = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();
        // get subscriber information
        List<User> userList = FollowersController.getFollowers(a.Id);
        Test.stopTest();

        // validate against expectations
        system.assertEquals(true, userList.isEmpty());
    }
}