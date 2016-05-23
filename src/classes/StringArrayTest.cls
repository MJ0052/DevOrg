public class StringArrayTest {
    public static List<String> generateStringArray(Integer length){
        List<String> stringList = new List<String>();
		for (Integer count=0; count <= length; count++) {
 		   stringList.add('Test '+count);
        }
        return stringList;
    }
}