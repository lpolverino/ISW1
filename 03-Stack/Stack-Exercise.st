!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OONode category: 'Stack-Exercise'!
Object subclass: #OONode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OONodeEmpty category: 'Stack-Exercise'!
OONode subclass: #OONodeEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONodeEmpty methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 12:19:12'!
canPop:aStack 
	^aStack cantPopEmptyStack 
	
	! !

!OONodeEmpty methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 12:20:50'!
canTop:aStack 
	^aStack cantTopEmptyStack 
	
	! !


!classDefinition: #OONodeNotEmpty category: 'Stack-Exercise'!
OONode subclass: #OONodeNotEmpty
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONodeNotEmpty methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 12:09:10'!
canPop: aStack
	^aStack  popNotEmptyStack! !

!OONodeNotEmpty methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 12:17:56'!
canTop: aStack
	^aStack  topNotEmptyStack! !

!OONodeNotEmpty methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 12:09:30'!
next 
	^next ! !

!OONodeNotEmpty methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 12:09:43'!
value
	^value! !

!OONodeNotEmpty methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 12:10:42'!
with: anElement next: aNode
	value := anElement.
	next := aNode! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'collection top lenght'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:53:13'!
cantPopEmptyStack
	^self error: self class stackEmptyErrorDescription

! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:57:44'!
cantTopEmptyStack
	^self error: self class stackEmptyErrorDescription

! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 12:11:19'!
initialize
	collection := OrderedCollection  new.
	top := OONodeEmpty new. 
	lenght := 0! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:34:54'!
isEmpty 
	^lenght =0 ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:31:52'!
isEmptyCopy
	^(collection size =0)! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 12:13:24'!
pop 
	^top canPop:self! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:31:57'!
popCopy
	|element|
	(self isEmpty) ifTrue: [self error: self class stackEmptyErrorDescription ].
	element := collection at: (collection size). 
	collection remove: element. 
	^element  ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:55:55'!
popNotEmptyStack
		|element| 
		element := top value.
		 top :=  top next. 
		lenght := lenght  -1 . 
		^element.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 12:11:39'!
push: anElement
	
	|newNode |
	newNode := OONodeNotEmpty new. 
	newNode with:  anElement  next: top.
	top := newNode . 
	lenght := lenght +1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:32:03'!
pushCopy: anElement
	
	collection add: anElement	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:34:41'!
size 
	^lenght ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:32:09'!
sizeCopy
	^collection  size ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:56:57'!
top
	^top canTop: self! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:32:14'!
topCopy
	
	(self isEmpty) ifTrue: [self error: self class stackEmptyErrorDescription ].
	 ^collection at: (collection size). 
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:56:27'!
topNotEmptyStack

		^ top value.
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #EmptyNode category: 'Stack-Exercise'!
OOStack subclass: #EmptyNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:54:07'!
canPop: aStack
	^aStack  cantPopEmptyStack! !

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:57:31'!
canTop: aStack
	^aStack  cantTopEmptyStack! !

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:26:19'!
isEmpty 
	^true! !

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:26:45'!
pop 
	^self error: OOStack stackEmptyErrorDescription ! !

!EmptyNode methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:26:41'!
top 
	^self error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #Node category: 'Stack-Exercise'!
OOStack subclass: #Node
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #ElementNode category: 'Stack-Exercise'!
Node subclass: #ElementNode
	instanceVariableNames: 'element next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementNode methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:50:07'!
canPop
	^self error: OOStack  stackEmptyErrorDescription ! !

!ElementNode methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:53:58'!
canPop:aStack 
	^aStack popNotEmptyStack
	
	! !

!ElementNode methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:57:15'!
canTop:aStack 
	^aStack topNotEmptyStack
	
	! !

!ElementNode methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:59:23'!
next 
	^next ! !

!ElementNode methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:59:16'!
value
	^element ! !

!ElementNode methodsFor: 'as yet unclassified' stamp: 'JB 4/21/2023 11:29:23'!
with: anElement  next: aNode
	element  := anElement . 
	next := aNode
	! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
