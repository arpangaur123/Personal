@isTest
public class TestClass_for_exampleTst1 {

    @isTest
    static void testme(){
        Example_For_test_1 et = new Example_For_test_1();
        system.debug('name____>>>>'+et.name);
        et.invoke();
        
        system.assertEquals('suraj',et.name);
        system.debug('name--->'+et.name);
        //et.call(); 
		//system.assertEquals('Reetik--->',et.name);
    }
}