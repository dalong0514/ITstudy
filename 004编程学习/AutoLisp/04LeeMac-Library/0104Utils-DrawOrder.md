## 0104. Utils-DrawOrder

[Draw Order Functions | Lee Mac Programming](http://www.lee-mac.com/draworderfunctions.html)

### Introduction

I have found that many users require more control over the draw order of various entities in a drawing, using more advanced & intuitive functions than those provided by AutoCAD as standard.

I have therefore designed a set of functions which may be used to manipulate the draw order of all entities in a selection set, or the draw order of a list of VLA-Objects supplied to the functions. The purpose, arguments and returns of each function is detailed in the respective code headers.

This set of functions will enable users to easily develop custom draw order programs of their own, a few examples of which are shown below.

Function Syntax:

```
(LM:movetotop    <obs>)
(LM:movetobottom <obs>)
(LM:moveabove    <obs> <obj>)
(LM:movebelow    <obs> <obj>)
(LM:swaporder    <ob1> <ob2>)
```

### Examples of Custom Draw-Order Functions

Here I demonstrate a few programs which utilise the above set of draw order functions. In the following examples, the variable 'acdoc' is intentionally global to improve performance.

Note that the draw order functions available for download above will need to be loaded before the following programs are used.

#### Move Objects to Top

The following program will move the selected objects to the top of the draw order.

```
(defun c:top ( / )
    (LM:movetotop (ssget (list (if (= 1 (getvar 'cvport)) (cons 410 (getvar 'ctab)) '(410 . "Model")))))
    (princ)
)
```

#### Move Objects to Bottom

The following program will move the selected objects to the bottom of the draw order.

```
(defun c:bottom ( / )
    (LM:movetobottom (ssget (list (if (= 1 (getvar 'cvport)) (cons 410 (getvar 'ctab)) '(410 . "Model")))))
    (princ)
)
```

#### Move Objects Above

The following program will move the selected objects above the draw order of the subsequently selected object.

```
(defun c:above ( / ent sel )
    (if (and (setq sel (ssget (list (if (= 1 (getvar 'cvport)) (cons 410 (getvar 'ctab)) '(410 . "Model")))))
             (setq ent (car (entsel "\nSelect object to move selection above: ")))
        )
        (LM:moveabove sel (vlax-ename->vla-object ent))
    )
    (princ)
)
```

#### Move Objects Below

The following program will move the selected objects below the draw order of the subsequently selected object.

```
(defun c:below ( / ent sel )
    (if (and (setq sel (ssget (list (if (= 1 (getvar 'cvport)) (cons 410 (getvar 'ctab)) '(410 . "Model")))))
             (setq ent (car (entsel "\nSelect object to move selection below: ")))
        )
        (LM:movebelow sel (vlax-ename->vla-object ent))
    )
    (princ)
)
```

#### Swap Objects

The following program will swap the draw order of the two selected objects; this operation requires a regen to take effect.

```
(defun c:swap ( / en1 en2 )
    (if (and (setq en1 (car (entsel "\nSelect first object: ")))
             (setq en2 (car (entsel "\nSelect object to swap with: ")))
        )
        (progn
            (LM:swaporder (vlax-ename->vla-object en1) (vlax-ename->vla-object en2))
            (vla-regen (LM:acdoc) acactiveviewport)
        )
    )
    (princ)
)
```

#### Move Objects on Layer to Top

The following program will move all objects residing on the layer of a selected object to the top of the draw order.

```
(defun c:layertop ( / ent )
    (if (setq ent (car (entsel "\nSelect object on layer to move to top: ")))
        (LM:movetotop
            (ssget "_X"
                (list
                    (assoc 8 (entget ent))
                    (if (= 1 (getvar 'cvport)) (cons 410 (getvar 'ctab)) '(410 . "Model"))
                )
            )
        )
    )
    (princ)
)
```

#### Move Hatch Objects to Bottom

The following program will move all Hatch objects to the bottom of the draw order.

```
(defun c:hatchbottom ( / )
    (LM:movetobottom
        (ssget "_X"
            (list
               '(0 . "HATCH")
                (if (= 1 (getvar 'cvport)) (cons 410 (getvar 'ctab)) '(410 . "Model"))
            )
        )
    )
    (princ)
)
```

As you can see, the possibilities are endless...