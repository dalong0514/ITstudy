# 0401Novelty-Clock

[AutoCAD Clock | Lee Mac Programming](http://www.lee-mac.com/clock.html)

## Introduction

Let me state from the outset that I realise that there isn't too much practicality in this application, and hence I consider it more of a novelty application for your amusement and enjoyment.

I have seen similar programs available that will create a clock interface and proceed to animate the hands using a while loop or similar, coupled with a small increment. These programs are cool in themselves, but since AutoLISP runs on the AutoCAD user interface processor thread, the program will take precedence over all other user actions whilst running and will cause Windows to render the AutoCAD application as non-responsive after 5 seconds of processing, that is, if the system hasn't already locked up with all the entity regeneration...

With this in mind, I decided to take a different route - the engine that powers my application utilises a Visual LISP Command Reactor to update its display, and hence it may function in the background without hindering the actions of the user; moreover, it may be used as a functional timepiece whilst working.

## Clock Operation

The program will display a chronograph-style clock interface, including a traditional analog dial, 24-hour dial, day-of-the-week dial, the date, month & year and a digital display.

I have designed the clock command to perform as a toggle - upon issuing this command at the AutoCAD command-line, the user is prompted to supply an insertion point and the clock face is displayed; typing this command again will disable the clock and remove the clock face.

When enabled, a Visual LISP Command Reactor will operate in the background and clock hands and accompanying text will update automatically to reflect the current time every time an AutoCAD command has been used.

The runclock command will continuously update the clock display as the user moves the mouse, until the user clicks or presses any key to exit. However, to enable this continuous animation, the runclock command will take precedence over all other actions whilst running.

Finally, although only a novelty application, this program will perform successfully in all UCS & Views.

Preview