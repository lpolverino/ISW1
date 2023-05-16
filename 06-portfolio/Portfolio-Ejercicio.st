!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'test' stamp: 'jb 5/15/2023 20:24:43'!
test00
	|portfolio |
	portfolio  :=  Portfolio  new.
	
	
	self assert: 0 equals: portfolio balance.  
	self assert:OrderedCollection  new equals:  portfolio accounts! !

!PortfolioTest methodsFor: 'test' stamp: 'jb 5/15/2023 20:31:29'!
test01
	|portfolio account  |
	portfolio  :=  Portfolio  new.
	account  := ReceptiveAccount new.

	Deposit register: 100 on: account. 
	portfolio addAcount: account .

	self assert: account balance equals: portfolio balance.  

	! !

!PortfolioTest methodsFor: 'test' stamp: 'jb 5/15/2023 21:20:12'!
test02
	|portfolio1 portfolio2|
	portfolio1  := Portfolio  new. 
	portfolio2  := Portfolio  new. 
	portfolio1  addPortfolio:  portfolio1. 
	self assert:  portfolio1  balance  equals: portfolio2 balance ! !

!PortfolioTest methodsFor: 'test' stamp: 'jb 5/15/2023 21:22:35'!
test03
	|portfolio1 portfolio2  account1 account2  |
	portfolio1  :=  Portfolio  new.
	account1  := ReceptiveAccount new.
	account2 := ReceptiveAccount  new.

	Deposit  register:   50  on:  account2 .
	Deposit register: 100 on: account1. 
	portfolio1 addAcount: account1 .

	
	portfolio2  	:= Portfolio  new.
	portfolio2 addPortfolio: portfolio1 .
	portfolio2  addAcount: account2 .
	
	self assert:  150 equals: portfolio2  balance.  

	! !

!PortfolioTest methodsFor: 'test' stamp: 'jb 5/15/2023 21:39:03'!
test04
	|portfolio1 account1 |
	portfolio1  :=  Portfolio  new.
	account1  := ReceptiveAccount new.
	

	
	Deposit register: 100 on: account1. 
	portfolio1 addAcount: account1 .
	
	
	self should: [	portfolio1  addAcount:  account1 . ] 
		raise:  Error
	 withExceptionDo: [:anError|
		self assert:   Portfolio errorMessageAlreadyExist equals: anError messageText . 			
		]  




	

	! !

!PortfolioTest methodsFor: 'test' stamp: 'jb 5/15/2023 21:41:45'!
test05
	|portfolio1 account1 portfolio2 |
	portfolio1  :=  Portfolio  new.
	account1  := ReceptiveAccount new.
	

	
	Deposit register: 100 on: account1. 
	portfolio1 addAcount: account1 .
	
	portfolio2 := Portfolio  new. 
	portfolio2  addPortfolio:  portfolio1 .
		
	
	self should: [	portfolio2  addAcount:  account1 . ] 
		raise:  Error
	 withExceptionDo: [:anError|
		self assert:   Portfolio errorMessageAlreadyExist equals: anError messageText . 			
		]  




	

	! !

!PortfolioTest methodsFor: 'test' stamp: 'jb 5/15/2023 20:52:50'!
_test03
	|portfolio account deposit |
	portfolio  :=  Portfolio  new.
			
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.		
	self deny: ( portfolio  hasRegister: deposit ).  

	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'jb 5/15/2023 19:58:16'!
affectBalance: aBalance
	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !



!Deposit methodsFor: 'balance' stamp: 'jb 5/15/2023 19:57:25'!
affectBalance: balance 
	^balance + self value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !



!Withdraw methodsFor: 'balance' stamp: 'jb 5/15/2023 19:57:42'!
affectBalance: balance 
	 ^balance - self value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'balance accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'adding accounts' stamp: 'jb 5/15/2023 21:37:23'!
addAcount: account 
	accounts  do:[:anAccount |
		anAccount = account ifTrue:[
			self error: self class errorMessageAlreadyExist .
			]
		].
	balance := balance + account balance.
	accounts add: account. ! !



!Portfolio methodsFor: 'balance' stamp: 'jb 5/15/2023 20:29:28'!
balance
	^balance! !


!Portfolio methodsFor: 'initializing' stamp: 'jb 5/15/2023 21:31:58'!
initialize
	balance  := 0. 
	accounts:= OrderedCollection  new.! !

!Portfolio methodsFor: 'initializing' stamp: 'jb 5/15/2023 21:45:09'!
transactions
	! !


!Portfolio methodsFor: '*CuisUniversity-Model' stamp: 'jb 5/15/2023 20:46:55'!
hasRegister: deposit 
	^false! !


!Portfolio methodsFor: 'adding' stamp: 'jb 5/15/2023 20:55:38'!
addPortfolio: aPortfolio 
	balance := balance + aPortfolio balance ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error handling' stamp: 'jb 5/15/2023 21:24:30'!
errorMessageAlreadyExist
	^'mal ahi, no es por ahi brooo :( '! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'jb 5/15/2023 19:57:51'!
balance
 	^transactions  inject:  0  into:  [:balance :aTransaction| 
			aTransaction affectBalance: 			balance
		] 
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
