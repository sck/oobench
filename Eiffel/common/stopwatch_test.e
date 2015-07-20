class STOPWATCH_TEST

create make

feature

    make is
    local
        stopwatch: STOPWATCH;
        i: INTEGER;
        j: INTEGER;
    do
        !!stopwatch.make;
        from 
            i := 1;
        until
            i > 9
        loop
            stopwatch.reset;
            stopwatch.start;
            i := i + 1;
            from 
                j := 1;
            until
                j > 99999999
            loop
                j := j + 1;
            end;
            stopwatch.stop;

            io.put_string("Elapsed time: ");
            io.put_double_format(stopwatch.elapsed_time, 0);
            io.put_string("ms%N");
        end;

    end;

end
