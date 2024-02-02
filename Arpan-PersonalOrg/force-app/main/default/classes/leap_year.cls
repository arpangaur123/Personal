public class leap_year {
    public void leap(){
        integer year = 1992;
        if (math.mod(year, 4) == 0 || math.mod(year, 100) == 0){
            if(math.mod(year, 400) == 0){
                system.debug('leap year');
            }
            else{
                system.debug('not leap year');
            }
            
        }
        else{
            system.debug('not leap year');
        }
        
    }

}