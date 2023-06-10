!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'instanceFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'JB 6/10/2023 19:48:38'!
test01NewCartsAreCreatedEmpty

	self assert: instanceFactory  createEmptyCart  isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'JB 6/10/2023 19:53:09'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := instanceFactory  createEmptyCart .
	
	self 
		should: [ cart add: instanceFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JB 6/10/2023 19:53:24'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := instanceFactory  createEmptyCart .
	
	cart add: instanceFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'JB 6/10/2023 19:50:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := instanceFactory  createEmptyCart .
	
	self 
		should: [cart add: 0 of: instanceFactory  itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JB 6/10/2023 19:51:07'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := instanceFactory  createEmptyCart .
	
	self 
		should: [cart add: 2 of: instanceFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'JB 6/10/2023 19:53:34'!
test06CartRemembersAddedItems

	| cart |
	
	cart := instanceFactory  createEmptyCart .
	
	cart add: instanceFactory  itemSellByTheStore.
	self assert: (cart includes: instanceFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JB 6/10/2023 19:53:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := instanceFactory  createEmptyCart .
	
	self deny: (cart includes: instanceFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'JB 6/10/2023 19:54:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := instanceFactory  createEmptyCart .
	
	cart add: 2 of: instanceFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: instanceFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'set up' stamp: 'JB 6/10/2023 19:48:14'!
setUp
	instanceFactory  := InstanceFactory  new    ! !


!classDefinition: #CashierForSaleTest category: 'TusLibros'!
TestCase subclass: #CashierForSaleTest
	instanceVariableNames: 'instanceFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierForSaleTest methodsFor: 'cashier test' stamp: 'JB 6/10/2023 19:35:51'!
test01checkoutEmptyCartShouldRaiseAnError

	self checkoutForCashier: instanceFactory  cashierWithEmptyCart  
		withCreditCard: instanceFactory  validCreditCard 
		 shouldNotProceedWithTheSellAndRaiseAnErrorWithDescription: CashierForSale cannotCheckoutEmptyCart! !

!CashierForSaleTest methodsFor: 'cashier test' stamp: 'JB 6/10/2023 19:36:41'!
test02checkingOutCartWithAnElementShouldDoSomething
	self assertCheckingoutTheCashier: instanceFactory cashierWithACartWithABook 
		affectsTheSalesBooks: OrderedCollection  new 
			 anDebitsTheAmmount: 500002 ! !

!CashierForSaleTest methodsFor: 'cashier test' stamp: 'JB 6/10/2023 19:36:41'!
test03checkingOutManyBooksShouldReturnTheCorrectAmmount	
	self  assertCheckingoutTheCashier:  instanceFactory cashierWithACartWithTwoBooks 
		 affectsTheSalesBooks: OrderedCollection  new   
			anDebitsTheAmmount: 500003 ! !

!CashierForSaleTest methodsFor: 'cashier test' stamp: 'JB 6/10/2023 19:24:39'!
test04expiredCreditcardShouldNotProceedWithTheSell
		self checkoutForCashier:  
			instanceFactory cashierWithACartWithABook
		 withCreditCard:  
			instanceFactory  expiredCreditCard
		shouldNotProceedWithTheSellAndRaiseAnErrorWithDescription: 
			CashierForSale cannotProccesSellForExpiredCreditCard! !

!CashierForSaleTest methodsFor: 'cashier test' stamp: 'JB 6/10/2023 19:24:39'!
test05creditCardWithoutFundsShouldNotProceedWithTheSell 
		self checkoutForCashier:  
			instanceFactory cashierWithACartWithABook	
		 withCreditCard:  
			instanceFactory  creditCardWithoutFunds	
		shouldNotProceedWithTheSellAndRaiseAnErrorWithDescription: 
			MerchantProcessorSimulator creditCardWithoutFundsErrorMessage
	! !

!CashierForSaleTest methodsFor: 'cashier test' stamp: 'JB 6/10/2023 19:24:39'!
test06robedCreditCardShouldNotProceedWithTheSell 
		self checkoutForCashier:  
				instanceFactory cashierWithACartWithABook		 
			withCreditCard:  
				instanceFactory  creditCardRobbed
				shouldNotProceedWithTheSellAndRaiseAnErrorWithDescription: 
					MerchantProcessorSimulator cannotProcessSaleForRobedCreditCard
	! !


!CashierForSaleTest methodsFor: 'set up' stamp: 'JB 6/10/2023 15:37:51'!
setUp
	instanceFactory := InstanceFactory  new.
	! !


!CashierForSaleTest methodsFor: 'testing private' stamp: 'JB 6/10/2023 19:36:41'!
assertCheckingoutTheCashier: cashier affectsTheSalesBooks: bookOfSells anDebitsTheAmmount: ammount
	self assert:  ammount  equals:  (cashier  checkoutWhitCreditCard:  instanceFactory  validCreditCard registerOn: bookOfSells ). 
	self assert: (OrderedCollection  with: ammount ) equals: bookOfSells! !

!CashierForSaleTest methodsFor: 'testing private' stamp: 'JB 6/10/2023 19:24:39'!
checkoutForCashier: aCashier withCreditCard: aCreditCard shouldNotProceedWithTheSellAndRaiseAnErrorWithDescription: aBlock  
	|bookOfSells|
	bookOfSells := OrderedCollection  new. 
	self should: [
		aCashier   checkoutWhitCreditCard:  aCreditCard  registerOn: bookOfSells. 

		] 
	 raise: Error-MessageNotUnderstood  
	 
	  description: [:anError| 
		self assert:  anError messageText   equals:   aBlock .
		self assert:  		bookOfSells isEmpty 
		]! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'lp 6/8/2023 20:51:35'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'lp 6/8/2023 20:27:09'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'lp 6/8/2023 20:23:39'!
list 
^ items copy! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'category-name' stamp: 'lp 6/8/2023 20:52:11'!
priceFor: aBook 
	(catalog  includesKey:   aBook ) ifTrue: [
			^catalog 	at: aBook
		]. 
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CashierForSale category: 'TusLibros'!
Object subclass: #CashierForSale
	instanceVariableNames: 'cart date gregorianMonthOfYear creditCardDebitator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierForSale methodsFor: 'initializing' stamp: 'JB 6/10/2023 19:08:48'!
initializeFor: aCart dated: aDate debitCreditCardWith: aCreditCardDebitator 
	cart := aCart.
	date := aDate.
	creditCardDebitator := aCreditCardDebitator.! !


!CashierForSale methodsFor: 'checkout' stamp: 'JB 6/10/2023 18:56:26'!
calculateTotalAmmount

	^ cart list inject:  0  into: [:anAmmount :aBook|
			anAmmount +  (cart priceFor: aBook). 			
		]! !

!CashierForSale methodsFor: 'checkout' stamp: 'JB 6/10/2023 19:02:36'!
checkoutWhitCreditCard: aCreditCard registerOn: bookOfSells 
	|ammount|
	self checkForEmptyCart. 
	self checkForDate: aCreditCard.
	ammount := self calculateTotalAmmount.
	creditCardDebitator  debitTheAmmount:    ammount  toTheCreditCard: aCreditCard . 
	bookOfSells  add: ammount .
	^ammount 
	
	! !


!CashierForSale methodsFor: 'checkout private' stamp: 'JB 6/10/2023 19:08:25'!
checkForDate: aCreditCard 
	( date >  aCreditCard date ) ifTrue:[
			self error: self class cannotProccesSellForExpiredCreditCard 
			]! !

!CashierForSale methodsFor: 'checkout private' stamp: 'JB 6/10/2023 19:07:30'!
checkForEmptyCart
	 cart isEmpty ifTrue:[
			 self error: self class cannotCheckoutEmptyCart	
		]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CashierForSale class' category: 'TusLibros'!
CashierForSale class
	instanceVariableNames: ''!

!CashierForSale class methodsFor: 'instance creation' stamp: 'JB 6/10/2023 19:10:45'!
forTheShoppingCart: aCartToCheckOut withDate: aDate debitSaleWithTheDebitator: aCreditCardDebitator 
	^self new initializeFor: aCartToCheckOut dated: aDate debitCreditCardWith: aCreditCardDebitator ! !


!CashierForSale class methodsFor: 'error message' stamp: 'lp 6/8/2023 20:02:08'!
cannotCheckoutEmptyCart
	^'No podes pagar con el carrito vacío :(((((' ! !

!CashierForSale class methodsFor: 'error message' stamp: 'lp 6/8/2023 21:45:58'!
cannotProccesSellForExpiredCreditCard
	^'No me dejan pasarlo broo, sabes que venite antes que cerremos y lo hacemos, tranka :)'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'gregorianMonthOfYear date creditCardNumber expirationDate creditCardOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initializing' stamp: 'JB 6/10/2023 17:52:00'!
initializeNumber: aCreditCardNumber date: anExpirationDate name: aCreditCardOwner 
	creditCardNumber := aCreditCardNumber.
	expirationDate := anExpirationDate.
	creditCardOwner := aCreditCardOwner.! !


!CreditCard methodsFor: 'date' stamp: 'JB 6/10/2023 17:58:35'!
date
	
	^expirationDate ! !


!CreditCard methodsFor: 'number' stamp: 'JB 6/10/2023 18:25:05'!
number
	^creditCardNumber ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'JB 6/10/2023 17:51:00'!
number: creditCardNumber date: expirationDate name: creditCardOwner 
	
	^self new initializeNumber: creditCardNumber date: expirationDate name: creditCardOwner ! !


!classDefinition: #InstanceFactory category: 'TusLibros'!
Object subclass: #InstanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!InstanceFactory methodsFor: 'cashier' stamp: 'JB 6/10/2023 19:39:12'!
cashierWithACartWithABook
	^self crateCorrectlyDatedCashierForTheCart:  (self createEmptyCart  add: self itemSellByTheStore ) ! !

!InstanceFactory methodsFor: 'cashier' stamp: 'JB 6/10/2023 19:39:12'!
cashierWithACartWithTwoBooks
		|cart|
		cart := self createEmptyCart  add: self itemSellByTheStore. 
		cart add: 'Full Moon' . 


		^self crateCorrectlyDatedCashierForTheCart:  cart
 
 ! !

!InstanceFactory methodsFor: 'cashier' stamp: 'JB 6/10/2023 19:39:12'!
cashierWithEmptyCart
	^self crateCorrectlyDatedCashierForTheCart:  self createEmptyCart ! !

!InstanceFactory methodsFor: 'cashier' stamp: 'JB 6/10/2023 19:39:12'!
crateCorrectlyDatedCashierForTheCart: aShoppingCart

	^ CashierForSale forTheShoppingCart: (aShoppingCart ) withDate: (GregorianMonthOfYear year: 2023   month: June ) debitSaleWithTheDebitator: MerchantProcessorSimulator new.! !


!InstanceFactory methodsFor: 'credit card' stamp: 'JB 6/10/2023 17:55:55'!
createLionelMessiCreditCardDated: aDate

	^ CreditCard  number: 1   date:  aDate name: 'Lionel Messi' ! !

!InstanceFactory methodsFor: 'credit card' stamp: 'JB 6/10/2023 18:35:17'!
creditCardRobbed
	^CreditCard  number:    3 date:  ( GregorianMonthOfYear year:  2024 month: September) name: 'Robben Van Persy' ! !

!InstanceFactory methodsFor: 'credit card' stamp: 'JB 6/10/2023 18:27:42'!
creditCardWithoutFunds
	^CreditCard  number:    2 date:  ( GregorianMonthOfYear year:  2024 month: September) name: 'Cristiano Ronaldo' ! !

!InstanceFactory methodsFor: 'credit card' stamp: 'JB 6/10/2023 17:54:52'!
expiredCreditCard
	^self createLionelMessiCreditCardDated: ( GregorianMonthOfYear year:  2010 month: September ). ! !

!InstanceFactory methodsFor: 'credit card' stamp: 'JB 6/10/2023 17:55:15'!
validCreditCard
	^self createLionelMessiCreditCardDated:   ( GregorianMonthOfYear year:  2024 month: September ). ! !


!InstanceFactory methodsFor: 'items' stamp: 'JB 6/10/2023 19:51:45'!
itemNotSellByTheStore
	^'Harry Potter :(' ! !

!InstanceFactory methodsFor: 'items' stamp: 'JB 6/10/2023 15:36:18'!
itemSellByTheStore
	^ 'validBook'! !


!InstanceFactory methodsFor: 'catalog' stamp: 'JB 6/10/2023 15:36:10'!
defaultCatalog
	|catalog| 
	catalog := Dictionary  new. 
	catalog add:( Association  key:  self itemSellByTheStore  value:  500002). 
	catalog add:( Association  key:  'Full Moon'   value:  1). 

	^ catalog! !


!InstanceFactory methodsFor: 'cart' stamp: 'JB 6/10/2023 15:36:07'!
createEmptyCart
	^Cart acceptingItemsOf: self defaultCatalog! !


!classDefinition: #MerchantProcessorSimulator category: 'TusLibros'!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'creditCardWithoutFunds stolenCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'debit' stamp: 'JB 6/10/2023 19:45:55'!
debitTheAmmount: anAmmount2debit toTheCreditCard: aCreditCard 
	self checkForNoFunds:  aCreditCard .
	self checkForRobbedCreditCard:  aCreditCard ! !


!MerchantProcessorSimulator methodsFor: 'initializing' stamp: 'JB 6/10/2023 18:35:18'!
initialize
	|instanceFactory |
	instanceFactory := 	InstanceFactory  new. 
	creditCardWithoutFunds  :=  instanceFactory  creditCardWithoutFunds.
	stolenCreditCard := instanceFactory  creditCardRobbed. ! !


!MerchantProcessorSimulator methodsFor: 'checking' stamp: 'JB 6/10/2023 19:44:29'!
checkForNoFunds: aCreditCard
	(aCreditCard  number = creditCardWithoutFunds number )ifTrue:[
				self error: self class creditCardWithoutFundsErrorMessage 
			].		
! !

!MerchantProcessorSimulator methodsFor: 'checking' stamp: 'JB 6/10/2023 19:45:55'!
checkForRobbedCreditCard: aCreditCard
	(aCreditCard  number = stolenCreditCard number )ifTrue:[
				self error: self class  cannotProcessSaleForRobedCreditCard
				] 	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: 'TusLibros'!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'category-name' stamp: 'JB 6/10/2023 18:40:24'!
cannotProcessSaleForRobedCreditCard
	^'tarjeta robada error message' ! !

!MerchantProcessorSimulator class methodsFor: 'category-name' stamp: 'JB 6/10/2023 18:26:31'!
creditCardWithoutFundsErrorMessage
	^'no tiene fondos la tarjeta :)' ! !
