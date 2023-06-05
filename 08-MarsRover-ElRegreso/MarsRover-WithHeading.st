!classDefinition: #MarsRoverSubscribersTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverSubscribersTest
	instanceVariableNames: 'marsRoverInTheCenterHeadingNorth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverSubscribersTest methodsFor: 'heading Observers' stamp: 'lp 6/5/2023 14:57:02'!
test07InitializeLogForHeadingWithOneChangeInMarsRover

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingLog afterDoingThisCommandList:'l'  producesThisLogs: (OrderedCollection with:'West').! !

!MarsRoverSubscribersTest methodsFor: 'heading Observers' stamp: 'lp 6/5/2023 15:11:36'!
test09LogForHeadingAndTheFirstChangeIsForThePositionShowNothing

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingLog afterDoingThisCommandList:'f'  producesThisLogs: (OrderedCollection new).! !

!MarsRoverSubscribersTest methodsFor: 'heading Observers' stamp: 'lp 6/5/2023 15:11:25'!
test10LogForHeadingUpdatesWhenMarsRoverReceivedRCommand

	self assertIfThanInstanceOfMarsRoverObservantClass:MarsRoverHeadingLog  afterDoingThisCommandList: 'r' producesThisLogs: (OrderedCollection with:'East').! !

!MarsRoverSubscribersTest methodsFor: 'heading Observers' stamp: 'lp 6/5/2023 15:11:20'!
test11LogForHeadingUpdateWhenMarsRoverReceivedManyRCommands

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingLog afterDoingThisCommandList: 'rr' producesThisLogs: (OrderedCollection with: 'East' with:'South').! !

!MarsRoverSubscribersTest methodsFor: 'heading Observers' stamp: 'lp 6/5/2023 15:11:14'!
test12LogForHeadingUpdatesWhenMarsRoverReceivedManyLCommand

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingLog afterDoingThisCommandList:  'llll' producesThisLogs: (OrderedCollection with: 'West' with:'South' with:'East' with:'North').! !

!MarsRoverSubscribersTest methodsFor: 'heading Observers' stamp: 'lp 6/5/2023 15:11:09'!
test13InitializeWindowForHeadingWithOneChangeInMarsRoverHeading

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingWindow afterDoingThisCommandList: 'l' producesThisLogs: 'Apuntando al Oeste'.! !

!MarsRoverSubscribersTest methodsFor: 'heading Observers' stamp: 'lp 6/5/2023 15:11:03'!
test14InitializeWindowForHeadingWithFirstChageisToThePosition

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingWindow afterDoingThisCommandList: 'f' producesThisLogs: ''.! !

!MarsRoverSubscribersTest methodsFor: 'heading Observers' stamp: 'lp 6/5/2023 15:10:58'!
test15WindowForHeadingShowTheLastHeadingOfTheMarsRover

	
	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingWindow afterDoingThisCommandList: 'rrrr' producesThisLogs: 'Apuntando al Norte'.! !


!MarsRoverSubscribersTest methodsFor: 'set up' stamp: 'lp 6/4/2023 17:27:34'!
setUp

	marsRoverInTheCenterHeadingNorth := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	! !


!MarsRoverSubscribersTest methodsFor: 'assertions' stamp: 'lp 6/5/2023 15:06:53'!
assertIfAfterAMassRoverExecutesTheCommands:aCommandList aMarsRoverHeadingAndPositionWindowProducesTheHeadingLog: aExpectedHeadingWindow andThePositionLog: aExectedPositionLog 

	|marsRoverHeandingAndPositionLog |
	
	marsRoverHeandingAndPositionLog :=MarsRoverHeadingAndPositionWindow listenTo:marsRoverInTheCenterHeadingNorth .
	marsRoverInTheCenterHeadingNorth process: aCommandList.
	
	self assert: marsRoverHeandingAndPositionLog showPosition equals:aExectedPositionLog.
	self assert: marsRoverHeandingAndPositionLog showHeading equals:aExpectedHeadingWindow.


	! !

!MarsRoverSubscribersTest methodsFor: 'assertions' stamp: 'lp 6/4/2023 17:33:49'!
assertIfThanInstanceOfMarsRoverObservantClass: observantClass afterDoingThisCommandList:aCommandString producesThisLogs: extectedLogs

	| marsRoverPositionLog |
	marsRoverPositionLog := observantClass listenTo:marsRoverInTheCenterHeadingNorth .
	marsRoverInTheCenterHeadingNorth process: aCommandString.
	
	self assert: marsRoverPositionLog show equals: extectedLogs! !

!MarsRoverSubscribersTest methodsFor: 'assertions' stamp: 'lp 6/4/2023 17:38:10'!
assertManyObserversForTheSameMassRoverProducesTheCorrectLogs

	|marsRoverPositionWindow marsRoverPositionLog |
	marsRoverPositionWindow := MarsRoverPositionWindow listenTo: marsRoverInTheCenterHeadingNorth .
	marsRoverPositionLog :=MarsRoverPositionLog listenTo:marsRoverInTheCenterHeadingNorth .
	marsRoverInTheCenterHeadingNorth process: 'f'.
	
	self assert: marsRoverPositionWindow show equals:1@2.
	self assert: marsRoverPositionLog show equals:(OrderedCollection with:1@2)! !


!MarsRoverSubscribersTest methodsFor: 'position Observers' stamp: 'lp 6/5/2023 10:07:39'!
test01InitializeLogForPositionWithOneChangeInMarsRover
	
	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverPositionLog afterDoingThisCommandList: 'f'  producesThisLogs: (OrderedCollection with:1@2)! !

!MarsRoverSubscribersTest methodsFor: 'position Observers' stamp: 'lp 6/5/2023 10:07:59'!
test02InitializeWindowForPositionWithOneChangeInMarsRover

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverPositionWindow afterDoingThisCommandList: 'f' producesThisLogs: 1@2.! !

!MarsRoverSubscribersTest methodsFor: 'position Observers' stamp: 'lp 6/5/2023 10:08:26'!
test03havingWindowAndLogForPositionInTheSameMarsRover

	self assertManyObserversForTheSameMassRoverProducesTheCorrectLogs.! !

!MarsRoverSubscribersTest methodsFor: 'position Observers' stamp: 'lp 6/4/2023 17:39:00'!
test04PositionLoggerShowAllPosiblesMovements

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverPositionLog afterDoingThisCommandList:'fblfb'  producesThisLogs: (OrderedCollection with:1@2 with:1@1 with:0@1 with: 1@1)! !

!MarsRoverSubscribersTest methodsFor: 'position Observers' stamp: 'lp 6/5/2023 15:10:30'!
test05PositionLoggerNotShowAnithingWhenHasAHeadingChange

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverPositionLog afterDoingThisCommandList:'l'  producesThisLogs: (OrderedCollection new)! !

!MarsRoverSubscribersTest methodsFor: 'position Observers' stamp: 'lp 6/5/2023 15:10:38'!
test06PositionWindowShowLastMovementDoneInMarsRover

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverPositionWindow afterDoingThisCommandList:'fblfb'  producesThisLogs: (1@1 )! !

!MarsRoverSubscribersTest methodsFor: 'position Observers' stamp: 'lp 6/5/2023 15:10:43'!
test07PositionWindowShowNothingWhenTheFirstChangeIsAHeadingChange

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverPositionWindow afterDoingThisCommandList:'l'  producesThisLogs: ''! !


!MarsRoverSubscribersTest methodsFor: 'position and heading' stamp: 'lp 6/5/2023 15:12:23'!
test16InitializeLogForPositionAndHeadingWithOneChangeInThePositionOfTheMarsRover



	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingAndPositionLog afterDoingThisCommandList: 'f' producesThisLogs: (OrderedCollection with:1@2).
	! !

!MarsRoverSubscribersTest methodsFor: 'position and heading' stamp: 'lp 6/5/2023 15:12:19'!
test17LogForPositionAndHeadingUpdatesForManyPositionChangesOfTheMarsRover

	
	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingAndPositionLog afterDoingThisCommandList: 'ff' producesThisLogs: (OrderedCollection with:1@2 with:1@3).
	
	
	! !

!MarsRoverSubscribersTest methodsFor: 'position and heading' stamp: 'lp 6/5/2023 15:12:14'!
test18LogForPositionAndHeadingUpdatesForHeadingChangesInTheMarsRover

	
	
	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingAndPositionLog afterDoingThisCommandList: 'ffl' producesThisLogs: (OrderedCollection with:1@2 with:1@3 with:'West').
	
	! !

!MarsRoverSubscribersTest methodsFor: 'position and heading' stamp: 'lp 6/5/2023 15:12:08'!
test19WindowForPositionAndHeadingUpdatesOnyThePositionWhenTheFirstChangeIsToThePosition

	self assertIfAfterAMassRoverExecutesTheCommands: 'f' aMarsRoverHeadingAndPositionWindowProducesTheHeadingLog:'' andThePositionLog: 1@2.


	! !

!MarsRoverSubscribersTest methodsFor: 'position and heading' stamp: 'lp 6/5/2023 15:12:03'!
test20WindowForPositionAndHeadingUpdatesOnlyTheHeadingIfFirstCommandIsAHeadingCommand

		self assertIfAfterAMassRoverExecutesTheCommands: 'l' aMarsRoverHeadingAndPositionWindowProducesTheHeadingLog:'Apuntando al Oeste' andThePositionLog: ''.



	! !

!MarsRoverSubscribersTest methodsFor: 'position and heading' stamp: 'lp 6/5/2023 15:11:57'!
test21WindowForPositionAndHeadingUpdatesWhenAreManyChangesOfPositionAndHeadingInTheMarsRover

	
	self assertIfAfterAMassRoverExecutesTheCommands: 'fr' aMarsRoverHeadingAndPositionWindowProducesTheHeadingLog: 'Apuntando al Este' andThePositionLog: 1@2


	! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'lp 6/5/2023 10:43:34'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	self addListener:( MarsRoverObserver for: self).! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'lp 6/5/2023 12:06:30'!
rotateLeft
	
	head rotateLeft.
	observer notify: head for:#head! !

!MarsRover methodsFor: 'heading' stamp: 'lp 6/5/2023 12:06:35'!
rotateRight
	
	head rotateRight.
	observer notify: head for:#head! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'lp 6/5/2023 12:03:58'!
moveBackward
	
	head moveBackward.
	observer notify: position for: #position! !

!MarsRover methodsFor: 'moving' stamp: 'lp 6/5/2023 12:04:07'!
moveEast
	
	position := position + (1@0).
	! !

!MarsRover methodsFor: 'moving' stamp: 'lp 6/5/2023 12:03:54'!
moveForward
	
	head moveForward.
	observer notify: position for: #position! !

!MarsRover methodsFor: 'moving' stamp: 'lp 6/5/2023 12:04:11'!
moveNorth
	
	position := position + (0@1).
	! !

!MarsRover methodsFor: 'moving' stamp: 'lp 6/5/2023 12:04:16'!
moveSouth
	
	position := position + (0@-1).
	! !

!MarsRover methodsFor: 'moving' stamp: 'lp 6/5/2023 12:04:23'!
moveWest
	
	position := position + (-1@0).
	! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'observer' stamp: 'lp 6/3/2023 11:50:51'!
addListener: aMarsRoverObserver 
	observer := aMarsRoverObserver ! !

!MarsRover methodsFor: 'observer' stamp: 'lp 6/4/2023 15:10:50'!
observer
	^observer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverHeadingAndPositionWindow category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeadingAndPositionWindow
	instanceVariableNames: 'marsRoverObserver marsRoverPositionWindow marsRoverHeadingWindow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingAndPositionWindow methodsFor: 'initialize' stamp: 'lp 6/4/2023 18:17:34'!
initializeWith: aMarsRover
	marsRoverObserver := aMarsRover observer .
	marsRoverPositionWindow := MarsRoverPositionWindow listenTo: aMarsRover .
	marsRoverHeadingWindow := MarsRoverHeadingWindow listenTo: aMarsRover.! !


!MarsRoverHeadingAndPositionWindow methodsFor: 'show' stamp: 'lp 6/4/2023 17:18:38'!
showHeading
	^ marsRoverHeadingWindow show .! !

!MarsRoverHeadingAndPositionWindow methodsFor: 'show' stamp: 'lp 6/4/2023 17:18:42'!
showPosition
^ marsRoverPositionWindow show! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingAndPositionWindow class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingAndPositionWindow class
	instanceVariableNames: ''!

!MarsRoverHeadingAndPositionWindow class methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 12:16:18'!
listenTo: aMarsRoverObserver 
	^self new initializeWith: aMarsRoverObserver ! !


!classDefinition: #MarsRoverHeadingTranslator category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeadingTranslator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingTranslator methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:16:19'!
AsSpanish
	self subclassResponsibility ! !

!MarsRoverHeadingTranslator methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 12:44:42'!
headingToString
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingTranslator class' category: 'MarsRover-WithHeading'!
MarsRoverHeadingTranslator class
	instanceVariableNames: ''!

!MarsRoverHeadingTranslator class methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 12:48:07'!
for: aHeading
	(aHeading isHeading: MarsRoverHeadingEast) ifTrue:[ ^ HeadingEastTranslator new.]
		ifFalse:[ (aHeading isHeading: MarsRoverHeadingWest) ifTrue:[ ^HeadingWestTranslator new]
			ifFalse:[(aHeading isHeading: MarsRoverHeadingSouth ) ifTrue:[^HeadingSouthTranslator new]
				ifFalse:[(aHeading isHeading: MarsRoverHeadingNorth ) ifTrue:[^HeadingNorthTranslator new]]]].! !


!classDefinition: #HeadingEastTranslator category: 'MarsRover-WithHeading'!
MarsRoverHeadingTranslator subclass: #HeadingEastTranslator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingEastTranslator methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:16:19'!
AsSpanish
	^'Este'! !

!HeadingEastTranslator methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 12:43:45'!
headingToString
	^'East'! !


!classDefinition: #HeadingNorthTranslator category: 'MarsRover-WithHeading'!
MarsRoverHeadingTranslator subclass: #HeadingNorthTranslator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingNorthTranslator methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:16:19'!
AsSpanish
	^'Norte'! !

!HeadingNorthTranslator methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 12:44:10'!
headingToString
	^'North'! !


!classDefinition: #HeadingSouthTranslator category: 'MarsRover-WithHeading'!
MarsRoverHeadingTranslator subclass: #HeadingSouthTranslator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingSouthTranslator methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:16:19'!
AsSpanish
	^'Sur'! !

!HeadingSouthTranslator methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 12:44:16'!
headingToString
	^'South'! !


!classDefinition: #HeadingWestTranslator category: 'MarsRover-WithHeading'!
MarsRoverHeadingTranslator subclass: #HeadingWestTranslator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HeadingWestTranslator methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:16:19'!
AsSpanish
	^'Oeste'! !

!HeadingWestTranslator methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 12:44:21'!
headingToString
	^'West'! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: 'observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'observetion' stamp: 'lp 6/5/2023 13:48:12'!
notify: aNewValueForAVariable for: aVaraibleType
	observers  at:  aVaraibleType  ifPresent: [:aCollectionOfObservers|
			aCollectionOfObservers  do:[:anObserver|
					anObserver updateObservers: aNewValueForAVariable .
					]
		]! !

!MarsRoverObserver methodsFor: 'observetion' stamp: 'lp 6/5/2023 10:39:27'!
subscribeObservator: aMarsRoverObservator for: varaibleToObserv 
	observers  at:   varaibleToObserv asString 
		ifPresent:[:value | 
			 value add: aMarsRoverObservator 
			]
		  ifAbsent: [
			observers  at: varaibleToObserv asString put: (  OrderedCollection with: aMarsRoverObservator ) 
			
			].


! !


!MarsRoverObserver methodsFor: 'initialization' stamp: 'lp 6/4/2023 15:46:37'!
initializeFor: aMarsRover 
	 aMarsRover addListener: self.
	observers := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObserver class' category: 'MarsRover-WithHeading'!
MarsRoverObserver class
	instanceVariableNames: ''!

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'lp 6/3/2023 11:48:47'!
for: aMarsRover 
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverSubscribers category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverSubscribers
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverSubscribers methodsFor: 'update' stamp: 'lp 6/5/2023 13:48:11'!
updateObservers: aPosition 
self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverSubscribers class' category: 'MarsRover-WithHeading'!
MarsRoverSubscribers class
	instanceVariableNames: ''!

!MarsRoverSubscribers class methodsFor: 'instance creation' stamp: 'lp 6/3/2023 11:58:18'!
listenTo: aMarsRoverObserver 
	^self new initializeWith: aMarsRoverObserver ! !


!classDefinition: #MarsRoverSubscriberWindow category: 'MarsRover-WithHeading'!
MarsRoverSubscribers subclass: #MarsRoverSubscriberWindow
	instanceVariableNames: 'marsRoverWindow marsRoverObserver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverSubscriberWindow methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 14:06:31'!
initializeWith: aMarsRover 
	marsRoverObserver := aMarsRover observer.
	marsRoverWindow := ''.
	 self subcribeToVariables: self variablesToSubscribe .! !

!MarsRoverSubscriberWindow methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:55:41'!
show
		^ marsRoverWindow ! !

!MarsRoverSubscriberWindow methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 14:06:31'!
subcribeToVariables: aVariableCollection

	 aVariableCollection do:[:aVariableToSubscribe |
		marsRoverObserver subscribeObservator: self  for: aVariableToSubscribe 
		]! !

!MarsRoverSubscriberWindow methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:56:49'!
updateObservers: aMarsRoverState

	 marsRoverWindow := (self valueToLog: aMarsRoverState )! !

!MarsRoverSubscriberWindow methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:55:57'!
variablesToSubscribe
	self subclassResponsibility ! !


!classDefinition: #MarsRoverHeadingWindow category: 'MarsRover-WithHeading'!
MarsRoverSubscriberWindow subclass: #MarsRoverHeadingWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWindow methodsFor: 'update' stamp: 'lp 6/5/2023 13:59:56'!
valueToLog: aHeandingTraslated

	^'Apuntando al ', (MarsRoverHeadingTranslator for: aHeandingTraslated )AsSpanish 
		! !

!MarsRoverHeadingWindow methodsFor: 'update' stamp: 'lp 6/5/2023 14:05:35'!
variablesToSubscribe
	^ OrderedCollection with:#head! !


!classDefinition: #MarsRoverPositionWindow category: 'MarsRover-WithHeading'!
MarsRoverSubscriberWindow subclass: #MarsRoverPositionWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionWindow methodsFor: 'update' stamp: 'lp 6/5/2023 14:00:06'!
valueToLog: aPosition 
	^ aPosition .! !

!MarsRoverPositionWindow methodsFor: 'update' stamp: 'lp 6/5/2023 14:05:46'!
variablesToSubscribe
	^OrderedCollection with:#position! !


!classDefinition: #MarsRoverSubscribersLog category: 'MarsRover-WithHeading'!
MarsRoverSubscribers subclass: #MarsRoverSubscribersLog
	instanceVariableNames: 'marsRoverObserver marsRoverLogs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverSubscribersLog methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:52:06'!
initializeWith: aMarsRover 
	marsRoverObserver := aMarsRover observer.
	marsRoverLogs := OrderedCollection new.
	 self subcribeToVariables: self variablesToSubscribe .! !

!MarsRoverSubscribersLog methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:26:14'!
show
		^ marsRoverLogs ! !

!MarsRoverSubscribersLog methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:51:45'!
subcribeToVariables: aVariableCollection

	 aVariableCollection do:[:aVariableToSubscribe |
		marsRoverObserver subscribeObservator: self  for: aVariableToSubscribe 
		]! !

!MarsRoverSubscribersLog methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:48:11'!
updateObservers: aMarsRoverState

	 marsRoverLogs add: (self valueToLog: aMarsRoverState )! !

!MarsRoverSubscribersLog methodsFor: 'as yet unclassified' stamp: 'lp 6/5/2023 13:52:06'!
variablesToSubscribe
	self subclassResponsibility ! !


!classDefinition: #MarsRoverHeadingAndPositionLog category: 'MarsRover-WithHeading'!
MarsRoverSubscribersLog subclass: #MarsRoverHeadingAndPositionLog
	instanceVariableNames: 'marsRoverObserver1 marsRoverLog1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!MarsRoverHeadingAndPositionLog methodsFor: 'initialize private' stamp: 'lp 6/5/2023 13:52:06'!
variablesToSubscribe

	^OrderedCollection with:#head with: #position.
	! !



!MarsRoverHeadingAndPositionLog methodsFor: 'update' stamp: 'lp 6/5/2023 13:49:37'!
valueToLog: aValue 
(aValue isKindOf: MarsRoverHeading ) ifTrue:[ ^ (MarsRoverHeadingTranslator for: aValue ) headingToString ]
	
					ifFalse:[^aValue ]! !


!classDefinition: #MarsRoverHeadingLog category: 'MarsRover-WithHeading'!
MarsRoverSubscribersLog subclass: #MarsRoverHeadingLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLog methodsFor: 'initialize' stamp: 'lp 6/5/2023 13:52:06'!
variablesToSubscribe

	^ OrderedCollection with:#head! !


!MarsRoverHeadingLog methodsFor: 'update' stamp: 'lp 6/5/2023 13:35:27'!
valueToLog: aHeandingTraslated

	^(MarsRoverHeadingTranslator for: aHeandingTraslated )headingToString ! !



!classDefinition: #MarsRoverPositionLog category: 'MarsRover-WithHeading'!
MarsRoverSubscribersLog subclass: #MarsRoverPositionLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionLog methodsFor: 'initialization' stamp: 'lp 6/5/2023 13:52:06'!
variablesToSubscribe

	^OrderedCollection  with: #position.! !


!MarsRoverPositionLog methodsFor: 'update' stamp: 'lp 6/5/2023 13:35:27'!
valueToLog: aPosition

	 ^ aPosition! !

