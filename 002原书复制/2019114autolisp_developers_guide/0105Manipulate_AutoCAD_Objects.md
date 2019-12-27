# 0105. About Using AutoLISP to Manipulate AutoCAD Objects (AutoLISP)

You can select and handle objects, and use their extended data.

Most AutoLISP ® functions that handle selection sets and objects identify a set or an object by the entity name. For selection sets, which are valid only in the current session, the volatility of names poses no problem, but it does for objects because they are saved in the drawing database. An application that must refer to the same objects in the same drawing (or drawings) at different times can use the objects' handles.

1『处理的逻辑：要么是处理选择集，要么是处理特定的实体。』

AutoLISP uses symbol tables to maintain lists of graphic and non-graphic data related to a drawing, such as the layers, linetypes, and block definitions. Each symbol table entry has a related entity name and handle and can be manipulated in a manner similar to the way other AutoCAD ® entities are manipulated.

1『利用 symbol tables 来定位要操作的实体。』



























