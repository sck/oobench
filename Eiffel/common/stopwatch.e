class STOPWATCH

creation {ANY} 
   make

feature {ANY} 
   
    start_time: DOUBLE;
    stop_time: DOUBLE;
    running: BOOLEAN;
   
    make is 
    do  
        running := false;
        start_time := - 1;
        stop_time := - 1;
    end -- make
   
    current_time_millis: DOUBLE is 
    local 
        time: MICROSECOND_TIME;
        days: DOUBLE;
    do  
        time.update;
        days := time.year_day;
        Result := days * 24 * 60 * 60 * 1000 + 
                time.hour * 60 * 60 * 1000 + time.minute * 60 * 1000 + 
                time.second * 1000 + time.microsecond / 1000;
    end -- current_time_millis
   
    start is 
    require 
        not running; 
    do  
        start_time := current_time_millis;
        running := true;
    end -- start
   
    stop is 
    require 
         running; 
         start_time /= - 1; 
    do  
        stop_time := current_time_millis;
        running := false;
    end -- stop
   
    elapsed_time: DOUBLE is 
    require 
        start_time /= - 1; 
        stop_time /= - 1; 
    do  
        if running then 
            Result := current_time_millis - start_time;
        else 
            Result := stop_time - start_time;
        end; 
    end -- elapsed_time
   
    reset is 
    do  
        start_time := - 1;
        stop_time := - 1;
        running := false;
    end -- reset

end -- class STOPWATCH
