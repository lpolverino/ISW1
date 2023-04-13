!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:51:15'!
assertIf: customerBook HaveThisNumberOfActiveCustomers: numberOfActiveCustomers ThisNumberOfSuspendedCustomers: numberOfsuspendedCustomers ThisNumberOfTotalCustomers: numberOfTotalCustomers andShouldHavePaulMcCartney: aBoolean  	self assert: numberOfActiveCustomers equals: customerBook numberOfActiveCustomers.	self assert: numberOfsuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: numberOfTotalCustomers  equals: customerBook numberOfCustomers.
	self assert:( (customerBook includesCustomerNamed: 'Paul McCartney' ) xor:  aBoolean not). 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:51:46'!
assertIfOnlyCustomerIsJohnLennon: customerBook
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: 'John Lennon')! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LP 4/13/2023 00:18:49'!
assertIfOnlyCustomerIsJohnLennonOf: customerBook whenFailingToSuspendACustomerNamed: customerName

	^ [ customerBook suspendCustomerNamed: customerName.
	self fail ]
		on: CantSuspend 
		do: [ :anError | self assertIfOnlyCustomerIsJohnLennon: customerBook ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LP 4/13/2023 00:15:13'!
assertIfOnlyCustomerIsJohnLennonOf:customerBook whenTryingToRemoveAndNotFounding:anName
	[ customerBook removeCustomerNamed: anName. self fail ] 
	on: NotFound		
	do: [ :anError |			self assertIfOnlyCustomerIsJohnLennon: customerBook ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:52:54'!
createACostumerBookAndSuspend:customerName	| customerBook aCostumer|	aCostumer := customerName.	customerBook  := self  createCustomerBookWith:  aCostumer .
	customerBook suspendCustomerNamed: aCostumer.
	^customerBook
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:52:40'!
createCustomerBookWith:customerName	| customerBook |	customerBook := CustomerBook new.	customerBook addCustomerNamed: customerName.	^customerBook


! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 10:27:01'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook   |
	customerBook := CustomerBook new.

	self thisColaboration:  [	customerBook addCustomerNamed: 'John Lennon'.]  shouldNotTakeMoreThan: 50*millisecond		
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:35:14'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	| customerBook   paulMcCartney |	paulMcCartney := 'Paul McCartney'.	customerBook  := self  createCustomerBookWith:  paulMcCartney .	
	self thisColaboration: 	[customerBook removeCustomerNamed: paulMcCartney. ] shouldNotTakeMoreThan: 100*millisecond 

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LP 4/12/2023 23:51:55'!
test03CanNotAddACustomerWithEmptyName 	| customerBook |	customerBook := CustomerBook new.
	self whenFails:[customerBook addCustomerNamed:'']  messageErrorShouldBe:CustomerBook customerCanNotBeEmptyErrorMessage andAssert: customerBook isEmpty! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LP 4/13/2023 00:15:13'!
test04CanNotRemoveAnInvalidCustomer	| customerBook |	customerBook := self  createCustomerBookWith:  'John Lennon' .
	self assertIfOnlyCustomerIsJohnLennonOf:customerBook whenTryingToRemoveAndNotFounding: 'Paul McCartney'  
	
	 

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:42:59'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook	| customerBook |	customerBook := self createACostumerBookAndSuspend: 'Paul McCartney'.	self assertIf: customerBook HaveThisNumberOfActiveCustomers: 0  ThisNumberOfSuspendedCustomers: 1  ThisNumberOfTotalCustomers:1  andShouldHavePaulMcCartney: true.

 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 13:43:32'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook	| customerBook paulMcCartney|	paulMcCartney := 'Paul McCartney'.	customerBook  := self  createACostumerBookAndSuspend: paulMcCartney .	customerBook removeCustomerNamed: paulMcCartney.
	self assertIf: customerBook HaveThisNumberOfActiveCustomers: 0  ThisNumberOfSuspendedCustomers: 0  ThisNumberOfTotalCustomers:0   andShouldHavePaulMcCartney: false 

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LP 4/13/2023 00:18:49'!
test07CanNotSuspendAnInvalidCustomer	| customerBook |
	customerBook := self  createCustomerBookWith: 'John Lennon'. 	self assertIfOnlyCustomerIsJohnLennonOf: customerBook whenFailingToSuspendACustomerNamed:  'George Harrison' 
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LP 4/13/2023 00:18:49'!
test08CanNotSuspendAnAlreadySuspendedCustomer	| customerBook johnLennon |
	johnLennon := 'John Lennon'.
	customerBook := self  createACostumerBookAndSuspend: johnLennon .
	self assertIfOnlyCustomerIsJohnLennonOf: customerBook whenFailingToSuspendACustomerNamed: johnLennon
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jb 4/12/2023 10:27:01'!
thisColaboration: aBlock shouldNotTakeMoreThan: time

	|  millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (time)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LP 4/12/2023 23:48:45'!
whenFails:aClosure messageErrorShouldBe:errorMessage andAssert:aCondition	[ aClosure value.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = errorMessage.
			self assert: aCondition. ]
		
! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'jb 4/12/2023 13:56:16'!
numberOfCustomers	^self numberOfSuspendedCustomers + self numberOfActiveCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'jb 4/12/2023 13:59:58'!
removeCustomerNamed: aName 
	active remove: aName ifAbsent: [suspended  remove: aName ifAbsent:[	^ NotFound signal.] ]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'jb 4/12/2023 14:00:45'!
suspendCustomerNamed: aName 	(active includes: aName) ifFalse: [^CantSuspend signal].
	active remove: aName.	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
