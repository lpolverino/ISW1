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
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONode methodsFor: 'accesing' stamp: 'LP 4/21/2023 16:27:20'!
getNextNodeFailIfAbsent
	^next! !

!OONode methodsFor: 'accesing' stamp: 'LP 4/21/2023 16:26:37'!
getValueFailIfAbsent
 	^value! !

!OONode methodsFor: 'accesing' stamp: 'LP 4/21/2023 16:25:13'!
isEmpty
	^false! !


!OONode methodsFor: 'initialization' stamp: 'LP 4/21/2023 16:06:25'!
initializeWith:aElement pointingTo:aNode
	next:=aNode.
	value := aElement! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OONode class' category: 'Stack-Exercise'!
OONode class
	instanceVariableNames: ''!

!OONode class methodsFor: 'as yet unclassified' stamp: 'LP 4/21/2023 16:07:21'!
with:anElement next:nextReference
	^self new initializeWith:anElement  pointingTo:nextReference ! !


!classDefinition: #OOAbsentNode category: 'Stack-Exercise'!
OONode subclass: #OOAbsentNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOAbsentNode methodsFor: 'accesing' stamp: 'LP 4/21/2023 16:27:21'!
getNextNodeFailIfAbsent
	^ self error: OOStack stackEmptyErrorDescription ! !

!OOAbsentNode methodsFor: 'accesing' stamp: 'LP 4/21/2023 16:26:37'!
getValueFailIfAbsent
	^ self error: OOStack stackEmptyErrorDescription ! !

!OOAbsentNode methodsFor: 'accesing' stamp: 'LP 4/21/2023 16:25:13'!
isEmpty
	^true! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'lenght values top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accesing' stamp: 'LP 4/21/2023 16:28:57'!
isEmpty
	
	^top isEmpty! !

!OOStack methodsFor: 'accesing' stamp: 'LP 4/21/2023 15:22:37'!
size
	^lenght! !

!OOStack methodsFor: 'accesing' stamp: 'LP 4/21/2023 16:29:10'!
top
	
	^top getValueFailIfAbsent! !


!OOStack methodsFor: 'private' stamp: 'LP 4/21/2023 16:34:26'!
changeTop
	|nextTop|
	
	nextTop := top getNextNodeFailIfAbsent.
	top := nextTop.
	lenght := lenght-1.
! !


!OOStack methodsFor: 'adding' stamp: 'LP 4/21/2023 16:29:05'!
push: anElement
	|newTop|
	
	lenght :=lenght +1. 
	newTop := OONode with:anElement next:top.
	top:=newTop.! !


!OOStack methodsFor: 'removing' stamp: 'LP 4/21/2023 16:34:19'!
pop
	|obsoliteTop|
	
	obsoliteTop := self top.
	self changeTop.
	^obsoliteTop
	"
	|nextTop topElement|
	lenght := lenght-1.
	nextTop := top getNextNodeFailIfAbsent.
	topElement:=self top.
	top := nextTop.
	^topElement
	
	"
	
	
	! !


!OOStack methodsFor: 'initialization' stamp: 'LP 4/21/2023 15:34:25'!
initialize
	values:=OrderedCollection new.
	lenght := 0.
	top := OOAbsentNode new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
