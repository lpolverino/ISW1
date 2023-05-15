!classDefinition: #MarsRoverTest category: 'MarsRover-Exercise'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsRoverDeployedInCenterFacingNorth marsRoverDeployedInCenterFacingSouth marsRoverDeployedInCenterFacingEast marsRoverDeployedInCenterFacingWest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRoverTest methodsFor: 'testing backward' stamp: 'lp 5/15/2023 15:49:04'!
test10MarsRovershouldMoveSouthWhenReceivedOneBInstructionAndFacingNorth


	marsRoverDeployedInCenterFacingNorth receiveCommands: 'b'.
	self assert:(marsRoverDeployedInCenterFacingNorth isInPosition: -1@0 andFacing:North)! !

!MarsRoverTest methodsFor: 'testing backward' stamp: 'lp 5/15/2023 15:49:16'!
test11MarsRovershouldMoveWestWhenReceivedOneBInstructionAndFacingEast

	marsRoverDeployedInCenterFacingEast receiveCommands: 'b'.
	self assert:(marsRoverDeployedInCenterFacingEast isInPosition: 0@-1 andFacing:East)! !

!MarsRoverTest methodsFor: 'testing backward' stamp: 'lp 5/15/2023 15:49:26'!
test12MarsRovershouldMoveNorthWhenReceivedOneBInstructionAndFacingSOuth

	marsRoverDeployedInCenterFacingSouth receiveCommands: 'b'.
	self assert:(marsRoverDeployedInCenterFacingSouth isInPosition: 1@0 andFacing:South )! !

!MarsRoverTest methodsFor: 'testing backward' stamp: 'lp 5/15/2023 15:49:36'!
test13MarsRovershouldMoveEastWhenReceivedOneBInstructionAndFacingWest


	marsRoverDeployedInCenterFacingWest receiveCommands: 'b'.
	self assert:(marsRoverDeployedInCenterFacingWest isInPosition: 0@1 andFacing:West )! !


!MarsRoverTest methodsFor: 'set-up creations' stamp: 'lp 5/15/2023 12:25:18'!
createMarsRoverInTheCenterFacingEast

	^ MarsRover inPosition: 0@0 facing:East new! !

!MarsRoverTest methodsFor: 'set-up creations' stamp: 'lp 5/15/2023 12:40:07'!
createMarsRoverInTheCenterFacingNorth

	^ MarsRover inPosition: 0@0 facing:North new! !

!MarsRoverTest methodsFor: 'set-up creations' stamp: 'lp 5/15/2023 12:25:32'!
createMarsRoverInTheCenterFacingSOuth

	^ MarsRover inPosition: 0@0 facing:South new! !

!MarsRoverTest methodsFor: 'set-up creations' stamp: 'lp 5/15/2023 12:25:38'!
createMarsRoverInTheCenterFacingWest

	^ MarsRover inPosition: 0@0 facing:West new! !


!MarsRoverTest methodsFor: 'testing empty instruction' stamp: 'lp 5/15/2023 15:51:40'!
test05MarsRoverDoesNothingWhenReceivedEmptyInstructionList

	
	marsRoverDeployedInCenterFacingWest receiveCommands: ''.
	self assert:(marsRoverDeployedInCenterFacingWest isInPosition: 0@0 andFacing:West )! !


!MarsRoverTest methodsFor: 'testing error' stamp: 'lp 5/15/2023 15:51:13'!
test22marsRoverShouldFailWhenStartWithSomeUnknowInstruction

	
	
	self should: [
		marsRoverDeployedInCenterFacingNorth receiveCommands: 'ñ'
		] raise:  Error 
	withExceptionDo: [:error|
			self assert:( MarsRover  unknowCommandErrorDescription  ) equals: (error  messageText ).
			self assert:( marsRoverDeployedInCenterFacingNorth isInPosition: 0@0 andFacing:North ).
	]
	! !


!MarsRoverTest methodsFor: 'testing foward' stamp: 'lp 5/15/2023 15:48:17'!
test06MarsRovershouldMoveNorthWhenReceivedOneFInstruction

		
	marsRoverDeployedInCenterFacingNorth receiveCommands: 'f'.
	self assert:(marsRoverDeployedInCenterFacingNorth isInPosition: 1@0 andFacing:North )! !

!MarsRoverTest methodsFor: 'testing foward' stamp: 'lp 5/15/2023 15:48:31'!
test07MarsRovershouldMoveSOuthWhenReceivedOneFInstruction

	marsRoverDeployedInCenterFacingSouth receiveCommands: 'f'.
	self assert:(marsRoverDeployedInCenterFacingSouth isInPosition: -1@0 andFacing:South )! !

!MarsRoverTest methodsFor: 'testing foward' stamp: 'lp 5/15/2023 15:48:40'!
test08MarsRovershouldMoveEastWhenReceivedOneFInstruction

	marsRoverDeployedInCenterFacingEast receiveCommands: 'f'.
	self assert:(marsRoverDeployedInCenterFacingEast isInPosition: 0@1 andFacing:East )! !

!MarsRoverTest methodsFor: 'testing foward' stamp: 'lp 5/15/2023 15:48:49'!
test09MarsRovershouldMoveWestWhenReceivedOneFInstruction

	marsRoverDeployedInCenterFacingWest receiveCommands: 'f'.
	self assert:(marsRoverDeployedInCenterFacingWest isInPosition: 0@-1 andFacing:West)! !


!MarsRoverTest methodsFor: 'testing Left Rotation' stamp: 'lp 5/15/2023 15:49:46'!
test18MarsRovershouldRotateToTheWestWhenReceivedOneLInstructionAndFacingNorth


	marsRoverDeployedInCenterFacingNorth receiveCommands: 'l'.
	self assert:(marsRoverDeployedInCenterFacingNorth isInPosition: 0@0 andFacing:West)! !

!MarsRoverTest methodsFor: 'testing Left Rotation' stamp: 'lp 5/15/2023 15:49:57'!
test19MarsRovershouldRotateToTheSouthWhenReceivedOneLInstructionAndFacingWest

	
	marsRoverDeployedInCenterFacingWest receiveCommands: 'l'.
	self assert:(marsRoverDeployedInCenterFacingWest isInPosition: 0@0 andFacing:South)! !

!MarsRoverTest methodsFor: 'testing Left Rotation' stamp: 'lp 5/15/2023 15:50:05'!
test20MarsRovershouldRotateToTheEastWhenReceivedOneLInstructionAndFacingSouth

	marsRoverDeployedInCenterFacingSouth receiveCommands: 'l'.
	self assert:(marsRoverDeployedInCenterFacingSouth isInPosition: 0@0 andFacing:East)! !

!MarsRoverTest methodsFor: 'testing Left Rotation' stamp: 'lp 5/15/2023 15:50:15'!
test21MarsRovershouldRotateToTheNOrthWhenReceivedOneLInstructionAndFacingEast

	marsRoverDeployedInCenterFacingEast receiveCommands: 'l'.
	self assert:(marsRoverDeployedInCenterFacingEast isInPosition: 0@0 andFacing:North)! !


!MarsRoverTest methodsFor: 'testing Right Rotation' stamp: 'lp 5/15/2023 15:50:24'!
test14MarsRovershouldRotateToTheEastWhenReceivedOneRInstructionAndFacingNorth

	
	marsRoverDeployedInCenterFacingNorth receiveCommands: 'r'.
	self assert:(marsRoverDeployedInCenterFacingNorth isInPosition: 0@0 andFacing:East )! !

!MarsRoverTest methodsFor: 'testing Right Rotation' stamp: 'lp 5/15/2023 15:50:40'!
test15MarsRovershouldRotateToTheSouthWhenReceivedOneRInstructionAndFacingEast

	
	marsRoverDeployedInCenterFacingEast receiveCommands: 'r'.
	self assert:(marsRoverDeployedInCenterFacingEast isInPosition: 0@0 andFacing:South )! !

!MarsRoverTest methodsFor: 'testing Right Rotation' stamp: 'lp 5/15/2023 15:50:49'!
test16MarsRovershouldRotateToTheWestWhenReceivedOneRInstructionAndFacingSOuth

	
	marsRoverDeployedInCenterFacingSouth receiveCommands: 'r'.
	self assert:(marsRoverDeployedInCenterFacingSouth isInPosition: 0@0 andFacing:West)! !

!MarsRoverTest methodsFor: 'testing Right Rotation' stamp: 'lp 5/15/2023 15:50:58'!
test17MarsRovershouldRotateToTheNorthWhenReceivedOneRInstructionAndFacingWest


	marsRoverDeployedInCenterFacingWest receiveCommands: 'r'.
	self assert:(marsRoverDeployedInCenterFacingWest isInPosition: 0@0 andFacing:North)! !


!MarsRoverTest methodsFor: 'testing many' stamp: 'lp 5/15/2023 15:45:33'!
setUp
	
	marsRoverDeployedInCenterFacingNorth := self createMarsRoverInTheCenterFacingNorth.
	marsRoverDeployedInCenterFacingSouth := self createMarsRoverInTheCenterFacingSOuth.
	marsRoverDeployedInCenterFacingEast := self createMarsRoverInTheCenterFacingEast .
	marsRoverDeployedInCenterFacingWest := self createMarsRoverInTheCenterFacingWest .! !

!MarsRoverTest methodsFor: 'testing many' stamp: 'lp 5/15/2023 15:51:57'!
test23marsRoverShouldMoveTwoTimesWhenReceivedTwoFInstruction

	
	marsRoverDeployedInCenterFacingWest receiveCommands: 'ff'.
	self assert:(marsRoverDeployedInCenterFacingWest isInPosition: 0@-2 andFacing:West)! !

!MarsRoverTest methodsFor: 'testing many' stamp: 'lp 5/15/2023 15:52:06'!
test24marsRoverShouldNotMOveAFterGoingFowardAndBackwards

	
	marsRoverDeployedInCenterFacingNorth receiveCommands: 'fb'.
	self assert:(marsRoverDeployedInCenterFacingNorth isInPosition: 0@0 andFacing:North)! !

!MarsRoverTest methodsFor: 'testing many' stamp: 'lp 5/15/2023 15:52:13'!
test25marsRoverShouldFaceWestAFterGoingFowardAndAndTurnLeft

	
	marsRoverDeployedInCenterFacingNorth receiveCommands: 'fl'.
	self assert:(marsRoverDeployedInCenterFacingNorth isInPosition: 1@0 andFacing:West)! !

!MarsRoverTest methodsFor: 'testing many' stamp: 'lp 5/15/2023 15:52:22'!
test26marsRoverShouldFaceEastAFterGoingFowardAndAndTurnRight

	
	marsRoverDeployedInCenterFacingNorth receiveCommands: 'fr'.
	self assert:(marsRoverDeployedInCenterFacingNorth isInPosition: 1@0 andFacing:East)! !

!MarsRoverTest methodsFor: 'testing many' stamp: 'lp 5/15/2023 15:52:36'!
test27marsRoverShouldBeOnePlaceFowardAndHaltWhenReceivedUknowCOmmandAFterF
	
	
	self should: [
		marsRoverDeployedInCenterFacingNorth receiveCommands: 'fñ'
		] raise:  Error 
	withExceptionDo: [:error|
			self assert:( MarsRover  unknowCommandErrorDescription  ) equals: (error  messageText ).
			self assert:( marsRoverDeployedInCenterFacingNorth isInPosition: 1@0 andFacing:North ).
	]! !

!MarsRoverTest methodsFor: 'testing many' stamp: 'lp 5/15/2023 15:52:46'!
test28marsRoverShouldMoveThreeTimesWhenReceivedThreeTImesFInstruction

	
	marsRoverDeployedInCenterFacingWest receiveCommands: 'fff'.
	self assert:(marsRoverDeployedInCenterFacingWest isInPosition: 0@-3 andFacing:West)! !

!MarsRoverTest methodsFor: 'testing many' stamp: 'lp 5/15/2023 15:52:54'!
test29marsRoverShouldbeTwoPOsitionFowardAfterGoingBackwardAfterTwoFowards

	
	marsRoverDeployedInCenterFacingWest receiveCommands: 'ffb'.
	self assert:(marsRoverDeployedInCenterFacingWest isInPosition: 0@-1 andFacing:West)! !

!MarsRoverTest methodsFor: 'testing many' stamp: 'lp 5/15/2023 15:53:01'!
test30marsRoverShouldTurnLeftAfterExcecutedTwoOtherInstructions

	
	marsRoverDeployedInCenterFacingWest receiveCommands: 'ffl'.
	self assert:(marsRoverDeployedInCenterFacingWest isInPosition: 0@-2 andFacing:South)! !

!MarsRoverTest methodsFor: 'testing many' stamp: 'lp 5/15/2023 15:53:11'!
test31marsRoverShouldTurnRightAfterExcecutedTwoOtherInstructions

	
	marsRoverDeployedInCenterFacingWest receiveCommands: 'ffr'.
	self assert:(marsRoverDeployedInCenterFacingWest isInPosition: 0@-2 andFacing:North)! !

!MarsRoverTest methodsFor: 'testing many' stamp: 'lp 5/15/2023 15:53:24'!
test32marsRoverShouldHaltAfterExecutedTwoPreviousCommands

		
	
	self should: [
		marsRoverDeployedInCenterFacingNorth receiveCommands: 'ffñ'
		] raise:  Error 
	withExceptionDo: [:error|
			self assert:( MarsRover  unknowCommandErrorDescription  ) equals: (error  messageText ).
			self assert:( marsRoverDeployedInCenterFacingNorth isInPosition: 2@0 andFacing:North ).
	]! !


!MarsRoverTest methodsFor: 'testing initialization' stamp: 'lp 5/15/2023 15:46:55'!
test00MarsRoverStartInTheInitialPosition

		
	self assert:(marsRoverDeployedInCenterFacingNorth isInPosition: 0@0 andFacing:North )! !

!MarsRoverTest methodsFor: 'testing initialization' stamp: 'lp 5/15/2023 12:32:54'!
test01MarsRoverDirectionIsnNorthWhenDeployedFacingNorth

	| marsRover |
	
	marsRover := 	MarsRover inPosition: 1@0 facing: North new.
	self assert:(marsRover isInPosition: 1@0 andFacing:North )! !

!MarsRoverTest methodsFor: 'testing initialization' stamp: 'lp 5/15/2023 15:47:14'!
test02MarsRoverDirectionIsEastWhenDeployedFacingEast

	self assert:(marsRoverDeployedInCenterFacingEast isInPosition: 0@0 andFacing:East )! !

!MarsRoverTest methodsFor: 'testing initialization' stamp: 'lp 5/15/2023 15:47:25'!
test03MarsRoverDirectionIsSouthWhenDeployedFacingSouth

	self assert:(marsRoverDeployedInCenterFacingSouth isInPosition: 0@0 andFacing:South )! !

!MarsRoverTest methodsFor: 'testing initialization' stamp: 'lp 5/15/2023 15:47:34'!
test04MarsRoverDirectionIsWestWhenDeployedFacingWest

	self assert:(marsRoverDeployedInCenterFacingWest isInPosition: 0@0 andFacing:West )! !


!classDefinition: #CardinalDirections category: 'MarsRover-Exercise'!
Object subclass: #CardinalDirections
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!CardinalDirections methodsFor: 'directions' stamp: 'lp 5/15/2023 15:35:21'!
turnLeft
	self subclassResponsibility ! !

!CardinalDirections methodsFor: 'directions' stamp: 'lp 5/15/2023 15:35:27'!
turnRight
	self subclassResponsibility ! !


!CardinalDirections methodsFor: 'Axis' stamp: 'lp 5/15/2023 12:35:24'!
getAxis
	self subclassResponsibility ! !

!CardinalDirections methodsFor: 'Axis' stamp: 'lp 5/15/2023 15:34:50'!
getInverseAxis
	self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover-Exercise'!
CardinalDirections subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!East methodsFor: 'Axis' stamp: 'lp 5/15/2023 12:35:40'!
getAxis
	^ 0@1! !

!East methodsFor: 'Axis' stamp: 'lp 5/15/2023 12:45:46'!
getInverseAxis
	^ 0@-1! !


!East methodsFor: 'directions' stamp: 'lp 5/15/2023 13:01:10'!
turnLeft
	^ North new.! !

!East methodsFor: 'directions' stamp: 'lp 5/15/2023 12:54:04'!
turnRight
	^ South  new! !


!classDefinition: #North category: 'MarsRover-Exercise'!
CardinalDirections subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!North methodsFor: 'Axis' stamp: 'lp 5/15/2023 12:35:53'!
getAxis
	^ 1@0! !

!North methodsFor: 'Axis' stamp: 'lp 5/15/2023 12:45:22'!
getInverseAxis
	^ -1@0! !


!North methodsFor: 'directions' stamp: 'lp 5/15/2023 12:58:11'!
turnLeft
	^ West new.! !

!North methodsFor: 'directions' stamp: 'lp 5/15/2023 12:52:56'!
turnRight
	^ East new! !


!classDefinition: #South category: 'MarsRover-Exercise'!
CardinalDirections subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!South methodsFor: 'Axis' stamp: 'lp 5/15/2023 12:36:21'!
getAxis
	^ -1@0! !

!South methodsFor: 'Axis' stamp: 'lp 5/15/2023 12:47:35'!
getInverseAxis
	^ 1@0! !


!South methodsFor: 'directions' stamp: 'lp 5/15/2023 13:00:27'!
turnLeft
	^ East new! !

!South methodsFor: 'directions' stamp: 'lp 5/15/2023 12:54:52'!
turnRight
	^ West new! !


!classDefinition: #West category: 'MarsRover-Exercise'!
CardinalDirections subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!West methodsFor: 'Axis' stamp: 'lp 5/15/2023 12:36:13'!
getAxis
	^ 0@-1! !

!West methodsFor: 'Axis' stamp: 'lp 5/15/2023 12:49:01'!
getInverseAxis
	^ 0@1! !


!West methodsFor: 'directions' stamp: 'lp 5/15/2023 12:59:48'!
turnLeft
	^ South new! !

!West methodsFor: 'directions' stamp: 'lp 5/15/2023 12:55:40'!
turnRight
	^ North new! !


!classDefinition: #InstructionsHandler category: 'MarsRover-Exercise'!
Object subclass: #InstructionsHandler
	instanceVariableNames: 'marsRover intructions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!InstructionsHandler methodsFor: 'initializing' stamp: 'lp 5/15/2023 15:28:47'!
initializeFor: aMarsRover

	marsRover := aMarsRover.
	intructions := Dictionary new.
	intructions  at: $f put:[marsRover executeFoward.].
	intructions  at:$b put:[marsRover executeBackwards].
	intructions  at:$r put:[marsRover executeRotateRight].
	intructions  at:$l put:[marsRover executeRotateLeft].! !


!InstructionsHandler methodsFor: 'command' stamp: 'lp 5/15/2023 15:29:34'!
executeAndFailIfItsUknown: aCharCommand

	^ (intructions at:aCharCommand ifAbsent:[marsRover canNotHandleInstruction]) value! !

!InstructionsHandler methodsFor: 'command' stamp: 'lp 5/15/2023 15:29:58'!
handleCommand: aCharCommand

	self executeAndFailIfItsUknown: aCharCommand
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InstructionsHandler class' category: 'MarsRover-Exercise'!
InstructionsHandler class
	instanceVariableNames: ''!

!InstructionsHandler class methodsFor: 'as yet unclassified' stamp: 'lp 5/15/2023 15:28:21'!
for:aMarsRover
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRover category: 'MarsRover-Exercise'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction instructionHandler'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Exercise'!

!MarsRover methodsFor: 'testing' stamp: 'lp 5/15/2023 12:32:27'!
isInPosition: aPosition andFacing: aDirection
	^ (aPosition = position ) and: (direction isKindOf: (aDirection))! !


!MarsRover methodsFor: 'initialization' stamp: 'lp 5/15/2023 15:27:35'!
deployIn: aPosition andFacing:aDirection
	position:= aPosition.
	direction := aDirection .
	instructionHandler  := InstructionsHandler for:self.! !


!MarsRover methodsFor: 'commands' stamp: 'lp 5/15/2023 15:25:52'!
receiveCommands: aInstructionList
	
	aInstructionList do:[:aCharInstruction| self executeCommand: aCharInstruction ]
		! !


!MarsRover methodsFor: 'execute Command' stamp: 'lp 5/15/2023 15:30:28'!
canNotHandleInstruction

	^ self error: self class  unknowCommandErrorDescription ! !

!MarsRover methodsFor: 'execute Command' stamp: 'lp 5/15/2023 15:33:16'!
executeBackwards
	position := position + direction getInverseAxis ! !

!MarsRover methodsFor: 'execute Command' stamp: 'lp 5/15/2023 15:34:24'!
executeCommand: aInstructionChar  
	^ instructionHandler handleCommand: aInstructionChar .
! !

!MarsRover methodsFor: 'execute Command' stamp: 'lp 5/15/2023 15:32:47'!
executeFoward
	position := position + direction getAxis .! !

!MarsRover methodsFor: 'execute Command' stamp: 'lp 5/15/2023 15:34:11'!
executeRotateLeft
	direction := direction turnLeft ! !

!MarsRover methodsFor: 'execute Command' stamp: 'lp 5/15/2023 15:33:49'!
executeRotateRight
	direction := direction turnRight .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Exercise'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'lp 5/15/2023 11:41:48'!
inPosition: aPosition facing:aDirection
	^self new deployIn: aPosition andFacing:aDirection .! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'lp 5/15/2023 13:05:39'!
unknowCommandErrorDescription
	'comando no reconocido'! !
