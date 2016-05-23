public class UserDataManipulation {
    public static Map<Id,User> GetUsersMap(){
        Map<Id,User> mapObj = new Map<Id,User>([Select Id,Name,ManagerID,Email from User]);
        return mapObj;
    }
}