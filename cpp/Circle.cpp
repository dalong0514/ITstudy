#include "Circle.h"
Circle::Circle()
{
    radius=1;
}

Circle::Circle(double newRadius)
{
    radius=newRadius;
}

double Circle::getArea()
{
    return radius*radius*3.14159;
}
