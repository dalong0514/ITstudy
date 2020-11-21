# Boost Your Coding Fu With Visual Studio Code and Vim

[Boost Your Coding Fu With Visual Studio Code and Vim | Barbarian Meets Coding](https://www.barbarianmeetscoding.com/blog/2019/02/08/boost-your-coding-fu-with-vscode-and-vim)

[Boost Your Coding Fu With VSCode and Vim - Table Of Contents | Barbarian Meets Coding](https://www.barbarianmeetscoding.com/boost-your-coding-fu-with-vscode-and-vim/table-of-contents)

This article doesn't assume any prior Vim knowledge so don't worry if you aren't familiar with Vim. I'll guide you through all the concepts and techniques you need to know to be effective with VSCode and Vim.

## 01. What is Vim?

Vi is an ancient text editor, old even before the first age of the world. It was designed to work on contraptions called terminals with the very uncommon yet inspired characteristic of functioning in a modal fashion. That is, it has a mode for inserting text, another for editing text, a different one for selecting text, and so on.

Vi’s latest and most celebrated incarnation is Vim (Vi IMproved and formerly Vi IMitation) which works both with text and graphical interfaces, comes with a plethora of improvements over vi and is supported on every platform known to humankind. But the impact of Vim doesn’t stop with Vim, Vim’s ideas are so very remarkable that they’ve trascended the Vim editor itself and propagated into other editors. Today you can find Vim-like modes in almost any editor and IDE that you can imagine. Like in Visual Studio Code.

Why Vim? Isn’t Visual Studio Code Enough?
Why should you care about learning about an ancient editor in this day and age? Does it really make such a big difference to my VSCode setup?

The truth is that Vim provides a different way of interacting with text from anything I’ve ever seen, a way that gives you a completely different level of control and fluency when editing code. At the hands of an experienced user, editing text with Vim seems like magic:

Vim makes you faster.
Vim makes you more precise
Vim unlocks a completely different level of control in text editing
Vim thins the interface between your brain and the computer
It is awe-striking when doing presentations :D
Awesome! But How can Vim achieve all this?

Vim’s modal nature empowers your keyboard to control every aspect of your editor. Every mode is a clean slate that gives your keyboard new powers, to edit text at lightning speed, navigate at the speed of thought, select and move text to your heart’s content, and more.

With Vim you’re no longer limited to inserting text nor subject to the tyranny of the mouse to click, navigate or select text. No. After using Vim for a while, you’ll be like a code surgeon that makes expert incisions with surgical precision whenever and wherever it is required, navigating through your code and codebase with the lightning speed and accuracy of a entirely keyboard driven workflow.

So Why would you want to learn Vim in this day and age? Paraphrasing the mighty Drew Neil author of Practical Vim and master of the most obscure arts of Vim:

Vim is for programmers who want to raise their game. In the hands of an expert, Vim shreds text at the speed of thought.

Why Vim in VSCode and Not Just Vim?
You may be wondering... Ok. If Vim is so good then... Why not just use Vim instead of Vim inside Visual Studio Code?

Great question! The truth is that setting Vim to work with a feature set similar to modern text editors is not a trivial task. Features likes code completion, code navigation, in-editor error messages, etc, although supported by Vim don't work perfectly out of the box.

Visual Studio Code and Vim offer a very sweet spot that balance the super rich development user experience of Visual Studio Code with lots of the amazing features present in Vim.

Installing Vim Inside Visual Studio Code
In order to bring the awesomeness of Vim inside Visual Studio Code you’ll need to install the VsCodeVim plugin:

Open Visual Studio Code
Go to Extensions
Type vim in the search box
The first plugin named Vim is the one you want
Click on the install button
Epic Victory!
VSCodeVim plugin inside VSCode
Now after the extension is installed you may need to restart Visual Studio Code for the changes to take effect. latest-vscode

Have you restarted it? Open a code file from your latest project and look at the cursor. Does it look like a rectangle? Yes? Welcome to Vim

Baby Steps in Vim
If you try to type text right now you’ll be surprised to see that nothing happens. Or to be more correct, nothing that you would have expected to happen. That is, as you type there’s no characters being typed in the screen. That’s because the core mode in Vim is Normal mode and not Insert mode.

In Normal mode you don’t insert text, you move around and edit it. This design decision stems from the realization that we spend more time reading, navigating and changing code that we do inserting it in the first place. These are the very basics you need to survive in Vim:

Move around with hjkl
Go into Insert mode with i where you can type stuff as usual
Go back to normal mode with <ESC> or <CTRL-C>
hjkl are the core and most basic motions in Vim. They allow you to move the cursor by one space in every direction:

           ↑
     ← h j k l →
         ↓
They are not the most effective, nor the most efficient way to move around in Vim. But they do give you agility and confidence to move around a file in Normal mode. Learning to hjkl effectively is the equivalent of learning to walk, or learning to ride a bike.

After you get comfortable with more Vim motions you won’t use hjkl as much, but they’ll come very handy for short-distance movements and small corrections.

Mapping Your Caps Lock Key to Control
One thing that comes super handy when using Vim (and any other editor for that matter) is to remap your *Caps Lock* Key to *Control*. This means that you can easily reach a super commonly used key such as *Control* from the comfort of the home row.

If you're using a Mac you can do this directly from Preferences, Keyboard. Otherwise you may need to install some software in your development machine but it should be very straightforward. Google be thy friend. Google it.

Moving Blazingly Fast With The Core Vim Motions
Motions (as in movements) are how you move around in Vim. They are commands that when typed move the cursor around with high speed and precision. There are many of them, and each one is best suited for different types and lengths of movement. I find they work great in tandem with VSCode native Go To features like Go To File and Go To Symbol.

Here’s a condensed list of the most useful ones:

Move Horizontally Word By Word
Word Motions allows you to move faster horizontally:

Use w to jump from word to word (and b to do it backward)
Use e to jump to the end of a word (and ge to do it backward)
A word in Vim only includes letters, digits and numbers. If you want to consider special characters like ., (, {, etc as part of a word (called WORD in Vim jargon) you can use the capitalized equivalents of the keys above (W, B, E, gE)
In general, word motions allow for more precise changes while WORD motions allow for faster movement.

Move To A Specific Character
Find character motions allow you to move horizontally quickly and with high precision:

Use f{char} to move (find) to the next occurrence of a character char in a line (and F to move backwards). For instance, f" sends you to the next occurrence of a double quote.
Use t{char} to move the cursor just before (until) the next occurrence of a character char
After using f{char} you can type ; to go to the next occurrence or , to go to the previous one. You can see the ; and , as commands for repeating the last character search.

On Notes, Melodies And Chords
Vim is quite special. If you've used other editors you're probably accustomed to typing chords of keys. That is, typing a combination of keys at the same time. For instance, CTRL-C to copy and CTRL-V to paste. Vim uses chords as well but relies even more on melodies of keys.

If you think of keys as notes, a melody is a series of notes one after the other. That's the most common way to work with vim when you're in normal mode. So, when you read that you need to type f{char} to find a character in a line it means that first you type f and then you type the character {char}. This, although unfamiliar and kind of strange, is very convenient as controlling the editor suddenly feels like just typing text. It is also great for your wrists' health.

Move Horizontally Extremely
To move extremely horizontally use:

0: Moves to the first character of a line
^: Moves to the first non-blank character of a line
$: Moves to the end of a line
g_: Moves to the non-blank character at the end of a line
To Move Vertically
Starting from k and j, we move on to a faster way of maneuvering vertically with:

} jumps entire paragraphs downwards
{ similarly but upwards
CTRL-D let’s you move down half a page
CTRL-U let’s you move up half a page
High Precision Vertical Motions With Search Pattern
To move vertically even faster when you have a target in mind, your best option is to search with the /{pattern} and ?{pattern} commands:

Use /{pattern} to search forward inside a file
Use ?{pattern} to search backwards
You’ll see that as you type, the matched patterns are highlighted. When you find what you want, type <Enter> and your cursor will jump to the first match in the search. There you can perform some editing if you want and later use n to jump to the next match (or N for the previous one). You can think of n as repeating a search.

Vim loves saving you time: At any time, you can type /<Enter> or ?<Enter> to run the last search (forwards or backwards). Use * to do a search for the word under the cursor.

Moving Faster With Counts
Counts are numbers which can be prefixed to a command to multiply the effect of that command. For instance, 2w allows us to move the cursor 2 words forward. Use {count}motion to multiply a motion {count} times.

A great way to move vertically is to take advantage of counts in combination with j and k. This works very well when you enable relative line numbers (via VSCode preferences) because it becomes very natural to jump {count} lines up and down to reach a target line.

Moving Semantically
Use gd to jump to definition of whatever is under your cursor
Use gf to jump to a file in an import
And Some More Nifty Core Motions
gg to go to the top of the file
{line}gg to go to a specific line
G to go to the end of the file
% jump to matching ({[]})
Editing Like Magic With Vim Operators
Motions aren’t just for moving. They can be used in combination with a series of commands called operators to edit your code in Normal mode. These combos normally take this shape:

    an action to perform: delete, change, yank, etc
         /
        /
       /                  ____ a motion that represents a piece
      |                  /     of text to which to appy the action
      |                 /      defined by the operator
  {operator}{count}{motion}
               \
                \
                 \
                  \_ a multiplier to "perform an action
                     {count} times"
One of such commands is delete triggered via the d key:

d5j deletes 5 lines down
df' deletes everything in the current line until the first occurrence of the ' character (including the character)
dt' would do like above but excluding the character (so up until just before)
d/hello deletes everything until the first occurrence of hello
ggdG deletes a complete document
Other useful operators are:

c change. This is the most useful operator. It deletes and sends you into insert mode so that you can type
y yank or copy in Vim jargon
p put or paste in Vim jargon
g~ to toggle caps
All these operators have some useful shorthand syntax aimed at saving you typing and increasing your speed in common use cases:

Double an operator to make it operate on a whole line: dd deletes a whole like, cc changes a whole line, etc.
Capitalize an operator to make it operate from the cursor to the end of a line: D deletes from the cursor to the end of the line, C changes to the end of a line, etc.
Noticed How Motions and Command Keys Make a Lot of Sense?
Commands and motions in Vim are generally easy to learn because they make sense and are easy to guess. Want to change something? You probably want to use the `c` operator. Want to move word by word? Try `w`. Want to delete something? Try the `d` operator and so on.

Operators and motions really shine when we combine operators with a special class of motions called text-objects.

Editing Up a Notch With Text Objects
Text objects are structured pieces of text or, if you will, the entities of a document domain model. What is a document composed of? Words, sentences, quoted text, paragraphs, blocks, (HTML) tags, etc. These are text objects.

The way that you specify a text object within a command is by combining the letter a (which represents the text object plus whitespace) or i (inner object without whitespace) with a character that represents a text object itself: w for word, s for sentence, ' " for quotes, p for paragraph, b for block surrounded by (, Bfor block surrounded by { and t for tag. So to delete different bits of text you could:

daw to delete a word (plus trailing whitespace)
ciw to change inner word
das to delete a sentence (dis delete inner sentence)
da" to delete something in double quotes including the quotes
ci" to change something inside double quotes
dap to delete a paragraph
dab da( or da) to delete a block surrounded by (
daB da{ or da} to delete a block surrounded by {
dat to delete an HTML tag
cit to change the contents of an HTML tag
Combining text objects with operators is extremely powerful and you’ll use them very often. Stuff like cit, ci" and cib is just brilliant.

Let’s say that we want to change the contents of this string below for something else:

const salute = 'I salute you oh Mighty Warrior'
You type ci'Hi!<ESC> and it becomes:

const salute = 'Hi!'
Just like that. You don’t need to go grab the mouse, select the text and then write something else. You type three letters and Boom.

Noticed How Most Vim Keys Are Placed Near Your Fingers?
The fact that Vim has modes allows keys near the home row to be reused in each separate mode, minimizing the need for slow and contorted key combinations, and heightening your speed and the longevity of your fingers and wrists. This is awesome!

Repeating The Last Change with The Dot Operator
Vim has yet another trick in store for you aimed at saving you more keystrokes: The magic . command. The . command allows you to repeat the last change you made. Imagine that you run dd to delete a line. You could type dd again to delete another line but you could also use . which is just a single keystroke. Ok, you save one keystroke, so what? Well, you can use the . command to repeat any type of change, not just single commands. For instance, you could change a word for “Awesome” like so cawAwesome<CR>, and then repeat that whole command with all those keystrokes by just using .. Think of the possibilities!

The . command works great in combination with the repeat search commands (;, ,, n or N). Imagine that you want to delete all occurrences of cucumber. An alternative3 would be to search for cucumber /cucumber then delete it with daw. From then on you can use n to go to the next match and . to delete it! Two keystrokes!?! Again think of the possibilities!!

Vim’s Secret Language
As you probably have noticed all these operators, counts and motions make up a (programming) language of sorts. You can think of operators as functions and counts and motions as arguments, or using an even simpler analogy… you can think of operators as verbs, counts as adjetives and motions as objects.

The true magic of Vim is composition. As you go building up this vocabulary of operators and motions you’ll find that you can combine them to your heart’s content. So that, once you know all the c, cl, caw, ciw, ct. from the previous paragraph and you learn how dl works, you’ll not only be able to use dl, you’ll know that you can also combine it with all the motions you already have at your disposal and daw, diw, dt, etc.

This is very cool. When using Vim you’ll feel you are navigating a meta-universe of text editing, it’s like programming or controlling the very mechanism of editing and writing text. If you’re familiar with git and how it feels to use the git command line to work with source control, you can think of Vim as the git of text editing. (Putting aside the fact that Vim predates git by almost 30 years). With Vim, you’ll look at a piece of text and you’ll no longer see just words or text, you’ll see the possibilities of an infinite number of operators and motions being applied.

Inserting Text a la Vim
Sooner or later you will have to write some code. In Vim, you write code in Insert mode. You’ve seen a little bit of insert mode when using the c command but let’s look at it some more. There’s two core commands that put you into insert mode: i for insert and a for append.

The i insert command puts you in insert mode before the cursor. While the a append command puts you in insert mode after the cursor (as if to append stuff wherever the cursor is placed). From then on you’re in insert mode and Vim pretty much behaves like any other editor (welcome back VSCode!).

Like with many other Vim commands i and a have uppercase counterparts that do stronger versions of insert and appending. I puts you in insert mode at the beginning of the current line whilst A puts you in insert mode at the end.

In addition to i and a there are another three super useful commands that I love to use to drop into insert mode:

o inserts a new line below the current one and drops you into insert mode (mnemonic open a line below)
O inserts a new line above the current one and also drops you into insert mode
gi puts you into insert mode at the last place you left insert mode. This is great if you drop of insert mode by mistake and want to go back where you were and continue typing.
Ok, so let’s say that now you are in insert mode, typing away and you make a mistake, like a typo. Do you go back to normal mode, fix the typo and go back into insert mode? No! There’s a couple of bindings that can help you fix an error right from within insert mode:

C-h lets you delete the last character you typed
C-w lets you delete the last word you typed
C-u lets you delete the last line you typed
Eventually though you’ll want to exit insert mode and do other stuff. There are three ways to do it: <ESC>, C-[ and C-C. Of all of this, the easier to type is C-C.

Selecting Text in Visual Mode
Visual Mode is the Vim equivalent to selecting text with a mouse. Instead of a mouse though, you’ll use Vim motions. This mode can come very handy whenever you need to select some text because it gives you visual feedback as you do it.

There’s three ways in which you can start visual mode:

v for visual mode character-wise. When you move around you go selecting character by character
V for visual mode line-wise. When you move around you go selecting line by line
<C-V> for visual mode block-wise. When you move around yo go selecting rectangular blocks of text
The visual mode can be very helpful for copying and pasting stuff and when operating on blocks of text or code. It works in the opposite way of normal mode:

In normal mode you first define the operator and then a motion that represents some text to which to apply that operator
In visual mode you select the text first and then you type the operator
Splits, Tabs and Switching Between Them
A great feature in Vim is its great support for splits and tabs. Creating, resizing, rearranging and moving between splits and tabs is incredibly easy and fast in Vim. VSCodeVim offers an OK support for this Vim feature.

Splits
Splits are awesome. They allow you to divide your workspace into vertical and horizontal split windows:

Use the :sp {nameoffile} command to open a horizontal split
Use the :vsp {nameoffile} command to open a vertical split
You can move between them with <C-W> + hjkl.

Splits in Vim
Typing a Command
Notice the : before some of these commands? The colon triggers command-line mode and sets you up to enter a command (also known as Ex command, you'll find out why later in the book when we dive into command-line mode).

To type an ex command you literally type `:` followed by the name of the command (e.g. :vsp). When you type a colon and a command, the command will be displayed in the lower-left part of the screen.

Tabs
Use :tabnew {file} to open a file in a new tab
Use :tabn to go to the next tab
Use :tabp to go to the previous tab
Surrounding Things With Vim Surround
VsCodeVim comes with a bunch of useful Vim plugins built-in. One of them is vim-surround which extends Vim’s secret language with a new operator: The surround operator or s.

Using this operator we can surround swaths of text using it as you would any other operator within Vim:

ds' to delete the surrounding ' (ds{char})
cs'" to change the surrounding ' for " (cs{old}{new})
ysaptli> to surround a paragraph with an <li> tag (ys{motion}{char})
You can also use vim-surround by selecting a bit of text in visual mode and then using S{desired character}

Moving Even Faster with vim-sneak and vim-EasyMotion
Vim-sneak and vim-EasyMotion are a couple of Vim plugins that overcharge how you move in Vim. Both of these plugins need to be enabled via your VSCodeVim preferences.

Vim-sneak is a middle ground between character search (inside a line) and pattern search (inside a file):

You type s{char}{char} and the cursor flies to the first occurrence of that two character sequence. From then on type ; for the next occurrence , , for the previous one. The S{char}{char} works in a similar fashion but backwards.
Where vim-surround extended Vim’s secret language with an operator, vim-sneak does the same but with a motion. As such you can use it in combination with other operators:

Type {operator}z{char}{char} and the operator will be applied over the text traversed by the sneak motion.
Vim-EasyMotion is a weird one as Vim plugins go. It completely bypasses Vim motions and reinvents them in a curious and mindblowing way. When you trigger an easy motion motion it labels the possible targets in the whole document with a key combination that is shown in an overlay (over the text in question). Type that combination and you’re teleported to that location.

For instance, type \\w (the \\ is how you trigger EasyMotion) and EasyMotion will label the beginning of all words ahead of you. Type \\f' and EasyMotion will label all occurrences of the ' character. Pretty nifty, isn’t it?

Vim-Easymotion labeling motions
Some handy Visual Studio Code only key mappings:
These are some handy mappings the VSCodeVim team came up with only for VSCode:

gb adds another cursor on the next word it finds which is the same as the word under the cursor. Like * but instead of jumping to next ocurrence it creates multiple cursors.
af is a visual moe command that selects increasingly larger blocks of text.
gh is the equivalent of hovering the mouse over where the cursor is. Super handy in order to enable a keyboard only workflow and still enjoy some features (error messages, types, etc) only available via the mouse.
Where Should I Go From Here?
Awesome! We’ve covered a lot of ground in this article and I hope you’ll find it useful as a guide to Vim in Visual Studio Code. All that remains is for you to practice little by little until you become more and more comfortable and proficient with Vim. Don’t try to apply everything you’ve learned in this article at once. Just pick some of the operators you find more useful and slowly go adding them to your workflow.

Even though we covered a lot of ground there’s tons of things we didn’t get to talk about:

I wrote a complete book that guides you through learning Vim in Visual Studio Code step by step in a lot more depth than this article. It’s free to read online. That’s a great place to continue your Vim in VSCode journey and to use as reference whenever you need it.
Learn Vim is a VSCode extension I created that helps you learn Vim right within VSCode, keeps your progress and provides room for thoughtful reading and deliberate practice.
There’s even more plugins available in VSCodeVim. Take a look and see if there’s anything you find interesting
One of Vim’s core features is its amazing customizability. VSCodeVim brings support for some of that with custom key mappings. That is, it allows you to define custom mappings to make frequent actions easier to type. Take a look here for some great examples.
Consider installing Neovim and enabling it in VSCode. It allows for an awesome command line mode support. Yep, yet another Vim mode that is capable of some amazing stuff.
Here is a complete list of the features available right now in VsCodeVim. Yep. It is humongous. Lots of goodies yet to explore.
Go, enjoy your newfound knowledge, improve your skills and productivity and if you ever want to learn more about Vim, I have more awesome stuff for you:

Try the Exploring Vim series for more involved articles about Vim
Or the 5 Minutes Vim series for shortish condensed articles
Or even better get Wizards Use Vim my beautiful book on all things Vim where I guide you step and step in how to be more awesome with Vim
Take care and go kick some ass! :D

Update Feb 10: Hey! I just started a new vlog series to help you get up to speed faster. Enjoy!


The latest release of VSCode brought support for plugins working right of the bat, but you never know. :D

↩
Spread The Word. Share this article!
Jaime González García
Written by Jaime González García , Dad, Husband, Front-end software engineer, UX designer, amateur pixel artist, tinkerer and master of the arcane arts. You should follow him on Twitter where he shares useful stuff! (and is funny too).


Wop! Want to Reach Out?
If you have any question or comments about the article just reach out on the twitterverse! My DMs are open and I'm always happy to help out and answer questions.

Tagged as...
exploring-vimvscodevimlearning-vimneovimprogrammingeditorstoolsdevtoolswebdevdevwriting
Would you like to receive more articles like this one on programming, web development, JavaScript, Angular, developer productivity, tools, UX and even exclusive content like free versions of my books in your mailbox? Then sign up to my super duper awesome inner circle.

Sign Me Up!
Or if you hate e-mail and love RSS instead then subscribe to the RSS feed like we're back in the 90s. Ice Ice Baby! Din din din Din di di din Ding.
Previously in Barbarian Meets Coding...
← 5 Minutes Vim: Moving Fast Within a File
Vlog: New Series on Vim in Visual Studio Code! →
Featured Topics
TypeScript
JavaScript
Vim
VSCode
Career
And More Cool Stuff On This Site...
About Me
Find out more about me: Where do I come from? What's my favorite dessert? Which songs do I sing in the shower? My deepest secreeeets...

Wiki
As I learn new stuff I like to keep notes. These are my notes made public! Lots of interesting and helpful stuff with no filters!

Videos
I sometimes make videos on YouTube. They are highly weird and quirky. Don't miss the bloopers at the end! Enjoy!

Projects
Here you can find the results of my tinkering. Labor of love side projects from the past, present and future.

Blog
This is where I write awesome articles on wondrous topics and unearth the misteries of the universe... and JavaScript.

Newsletter
The Barbarian Meets Coding Newsletter! A place where you get a look behind the scenes of Barbarian Meets Coding, a peek inside ma brain and whatever I'm working on.

Now
Find out what I'm doing right now! (Right right now, I'm writing this text)

Books
I love writing! Here you can find more about the books I've written and those that I'm planning on writing.

Speaking
On occasion I speak at conferences and meetups. I love to put on a show, and teach and entertain in equal measure. See where I'll be speaking next.

Reading
Reading is a passion of mine. Take a sneak peek at the books I've read and the ones I'm reading.

Archives
A list of all the articles I've written in this blog.

Would you like to receive more articles like this one on programming, web development, JavaScript, Angular, developer productivity, tools, UX and even exclusive content like free versions of my books in your mailbox? Then sign up to my super duper awesome inner circle.

Sign Me Up!
Or if you hate e-mail and love RSS instead then subscribe to the RSS feed like we're back in the 90s. Ice Ice Baby! Din din din Din di di din Ding.
Did Ya Know I've Written Some Books?
I have! The JavaScript-mancy series is the lovechild of three of my passions: JavaScript, writing and Fantasy. In the pages of each one of the books of the series you’ll find a breadth of JavaScript knowledge, delivered with a humorous and casual style of writing and sprinkled with Fantasy at every turn.

They are the weirdest and quirkiest JavaScript books you'll ever find. There's nothing out there quite like it.

Tell Me More!!
JavaScript-mancy: Getting Started With the Arcane Art Of Writing Awesome JavaScript
© 2010-2019 Copyright Jaime Gonzalez Garcia *. All rights reserved.

This site is built with Gatsby which is insanely awesome.

*Half-elven ranger, deadly archer, master of the two-handed sword and dual scimitar wielder, protector of Veleiron, Falcon of the Crepuscle, silent death of the swamps of Zulk....