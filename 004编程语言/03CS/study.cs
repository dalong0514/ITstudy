using System;
using System.Collections;
using System.Linq;
using System.Text;

namespace study
{
public class MyClass
{
    public string name;
    //private int intVal;

    public int Val{get;set;}
    public MyClass(string newname,int i)
    {
        name=newname;
        Val=i;
    }
}

public class Operation
{
    public double NumberA{get;set;}
    public double NumberB{get;set;}
    public virtual double GetResult()
    {
        double result=0;
        return result;
    }
}

class OperationAdd:Operation
{
public override double GetResult()
{
    double result=0;
    result=NumberA+NumberB;
    return result;
}
}

class OperationSub:Operation
{
public override double GetResult()
{
    double result=0;
    result=NumberA-NumberB;
    return result;
}
}

class OperationMul:Operation
{
public override double GetResult()
{
    double result=0;
    result=NumberA*NumberB;
    return result;
}
}

class OperationDiv:Operation
{
public override double GetResult()
{
    double result=0;
    if(NumberB==0)
        throw new Exception("The number can not be 0");
    result=NumberA/NumberB;
    return result;
}
}

public class OperationFactory
{
    public static Operation CreatOperate(string operate)
    {
        Operation oper=null;
        switch(operate)
        {
            case "+":
            oper=new OperationAdd();
            break;
            case "-":
            oper=new OperationSub();
            break;
            case "*":
            oper=new OperationMul();
            break;
            case "/":
            oper=new OperationDiv();
            break;
        }
        return oper;
    }
}


}






















