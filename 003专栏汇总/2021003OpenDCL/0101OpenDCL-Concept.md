# 0101. OpenDCL Concept

## 1.1 Object Model

1『

OpenDCL 的文档资料比 Object DCL 简单很多，但目前觉得两者语法、思路基本是一样的，全完可以通过看 Object DCL 的文档说明来实践 OpenDCL。

界面文件 `.odcl` 基本按 Object DCL 那边的教程示例简单做一个。lisp 文件如下：

```c
(command "_OPENDCL")

(defun c:HelloWorld ()
  (dcl-Project-Load "D:\\opendcl\\GsDataflow.odcl" T)
  (dcl_form_Show GsDataFlow/Form1)

)

(defun c:GsDataFlow/Form1/TextButton1#OnClicked (/)
  ;(dcl-MessageBox "To Do: code must be added to event handler\r\nc:GsDataFlow/Form1/TextButton1#OnClicked" "To do")
  (dcl-Control-SetCaption GsDataFlow/Form1/Label1 "Hello World !")
)
```

上面的效果是：点一下「OK」按钮后，label 那个文字直接变成了「Hello World !」。

加载后直接在 CAD 里跑命令 `HelloWorld` 后提示找不到命令 `dcl-Project-Load`，跟 Object DCL 卡住的问题点一样。幸好在文档里看到了相关信息，直接用命令 `(command "_OPENDCL")` 加载，从弹出的窗口知道了 OpenDCL 函数包的存放位置：`C:\Program Files (x86)\Common Files\OpenDCL`。而且下次用 `(command "_OPENDCL")` 加载就不会弹出窗口了，那么该语句其实可以直接写在 lisp 文件里的。

OpenDCL 这边算是跑通了，如果以后原生 DCL 无法满足需求后，可以转战 OpenDCL。（2021-03-14）

』







The AutoLISP interface exposed by OpenDCL Runtime employs concepts borrowed from object oriented programming, but strictly speaking, AutoLISP is not object oriented. Nevertheless, there is an underlying OpenDCL object model, and it's helpful to understand this model when programming for OpenDCL. The convention used by OpenDCL for calling object methods is to specify the object instance as the first argument to the method function.

OpenDCL objects are represented in AutoLISP as entity names (an entity name is just a memory pointer that points to the object instance). When an OpenDCL project is loaded, OpenDCL automatically sets AutoLISP symbols for each form defined in the project. While a form is active, OpenDCL sets AutoLISP symbols for each control on the form. The VarName property of forms and controls determines the name of the AutoLISP symbol used to reference the object. For example, showing a form is accomplished by calling the Form-Show method with the form handle as the first argument:

(dcl-Form-Show Project1/Form1)
In this example, Project1/Form1 is an AutoLISP symbol that is automatically set by OpenDCL to point to the form when the project is loaded.

OpenDCL Object Model
The basic OpenDCL object type exposed to AutoLISP is the control. Internally, forms are a special type of control, so control methods typically apply to forms as well. The other fundamental object exposed by OpenDCL is the project. OpenDCL also exposes specialized objects like the ImageList, BinFile, and AxObject. Each of these object types have their own methods that can be called using the following calling format:

(dcl-METHODNAME <OBJECT> ARGUMENTS)
Every control contains a list of properties. Different types of controls contain different properties, but all controls of a given type contain the same properties. Some controls, like ActiveX controls, may contain additional properties that are exposed separately from the built in OpenDCL properties. Properties are not exposed as independent objects; instead they are accessed through their owning control by name, using the following convention (where PROPERTYNAME is the property API name):

(dcl-Control-GetPROPERTYNAME <CONTROL>)
(dcl-Control-SetPROPERTYNAME <CONTROL> NEWVALUE)
Alternatively, properties can be accessed via the generic Control-GetProperty and Control-SetProperty methods.

OpenDCL Project Structure
As the following hierarchy diagram shows, an OpenDCL project contains forms and pictures. Forms contain properties and controls. Controls also contain properties. OpenDCL Runtime is designed to allow an unlimited number of projects to be loaded simultaneously, so that multiple independent OpenDCL applications can function inside AutoCAD without interfering with each other.



OpenDCL Control Handles

Controls (and forms) are referenced in AutoLISP code by AutoLISP symbols that contain a handle for the control. These symbols are automatically created in the AutoLISP namespace of every AutoCAD drawing while an instance of a form is active. The default AutoLISP symbol name for this handle is constructed by concatenating the project key, form name, and control name, all separated by a forward slash character, as in this example:

((dcl-Control-GetName ProjectKey/FormName/ControlName)
This default symbol name can be overridden by setting the control's VarName property, but using the default naming convention is recommended to minimize the risk of symbol name collisions between applications.

Controls and forms can also be referenced by specifying their project hierarchy path in the form of strings, as in this example:

(dcl-Control-GetName "ProjectKey" "FormName" "ControlName")
The lisp symbol method only works while the control's form is active, however the string method can be used to refer to any loaded control even when its form is not active. The string method is also useful when performing the same operation on a list of controls, as in this example:

(foreach control '("Control1" "Control2" "Control3") (
dcl-Control-SetEnabled "ProjectKey" "FormName" control NIL))

## 1.2 Application Development

An OpenDCL application consists of AutoLISP code and OpenDCL project data. The OpenDCL project data is created and edited in OpenDCL Studio, and can exist either as a separate .odcl file or as data within the AutoLISP code. Embedding the project data within the AutoLISP code is an advanced topic that is covered elsewhere.

OpenDCL uses an event driven programming model, where user interface events trigger calls to event handlers that perform the work of the application. A typical OpenDCL application includes code to load and display a form, along with event handlers that manage the form once it is displayed. Event handlers respond to user actions such as pressing a button or selecting an item in a list.

The AutoLISP code that displays an OpenDCL form must first ensure that the OpenDCL Runtime module is loaded. This is done by utilizing AutoCAD's demand loading feature by executing the OPENDCL command. There is no need to check whether the runtime is already loaded -- if it is, the command does nothing.

(command "_OPENDCL")
The next step is to load the project data. If the project data is stored in a file, it can be loaded by calling the (dcl-Project-Load) function. If you choose to embed the project data within the AutoLISP code, it can be loaded by calling the (dcl-Project-Import) function.

Once the project data is loaded, a call to (dcl-Form-Show) will create a dialog and display it on the screen. After the dialog is displayed, AutoLISP event handlers take over and manage the form until it is closed. Initializing the dialog must be done in an event handler called OnInitialize. Following is typical code for displaying a simple modal dialog:

(defun C:MyCommand (/ Result)
  (command "_OPENDCL") ; Load OpenDCL Runtime
  (if (dcl-Project-Load "MyProject") ; Load project data from MyProject.odcl
    (progn
      (setq Result (dcl-Form-Show MyProject/MyForm))
      ; Note that this code does not execute until *after* the
        dialog is closed!
      (if (= Result 1) (DoSomething))
    )
  )
  (princ)
)
(defun c:MyProject/MyForm#OnInitialize (/)
  (dcl-Control-SetCaption MyProject/MyForm/Label1 "Hello World!")
)
(defun c:MyProject/MyForm/CloseButton#OnClicked (/)
  (dcl-Form-Close MyProject/MyForm)
)

As you can see, the code for displaying the dialog is very simple. The work of initializing, managing, and responding to the dialog events all happens in separate event handlers that get called while the dialog is active. The dialog is closed when an event handler calls (dcl-Form-Close). Note that (dcl-Form-Close) can be given an optional dialog status code that is subsequently returned by the (dcl-Form-Show) function. This status code can be used to determine what, if anything, should be done after the dialog has closed.

Modal vs. Modeless Support Forum
Report A Bug  

--------------------------------------------------------------------------------

Modal dialogs disable the AutoCAD window until they are closed. By their nature, modal dialogs are easier to manage because the AutoCAD state remains unchanged for the life of the dialog. Modal dialogs return a dialog status code when they close, and typically the main application code performs additional actions based on the status code returned from the dialog.

Modeless dialogs present additional challenges. Since modeless dialogs can remain open for the lifetime of the AutoCAD application, they must deal with changing AutoCAD state such as documents opening and closing. In addition, since every AutoCAD drawing has its own AutoLISP namespace, activating a new document means that event handlers defined in the deactivated document will no longer be accessible in the newly activated document.

These realities mean that the only way to manage a modeless dialog is by ensuring that the event handlers are defined in every new drawing file. In practice, this usually means that the application lisp file (or files) must be loaded via the acaddoc.lsp file or a similar method that loads the files as part of new document initialization.

Furthermore, since the dialog may already be active when startup code executes (after opening a second drawing file, for example), it must act accordingly. For example, if the application must read some initialization settings from the registry, it likely needs to do that only when the modeless dialog is initially activated. If such initialization is performed in the dialog's OnInitialize event, it will only get executed once when the dialog is first activated. If the application needs to determine at runtime whether the dialog is already active it can use an expression like the following:

(and MyProject-MyForm (dcl-Form-IsActive MyProject-MyForm))
In addition to programming startup code to act appropriately when more than one drawing is opened, modeless dialogs must also behave correctly when all open drawings are closed (resulting in a state referred to as a "no doc state") or when the user switches between multiple active drawings. If the modeless dialog contains controls whose settings or properties depend on the drawing contents, then it must define event handlers for the OnDocActivated and OnEnteringNoDocState events to update the controls as the document state changes.

Modeless dialog event handlers are normally invoked in the AutoCAD application context instead of the document context. AutoLISP code running in the application context cannot call document-dependent functions like the (command) function. To deal with this problem, the control's 'Event Invoke' property may be used to trigger the event handler asynchronously in the document context, thus allowing calls to (command) to succeed. Alternatively, the event handler may be executed synchronously, but instead of calling document-dependent functions within the handler function, it can simply trigger a new command to execute in the document context via the (dcl-SendString) function.


