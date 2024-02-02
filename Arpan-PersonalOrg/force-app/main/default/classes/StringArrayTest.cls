public class StringArrayTest {
    public static list<string> generateStringArray(integer n ){
        list<string> mystring = new list<string>();
        for(integer i=0;i<n;i++){
            mystring.add('Test '+ i );
            system.debug(mystring[i]);
        }
        return mystring;
        
    }

}