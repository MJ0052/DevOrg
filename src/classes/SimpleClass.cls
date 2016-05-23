public class SimpleClass {

 public void foo() {
   System.debug('foo here');
 }
 
 
 static testmethod void testFoo() {
  SimpleClass a = new SimpleClass();
  a.foo();
 }
}