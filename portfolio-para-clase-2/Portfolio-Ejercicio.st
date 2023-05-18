!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 12:44:57'!
test00PortofolioShouldStartWithBalanceIn0

|portfolio|
portfolio := Portfolio new.

self assert:0 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 12:50:32'!
test01addFirstAccountMakePortfolioBalanceEqualsToTheAccountBalance

|portfolio account |

portfolio := Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.

portfolio addAccount: account.


self assert:100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 12:59:39'!
test02addAccountSHouldAddHisBalance

|portfolio account anotherAccount |

portfolio := Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.
portfolio addAccount: account.

anotherAccount := ReceptiveAccount new.
Deposit register: 50 on: anotherAccount .
portfolio addAccount: anotherAccount .


self assert:150 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 12:58:23'!
test03addFirstAPortafolioMakeTheBalanceEqualsToTheAddedPoratafolioBalance

|portfolio account portafolioToAdd|

portafolioToAdd := Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.
portafolioToAdd addAccount: account.

portfolio := Portfolio new initialize.
portfolio addPortafolio: portafolioToAdd .


self assert:100 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 13:16:00'!
test04addAPortafolioSHouldAddHisBalance

|portfolio account portafolioToAdd  secondAccount secondPortafolioToAdd |

portafolioToAdd := Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.
portafolioToAdd addAccount: account.

secondPortafolioToAdd := Portfolio new initialize .
secondAccount := ReceptiveAccount new.
Deposit register: 100 on: secondAccount.
secondPortafolioToAdd addAccount: secondAccount.

portfolio := Portfolio new initialize.


portfolio addPortafolio: portafolioToAdd .
portfolio addPortafolio: secondPortafolioToAdd .



self assert:200 equals: portfolio balance.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 13:45:48'!
test05addAAccountAlreadyInThePortfolioAccountsProducesError
|portfolio account    |


portfolio := Portfolio new initialize.
account := ReceptiveAccount new.
Deposit register: 100 on: account.

portfolio addAccount: account.
self should: [portfolio addAccount: account]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 14:23:32'!
test06addAAccountAlreadyInThePortfolioInnerPortafolioProducesError
|portfolio account innerPortafolio |


portfolio := Portfolio new initialize.
innerPortafolio:= Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.

innerPortafolio addAccount: account.
portfolio addPortafolio: innerPortafolio .
self should: [portfolio addAccount: account]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 14:25:24'!
test07addAAccountAlreadyInThePortfolioInnerPortafoliosProducesError
|portfolio account innerPortafolio portafolioInInnerPortafolio |


portfolio := Portfolio new initialize.
innerPortafolio:= Portfolio new initialize .
portafolioInInnerPortafolio := Portfolio new initialize .
account := ReceptiveAccount new.
Deposit register: 100 on: account.

portafolioInInnerPortafolio addAccount: account.
innerPortafolio addPortafolio: portafolioInInnerPortafolio.
portfolio addPortafolio: innerPortafolio .
self should: [portfolio addAccount: account]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 15:09:39'!
test08addAPortafolioWIthAAlreadyExistingAccountInTheReceptorPortfolioAccounts
|portfolio account portafolioToAdd|


portfolio := Portfolio new initialize.
portafolioToAdd := Portfolio  new initialize. 

account := ReceptiveAccount new.
Deposit register: 100 on: account.

portfolio addAccount: account.
portafolioToAdd addAccount: account .
self should: [portfolio addPortafolio: portafolioToAdd ]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 15:09:56'!
test09addAPortafolioWIthAAlreadyExistingAccountInThePortfolioReceptorInmeidatePortfolios
|portfolio account portafolioToAdd innerPortfolio|


portfolio := Portfolio new initialize.
portafolioToAdd := Portfolio  new initialize. 
innerPortfolio := Portfolio  new initialize. 

account := ReceptiveAccount new.
Deposit register: 100 on: account.

innerPortfolio addAccount: account.
portfolio addPortafolio: innerPortfolio .
portafolioToAdd addAccount: account .

self should: [portfolio addPortafolio: portafolioToAdd ]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 15:10:15'!
test10addAPortafolioWIthAAlreadyExistingAccountInThePortfolioReceptorInnerPortfolios
|portfolio account portafolioToAdd innerPortfolio innerPortfolioInTheInnerPortfolio|


portfolio := Portfolio new initialize.
portafolioToAdd := Portfolio  new initialize. 
innerPortfolio := Portfolio  new initialize. 
innerPortfolioInTheInnerPortfolio:= Portfolio new initialize .

account := ReceptiveAccount new.
Deposit register: 100 on: account.

innerPortfolioInTheInnerPortfolio addAccount: account.
innerPortfolio  addPortafolio: innerPortfolioInTheInnerPortfolio .
portfolio addPortafolio: innerPortfolio .
portafolioToAdd addAccount: account .

self should: [portfolio addPortafolio: portafolioToAdd ]
	 raise: Error 
	 withExceptionDo:[:anError|
		self assert:( anError messageText) equals:( Portfolio cannotAddAlreadyExistingAccount) ] .

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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'balance accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 14:34:51'!
accounts
	^accounts ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 13:17:10'!
balance
	^( accounts sum:[:anAccount | anAccount balance] ifEmpty: [0] ) + ( portfolios sum:[:anAccount | anAccount balance] ifEmpty: [0] )! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 13:16:36'!
initialize
	accounts:= OrderedCollection new.
	portfolios:=OrderedCollection new.
	balance := 0.
! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 14:32:41'!
portfolios
	^portfolios ! !


!Portfolio methodsFor: 'adding' stamp: 'lp 5/18/2023 14:44:00'!
addAccount: accountToAdd 
	self canAdd: accountToAdd.
	accounts add: accountToAdd 
		
	
	
	
	
! !

!Portfolio methodsFor: 'adding' stamp: 'lp 5/18/2023 15:05:09'!
addPortafolio: portafolioToAdd 
	self failIfFoundSameAccountIn: portafolioToAdd.
	portfolios add: portafolioToAdd ! !

!Portfolio methodsFor: 'adding' stamp: 'lp 5/18/2023 14:44:00'!
canAdd: accountToAdd

	^ self hasAccount: accountToAdd! !

!Portfolio methodsFor: 'adding' stamp: 'lp 5/18/2023 15:07:40'!
failIfFoundSameAccountIn: portafolioToAdd

	self haveTheSameAccount: portafolioToAdd.
	portfolios do:[:aPortfolio| aPortfolio failIfFoundSameAccountIn: portafolioToAdd]! !

!Portfolio methodsFor: 'adding' stamp: 'lp 5/18/2023 14:41:57'!
hasAccount: accountToAdd

	^ (self hasAccountInAccounts: accountToAdd) 
	ifFalse: [
		self hasAccountInInnerPortfolios: accountToAdd.
			]! !

!Portfolio methodsFor: 'adding' stamp: 'lp 5/18/2023 14:39:40'!
hasAccountInAccounts: accountToAdd

	^ (self accounts) detect:[:account| ( account = accountToAdd)]
	ifFound:[:accoutn |  self error: self class cannotAddAlreadyExistingAccount ]
	ifNone:[^false]! !

!Portfolio methodsFor: 'adding' stamp: 'lp 5/18/2023 14:41:48'!
hasAccountInInnerPortfolios: accountToAdd

	^ portfolios do:[:aPortfolio| aPortfolio hasAccount: accountToAdd ]! !

!Portfolio methodsFor: 'adding' stamp: 'lp 5/18/2023 15:03:35'!
haveTheSameAccount: portafolioToAdd

	^ accounts do:[:anAccount| portafolioToAdd hasAccount: anAccount ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 13:24:59'!
cannotAddAlreadyExistingAccount
^'The Account is Already in the Portfolio'! !


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


!ReceptiveAccount methodsFor: 'balance' stamp: 'lp 5/18/2023 12:41:48'!
balance

	^transactions inject:0 into:[:aBalance :aTransaction | aTransaction affetBalance: aBalance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
