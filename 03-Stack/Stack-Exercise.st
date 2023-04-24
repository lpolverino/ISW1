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
	instanceVariableNames: 'stack finder stackEmpty stackError stackErrorCopy stackWithOneElement stackWithManyElement stackWithOneElementCopy stackWithManyElementCopy emptyColection stringsWithabcdef'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'LP 4/23/2023 21:40:58'!
setUp
	
	finder:= SentenceFinderByPrefix  new.
	self setUpStacks.
	self setUpColections.
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'LP 4/23/2023 21:43:08'!
setUpColections
	
	emptyColection := OrderedCollection new.

	stringsWithabcdef := (OrderedCollection new) add:'abcdef'.
	! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'LP 4/23/2023 21:54:02'!
setUpStackError
	
	|aStack|
	
	aStack := OOStack new.
	aStack push: 'Hola'.
	aStack push: 'JOrge'.
	aStack push: 25.
	^aStack 
	

	! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'LP 4/23/2023 21:18:54'!
setUpStackWithManyElement

	|aStack|
	aStack:=OOStack new.
	aStack push: 'abc'.
	aStack push: 'abcd'.
	aStack push: 'abcde'.
	aStack push: 'abcdd'.
	aStack push: 'abcdef'.
	^aStack
	! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'LP 4/23/2023 21:54:12'!
setUpStackWithOneElement

	|aStack|
	
	aStack := OOStack new.
	aStack push:'Jorge'.
	^aStack
	! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'LP 4/23/2023 21:25:49'!
setUpStacks
	
	stack := OOStack new.
	stackEmpty := OOStack new.
	
	self setUpStacksError.
	self setUpStacksWithManyElement.
	self setUpStacksWithOneElement.
	
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'LP 4/23/2023 21:17:35'!
setUpStacksError
	
	stackError :=self  setUpStackError.
	stackErrorCopy :=self  setUpStackError.
	

	! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'LP 4/23/2023 21:19:51'!
setUpStacksWithManyElement

	stackWithManyElement := self setUpStackWithManyElement .
	stackWithManyElementCopy := self setUpStackWithManyElement.
	! !

!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'LP 4/23/2023 21:22:52'!
setUpStacksWithOneElement

	stackWithOneElementCopy := self setUpStackWithOneElement.
	stackWithOneElement := self setUpStackWithOneElement.

	! !


!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JB 4/24/2023 08:50:23'!
test01filteringAnEmptyStackReturnsAnEmptyCollectionAndKeepsTheEmptyStack
	
	self assertIfFilteringWith:'algo' to:stack returns: emptyColection andCheckIfTheStackIsTheSameWIth:stackEmpty .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JB 4/24/2023 08:52:32'!
test02filteringAStackWithANonStringElementRaisesAnErrorAndKeepsTheStackIntact
	
	self
		should: [ finder filter:stackError byPrefix:'' ]
			raise: Error - MessageNotUnderstood 
			withExceptionDo: [ :anError |
				self assert: anError messageText = SentenceFinderByPrefix elementIsNotString.
				self assert: (self thisStack:stackError isEqualTo:stackErrorCopy).]
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JB 4/24/2023 08:54:11'!
test03filteringAOneElementStackWithAValidPrefixReturnsAValidCollectionAndKeepsTheStackIntact

	|colectionWithOneString|.
	
	colectionWithOneString := OrderedCollection new.
	colectionWithOneString add:'Jorge'.
	
	self assertIfFilteringWith:'Jor' to:stackWithOneElement returns: colectionWithOneString andCheckIfTheStackIsTheSameWIth:stackWithOneElementCopy .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JB 4/24/2023 08:55:46'!
test04filteringAMultiElementStackWithACommonPrefixReturnsAValidCollectionAndKeepsTheStackIntact

	|abcColection|
	
	abcColection := OrderedCollection new.
	abcColection add:'abcdef'.
	abcColection add:'abcdd'.
	abcColection add:'abcde'.
	abcColection add:'abcd'.
	abcColection add:'abc'.
	
	self assertIfFilteringWith: 'abc' to:stackWithManyElement returns: abcColection andCheckIfTheStackIsTheSameWIth:stackWithManyElementCopy .
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LP 4/23/2023 23:07:44'!
test05UnStackFiltradoConUnPrefijoDeUnaSolaSentenciaDevuelveUnaColeccionCorrecta

	|abcColection|
	
	abcColection := OrderedCollection new.
	abcColection add:'abcdef'.
	
	self assertIfFilteringWith:'abcdef' to:stackWithManyElement returns: abcColection andCheckIfTheStackIsTheSameWIth:stackWithManyElementCopy .
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JB 4/24/2023 08:57:24'!
test06filteringAMultiElementStackWithANonExistingPrefixReturnsAnEmptyCollectionAndKeepsTheStackIntact
"¿es necesario?"
	
	"self assert:(finder filter:stackWithManyElement byPrefix:'jorge' ) equals:emptyColection .
	self assert: (self thisStack:stackWithManyElement isEqualTo:stackWithManyElementCopy).	"
	
	self assertIfFilteringWith:'jorge' to:stackWithManyElement returns: emptyColection andCheckIfTheStackIsTheSameWIth:stackWithManyElementCopy .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'JB 4/24/2023 09:06:32'!
test07filteringAMultiElementStackWithACommonPrefixOfAPairOfElementsReturnsAValidCollectionAndKeepsTheStackIntact

	|abcColection|
	
	abcColection := OrderedCollection new.
	abcColection add:'abcdef'.
	abcColection add:'abcde'.

	self assertIfFilteringWith:'abcde'  to:stackWithManyElement returns: abcColection andCheckIfTheStackIsTheSameWIth:stackWithManyElementCopy .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'LP 4/23/2023 23:09:15'!
test08UnStackDondeTodosLosElementosCompartenUnPrefijoMenosUnoDevuelveUnaColeccionCorrecta

	|abcColection|
	
	abcColection := OrderedCollection new.
	abcColection add:'abcdef'.
	abcColection add:'abcdd'.
	abcColection add:'abcde'.
	abcColection add:'abcd'.

	self assertIfFilteringWith:'abcd'  to:stackWithManyElement returns: abcColection andCheckIfTheStackIsTheSameWIth:stackWithManyElementCopy .
	! !


!SentenceFinderByPrefixTest methodsFor: 'auxiliar' stamp: 'LP 4/23/2023 23:04:04'!
assertIfFilteringWith:aFilter to:aStack returns:aColection andCheckIfTheStackIsTheSameWIth:aStackCopy  

	self assert:(finder filter:aStack byPrefix:aFilter) equals:aColection.
	self assert: (self thisStack:aStack isEqualTo:aStackCopy).	! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliar' stamp: 'LP 4/23/2023 20:23:57'!
thisStack: aStack1 hasTheSameElementsAs:aStack2
	|element1 element2 result|
	
	(aStack1 isEmpty) ifTrue:[^true]. 
	element1 := aStack1 pop.
	element2 := aStack2 pop.
	result := (element1 = element2 ) and:(self thisStack:aStack1 hasTheSameElementsAs:aStack2).
	aStack1 push: element1.
	aStack2 push: element2.
	^result
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliar' stamp: 'JB 4/24/2023 09:11:10'!
thisStack: aStack1 hasTheSameSizeAs: aStack2

	^ aStack1 size = aStack2 size! !

!SentenceFinderByPrefixTest methodsFor: 'auxiliar' stamp: 'JB 4/24/2023 09:13:36'!
thisStack:aStack isEqualTo:aStackToCompare
	((self thisStack: aStack hasTheSameSizeAs: aStackToCompare )) ifTrue: [
		^ self thisStack:aStack hasTheSameElementsAs:aStackToCompare
		].
	^false
	! !


!classDefinition: #OONode category: 'Stack-Exercise'!
Object subclass: #OONode
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OONode methodsFor: 'accesing' stamp: 'LP 4/23/2023 23:36:46'!
getNextNodeFailIfAbsent: stack
	^ self subclassResponsibility ! !

!OONode methodsFor: 'accesing' stamp: 'LP 4/23/2023 23:38:36'!
getValueFailIfAbsent: stack
 	^ self subclassResponsibility ! !

!OONode methodsFor: 'accesing' stamp: 'LP 4/23/2023 23:26:00'!
isEmpty
	^self subclassResponsibility ! !


!classDefinition: #OOAbsentNode category: 'Stack-Exercise'!
OONode subclass: #OOAbsentNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOAbsentNode methodsFor: 'accesing' stamp: 'LP 4/23/2023 23:42:40'!
getNextNodeFailIfAbsent: stack
	^ stack accesingEmptyElement! !

!OOAbsentNode methodsFor: 'accesing' stamp: 'LP 4/23/2023 23:42:40'!
getValueFailIfAbsent: stack
	^ stack accesingEmptyElement ! !

!OOAbsentNode methodsFor: 'accesing' stamp: 'LP 4/23/2023 23:25:47'!
isEmpty
	^ true! !


!classDefinition: #OOLinkNode category: 'Stack-Exercise'!
OONode subclass: #OOLinkNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOLinkNode methodsFor: 'accesing' stamp: 'LP 4/23/2023 23:36:46'!
getNextNodeFailIfAbsent: stack
	^next! !

!OOLinkNode methodsFor: 'accesing' stamp: 'LP 4/23/2023 23:38:36'!
getValueFailIfAbsent: stack
 	^value! !

!OOLinkNode methodsFor: 'accesing' stamp: 'LP 4/23/2023 23:21:58'!
isEmpty
	^false! !


!OOLinkNode methodsFor: 'initialization' stamp: 'LP 4/23/2023 23:21:47'!
initializeWith:aElement pointingTo:aNode
	next:=aNode.
	value := aElement! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOLinkNode class' category: 'Stack-Exercise'!
OOLinkNode class
	instanceVariableNames: ''!

!OOLinkNode class methodsFor: 'as yet unclassified' stamp: 'LP 4/23/2023 23:20:53'!
with:anElement next:nextReference
	^self new initializeWith:anElement  pointingTo:nextReference ! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'lenght top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accesing' stamp: 'LP 4/21/2023 16:28:57'!
isEmpty
	
	^top isEmpty! !

!OOStack methodsFor: 'accesing' stamp: 'LP 4/21/2023 15:22:37'!
size
	^lenght! !

!OOStack methodsFor: 'accesing' stamp: 'LP 4/23/2023 23:38:36'!
top
	
	^top getValueFailIfAbsent: self! !


!OOStack methodsFor: 'private' stamp: 'LP 4/23/2023 23:36:46'!
changeTop
	|nextTop|
	
	nextTop := top getNextNodeFailIfAbsent: self.
	top := nextTop.
	lenght := lenght-1.
! !


!OOStack methodsFor: 'adding' stamp: 'LP 4/23/2023 23:23:47'!
push: anElement
	|newTop|
	
	lenght :=lenght +1. 
	newTop := OOLinkNode with:anElement next:top.
	top:=newTop.! !


!OOStack methodsFor: 'removing' stamp: 'JB 4/24/2023 08:02:19'!
pop
	|topValue|
	topValue := self top.
	self changeTop.
	^topValue
	
	
	! !


!OOStack methodsFor: 'initialization' stamp: 'LP 4/23/2023 23:42:40'!
accesingEmptyElement
	^self error: self class stackEmptyErrorDescription ! !

!OOStack methodsFor: 'initialization' stamp: 'JB 4/24/2023 07:53:20'!
initialize

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

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'LP 4/23/2023 19:32:25'!
add:aElement to:aColection ifItHasAsAPrefix:aPrefix
	
	(aElement beginsWith: aPrefix) ifTrue:[aColection add: aElement]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'LP 4/23/2023 19:32:18'!
checkIfAStackOfStrings:aStack
	|element|
	
	(aStack isEmpty) ifFalse:[ 
		element:= aStack pop.
		
		(element isKindOf: String)
		 ifFalse:[
			^self makeExceptionAndPush: element into: aStack].
		
		[self checkIfAStackOfStrings: aStack]
			on: Error
			do:[^ self makeExceptionAndPush: element into: aStack].	
			aStack push: element.
		].! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'LP 4/23/2023 19:56:21'!
collectAllStringsIn: aStackOfStrings withPrefix:aPrefix into: aColectionToFill
	|element|
	
	(aStackOfStrings isEmpty) ifFalse:[ 
		
		element:= aStackOfStrings pop.
		self add:element  to:aColectionToFill  ifItHasAsAPrefix: aPrefix.
		self collectAllStringsIn: aStackOfStrings withPrefix:aPrefix into: aColectionToFill.
		aStackOfStrings push: element.
		]! !

!SentenceFinderByPrefix methodsFor: 'private' stamp: 'LP 4/23/2023 19:29:02'!
makeExceptionAndPush: anElement into: aStack
	aStack push: anElement.
	^Error signal! !


!SentenceFinderByPrefix methodsFor: 'filtering' stamp: 'LP 4/23/2023 20:31:26'!
filter:aStack byPrefix:aPrefix

	|stringsWithSamePrefix|
	stringsWithSamePrefix := OrderedCollection new.
	
	[self checkIfAStackOfStrings: aStack]
		on: Error
		do:[^self error: self class elementIsNotString ].
		
	self collectAllStringsIn: aStack withPrefix:aPrefix into: stringsWithSamePrefix.
	^stringsWithSamePrefix
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'LP 4/23/2023 16:30:25'!
elementIsNotString

	^'An elment in the stack is not a String!!!!!!!!!!!!!!!!!!!!!!!!!!!! :('! !
