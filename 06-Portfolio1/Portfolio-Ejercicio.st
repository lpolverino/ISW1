!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'balance Test' stamp: 'lp 5/18/2023 12:44:57'!
test00PortofolioShouldStartWithBalanceIn0

|portfolio|
portfolio := Portfolio new.

self assert:0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/20/2023 20:34:00'!
test01addFirstAccountMakePortfolioBalanceEqualsToTheAccountBalance

|portfolio account |

portfolio := Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.

portfolio add:account.

self assert:100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/20/2023 20:41:59'!
test02addAccountSHouldAddHisBalance

|portfolio account anotherAccount |

portfolio := Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.
portfolio add: account.

anotherAccount := ReceptiveAccount new.
Deposit register: 50 on: anotherAccount .
portfolio add: anotherAccount .
self assert:150 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/20/2023 20:50:12'!
test03addFirstAPortafolioMakeTheBalanceEqualsToTheAddedPoratafolioBalance

|portfolio account portafolioToAdd|

portafolioToAdd := Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.
portafolioToAdd add: account.

portfolio := Portfolio new initialize.
portfolio add: portafolioToAdd .

self assert:100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/21/2023 15:48:14'!
test04addAPortafolioSHouldAddHisBalance

|portfolio account portafolioToAdd  secondAccount secondPortafolioToAdd |

portafolioToAdd := Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.
portafolioToAdd add: account.

secondPortafolioToAdd := Portfolio new initialize .
secondAccount := ReceptiveAccount new.
Deposit register: 100 on: secondAccount.
secondPortafolioToAdd add: secondAccount.

portfolio := Portfolio new initialize.


portfolio add: portafolioToAdd .
portfolio add: secondPortafolioToAdd .



self assert:200 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/20/2023 20:52:07'!
test05addAAccountAlreadyInThePortfolioAccountsProducesError
|portfolio account    |


portfolio := Portfolio new initialize.
account := ReceptiveAccount new.
Deposit register: 100 on: account.

portfolio add: account.
self should: [portfolio add: account]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/21/2023 15:27:25'!
test06addAAccountAlreadyInThePortfolioInnerPortafolioProducesError
|portfolio account innerPortafolio |


portfolio := Portfolio new initialize.
innerPortafolio:= Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.

innerPortafolio add: account.
portfolio add: innerPortafolio .
self should: [portfolio add: account]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/21/2023 15:48:29'!
test07addAAccountAlreadyInThePortfolioInnerPortafoliosProducesError
|portfolio account innerPortafolio portafolioInInnerPortafolio |


portfolio := Portfolio new initialize.
innerPortafolio:= Portfolio new initialize .
portafolioInInnerPortafolio := Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.

portafolioInInnerPortafolio add: account.
innerPortafolio add: portafolioInInnerPortafolio.
portfolio add: innerPortafolio .
self should: [portfolio add: account]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/21/2023 14:35:32'!
test08addAPortafolioWIthAAlreadyExistingAccountInTheReceptorPortfolioAccounts
|portfolio account portafolioToAdd|


portfolio := Portfolio new initialize.
portafolioToAdd := Portfolio  new initialize. 

account := ReceptiveAccount new.
Deposit register: 100 on: account.

portfolio add: account.
portafolioToAdd add:  account .
self should: [portfolio add: portafolioToAdd ]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/21/2023 15:25:27'!
test09addAPortafolioWIthAAlreadyExistingAccountInThePortfolioReceptorInmeidatePortfolios
|portfolio account portafolioToAdd innerPortfolio|


portfolio := Portfolio new initialize.
portafolioToAdd := Portfolio  new initialize. 
innerPortfolio := Portfolio  new initialize. 

account := ReceptiveAccount new.
Deposit register: 100 on: account.

innerPortfolio add:  account.
portfolio add: innerPortfolio .
portafolioToAdd add: account .

self should: [portfolio add: portafolioToAdd ]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/21/2023 15:47:11'!
test10addAPortafolioWIthAAlreadyExistingAccountInThePortfolioReceptorInnerPortfolios
|portfolio account portafolioToAdd innerPortfolio innerPortfolioInTheInnerPortfolio|


portfolio := Portfolio new initialize.
portafolioToAdd := Portfolio  new initialize. 
innerPortfolio := Portfolio  new initialize. 
innerPortfolioInTheInnerPortfolio:= Portfolio new initialize .

account := ReceptiveAccount new.
Deposit register: 100 on: account.

innerPortfolioInTheInnerPortfolio add: account.
innerPortfolio  add:  innerPortfolioInTheInnerPortfolio .
portfolio add: innerPortfolio .
portafolioToAdd add: account .

self should: [portfolio add: portafolioToAdd ]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/21/2023 17:10:45'!
test13
|portfolioFatherLeft     portfolioChild account |portfolioFatherLeft  := Portfolio  new.
portfolioChild := Portfolio new  .

account := ReceptiveAccount new.Deposit register: 100 on: account.

portfolioFatherLeft  add:account.portfolioFatherLeft add: portfolioChild  . 




self  should: [portfolioChild  add: account ] 
	raise:  Error
	withExceptionDo: [:anError|
		self assert:  anError  messageText  equals: Portfolio  cannotAddAlreadyExistingAccount  
		].
	
	


! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/21/2023 17:10:27'!
test14
|portfolioFatherLeft   portfolioFatherRight  portfolioChild account |portfolioFatherLeft  := Portfolio  new.
portfolioFatherRight := Portfolio new  .portfolioChild := Portfolio new  .

account := ReceptiveAccount new.Deposit register: 100 on: account.

portfolioFatherLeft  add:account.portfolioFatherLeft add: portfolioChild  . 

portfolioFatherRight  add: portfolioChild . 


self  should: [portfolioChild  add: account ] 
	raise:  Error
	withExceptionDo: [:anError|
		self assert:  anError  messageText  equals: Portfolio  cannotAddAlreadyExistingAccount  
		].
	
	


! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/21/2023 18:41:37'!
test15
| portfolioRoot      portfolioFather  portfolioChild account |portfolioRoot  := Portfolio new. 
 
portfolioFather  := Portfolio  new.
portfolioChild := Portfolio new  .

account := ReceptiveAccount new.Deposit register: 100 on: account.

portfolioRoot add:account.

portfolioRoot  add: portfolioFather . 
portfolioFather  add: portfolioChild . 


self  should: [portfolioChild  add: account ] 
	raise:  Error
	withExceptionDo: [:anError|
		self assert:  anError  messageText  equals: Portfolio  cannotAddAlreadyExistingAccount  
		].
	
	


! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/21/2023 18:34:13'!
test16
| portfolioRoot1   portfolioRoot2   portfolioFather  portfolioChild account |portfolioRoot1  := Portfolio new. 
portfolioRoot2  := Portfolio new. 
portfolioFather  := Portfolio  new.
portfolioChild := Portfolio new  .

account := ReceptiveAccount new.Deposit register: 100 on: account.

portfolioRoot2   add:account.
portfolioRoot2  add: portfolioFather .
portfolioRoot1  add: portfolioFather . 
portfolioFather  add: portfolioChild . 


self  should: [portfolioChild  add: account ] 
	raise:  Error
	withExceptionDo: [:anError|
		self assert:  anError  messageText  equals: Portfolio  cannotAddAlreadyExistingAccount  
		].
	
	


! !

!PortfolioTest methodsFor: 'balance Test' stamp: 'jb 5/21/2023 18:41:25'!
test18
| portfolioRoot      portfolioFather  portfolioChild account |portfolioRoot  := Portfolio new. 
 
portfolioFather  := Portfolio  new.
portfolioChild := Portfolio new  .

account := ReceptiveAccount new.Deposit register: 100 on: account.

portfolioRoot add:account.

portfolioRoot  add: portfolioFather . 
portfolioFather  add: portfolioChild . 


self  should: [portfolioChild  add: account ] 
	raise:  Error
	withExceptionDo: [:anError|
		self assert:  anError  messageText  equals: Portfolio  cannotAddAlreadyExistingAccount  
		].
	
	


! !


!PortfolioTest methodsFor: 'hasRegisteredTest' stamp: 'jb 5/22/2023 12:32:37'!
test11|portfolio account  register|

portfolio := Portfolio new initialize.

account := ReceptiveAccount new.
register :=  Deposit register: 100 on: account.

portfolio add: account.

self assert: ( portfolio  hasRegistered: register )! !

!PortfolioTest methodsFor: 'hasRegisteredTest' stamp: 'jb 5/22/2023 12:33:14'!
test12|portfolio account register|

portfolio := Portfolio new initialize.

account := ReceptiveAccount new.
Deposit register: 100 on: account.register :=  Withdraw  register:  50  on:  ReceptiveAccount  new.

portfolio add: account.

self deny: ( portfolio  hasRegistered: register )! !

!PortfolioTest methodsFor: 'hasRegisteredTest' stamp: 'jb 5/22/2023 12:35:17'!
test19|portfolio  portfolioToAdd account register|

portfolio := Portfolio new .portfolioToAdd  := Portfolio  new. 

account := ReceptiveAccount new.
register:= Deposit register: 100 on: account.
portfolioToAdd  add: account .
portfolio add: portfolioToAdd .

self assert: ( portfolio  hasRegistered: register )! !


!PortfolioTest methodsFor: 'transaction' stamp: 'jb 5/21/2023 18:37:59'!
test17

|portfolio account register |

portfolio := Portfolio new initialize .
account := ReceptiveAccount new.
register:=Deposit register: 100 on: account.

portfolio add:account.

self assert: (OrderedCollection   with: register  )equals: portfolio transactions .! !

!PortfolioTest methodsFor: 'transaction' stamp: 'jb 5/22/2023 12:47:50'!
test20

|portfolio portfolioToAdd account register |
portfolioToAdd := Portfolio  new. 
portfolio := Portfolio new .
account := ReceptiveAccount new.
register:=Deposit register: 100 on: account.

portfolioToAdd add:account.portfolio  add: portfolioToAdd  .

self assert: (OrderedCollection   with: register  )equals: portfolio transactions .! !


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


!Deposit methodsFor: 'balance' stamp: 'lp 5/18/2023 12:42:36'!
affetBalance: aBalance 
	^aBalance + self value! !

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


!Withdraw methodsFor: 'balance' stamp: 'lp 5/18/2023 12:42:58'!
affetBalance: aBalance 
	^aBalance - self value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialElement category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialElement methodsFor: 'balance' stamp: 'jb 5/20/2023 20:23:41'!
balance
	self  subclassResponsibility ! !


!FinancialElement methodsFor: 'transactions' stamp: 'jb 5/20/2023 20:23:46'!
transactions
	self  subclassResponsibility ! !


!FinancialElement methodsFor: 'testing' stamp: 'jb 5/20/2023 20:23:34'!
hasRegistered: aRegister
	self  subclassResponsibility ! !


!FinancialElement methodsFor: 'addig private' stamp: 'jb 5/21/2023 16:39:14'!
doesItHaveAnAccountInCommonWith: aFinancialElement
	self  subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialElement subclass: #Portfolio
	instanceVariableNames: 'financialElements portfolioHirarchy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'adding' stamp: 'jb 5/21/2023 23:52:22'!
add: aFinancialElementToAdd 
		self checkIfItCanAddThisFinancialElement:  aFinancialElementToAdd . 
		financialElements  add: aFinancialElementToAdd. 
		aFinancialElementToAdd addToPortfoliosInTheHirarchy: self.  ! !


!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 23:52:22'!
addToPortfoliosInTheHirarchy: aPortfolio 

	portfolioHirarchy  := portfolioHirarchy add: aPortfolio ! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 23:57:29'!
checkIfItCanAddThisFinancialElement: aFinancialElementToAdd
	(portfolioHirarchy  doesAnyElementInHirarchyHaveAnAccountInCommonWith: aFinancialElementToAdd ) ifTrue:  [
			self error: self class cannotAddAlreadyExistingAccount 
		]
	
	! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:34:08'!
doesAnyOfItsElementsHasAnAccountInCommonWith: aFinancialElementToAdd 
		
		^ financialElements  anySatisfy:[:aFinancialElement|
			  aFinancialElementToAdd sharesAnAccountWith: aFinancialElement 
		].
	
	
	
		! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 17:49:07'!
doesAnyOfItsElementsHasAnAccountInCommonWith: aFinancialElementToAdd  notStoppingBy: aPortfolioToAvoid 
		^ (self financialElementsWithout: aPortfolioToAvoid )anySatisfy:  [ :aFinancialElement |
					aFinancialElementToAdd  sharesAnAccountWith:  aFinancialElement ]
	
		! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:32:01'!
doesItHaveAnAccountInCommonWith: aPortfolio 
	^self doesAnyOfItsElementsHasAnAccountInCommonWith:  aPortfolio .! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 17:49:07'!
financialElementsWithout: aPortfolioToAvoid

	^ financialElements  reject:  [:aFinancialElement |
				aFinancialElement  = aPortfolioToAvoid  
			]! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:24:21'!
hasOrIsThisAccount: anAccount
	^financialElements  anySatisfy: [:aFinancialElement|
		aFinancialElement  hasOrIsThisAccount:  anAccount 
		]! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/22/2023 00:03:42'!
roots
	
	^portfolioHirarchy allRoots.  ! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:34:08'!
sharesAnAccountWith: aFinancialElement 
	 ^aFinancialElement  doesItHaveAnAccountInCommonWith: self.! !


!Portfolio methodsFor: 'balance' stamp: 'jb 5/20/2023 20:24:52'!
balance
	^ financialElements sum:[:aFinancialElement | aFinancialElement  balance] ifEmpty: [0] ! !


!Portfolio methodsFor: 'initialization' stamp: 'jb 5/21/2023 23:51:00'!
initialize
financialElements  := OrderedCollection new. 
	

portfolioHirarchy  := PortfolioHirarchy of: self. ! !


!Portfolio methodsFor: 'register' stamp: 'jb 5/22/2023 12:42:26'!
hasRegistered: aRegister 
	^financialElements  anySatisfy:  [:aFinancialElement|
		aFinancialElement hasRegistered:  aRegister 
		]! !


!Portfolio methodsFor: 'transactions' stamp: 'jb 5/22/2023 12:53:51'!
transactions
	|transactions|
	transactions := OrderedCollection  new. 
	financialElements  do: [:aFinancialElement|
		transactions  addAll:  aFinancialElement  transactions			
	].
	^transactions ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 13:24:59'!
cannotAddAlreadyExistingAccount
^'The Account is Already in the Portfolio'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialElement subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'balance' stamp: 'lp 5/18/2023 12:41:48'!
balance

	^transactions inject:0 into:[:aBalance :aTransaction | aTransaction affetBalance: aBalance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'adding private' stamp: 'jb 5/21/2023 23:52:22'!
addToPortfoliosInTheHirarchy: aPortfolio ! !

!ReceptiveAccount methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:34:46'!
doesItHaveAnAccountInCommonWith: aFinancialElement 
	^aFinancialElement  hasOrIsThisAccount:  self.! !

!ReceptiveAccount methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:24:21'!
hasOrIsThisAccount: anAccount 
	^self = anAccount  ! !

!ReceptiveAccount methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:34:08'!
sharesAnAccountWith: aFinancialElement 
	^aFinancialElement  hasOrIsThisAccount:  self.! !


!classDefinition: #PortfolioHirarchy category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioHirarchy
	instanceVariableNames: 'portfolioInTheCenterOfTheHirarchy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioHirarchy methodsFor: 'hirarchy' stamp: 'jb 5/21/2023 23:42:26'!
allRoots 
	self subclassResponsibility ! !

!PortfolioHirarchy methodsFor: 'hirarchy' stamp: 'jb 5/21/2023 23:57:52'!
doesAnyElementInHirarchyHaveAnAccountInCommonWith: aFinancialElementToAdd 
	self subclassResponsibility ! !


!PortfolioHirarchy methodsFor: 'adding' stamp: 'jb 5/22/2023 11:55:23'!
add:aPortfolioToAddInTheHirarchy
	self subclassResponsibility  ! !


!PortfolioHirarchy methodsFor: 'initializing' stamp: 'jb 5/22/2023 11:57:40'!
initializeWith: aPortfolio
	portfolioInTheCenterOfTheHirarchy  := aPortfolio ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioHirarchy class' category: 'Portfolio-Ejercicio'!
PortfolioHirarchy class
	instanceVariableNames: ''!

!PortfolioHirarchy class methodsFor: 'as yet unclassified' stamp: 'jb 5/21/2023 23:49:55'!
of: aPortfolioToStablishHirarchy
	^PortfolioRoot new initializeWith: aPortfolioToStablishHirarchy ! !


!classDefinition: #PortfolioBranched category: 'Portfolio-Ejercicio'!
PortfolioHirarchy subclass: #PortfolioBranched
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioBranched methodsFor: 'hirarchy' stamp: 'jb 5/22/2023 00:03:18'!
allRoots
	|collectionOfRoots|
	collectionOfRoots  := OrderedCollection  new. 
	parents  do: [:aParentPortfolio|
		collectionOfRoots  addAll:  aParentPortfolio  roots 
		].
	^collectionOfRoots ! !

!PortfolioBranched methodsFor: 'hirarchy' stamp: 'jb 5/22/2023 00:00:59'!
doesAnyElementInHirarchyHaveAnAccountInCommonWith: aFinancialElementToAdd 
	^self allRoots  anySatisfy: [:aPortfolioRoot|
		aPortfolioRoot  doesItHaveAnAccountInCommonWith:  aFinancialElementToAdd 
		]! !


!PortfolioBranched methodsFor: 'adding' stamp: 'jb 5/21/2023 23:49:07'!
add: aPortfolioToAddToHirarchy
	parents  add: aPortfolioToAddToHirarchy. 
	^self! !


!PortfolioBranched methodsFor: 'initializing' stamp: 'jb 5/22/2023 11:59:21'!
initializeWith: aPortfolioToMakeHirarchy  and: aPortfolioToBeginHirarchy
	parents := OrderedCollection  new. 
	parents  add: aPortfolioToBeginHirarchy .
	super initializeWith:  aPortfolioToMakeHirarchy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioBranched class' category: 'Portfolio-Ejercicio'!
PortfolioBranched class
	instanceVariableNames: ''!

!PortfolioBranched class methodsFor: 'as yet unclassified' stamp: 'jb 5/21/2023 23:39:04'!
of: aPortfolioToMakeHirarchy with: aPortfolioToBeginHirarchy 
	^ self new initializeWith: aPortfolioToMakeHirarchy  and: aPortfolioToBeginHirarchy  ! !


!classDefinition: #PortfolioRoot category: 'Portfolio-Ejercicio'!
PortfolioHirarchy subclass: #PortfolioRoot
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!PortfolioRoot methodsFor: 'hirarchy' stamp: 'jb 5/22/2023 11:58:37'!
allRoots 
	 ^OrderedCollection  with:  portfolioInTheCenterOfTheHirarchy ! !

!PortfolioRoot methodsFor: 'hirarchy' stamp: 'jb 5/22/2023 11:58:46'!
doesAnyElementInHirarchyHaveAnAccountInCommonWith: aFinancialElementToAdd 
	^portfolioInTheCenterOfTheHirarchy  doesAnyOfItsElementsHasAnAccountInCommonWith:  aFinancialElementToAdd ! !


!PortfolioRoot methodsFor: 'adding' stamp: 'jb 5/22/2023 11:58:19'!
add: aPortfolioUpInTheHirarchy
	^PortfolioBranched  of: portfolioInTheCenterOfTheHirarchy  with: aPortfolioUpInTheHirarchy 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioRoot class' category: 'Portfolio-Ejercicio'!
PortfolioRoot class
	instanceVariableNames: 'portfolio'!

!PortfolioRoot class methodsFor: 'as yet unclassified' stamp: 'jb 5/21/2023 23:45:01'!
of: aPortfolioToMakeHirarchy
	^self new initializeWith:  aPortfolioToMakeHirarchy ! !
