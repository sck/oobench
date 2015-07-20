using System;

public class Test {
    public static String myString;
    public static void Main() {
        DateTime t1 = DateTime.Now;
        for (int i = 0; i < 500; i++) {
            for (int j = 0; j < 10000000; j++) {
            }
            Console.WriteLine(DateTime.Now.Ticks / 1000000);
        }
        DateTime t2 = DateTime.Now;
        Console.WriteLine("Ms: " + ((t2.Ticks - t1.Ticks) / 10000));
        Console.WriteLine("Total: {0}", GC.GetTotalMemory(true));
        myString = new String('#', 40000);
        Console.WriteLine("Total: {0}", GC.GetTotalMemory(true));
        myString = null;
        Console.WriteLine("Total: {0}", GC.GetTotalMemory(true));
    }
}
