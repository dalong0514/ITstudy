# 0304Mathematical-Koch Snowflake

[Koch Snowflake | Lee Mac Programming](http://www.lee-mac.com/koch.html)

Introduction
The Koch Snowflake, devised by Swedish mathematician Helge von Koch in 1904, is one of the earliest and perhaps most familiar fractal curves.

On this page I shall explore the intriguing and somewhat surprising geometrical properties of this ostensibly simple curve, and have also included an AutoLISP program to enable you to construct the Koch Snowflake fractal curve on your own computer.

Construction
The Koch Snowflake is composed of three individual Koch Curves, arranged to form an equilateral triangle.

Each Koch Curve is constructed by first dividing a straight line segment into three equal parts and then constructing an equilateral triangle whose base is the middle segment of the line, before finally removing the base of the triangle:

Koch Curve

This procedure is then repeated on each of the four resulting line segments; the infinite limit of this process is the Koch Curve.

Geometrical Properties
As a consequence of its fractal nature, the Koch Snowflake has some very intriguing & surprising geometrical properties.

If the initial equilateral triangle has side length s, then the initial area enclosed by the Koch Snowflake at the 0th iteration is:

A0

The perimeter of the Koch Snowflake at the 0th iteration is hence:

P0

Three new triangles are added at the first iteration, and for every following iteration, 4 times as many triangles are added to the Snowflake.

So at the nth stage (where n ≥ 1) there are 3·4(n-1) additional triangles.

With every iteration, the side length of each triangle is a third the length of the side length at the previous iteration, meaning that the area of the triangles reduces by a factor of 9 at each iteration.

Therefore, at the nth stage, the Koch Snowflake has an Area of:

An

In the limit as n goes to infinity, this iteration formula converges to:

An2

...which is clearly finite.

However, with every iteration there are four times as many line segments, with each line segment a third as long as the previous iteration.

Hence, at the nth stage, the perimeter is:

Pn

Since 4/3 > 1, this expression goes to infinity as n goes to infinity.

Therefore, we have the surprising conclusion that the Koch Snowflake is an infinitely long curve bounding a finite area.

Demonstration
Koch.gif
See also Sierpinski Triangle, Fractals & Iterated Function Systems.