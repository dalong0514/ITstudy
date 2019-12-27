using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;

public class helloworld
{
    static public void Main()
    {
        //int num;
        //string name;
        //name=Console.ReadLine();
        //(new helloworld()).shownum();
        //Console.WriteLine("Enter your name");
        //name=Console.ReadLine();
        //Console.WriteLine("My name is {0}",name);
        //Console.WriteLine("The result is {0}",result);
        ArrayList myAL=new ArrayList();
        myAL.Add("Helllo");
        myAL.Add("World");
        myAL.Add("!");
        Console.WriteLine("myAL");
        PrintValues(myAL);
    }

    public static void PrintValues(IEnumerable myList)
    {
        foreach (Object obj in myList)
            Console.Write(" {0}",obj);
        Console.WriteLine();
    }
}
