!classDefinition: #MarsRoverObservantsTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverObservantsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/3/2023 12:23:40'!
test06LogHeadingInitialize

	|marsRover marsRoverPositionLog marsRoverObserver |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	marsRoverObserver := MarsRoverObserver for: marsRover.
	marsRoverPositionLog :=MarsRoverHeadingLog listenTo:marsRoverObserver.
	marsRover process: 'l'.
	
	self assert: marsRoverPositionLog show equals:(OrderedCollection with:'West')! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/3/2023 12:25:30'!
test07LogHeadingUpdateWhenReceivedRCommand

	|marsRover marsRoverPositionLog marsRoverObserver |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	marsRoverObserver := MarsRoverObserver for: marsRover.
	marsRoverPositionLog :=MarsRoverHeadingLog listenTo:marsRoverObserver.
	marsRover process: 'r'.
	
	self assert: marsRoverPositionLog show equals:(OrderedCollection with:'East')! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/3/2023 12:27:02'!
test08LogHeadingUpdateWhenReceivedManyRCommand

	|marsRover marsRoverPositionLog marsRoverObserver |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
		marsRoverObserver := MarsRoverObserver for: marsRover.
	marsRoverPositionLog :=MarsRoverHeadingLog listenTo:marsRoverObserver.
	marsRover process: 'rr'.
	
	self assert: marsRoverPositionLog show equals:(OrderedCollection with: 'East' with:'South')! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/3/2023 12:27:18'!
test09LogHeadingUpdateWhenReceivedManyLCommand

	|marsRover marsRoverPositionLog marsRoverObserver |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
		marsRoverObserver := MarsRoverObserver for: marsRover.
	marsRoverPositionLog :=MarsRoverHeadingLog listenTo:marsRoverObserver.
	marsRover process: 'llll'.
	
	self assert: marsRoverPositionLog show equals:(OrderedCollection with: 'West' with:'South' with:'East' with:'North')! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/3/2023 12:27:44'!
test10WindowHeadingInitialize

	|marsRover marsRoverPositionLog marsRoverObserver |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	marsRoverObserver := MarsRoverObserver for: marsRover.
	marsRoverPositionLog :=MarsRoverHeadingWindow listenTo:marsRoverObserver.
	marsRover process: 'l'.
	
	self assert: marsRoverPositionLog show equals:'West'! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/3/2023 12:27:57'!
test11WindowHeadingAllDirections

	|marsRover marsRoverPositionLog marsRoverObserver |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	marsRoverObserver := MarsRoverObserver for: marsRover.
	marsRoverPositionLog :=MarsRoverHeadingWindow listenTo:marsRoverObserver.
	marsRover process: 'rrrr'.
	
	self assert: marsRoverPositionLog show equals:'North'! !

!MarsRoverObservantsTest methodsFor: 'heading Observers' stamp: 'lp 6/3/2023 12:28:08'!
test12WindowHeadingWhenNotTurnCommand

	|marsRover marsRoverPositionLog marsRoverObserver |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	marsRoverObserver := MarsRoverObserver for: marsRover.
	marsRoverPositionLog :=MarsRoverHeadingWindow listenTo:marsRoverObserver.
	marsRover process: 'rrrrf'.
	
	self assert: marsRoverPositionLog show equals:'Nada'! !


!MarsRoverObservantsTest methodsFor: 'position Observers' stamp: 'lp 6/3/2023 11:57:16'!
test01InitializeLogWithPosition

	|marsRover marsRoverPositionLog marsRoverObserver |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	marsRoverObserver := MarsRoverObserver for: marsRover.
	marsRoverPositionLog :=MarsRoverPositionLog listenTo:marsRoverObserver .
	marsRover process: 'f'.
	
	self assert: marsRoverPositionLog show equals:(OrderedCollection with:1@2)! !

!MarsRoverObservantsTest methodsFor: 'position Observers' stamp: 'lp 6/3/2023 12:18:37'!
test02InitializeWindowWithPosition

	|marsRover marsRoverPositionWindow marsRoverObserver |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	marsRoverObserver := MarsRoverObserver for: marsRover.
	marsRoverPositionWindow := MarsRoverPositionWindow listenTo: marsRoverObserver .
	marsRover process: 'f'.
	
	self assert: marsRoverPositionWindow show equals:1@2.! !

!MarsRoverObservantsTest methodsFor: 'position Observers' stamp: 'jb 6/3/2023 19:48:43'!
test03havingWindowAndLogPosition

	|marsRover marsRoverPositionWindow marsRoverPositionLog marsRoverObserver|
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	marsRoverObserver := MarsRoverObserver for: marsRover.
	marsRoverPositionWindow := MarsRoverPositionWindow listenTo: marsRoverObserver .
	marsRoverPositionLog :=MarsRoverPositionLog listenTo:marsRoverObserver .
	marsRover process: 'f'.
	
	self assert: marsRoverPositionWindow show equals:1@2.
	self assert: marsRoverPositionLog show equals:(OrderedCollection with:1@2).! !

!MarsRoverObservantsTest methodsFor: 'position Observers' stamp: 'lp 6/3/2023 12:20:56'!
test04PositionLoggerShowAllPosiblesMovements

	|marsRover marsRoverPositionLog marsRoverObserver |
	marsRover := MarsRover at: 1@1 heading: MarsRoverHeadingNorth .
	marsRoverObserver := MarsRoverObserver for: marsRover.
	marsRoverPositionLog :=MarsRoverPositionLog listenTo:marsRoverObserver .
	marsRover process: 'fblfb'.

	self assert: marsRoverPositionLog show equals:(OrderedCollection with:1@2 with:1@1 with:0@1 with: 1@1).! !


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


!MarsRover methodsFor: 'initialization' stamp: 'lp 6/3/2023 11:42:06'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	observer:= MarsRoverObserver new.
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

!MarsRover methodsFor: 'heading' stamp: 'lp 6/3/2023 11:53:55'!
rotateLeft
	
	head rotateLeft.
	self notifyObserver: head.! !

!MarsRover methodsFor: 'heading' stamp: 'lp 6/3/2023 11:53:55'!
rotateRight
	
	head rotateRight.
	self notifyObserver: head.! !


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

!MarsRover methodsFor: 'moving' stamp: 'lp 6/3/2023 11:53:55'!
moveEast
	
	position := position + (1@0).
	self notifyObserver: position! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'jb 6/3/2023 20:30:44'!
moveNorth
	
	position := position + (0@1).
	self notifyObserver: position! !

!MarsRover methodsFor: 'moving' stamp: 'lp 6/3/2023 11:53:55'!
moveSouth
	
	position := position + (0@-1).
	self notifyObserver: position! !

!MarsRover methodsFor: 'moving' stamp: 'lp 6/3/2023 11:53:55'!
moveWest
	
	position := position + (-1@0).
	self notifyObserver: position! !


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

!MarsRover methodsFor: 'observer' stamp: 'lp 6/3/2023 11:53:55'!
notifyObserver: aTypeObserved

	^ observer notify: aTypeObserved ! !

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


!classDefinition: #MarsRoverHeadingLog category: 'MarsRover-WithHeading'!
MarsRoverObservants subclass: #MarsRoverHeadingLog
	instanceVariableNames: 'marsRover marsRoverHeadings marsRoverObserver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLog methodsFor: 'initialize' stamp: 'lp 6/3/2023 12:25:55'!
initializeWith: aMarsRoverObserver 
	marsRoverObserver := aMarsRoverObserver.
	marsRoverObserver subscribeObservator: self for:'head'.
	marsRoverHeadings := OrderedCollection new.
! !


!MarsRoverHeadingLog methodsFor: 'update' stamp: 'lp 6/3/2023 10:16:08'!
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
MarsRoverObservants subclass: #MarsRoverHeadingWindow
	instanceVariableNames: 'marsRover marsRoverHeading marsRoverObserver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWindow methodsFor: 'initialize' stamp: 'lp 6/3/2023 12:26:01'!
initializeWith: aMarsRoverObserver 
	marsRoverObserver := aMarsRoverObserver.
	marsRoverObserver subscribeObservator: self for:'head'.
	marsRoverHeading := OrderedCollection new.
	! !


!MarsRoverHeadingWindow methodsFor: 'show' stamp: 'lp 6/3/2023 11:19:30'!
show
	^marsRoverHeading last ! !

!MarsRoverHeadingWindow methodsFor: 'show' stamp: 'lp 6/3/2023 11:24:23'!
updateObserver: aHeanding 

	(aHeanding isKindOf: MarsRoverHeadingEast) ifTrue:[ marsRoverHeading add: 'East']
		ifFalse:[ (aHeanding isKindOf: MarsRoverHeadingWest) ifTrue:[ marsRoverHeading add:'West']
			ifFalse:[(aHeanding isKindOf: MarsRoverHeadingSouth ) ifTrue:[marsRoverHeading add:'South']
				ifFalse:[(aHeanding isKindOf: MarsRoverHeadingNorth ) ifTrue:[marsRoverHeading add:'North']
					ifFalse:[marsRoverHeading add:'Nada']]]]
		! !


!classDefinition: #MarsRoverPositionLog category: 'MarsRover-WithHeading'!
MarsRoverObservants subclass: #MarsRoverPositionLog
	instanceVariableNames: 'marsRoverObserver marsRoverPositionLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionLog methodsFor: 'initialization' stamp: 'lp 6/3/2023 11:59:18'!
initializeWith: aMarsRoverObserver 
	marsRoverObserver := aMarsRoverObserver.
	marsRoverObserver subscribeObservator: self for:'position'.
	marsRoverPositionLog := OrderedCollection new.! !


!MarsRoverPositionLog methodsFor: 'update' stamp: 'lp 6/3/2023 11:31:20'!
updateObserver: aPosition 
	(aPosition isKindOf: MarsRoverHeading ) ifFalse:[
	marsRoverPositionLog add: aPosition.]! !


!MarsRoverPositionLog methodsFor: 'log' stamp: 'lp 6/3/2023 09:14:06'!
show
	^ marsRoverPositionLog ! !


!classDefinition: #MarsRoverPositionWindow category: 'MarsRover-WithHeading'!
MarsRoverObservants subclass: #MarsRoverPositionWindow
	instanceVariableNames: 'marsRover marsRoverPosition marsRoverObserver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionWindow methodsFor: 'initialization' stamp: 'lp 6/3/2023 12:19:54'!
initializeWith: aMarsRoverObserver 
	marsRoverPosition :=  OrderedCollection new.
	marsRoverObserver := aMarsRoverObserver.
	marsRoverObserver subscribeObservator: self for:'position'.

	! !


!MarsRoverPositionWindow methodsFor: 'windowing' stamp: 'lp 6/3/2023 08:59:58'!
show
	^ marsRoverPosition first! !


!MarsRoverPositionWindow methodsFor: 'update' stamp: 'lp 6/3/2023 11:32:45'!
updateObserver: aPosition 
	(aPosition isKindOf: MarsRoverHeading ) ifFalse:[
	marsRoverPosition := OrderedCollection with: aPosition .]! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: 'observers marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'as yet unclassified' stamp: 'lp 6/3/2023 11:42:39'!
notifyObservers: aTypeObserved

	^ observers do:[:anObserver|
		anObserver updateObserver:aTypeObserved.
		]! !


!MarsRoverObserver methodsFor: 'initialization' stamp: 'jb 6/3/2023 21:45:09'!
initializeFor: aMarsRover 
	 aMarsRover addListener: self.
	observers := OrderedCollection new.! !

!MarsRoverObserver methodsFor: 'initialization' stamp: 'jb 6/3/2023 21:45:31'!
subscribeObservator: aMarsRoverPositionLog for: varaibleToObserv 
	observers  add: aMarsRoverPositionLog ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverObserver class' category: 'MarsRover-WithHeading'!
MarsRoverObserver class
	instanceVariableNames: ''!

!MarsRoverObserver class methodsFor: 'instance creation' stamp: 'lp 6/3/2023 11:48:47'!
for: aMarsRover 
	^self new initializeFor: aMarsRover ! !
