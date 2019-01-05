using System;
using System.Collections;
using System.Linq;
using System.Text;

public class Product
{
    string name;
    public string Name {get {return name;}}
    decimal price;
    public decimal Price {get {return price;}}

    public Product(string name,decimal price)
    {
        this.name=name;
        this.price=price;
    }

    public static ArrayList GetSampleProducts()
    {
        ArrayList list=new ArrayList();
        list.Add(new Product("West Side Story",9.99m));
        list.Add(new Product("Assassins",14.99m));
        list.Add(new Product("Frogs",13.99m));
        list.Add(new Product("Sweeney Todd",10.99m));
        return list;
    }
    
    public override string ToString()
    {
        return string.Format("{0}:{1}",name,price);
    }

    static public void Main()
    {
        ArrayList myAL=GetSampleProducts();
        Console.WriteLine("Count: {0}",myAL.Count);
        Console.WriteLine("Capacity: {0}",myAL.Capacity);
        PrintValues(myAL);
    }


    public static void PrintValues(IEnumerable myList)
    {
        foreach (Object obj in myList)
            Console.WriteLine("{0}",obj);
    }

}

