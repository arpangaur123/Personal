@isTest
public class checkRecursionTest {

    @isTest
    public static void run(){
        
        checkRecursion obj = new checkRecursion();
        checkRecursion.run = true;
        checkRecursion.runOnce();
    }
}