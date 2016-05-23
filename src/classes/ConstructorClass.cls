public class ConstructorClass {
	private static final Integer DEFAULT_SIZE = 10;
	Integer size;
    public ConstructorClass() {
      	this(DEFAULT_SIZE);
   	}
	public ConstructorClass(Integer ObjectSize) {
     	size = ObjectSize;  
   	}
}