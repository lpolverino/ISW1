!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportesTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportesTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 16:56:32'!
test01empyAccountSummaryReportGivesOnlyTheBalance


self assert: 'balance = 0' equals: (ReceptiveAccount new) accountSummary
! !

!ReportesTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 17:18:25'!
test02AccountSummaryGivesADeposit
|account|
account := ReceptiveAccount  new.
Deposit register: 100 on: account .


self assert: 'Deposito por 100.',String crString ,'balance = 100'
	equals: account accountSummary
! !

!ReportesTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 17:19:22'!
test03AccountSummaryGivesAWithdraw
|account|
account := ReceptiveAccount  new.
Withdraw register: 100 on: account .


self assert: 'Extraccion por 100.',String crString ,'balance = -100'
	equals: account accountSummary
! !

!ReportesTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 17:28:07'!
test04AccountSummaryGivesAExitTransfer
|accountExtracted accountDeposit|
accountExtracted := ReceptiveAccount  new.
accountDeposit := ReceptiveAccount new.

Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .


self assert: 'Salida por Transferencia de 100.',String crString ,'balance = -100'
	equals: accountExtracted accountSummary
! !

!ReportesTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 17:36:39'!
test05AccountSummaryGivesAInTransfer
|accountExtracted accountDeposit|
accountExtracted := ReceptiveAccount new.
accountDeposit := ReceptiveAccount new.

Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .


self assert: 'Entrada por Transferencia de 100.',String crString ,'balance = 100'
	equals: accountDeposit accountSummary
! !

!ReportesTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 17:43:39'!
test06AccountSummaryGivesMany
|account accountToExtract accountToDeposit|
account := ReceptiveAccount  new.
accountToExtract := ReceptiveAccount new.
accountToDeposit := ReceptiveAccount new.

Deposit register: 100 on: account. 
Withdraw register: 50 on:account .

Transfer theAmmount: 20 from: account  to: accountToDeposit .
Transfer theAmmount: 30 from: accountToExtract  to: account .



self assert: 
'Deposito por 100.',String crString ,
'Extraccion por 50.',String crString ,
'Salida por Transferencia de 20.',String crString,
'Entrada por Transferencia de 30.',String crString ,
'balance = 60'
	equals: account accountSummary
! !

!ReportesTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 17:59:40'!
test07emptyPortfolioAccountSumaryGivesBalance0
|portfolio |

portfolio := Portfolio new.


self assert: 
'balance = 0'
	equals: portfolio accountSummary
! !

!ReportesTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 18:07:48'!
test08PortfolioWithAnAccountAccountSumary
| portfolio account |
account := ReceptiveAccount  new.
Withdraw register: 100 on: account .

portfolio := Portfolio new.
portfolio add: account .


self assert: 
'Extraccion por 100.',String crString ,
'balance = -100'
	equals: portfolio accountSummary
! !

!ReportesTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 18:07:40'!
test09PortfolioWithAnotherPortfolioAccountSumary
|portfolioToAdd portfolio account |
account := ReceptiveAccount  new.
Withdraw register: 100 on: account .

portfolio := Portfolio new.
portfolioToAdd := Portfolio new.
portfolioToAdd  add: account .
portfolio add: portfolioToAdd .


self assert: 
'Extraccion por 100.',String crString ,
'balance = -100'
	equals: portfolio accountSummary
! !

!ReportesTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 18:21:02'!
test10PortfolioWithTwoAccountsAccountSumary
| portfolio accountDeposit accountWithDraw |
accountWithDraw := ReceptiveAccount  new.
Withdraw register: 100 on: accountWithDraw .

accountDeposit := ReceptiveAccount  new.
Deposit register: 10 on: accountDeposit .

portfolio := Portfolio new.
portfolio add: accountWithDraw .
portfolio add: accountDeposit .


self assert: 
'Extraccion por 100.',String crString ,
'Deposito por 10.',String crString ,
'balance = -90'
	equals: portfolio accountSummary
! !

!ReportesTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 18:30:19'!
test11PortfolioWithaPortfolioWithAnotherPortfolioInsideAccountSumary
| portfolio portfolioChild portfolioGrandson accountDeposit accountWithDraw |
accountWithDraw := ReceptiveAccount  new.
Withdraw register: 100 on: accountWithDraw .

accountDeposit := ReceptiveAccount  new.
Deposit register: 10 on: accountDeposit .

portfolioChild:=Portfolio new.

portfolioGrandson := Portfolio new.

portfolio := Portfolio new.
portfolio add: accountWithDraw .
portfolio add: accountDeposit .

portfolioChild add: portfolioGrandson .
portfolio add: portfolioChild .

self assert: 
'Extraccion por 100.',String crString ,
'Deposito por 10.',String crString ,
'balance = -90'
	equals: portfolio accountSummary
! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 15:03:07'!
test01NewTransfer

|accountExtracted accountDeposit |

accountExtracted := ReceptiveAccount new.
accountDeposit := ReceptiveAccount  new.


Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .

self assert: accountExtracted balance equals: -100.
self assert: accountDeposit  balance equals: 100.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 16:29:48'!
test02chekingLegs

| transaction accountExtracted accountDeposit |

accountExtracted := ReceptiveAccount new.
accountDeposit := ReceptiveAccount  new.


transaction := Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .

self assert:( accountExtracted hasRegistered: transaction).
self assert: (accountDeposit  hasRegistered: transaction ).
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 16:40:37'!
test03transferAreInTransaction

| transfer accountExtracted accountDeposit |

accountExtracted := ReceptiveAccount new.
accountDeposit := ReceptiveAccount  new.


transfer := Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .

self assert:( accountExtracted transactions includes: transfer).
self assert: (accountDeposit transactions includes: transfer).
! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reportes' stamp: 'lp 5/25/2023 18:34:11'!
accountSummary
|accountSummary|
	accountSummary  := ''.
	accounts do:[:anAccount |
			accountSummary := accountSummary , anAccount calculateAccountSummary .
		].
	
	^ accountSummary , 'balance = ', self balance asString! !

!Portfolio methodsFor: 'reportes' stamp: 'lp 5/25/2023 18:11:05'!
calculateAccountSummary
	|accountSummary|
	accountSummary  := ''.
	(accounts size = 0) ifFalse:[
		accountSummary :=  (accounts at:1) calculateAccountSummary 
		].
	
	^ accountSummary ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'reports' stamp: 'lp 5/25/2023 17:57:15'!
accountSummary
	
	^ self calculateAccountSummary ,'balance = ',  self balance asString ! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'lp 5/25/2023 17:56:25'!
calculateAccountSummary
	|accountSummary|

	accountSummary  := ''.
		transactions do:[:aTransaction |
		((aTransaction) isKindOf: Deposit) ifTrue:[accountSummary := accountSummary , 'Deposito por ' , (aTransaction) value asString ,'.', String crString ].
		((aTransaction) isKindOf: Withdraw) ifTrue:[accountSummary := accountSummary , 'Extraccion por ' , (aTransaction) value asString ,'.', String crString ] .
		((aTransaction) isKindOf: ExtractionLeg ) ifTrue:[accountSummary := accountSummary , 'Salida por Transferencia de ' , (aTransaction) transferHead value asString ,'.', String crString ] .
		((aTransaction) isKindOf: DepositLeg ) ifTrue:[accountSummary := accountSummary , 'Entrada por Transferencia de ' , (aTransaction) transferHead value asString ,'.', String crString ] .
		].
	^accountSummary ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initialization' stamp: 'lp 5/25/2023 15:47:00'!
theAmmount: anAmmount from: accountExtracted to: accountDeposit 
	|aTransfer|
	aTransfer := TransferHead withValue: anAmmount .
	accountExtracted register: aTransfer extractedLeg.
	accountDeposit register: aTransfer depositLeg.
	^ aTransfer.! !


!classDefinition: #TransferHead category: 'Portfolio-Solucion'!
Transfer subclass: #TransferHead
	instanceVariableNames: 'ammount extractionLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferHead methodsFor: 'initialization' stamp: 'lp 5/25/2023 15:59:09'!
depositLeg
	depositLeg ifNil:[depositLeg:= DepositLeg of: self].
	^depositLeg! !

!TransferHead methodsFor: 'initialization' stamp: 'lp 5/25/2023 16:04:17'!
extractedLeg
	extractionLeg ifNil:[extractionLeg := ExtractionLeg of: self].
	^extractionLeg! !

!TransferHead methodsFor: 'initialization' stamp: 'lp 5/25/2023 15:57:26'!
initializeWith: anAmmount 
	
	ammount := anAmmount.
	! !

!TransferHead methodsFor: 'initialization' stamp: 'lp 5/25/2023 16:24:19'!
isEqualToATransferLeg: aTransactionLeg
	^ aTransactionLeg headIsEqualTo: self! !

!TransferHead methodsFor: 'initialization' stamp: 'lp 5/25/2023 15:48:49'!
value
	^ ammount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferHead class' category: 'Portfolio-Solucion'!
TransferHead class
	instanceVariableNames: 'transferHead'!

!TransferHead class methodsFor: 'initialization' stamp: 'lp 5/25/2023 15:48:02'!
withValue: anAmmount 
	^ self new initializeWith: anAmmount .! !


!classDefinition: #TransferLegs category: 'Portfolio-Solucion'!
Transfer subclass: #TransferLegs
	instanceVariableNames: 'transferHead'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLegs methodsFor: 'equal' stamp: 'lp 5/25/2023 16:21:26'!
= aTransaction
	(aTransaction isKindOf: Transfer )ifTrue:[
		
	^aTransaction isEqualToATransferLeg: self].
	^false
! !

!TransferLegs methodsFor: 'equal' stamp: 'lp 5/25/2023 16:13:54'!
hash
	^ super hash! !

!TransferLegs methodsFor: 'equal' stamp: 'lp 5/25/2023 16:19:28'!
headIsEqualTo: aTransferHead
	^ transferHead = aTransferHead! !

!TransferLegs methodsFor: 'equal' stamp: 'lp 5/25/2023 16:22:44'!
isEqualToATransferLeg: aTransferLeg
	^transferHead = aTransferLeg transferHead! !


!TransferLegs methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 15:45:35'!
affectBalance: aBalance
	self subclassResponsibility ! !

!TransferLegs methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 15:44:54'!
initializeWith: aTransferHead

	transferHead := aTransferHead 
	! !

!TransferLegs methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 16:23:22'!
transferHead
	^ transferHead ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLegs class' category: 'Portfolio-Solucion'!
TransferLegs class
	instanceVariableNames: ''!

!TransferLegs class methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 15:43:19'!
of: aTransferHead 
	^self new initializeWith: aTransferHead .! !


!classDefinition: #DepositLeg category: 'Portfolio-Solucion'!
TransferLegs subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 15:39:10'!
affectBalance: aBalanceAmmount
	^ aBalanceAmmount +  transferHead value.! !


!classDefinition: #ExtractionLeg category: 'Portfolio-Solucion'!
TransferLegs subclass: #ExtractionLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ExtractionLeg methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 15:39:26'!
affectBalance: aBalanceAmmount
	^ aBalanceAmmount - transferHead value.! !
