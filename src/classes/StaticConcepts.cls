public class StaticConcepts {
	public static final Integer THRESHOLD_VALUE = 5;
	
    public static void Method1(){
     	//THRESHOLD_VALUE = 10;
     	Integer a = 2 * THRESHOLD_VALUE;
        System.debug(THRESHOLD_VALUE);
    }
     public static void Method2(){
        //THRESHOLD_VALUE = 15;
        System.debug(THRESHOLD_VALUE);
    }
}