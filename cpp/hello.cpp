#include <iostream>
#include <cmath>
using namespace std;

void function1();
void function2();
void swap(int &n1,int &n2);
int arr[3];
int main()
{
    int a=1;
    cout<<&a<<endl;
    return 0;
}

void function1()
{
    int x=1;
    int y=1;
    for(int i=1;i<5;i++)
    {x+=i;}
    for(int i=1;i<5;i++)
    {y+=i;}
    cout<<"x="<<x<<" y="<<y<<endl;
}

void function2()
{
    int i=1,sum=0;
    for(int i;i<10;i++)
    {sum+=i;}
    cout<<"i="<<i<<" sum="<<sum<<endl;
}

int max(int num1,int num2)
{
    if(num1>num2)
        return num1;
    else
        return num2;
}

double max(double num1,double num2)
{
    if(num1>num2)
        return num1;
    else
        return num2;
}

void swap(int& n1,int& n2)
{
    cout<<"Inside the swap function"<<endl;
    cout<<"Before swaping n1 is "<<n1<<" n2 is "<<n2<<endl;

    int temp=n1;
    n1=n2;
    n2=temp;

    cout<<"After swapping n1 is "<<n1<<" n2 is "<<n2<<endl;
}
