!classDefinition: #MarsRoverObservantsTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverObservantsTest
	instanceVariableNames: 'marsRoverInTheCenterHeadingNorth'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:51:02'!
assertIfAfterAMassRoverExecutesTheCommands:aCommandList aMarsRoverHeadingAndPositionWindowProducesTheHeadingLog: aExpectedHeadingWindow

	|marsRoverHeandingAndPositionLog response |
	
	marsRoverHeandingAndPositionLog :=MarsRoverHeadingAndPositionWindow listenTo:marsRoverInTheCenterHeadingNorth .
	marsRoverInTheCenterHeadingNorth process: aCommandList.
	response := 1@2.
	
	self assert: marsRoverHeandingAndPositionLog showPosition equals:response.
	self assert: marsRoverHeandingAndPositionLog showHeading equals:aExpectedHeadingWindow.


	! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:39:52'!
test06LogHeadingInitialize

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingLog afterDoingThisCommandList:'l'  producesThisLogs: (OrderedCollection with:'West').! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:40:25'!
test07LogHeadingUpdateWhenReceivedRCommand

	self assertIfThanInstanceOfMarsRoverObservantClass:MarsRoverHeadingLog  afterDoingThisCommandList: 'r' producesThisLogs: (OrderedCollection with:'East').! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:40:54'!
test08LogHeadingUpdateWhenReceivedManyRCommand

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingLog afterDoingThisCommandList: 'rr' producesThisLogs: (OrderedCollection with: 'East' with:'South').! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:41:37'!
test09LogHeadingUpdateWhenReceivedManyLCommand

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingLog afterDoingThisCommandList:  'llll' producesThisLogs: (OrderedCollection with: 'West' with:'South' with:'East' with:'North').! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:42:10'!
test10WindowHeadingInitialize

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingWindow afterDoingThisCommandList: 'l' producesThisLogs: 'West'.! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:42:32'!
test11WindowHeadingAllDirections

	
	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingWindow afterDoingThisCommandList: 'rrrr' producesThisLogs: 'North'.! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:43:40'!
test12LogForPositionAndHeading



	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingAndPositionLog afterDoingThisCommandList: 'f' producesThisLogs: (OrderedCollection with:1@2).
	! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:44:06'!
test13LogForPositionAndHeadingMultiplesPositions

	
	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingAndPositionLog afterDoingThisCommandList: 'ff' producesThisLogs: (OrderedCollection with:1@2 with:1@3).
	
	
	! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:44:37'!
test14LogForPositionAndHeadingChangeHeading

	
	
	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverHeadingAndPositionLog afterDoingThisCommandList: 'ffl' producesThisLogs: (OrderedCollection with:1@2 with:1@3 with:'West').
	
	! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:51:03'!
test15WindowForPositionAndHeading

	self assertIfAfterAMassRoverExecutesTheCommands: 'f' aMarsRoverHeadingAndPositionWindowProducesTheHeadingLog:''.


	! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/4/2023 17:51:03'!
test16WindowForPositionAndHeadingChangeHeading

	
	self assertIfAfterAMassRoverExecutesTheCommands: 'fr' aMarsRoverHeadingAndPositionWindowProducesTheHeadingLog: 'East'


	! !


!MarsRoverObservantsTest methodsFor: 'position Observers' stamp: 'lp 6/4/2023 17:33:49'!
assertIfThanInstanceOfMarsRoverObservantClass: observantClass afterDoingThisCommandList:aCommandString producesThisLogs: extectedLogs

	| marsRoverPositionLog |
	marsRoverPositionLog := observantClass listenTo:marsRoverInTheCenterHeadingNorth .
	marsRoverInTheCenterHeadingNorth process: aCommandString.
	
	self assert: marsRoverPositionLog show equals: extectedLogs! !

!MarsRoverObservantsTest methodsFor: 'position Observers' stamp: 'lp 6/4/2023 17:38:10'!
assertManyObserversForTheSameMassRoverProducesTheCorrectLogs

	|marsRoverPositionWindow marsRoverPositionLog |
	marsRoverPositionWindow := MarsRoverPositionWindow listenTo: marsRoverInTheCenterHeadingNorth .
	marsRoverPositionLog :=MarsRoverPositionLog listenTo:marsRoverInTheCenterHeadingNorth .
	marsRoverInTheCenterHeadingNorth process: 'f'.
	
	self assert: marsRoverPositionWindow show equals:1@2.
	self assert: marsRoverPositionLog show equals:(OrderedCollection with:1@2)! !

!MarsRoverObservantsTest methodsFor: 'position Observers' stamp: 'lp 6/4/2023 17:27:34'!
setUp

	marsRoverInTheCenterHeadingNorth := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	! !

!MarsRoverObservantsTest methodsFor: 'position Observers' stamp: 'lp 6/4/2023 17:33:49'!
test01InitializeLogWithPosition
	
	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverPositionLog afterDoingThisCommandList: 'f'  producesThisLogs: (OrderedCollection with:1@2)! !

!MarsRoverObservantsTest methodsFor: 'position Observers' stamp: 'lp 6/4/2023 17:34:38'!
test02InitializeWindowWithPosition

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverPositionWindow afterDoingThisCommandList: 'f' producesThisLogs: 1@2.! !

!MarsRoverObservantsTest methodsFor: 'position Observers' stamp: 'lp 6/4/2023 17:38:10'!
test03havingWindowAndLogPosition

	self assertManyObserversForTheSameMassRoverProducesTheCorrectLogs.! !

!MarsRoverObservantsTest methodsFor: 'position Observers' stamp: 'lp 6/4/2023 17:39:00'!
test04PositionLoggerShowAllPosiblesMovements

	self assertIfThanInstanceOfMarsRoverObservantClass: MarsRoverPositionLog afterDoingThisCommandList:'fblfb'  producesThisLogs: (OrderedCollection with:1@2 with:1@1 with:0@1 with: 1@1)! !


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
	instanceVariableNames: 'position head observers observer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'lp 6/4/2023 14:56:36'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	self addListener:( MarsRoverObserver for: self).
	"observers:= OrderedCollection new."! !


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

!MarsRover methodsFor: 'heading' stamp: 'lp 6/4/2023 19:15:29'!
rotateLeft
	
	head rotateLeft.
	observer notify: head for:'head'! !

!MarsRover methodsFor: 'heading' stamp: 'lp 6/4/2023 19:15:22'!
rotateRight
	
	head rotateRight.
	observer notify: head for:'head'! !


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


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'lp 6/4/2023 19:15:09'!
moveEast
	
	position := position + (1@0).
	observer notify: position for:'position'! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'lp 6/4/2023 19:15:05'!
moveNorth
	
	position := position + (0@1).
	observer notify: position for:'position'! !

!MarsRover methodsFor: 'moving' stamp: 'lp 6/4/2023 19:15:01'!
moveSouth
	
	position := position + (0@-1).
	observer notify: position for:'position'! !

!MarsRover methodsFor: 'moving' stamp: 'lp 6/4/2023 19:14:49'!
moveWest
	
	position := position + (-1@0).
	observer notify: position for:'position'.! !


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

!MarsRover methodsFor: 'observer' stamp: 'lp 6/4/2023 14:58:28'!
notifyObserver: aTypeObserved

	^ observer  notifyObservers: aTypeObserved .! !

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


!classDefinition: #MarsRoverObservants category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObservants
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObservants methodsFor: 'as yet unclassified' stamp: 'lp 6/3/2023 09:04:23'!
updateObserver: aPosition 
self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObservants class' category: 'MarsRover-WithHeading'!
MarsRoverObservants class
	instanceVariableNames: ''!

!MarsRoverObservants class methodsFor: 'instance creation' stamp: 'lp 6/3/2023 11:58:18'!
listenTo: aMarsRoverObserver 
	^self new initializeWith: aMarsRoverObserver ! !


!classDefinition: #MarsRoverHeadingAndPositionLog category: 'MarsRover-WithHeading'!
MarsRoverObservants subclass: #MarsRoverHeadingAndPositionLog
	instanceVariableNames: 'marsRoverObserver marsRoverHeadings marsRoverPosition marsRoverPositionObserver marsRoverLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingAndPositionLog methodsFor: 'as yet unclassified' stamp: 'lp 6/4/2023 16:57:36'!
initializeWith: aMarsRover
	marsRoverObserver := aMarsRover observer .
	self subcribeToObservator.
	marsRoverLog := OrderedCollection new.! !

!MarsRoverHeadingAndPositionLog methodsFor: 'as yet unclassified' stamp: 'lp 6/4/2023 16:51:27'!
show
	^ marsRoverLog ! !

!MarsRoverHeadingAndPositionLog methodsFor: 'as yet unclassified' stamp: 'lp 6/4/2023 16:26:58'!
subcribeToObservator

	marsRoverObserver subscribeObservator: self for:'head'.
	marsRoverObserver subscribeObservator: self for:'position'! !


!MarsRoverHeadingAndPositionLog methodsFor: 'position' stamp: 'lp 6/4/2023 19:22:44'!
updateObserver: aValue 
	(aValue isKindOf: MarsRoverHeadingEast) ifTrue:[ marsRoverLog add: 'East']
		ifFalse:[ (aValue isKindOf: MarsRoverHeadingWest) ifTrue:[ marsRoverLog add:'West']
			ifFalse:[(aValue isKindOf: MarsRoverHeadingSouth ) ifTrue:[marsRoverLog add:'South']
				ifFalse:[(aValue isKindOf: MarsRoverHeadingNorth ) ifTrue:[marsRoverLog add:'North']
					ifFalse:[marsRoverLog add: aValue ]]]]! !



!classDefinition: #MarsRoverHeadingAndPositionWindow category: 'MarsRover-WithHeading'!
MarsRoverObservants subclass: #MarsRoverHeadingAndPositionWindow
	instanceVariableNames: 'marsRoverObserver marsRoverPositionWindow marsRoverHeadingWindow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingAndPositionWindow methodsFor: 'as yet unclassified' stamp: 'lp 6/4/2023 18:17:34'!
initializeWith: aMarsRover
	marsRoverObserver := aMarsRover observer .
	marsRoverPositionWindow := MarsRoverPositionWindow listenTo: aMarsRover .
	marsRoverHeadingWindow := MarsRoverHeadingWindow listenTo: aMarsRover.! !

!MarsRoverHeadingAndPositionWindow methodsFor: 'as yet unclassified' stamp: 'lp 6/4/2023 17:11:01'!
subcribeToObservator

	marsRoverObserver subscribeObservator: self for:'head'.
	marsRoverObserver subscribeObservator: self for:'position'! !


!MarsRoverHeadingAndPositionWindow methodsFor: 'position' stamp: 'lp 6/4/2023 17:18:42'!
showPosition
^ marsRoverPositionWindow show! !


!MarsRoverHeadingAndPositionWindow methodsFor: 'heading' stamp: 'lp 6/4/2023 17:18:38'!
showHeading
	^ marsRoverHeadingWindow show .! !


!classDefinition: #MarsRoverHeadingObservants category: 'MarsRover-WithHeading'!
MarsRoverObservants subclass: #MarsRoverHeadingObservants
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!classDefinition: #MarsRoverHeadingLog category: 'MarsRover-WithHeading'!
MarsRoverHeadingObservants subclass: #MarsRoverHeadingLog
	instanceVariableNames: 'marsRover marsRoverHeadings marsRoverObserver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLog methodsFor: 'initialize' stamp: 'lp 6/4/2023 15:13:19'!
initializeWith: aMarsRover 
	marsRoverObserver := aMarsRover observer .
	marsRoverObserver subscribeObservator: self for:'head'.
	marsRoverHeadings := OrderedCollection new.
! !


!MarsRoverHeadingLog methodsFor: 'update' stamp: 'lp 6/4/2023 19:20:57'!
updateObserver: aHeanding 
	"marsRoverHeadings add: aHeanding."
	(aHeanding isKindOf: MarsRoverHeadingEast) ifTrue:[ marsRoverHeadings add: 'East']
		ifFalse:[ (aHeanding isKindOf: MarsRoverHeadingWest) ifTrue:[ marsRoverHeadings add:'West']
			ifFalse:[(aHeanding isKindOf: MarsRoverHeadingSouth ) ifTrue:[marsRoverHeadings add:'South']
				ifFalse:[(aHeanding isKindOf: MarsRoverHeadingNorth ) ifTrue:[marsRoverHeadings add:'North']]]]
		! !


!MarsRoverHeadingLog methodsFor: 'show' stamp: 'lp 6/3/2023 09:33:36'!
show
	^marsRoverHeadings .! !


!classDefinition: #MarsRoverHeadingWindow category: 'MarsRover-WithHeading'!
MarsRoverHeadingObservants subclass: #MarsRoverHeadingWindow
	instanceVariableNames: 'marsRover marsRoverHeading marsRoverObserver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWindow methodsFor: 'initialize' stamp: 'lp 6/4/2023 17:22:21'!
initializeWith: aMarsRover 
	marsRoverObserver := aMarsRover observer .
	marsRoverObserver subscribeObservator: self for:'head'.
	marsRoverHeading := ''.
	! !


!MarsRoverHeadingWindow methodsFor: 'show' stamp: 'lp 6/4/2023 17:22:26'!
show
	^marsRoverHeading ! !

!MarsRoverHeadingWindow methodsFor: 'show' stamp: 'lp 6/4/2023 19:20:45'!
updateObserver: aHeanding 

	(aHeanding isKindOf: MarsRoverHeadingEast) ifTrue:[ marsRoverHeading := 'East']
		ifFalse:[ (aHeanding isKindOf: MarsRoverHeadingWest) ifTrue:[ marsRoverHeading :='West']
			ifFalse:[(aHeanding isKindOf: MarsRoverHeadingSouth ) ifTrue:[marsRoverHeading :='South']
				ifFalse:[(aHeanding isKindOf: MarsRoverHeadingNorth ) ifTrue:[marsRoverHeading :='North']
					ifFalse:[marsRoverHeading add:'Nada']]]]
		! !


!classDefinition: #MarsRoverPositionObservants category: 'MarsRover-WithHeading'!
MarsRoverObservants subclass: #MarsRoverPositionObservants
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!classDefinition: #MarsRoverPositionLog category: 'MarsRover-WithHeading'!
MarsRoverPositionObservants subclass: #MarsRoverPositionLog
	instanceVariableNames: 'marsRoverObserver marsRoverPositionLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionLog methodsFor: 'initialization' stamp: 'lp 6/4/2023 15:10:35'!
initializeWith: aMarsRover 
	marsRoverObserver := aMarsRover observer.
	marsRoverObserver subscribeObservator: self for:'position'.
	marsRoverPositionLog := OrderedCollection new.! !


!MarsRoverPositionLog methodsFor: 'update' stamp: 'lp 6/4/2023 19:20:02'!
updateObserver: aPosition 
	marsRoverPositionLog add: aPosition.! !


!MarsRoverPositionLog methodsFor: 'log' stamp: 'lp 6/3/2023 09:14:06'!
show
	^ marsRoverPositionLog ! !


!classDefinition: #MarsRoverPositionWindow category: 'MarsRover-WithHeading'!
MarsRoverPositionObservants subclass: #MarsRoverPositionWindow
	instanceVariableNames: 'marsRover marsRoverPosition marsRoverObserver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionWindow methodsFor: 'initialization' stamp: 'lp 6/4/2023 15:13:53'!
initializeWith: aMarsRover 
	marsRoverPosition :=  OrderedCollection new.
	marsRoverObserver := aMarsRover observer .
	marsRoverObserver subscribeObservator: self for:'position'.

	! !


!MarsRoverPositionWindow methodsFor: 'windowing' stamp: 'lp 6/3/2023 08:59:58'!
show
	^ marsRoverPosition first! !


!MarsRoverPositionWindow methodsFor: 'update' stamp: 'lp 6/4/2023 19:20:23'!
updateObserver: aPosition 
marsRoverPosition := OrderedCollection with: aPosition! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: 'observers marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!


!MarsRoverObserver methodsFor: 'initialization' stamp: 'lp 6/4/2023 15:46:37'!
initializeFor: aMarsRover 
	 aMarsRover addListener: self.
	observers := Dictionary new.! !

!MarsRoverObserver methodsFor: 'initialization' stamp: 'lp 6/4/2023 19:19:38'!
notify: aValue for: aVaraibleType
	observers  at:  aVaraibleType  ifPresent: [:aCollectionOfObservers|
			aCollectionOfObservers  do:[:anObserver|
					anObserver updateObserver: aValue .
					]
		]! !

!MarsRoverObserver methodsFor: 'initialization' stamp: 'jb 6/3/2023 20:06:12'!
subscribeObservator: aMarsRoverPositionLog for: varaibleToObserv 
	observers  at:   varaibleToObserv asString 
		ifPresent:[:value | 
			 value add: aMarsRoverPositionLog 
			]
		  ifAbsent: [
			observers  at: varaibleToObserv asString put: (  OrderedCollection with: aMarsRoverPositionLog ) 
			
			].


! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObserver class' category: 'MarsRover-WithHeading'!
MarsRoverObserver class
	instanceVariableNames: ''!

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'lp 6/3/2023 11:48:47'!
for: aMarsRover 
	^self new initializeFor: aMarsRover ! !
