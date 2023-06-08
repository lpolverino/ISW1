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

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'lp} 6/7/2023 11:57:36'!
test03anEmptyShoppingCartShouldListAnEmptyList

	self  assert:  SortedCollection new equals: self createEmptyCart list! !

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'lp} 6/7/2023 15:47:03'!
test04AShoppingCartWithABookShouldListACollectionWithABook

	self  assert:   (SortedCollection with:( Association key:#Twilight value: 1)) equals: self createACartWithASingleBookNamedTwilight  list! !

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'lp} 6/7/2023 12:00:30'!
test05AShoppingCartWithManyBooksShouldListACollectionWithManyABook

	self  assert:
	    (SortedCollection with:( Association key:#Twilight value: 1) with:  (Association key:#Fullmoon value: 1) )
	equals:  self createACartWithTwilightAndFullMoon list! !

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'JB 6/6/2023 13:54:39'!
test06addingABookWithAnNegativeQuantityShouldRaisAnError

	self  should:[
		self createEmptyCart  add: #Twilight  quantity: -1.	
		]  raise:  Error
			withExceptionDo: [ :anError|
				self assert:  anError messageText  equals: ShoppingCart negativeQuantityErrorMessage
				
				]
	 	! !

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'lp} 6/7/2023 11:53:42'!
test07addingAQuantityOfABookIntoAShoppingCartShouldAppearThatQuantityOfTimesInTheList

		self assert:  (Bag  with: #Twilight with: #Twilight ) sortedElements equals: self createACartWithTwilightTwice  list ! !

!ShoppingCartTest methodsFor: 'shopping cart test' stamp: 'lp} 6/7/2023 12:13:07'!
test08CannotAddABookThatIsNotFromTheEditorial

		
	self  should:[
		self createEmptyCart  add: #LibroDeOtraEditorial  quantity: 1.	
		]  raise:  Error
			withExceptionDo: [ :anError|
				self assert:  anError messageText  equals: ShoppingCart cannotAddABookFromAnotherEditorial
				
				]! !


!ShoppingCartTest methodsFor: 'shooping cart instance creation' stamp: 'JB 6/6/2023 13:58:51'!
createACartWithASingleBookNamedTwilight

	^ self createEmptyCart  add: #Twilight  quantity: 1! !

!ShoppingCartTest methodsFor: 'shooping cart instance creation' stamp: 'lp} 6/7/2023 12:00:47'!
createACartWithTwilightAndFullMoon

	^ self createACartWithASingleBookNamedTwilight add: #Fullmoon  quantity: 1! !

!ShoppingCartTest methodsFor: 'shooping cart instance creation' stamp: 'JB 6/6/2023 13:59:59'!
createACartWithTwilightTwice

	^ self createEmptyCart add:  #Twilight  quantity: 	 	2! !

!ShoppingCartTest methodsFor: 'shooping cart instance creation' stamp: 'JB 6/6/2023 13:51:25'!
createEmptyCart

	^ ShoppingCart new! !


!classDefinition: #EdiorialBooks category: 'TusLibros01'!
Object subclass: #EdiorialBooks
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros01'!


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EdiorialBooks class' category: 'TusLibros01'!
EdiorialBooks class
	instanceVariableNames: 'books'!

!EdiorialBooks class methodsFor: 'as yet unclassified' stamp: 'lp} 6/7/2023 15:33:20'!
hasBook: aBook
	books ifNil:[books:=OrderedCollection with:#Twilight with: #Fullmoon].
	^books includes: aBook ! !


!classDefinition: #ShoppingCart category: 'TusLibros01'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'book books booksFromTheEditorial'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros01'!

!ShoppingCart methodsFor: 'adding' stamp: 'lp} 6/7/2023 12:14:54'!
add: aBook quantity: aQuantity 	
	self assertCanAdd:aBook withQuantity: aQuantity. 
	books add: aBook withOccurrences:aQuantity 

! !


!ShoppingCart methodsFor: 'initializing' stamp: 'lp} 6/7/2023 15:31:58'!
initialize
	books :=  Bag new.! !


!ShoppingCart methodsFor: 'testing' stamp: 'JB 6/6/2023 13:16:27'!
isEmpty

	^books isEmpty ! !

!ShoppingCart methodsFor: 'testing' stamp: 'lp} 6/7/2023 11:57:11'!
list
	^books sortedElements ! !


!ShoppingCart methodsFor: 'adding private' stamp: 'JB 6/6/2023 14:08:45'!
addBookToTheShoppingCart: aBook   thisAmountOfTimes: aQuantity 
	1 to: aQuantity do: [:aNumberOfIteration |
			books add: aBook 		
		]  


! !

!ShoppingCart methodsFor: 'adding private' stamp: 'lp} 6/7/2023 15:32:49'!
assertCanAdd: aBook 
	(EdiorialBooks hasBook: aBook) ifFalse:[self error: self class cannotAddABookFromAnotherEditorial ].! !

!ShoppingCart methodsFor: 'adding private' stamp: 'lp} 6/7/2023 12:16:20'!
assertCanAdd: aBook withQuantity: aQuantity 
	self assertCanAdd: aBook.
	self assertCanAddTheQuantity: aQuantity ! !

!ShoppingCart methodsFor: 'adding private' stamp: 'lp} 6/7/2023 12:16:11'!
assertCanAddTheQuantity: aQuantity

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

!ShoppingCart class methodsFor: 'error message' stamp: 'lp} 6/7/2023 12:14:06'!
cannotAddABookFromAnotherEditorial
	^'No podes comprarnos algo que no es nuestro'! !

!ShoppingCart class methodsFor: 'error message' stamp: 'JB 6/6/2023 13:35:43'!
negativeQuantityErrorMessage
	^'No se puede poner cantidades negativas' ! !

!ShoppingCart class methodsFor: 'error message' stamp: 'JB 6/6/2023 13:46:56'!
zeroQuantityErrorMessage
	^'No se puede poner cantidades nulas' ! !
