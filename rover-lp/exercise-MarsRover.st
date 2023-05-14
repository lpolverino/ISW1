!classDefinition: #MarsRoverTest category: 'exercise-MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'exercise-MarsRover'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:10:53'!
test01AlIniciarElRobotSabeDondeEsta

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Norte .
	
	self assert: ( marsRover hasPosition: 0@0 andFacing:Norte )! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:11:03'!
test02SabeRecivirInstruccionVacia

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Norte .
	
	marsRover receiveCommand:''.
	
	self assert: ( marsRover hasPosition: 0@0 andFacing:Norte )! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:21:29'!
test03SabeRecivirUnComandoFAvanzandoAlEste

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Este .
	
	marsRover receiveCommand:'f'.
	
	self assert: ( marsRover hasPosition: 0@1 andFacing:Este )! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:21:40'!
test04SabeRecivirUnComandoFAvanzandoAlSur

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Sur .
	
	marsRover receiveCommand:'f'.
	
	self assert: ( marsRover hasPosition: -1@0 andFacing:Sur )! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:21:47'!
test05SabeRecivirUnComandoFAvanzandoAlOeste

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Oeste .
	
	marsRover receiveCommand:'f'.
	
	self assert: ( marsRover hasPosition: 0@-1 andFacing:Oeste )! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:13:35'!
test06SabeRecivirUnComandoFAvanzandoAlNorte

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Norte .
	
	marsRover receiveCommand:'f'.
	
	self assert: ( marsRover hasPosition: 1@0 andFacing:Norte)
	"El test nos dice que tiene que tener un comportamiento distinto segun la direccion, el mensaje puede ser refactorizando con doble dispatch"! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:33:33'!
test07SabeRecivirUnComandoBRetrocediendoAlEste

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Este .
	
	marsRover receiveCommand:'b'.
	
	self assert: ( marsRover hasPosition: 0@-1 andFacing:Este)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:33:42'!
test08SabeRecivirUnComandoBRetrocediendoAlNorte

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Norte .
	
	marsRover receiveCommand:'b'.
	
	self assert: ( marsRover hasPosition: -1@0 andFacing:Norte)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:34:05'!
test09SabeRecivirUnComandoBRetrocediendoAlSur

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Sur .
	
	marsRover receiveCommand:'b'.
	
	self assert: ( marsRover hasPosition: 1@0 andFacing:Sur)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:35:38'!
test10SabeRecivirUnComandoBRetrocediendoAlOeste

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Oeste .
	
	marsRover receiveCommand:'b'.
	
	self assert: ( marsRover hasPosition: 0@1 andFacing:Oeste)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:45:13'!
test11SabeRecivirUnComandoRMirandoHaciaElNorte

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Norte .
	
	marsRover receiveCommand:'r'.
	
	self assert: ( marsRover hasPosition: 0@0 andFacing:Este)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:45:42'!
test12SabeRecivirUnComandoRMirandoHaciaElEste

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Este .
	
	marsRover receiveCommand:'r'.
	
	self assert: ( marsRover hasPosition: 0@0 andFacing:Sur)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:47:13'!
test13SabeRecivirUnComandoRMirandoHaciaElSur

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Sur .
	
	marsRover receiveCommand:'r'.
	
	self assert: ( marsRover hasPosition: 0@0 andFacing:Oeste)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:49:40'!
test14SabeRecivirUnComandoRMirandoHaciaElOeste

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Oeste .
	
	marsRover receiveCommand:'r'.
	
	self assert: ( marsRover hasPosition: 0@0 andFacing:Norte)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:55:07'!
test15SabeRecivirUnComandoLMirandoHaciaElNorte

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Norte .
	
	marsRover receiveCommand:'l'.
	
	self assert: ( marsRover hasPosition: 0@0 andFacing:Oeste)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:59:02'!
test16SabeRecivirUnComandoLMirandoHaciaElEste

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Este .
	
	marsRover receiveCommand:'l'.
	
	self assert: ( marsRover hasPosition: 0@0 andFacing:Norte)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 12:01:32'!
test17SabeRecivirUnComandoLMirandoHaciaElSur

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Sur .
	
	marsRover receiveCommand:'l'.
	
	self assert: ( marsRover hasPosition: 0@0 andFacing:Este)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 12:03:32'!
test18SabeRecivirUnComandoLMirandoHaciaElOeste

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Oeste .
	
	marsRover receiveCommand:'l'.
	
	self assert: ( marsRover hasPosition: 0@0 andFacing:Sur)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 12:10:34'!
test19SabeRecivirDosComandosDiferentes

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Oeste .
	
	marsRover receiveCommand:'lf'.
	
	self assert: ( marsRover hasPosition: -1@0 andFacing:Sur)
	! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 12:23:00'!
test20SabeRecivirVariosComandosDiferentes

	| marsRover |
	marsRover := MarsRover new initializeIn: 0@0 facing:Norte .
	
	marsRover receiveCommand:'ffff'.
	
	self assert: ( marsRover hasPosition: 4@0 andFacing:Norte)
	! !


!classDefinition: #MarsRover category: 'exercise-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'exercise-MarsRover'!

!MarsRover methodsFor: 'initialize' stamp: 'Lp 5/13/2023 10:38:35'!
initializeIn: aPoint facing: aDirection
	position := aPoint.
	direction := aDirection new initializeWith: self.! !


!MarsRover methodsFor: 'testing' stamp: 'Lp 5/13/2023 10:45:42'!
hasPosition: aPosition andFacing: aDirection 
	(aPosition = position and: (direction is:aDirection)) ifTrue: [^true]. 
	^false! !


!MarsRover methodsFor: 'move Foward' stamp: 'Lp 5/13/2023 12:23:45'!
goFowardToTheEast
	position:= position +(0@1)! !

!MarsRover methodsFor: 'move Foward' stamp: 'Lp 5/13/2023 12:23:54'!
goFowardToTheNorth
	position:= position +(1@0)! !

!MarsRover methodsFor: 'move Foward' stamp: 'Lp 5/13/2023 12:24:03'!
goFowardToTheSouth
	position:= position +(-1@0)! !

!MarsRover methodsFor: 'move Foward' stamp: 'Lp 5/13/2023 12:24:11'!
goFowardToTheWest
	position:= position +(0@-1)! !


!MarsRover methodsFor: 'command' stamp: 'Lp 5/13/2023 12:16:19'!
m1: aListOfCommands

	^ aListOfCommands = $f ifTrue: [
			direction  receiveFoward ]
			ifFalse: [
				aListOfCommands  = $b ifTrue: [
					direction receiveBackward
					]
					ifFalse: [
						aListOfCommands  = $r ifTrue: [
							direction receiveRight.
							]
						ifFalse:[
								direction receiveLeft.
									]
							]
						]! !

!MarsRover methodsFor: 'command' stamp: 'Lp 5/13/2023 12:18:40'!
receiveCommand: aListOfCommands
	aListOfCommands isEmpty ifFalse:[
		aListOfCommands do:[:command| self m1:command]
		
		"self m1: (aListOfCommands at:1). 
			aListOfCommands size = 2 ifTrue:[
				self m1: (aListOfCommands at:2)"
				] ! !


!MarsRover methodsFor: 'move Backward' stamp: 'Lp 5/13/2023 12:24:23'!
goBackwardToTheEast
	position := position + (0@-1)! !

!MarsRover methodsFor: 'move Backward' stamp: 'Lp 5/13/2023 12:24:30'!
goBackwardToTheNorth
	position := position +(-1@0)! !

!MarsRover methodsFor: 'move Backward' stamp: 'Lp 5/13/2023 12:24:40'!
goBackwardToTheSouth
	position := position +(1@0)! !

!MarsRover methodsFor: 'move Backward' stamp: 'Lp 5/13/2023 12:24:47'!
goBackwardToTheWest
	position := position +(0@1)! !


!MarsRover methodsFor: 'rotate Left' stamp: 'Lp 5/13/2023 12:08:57'!
rotateLeftFromTheEast

	direction := Norte new initializeWith: self! !

!MarsRover methodsFor: 'rotate Left' stamp: 'Lp 5/13/2023 12:09:01'!
rotateLeftFromTheNorth

	direction :=  Oeste new initializeWith: self! !

!MarsRover methodsFor: 'rotate Left' stamp: 'Lp 5/13/2023 12:09:04'!
rotateLeftFromTheSouth

	direction :=  Este new initializeWith: self! !

!MarsRover methodsFor: 'rotate Left' stamp: 'Lp 5/13/2023 12:09:08'!
rotateLeftFromTheWest

	direction :=  Sur new initializeWith: self! !


!MarsRover methodsFor: 'rotate Right' stamp: 'Lp 5/13/2023 11:51:33'!
rotateRightFromEast

	^ direction := Sur new initializeWith: self! !

!MarsRover methodsFor: 'rotate Right' stamp: 'Lp 5/13/2023 11:51:19'!
rotateRightFromNorth

	^ direction := Este new initializeWith: self! !

!MarsRover methodsFor: 'rotate Right' stamp: 'Lp 5/13/2023 11:52:28'!
rotateRightFromWest

	^ direction := Norte new initializeWith: self! !

!MarsRover methodsFor: 'rotate Right' stamp: 'Lp 5/13/2023 11:51:46'!
rotateRigthFromSouth

	^ direction := Oeste new initializeWith: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'exercise-MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'Lp 5/12/2023 12:49:17'!
inPosition: aPoint facing: aSymbol 
	^self new initializeIn: aPoint facing: aSymbol ! !


!classDefinition: #MarsRoverDirection category: 'exercise-MarsRover'!
Object subclass: #MarsRoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'exercise-MarsRover'!

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 10:41:35'!
initializeWith: aMarsRover
	self subclassResponsibility ! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:11:22'!
is: aDirection
	self subclassResponsibility ! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:37:03'!
receiveBackward
	self subclassResponsibility ! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 10:41:58'!
receiveFoward
	self subclassResponsibility ! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 12:06:13'!
receiveLeft
	self subclassResponsibility ! !

!MarsRoverDirection methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:53:04'!
receiveRight
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverDirection class' category: 'exercise-MarsRover'!
MarsRoverDirection class
	instanceVariableNames: ''!

!MarsRoverDirection class methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 10:35:04'!
for: aDirection
	
	^self new initializeFor:aDirection! !


!classDefinition: #Este category: 'exercise-MarsRover'!
MarsRoverDirection subclass: #Este
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'exercise-MarsRover'!

!Este methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:21:07'!
initializeWith:aMarsRover
	marsRover := aMarsRover! !

!Este methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:21:20'!
is: aDirection
	^aDirection = Este! !

!Este methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:37:14'!
receiveBackward
	marsRover goBackwardToTheEast.! !

!Este methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:23:16'!
receiveFoward
	marsRover goFowardToTheEast.! !

!Este methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 12:06:36'!
receiveLeft
	marsRover rotateLeftFromTheEast .! !

!Este methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:53:36'!
receiveRight
	marsRover rotateRightFromEast.! !


!classDefinition: #Norte category: 'exercise-MarsRover'!
MarsRoverDirection subclass: #Norte
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'exercise-MarsRover'!

!Norte methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 10:40:15'!
initializeWith:aMarsRover
	marsRover := aMarsRover! !

!Norte methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:15:56'!
is: aDirection
	^aDirection = Norte! !

!Norte methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:37:30'!
receiveBackward
	marsRover goBackwardToTheNorth.! !

!Norte methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:23:00'!
receiveFoward
	marsRover goFowardToTheNorth.! !

!Norte methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 12:06:50'!
receiveLeft
	marsRover rotateLeftFromTheNorth .! !

!Norte methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:53:46'!
receiveRight
	marsRover rotateRightFromNorth .! !


!classDefinition: #Oeste category: 'exercise-MarsRover'!
MarsRoverDirection subclass: #Oeste
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'exercise-MarsRover'!

!Oeste methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:26:36'!
initializeWith:aMarsRover
	marsRover := aMarsRover! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:24:34'!
is: aDirection
	^aDirection = Oeste! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:37:49'!
receiveBackward
	marsRover goBackwardToTheWest.! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:24:51'!
receiveFoward
	marsRover goFowardToTheWest.! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 12:07:34'!
receiveLeft
	marsRover rotateLeftFromTheWest .! !

!Oeste methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:54:03'!
receiveRight
	marsRover rotateRightFromWest.! !


!classDefinition: #Sur category: 'exercise-MarsRover'!
MarsRoverDirection subclass: #Sur
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'exercise-MarsRover'!

!Sur methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:26:43'!
initializeWith:aMarsRover
	marsRover := aMarsRover! !

!Sur methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:27:04'!
is: aDirection
	^aDirection = Sur! !

!Sur methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:38:03'!
receiveBackward
	marsRover goBackwardToTheSouth.! !

!Sur methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:27:19'!
receiveFoward
	marsRover goFowardToTheSouth.! !

!Sur methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 12:07:44'!
receiveLeft
	marsRover rotateLeftFromTheSouth .! !

!Sur methodsFor: 'as yet unclassified' stamp: 'Lp 5/13/2023 11:54:22'!
receiveRight
	marsRover rotateRigthFromSouth .! !
