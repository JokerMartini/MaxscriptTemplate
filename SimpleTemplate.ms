/*HeaderStart*******************************************************
:Created By:			John Martini
:Company:				JokerMartini
:Site:					http://JokerMartini.com
:Email:					jokermartini@gmail.com
:Client:				

:Purpose:
	Allows for constraining objects between two other objects. 
	Objects will maintain their distances from the targets. 

:History:
	V:0.00.01A Nov 4 2014
		Getting started. 

:Todo:

:Bugs:

:Tests:
*******************************************************HeaderEnd*/

--Destroy the dialog if it is open. This is here for testing purposes. 
try(destroyDialog myTool.instUI;myTool.instUI=undefined)catch()

--Structure containing the tool
struct myTool
(
	testR=undefined,
	
	fn doSomething=
	(
		print "Do Something"
	),
	
	fn menu=
	(
		rcMenu myMenu
		(
			menuItem closeMnu "Close"
			menuItem testMnu "Test"
			
			on closeMnu picked do myTool.run()
			on testMnu picked do myTool.doSomething()
		)
	),
	
	fn ui=
	(
		rollout testR "Test"
		(
			
			on testR close do 
			(
				myTool.testR=undefined
			)
		)
	),
	
	fn run=
	(
		if testR==undefined then
		(
			ui()
			createDialog testR menu:(menu())
		)else
		(
			destroyDialog testR
			testR=undefined
		)
	),
	
	/*CommentStart*******************************************************
	This is here so that other tools can retreive the rollouts from this tool and display
		them in another UI
	*******************************************************CommentEnd*/
	fn getRollouts=(#(ui())),
		
	/*CommentStart*******************************************************
	MacroScript definition
		Will not work if you are encrypting your scripts
	*******************************************************CommentEnd*/
	macro=
	(
		macroScript myToolMacro 
			category:"My Tools"
		(
			on execute do 
			(
				if myTool!=undefined do 
				(
					myTool.run()
				)
			)
		)
	)
)
myTool=myTool()
myTool.run() --Just here for testing. 
