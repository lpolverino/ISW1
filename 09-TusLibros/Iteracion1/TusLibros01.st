!classDefinition: #ShoppingCartTest category: 'TusLibros01'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros01'!

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'JB 6/6/2023 13:51:25'!
test01CreatingAShopingCartShouldBeEmpty
	self  assert:  self createEmptyCart isEmpty! !

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'JB 6/6/2023 13:58:51'!
test02AShoppingCartWithABookShouldNotBeEmpty

	self  deny:   self createACartWithASingleBookNamedTwilight   isEmpty! !

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'JB 6/6/2023 13:51:25'!
test03anEmptyShoppingCartShouldListAnEmptyList

	self  assert:  OrderedCollection  new equals: self createEmptyCart list! !

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'JB 6/6/2023 13:58:51'!
test04AShoppingCartWithABookShouldListACollectionWithABook

	self  assert:   (OrderedCollection with: #Twilight) equals: self createACartWithASingleBookNamedTwilight  list! !

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'JB 6/6/2023 13:58:25'!
test05AShoppingCartWithManyBooksShouldListACollectionWithManyABook

	self  assert:   (OrderedCollection with: #Twilight with: #FullMoon  ) equals:  self createACartWithTwilightAndFullMoon list! !

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'JB 6/6/2023 13:54:39'!
test06addingABookWithAnNegativeQuantityShouldRaisAnError

	self  should:[
		self createEmptyCart  add: #Twilight  quantity: -1.	
		]  raise:  Error
			withExceptionDo: [ :anError|
				self assert:  anError messageText  equals: ShoppingCart negativeQuantityErrorMessage
				
				]
	 	! !

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'JB 6/6/2023 14:00:19'!
test07addingAQuantityOfABookIntoAShoppingCartShouldAppearThatQuantityOfTimesInTheList

	self assert:  (OrderedCollection  with: #Twilight with: #Twilight ) equals: self createACartWithTwilightTwice  list ! !


!ShoppingCartTest methodsFor: 'shooping cart instance creation' stamp: 'JB 6/6/2023 13:58:51'!
createACartWithASingleBookNamedTwilight

	^ self createEmptyCart  add: #Twilight  quantity: 1! !

!ShoppingCartTest methodsFor: 'shooping cart instance creation' stamp: 'JB 6/6/2023 13:58:51'!
createACartWithTwilightAndFullMoon

	^ self createACartWithASingleBookNamedTwilight add: #FullMoon  quantity: 1! !

!ShoppingCartTest methodsFor: 'shooping cart instance creation' stamp: 'JB 6/6/2023 13:59:59'!
createACartWithTwilightTwice

	^ self createEmptyCart add:  #Twilight  quantity: 	 	2! !

!ShoppingCartTest methodsFor: 'shooping cart instance creation' stamp: 'JB 6/6/2023 13:51:25'!
createEmptyCart

	^ ShoppingCart new! !


!classDefinition: #ShoppingCart category: 'TusLibros01'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'book books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros01'!

!ShoppingCart methodsFor: 'adding' stamp: 'JB 6/6/2023 14:09:07'!
add: aBook quantity: aQuantity 	
	self assertCanAdd: aQuantity. 
	self addBookToTheShoppingCart:  aBook  thisAmountOfTimes: aQuantity 

! !


!ShoppingCart methodsFor: 'initializing' stamp: 'JB 6/6/2023 13:15:54'!
initialize
	books :=  OrderedCollection new. ! !


!ShoppingCart methodsFor: 'testing' stamp: 'JB 6/6/2023 13:16:27'!
isEmpty

	^books isEmpty ! !

!ShoppingCart methodsFor: 'testing' stamp: 'JB 6/6/2023 13:15:30'!
list
	^books! !


!ShoppingCart methodsFor: 'adding private' stamp: 'JB 6/6/2023 14:08:45'!
addBookToTheShoppingCart: aBook   thisAmountOfTimes: aQuantity 
	1 to: aQuantity do: [:aNumberOfIteration |
			books add: aBook 		
		]  


! !

!ShoppingCart methodsFor: 'adding private' stamp: 'JB 6/6/2023 14:06:13'!
assertCanAdd: aQuantity

	aQuantity  = 0 ifTrue:  [
		self error: self class  zeroQuantityErrorMessage
		]. 
	aQuantity  < 0 ifTrue:  [
		self error: self class  negativeQuantityErrorMessage  
		]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'TusLibros01'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'error message' stamp: 'JB 6/6/2023 13:35:43'!
negativeQuantityErrorMessage
	^'No se puede poner cantidades negativas' ! !

!ShoppingCart class methodsFor: 'error message' stamp: 'JB 6/6/2023 13:46:56'!
zeroQuantityErrorMessage
	^'No se puede poner cantidades nulas' ! !
