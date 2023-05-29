!classDefinition: #AccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTest methodsFor: 'account summary test' stamp: 'lp 5/29/2023 11:56:13'!
test01empyAccountSummaryReportGivesOnlyTheBalance


self assert: (OrderedCollection with: 'balance = 0') equals: (ReceptiveAccount new) accountSummary
! !

!AccountTest methodsFor: 'account summary test' stamp: 'lp 5/29/2023 11:57:36'!
test02AccountSummaryGivesADeposit
|account response|
account := ReceptiveAccount  new.
Deposit register: 100 on: account .
response := OrderedCollection with: 'Deposito por 100.',String crString with:'balance = 100'.


self assert: response
	equals: account accountSummary
! !

!AccountTest methodsFor: 'account summary test' stamp: 'lp 5/29/2023 12:04:27'!
test03AccountSummaryGivesAWithdraw
|account response |
account := ReceptiveAccount  new.
Withdraw register: 100 on: account .
response := OrderedCollection with: 'Extraccion por 100.',String crString with:'balance = -100'.


self assert: response
	equals: account accountSummary
! !

!AccountTest methodsFor: 'account summary test' stamp: 'lp 5/29/2023 12:06:09'!
test04AccountSummaryGivesAExitTransfer
|accountExtracted accountDeposit response |
accountExtracted := ReceptiveAccount  new.
accountDeposit := ReceptiveAccount new.

Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .

response := OrderedCollection with: 'Salida por Transferencia de 100.',String crString with:'balance = -100'.


self assert: response
	equals: accountExtracted accountSummary

! !

!AccountTest methodsFor: 'account summary test' stamp: 'lp 5/29/2023 12:06:53'!
test05AccountSummaryGivesAInTransfer
|accountExtracted accountDeposit response |
accountExtracted := ReceptiveAccount new.
accountDeposit := ReceptiveAccount new.

Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .

response := OrderedCollection with: 'Entrada por Transferencia de 100.',String crString with:'balance = 100'.


self assert: response
	equals: accountDeposit accountSummary
! !

!AccountTest methodsFor: 'account summary test' stamp: 'lp 5/29/2023 12:09:26'!
test06AccountSummaryGivesMany
|account accountToExtract accountToDeposit response |
account := ReceptiveAccount  new.
accountToExtract := ReceptiveAccount new.
accountToDeposit := ReceptiveAccount new.

Deposit register: 100 on: account. 
Withdraw register: 50 on:account .

Transfer theAmmount: 20 from: account  to: accountToDeposit .
Transfer theAmmount: 30 from: accountToExtract  to: account .

response := OrderedCollection with:'Deposito por 100.',String crString with:'Extraccion por 50.',String crString with:'Salida por Transferencia de 20.',String crString with: 'Entrada por Transferencia de 30.',String crString with:'balance = 60'.


self assert: response
	equals: account accountSummary

! !

!AccountTest methodsFor: 'account summary test' stamp: 'lp 5/25/2023 17:59:40'!
test07emptyPortfolioAccountSumaryGivesBalance0
|portfolio |

portfolio := Portfolio new.


self assert: 
'balance = 0'
	equals: portfolio accountSummary
! !

!AccountTest methodsFor: 'account summary test' stamp: 'lp 5/25/2023 18:07:48'!
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

!AccountTest methodsFor: 'account summary test' stamp: 'lp 5/25/2023 18:07:40'!
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

!AccountTest methodsFor: 'account summary test' stamp: 'lp 5/25/2023 18:21:02'!
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

!AccountTest methodsFor: 'account summary test' stamp: 'lp 5/25/2023 18:30:19'!
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

!AccountTest methodsFor: 'account summary test' stamp: 'jb 5/27/2023 14:12:17'!
test12PortfolioWithPortfolioAndAnAccountGiveCorrectAccountSummary
| portfolio portfolioChild accountDeposit accountWithDraw |
accountWithDraw := ReceptiveAccount  new.
Withdraw register: 100 on: accountWithDraw .

accountDeposit := ReceptiveAccount  new.
Deposit register: 10 on: accountDeposit .

portfolioChild:=Portfolio new.
portfolio := Portfolio new.

portfolioChild add: accountWithDraw .
portfolio add: accountDeposit .


portfolio add: portfolioChild .

self assert: 
'Deposito por 10.',String crString ,
'Extraccion por 100.',String crString ,
'balance = -90'
	equals: portfolio accountSummary
! !


!AccountTest methodsFor: 'net transfer test' stamp: 'jb 5/27/2023 14:16:27'!
test13emptyAccountShouldGive0NetTransfer
self assert: 0 equals: ReceptiveAccount  new netTransfer
! !

!AccountTest methodsFor: 'net transfer test' stamp: 'jb 5/27/2023 14:26:26'!
test14anAccountWithAnOnlyTransferGivesCorrectNetTransfer
|account transfer|
account := ReceptiveAccount  new. 
transfer:= Transfer theAmmount:  100  from:  ReceptiveAccount  new  to: account.  
self assert: 100 equals: account netTransfer
! !

!AccountTest methodsFor: 'net transfer test' stamp: 'jb 5/27/2023 15:33:02'!
test15AccountWithTwoTransfersGiveCorrectNetTransfer
|account |
account := ReceptiveAccount  new. 
Transfer theAmmount:  100  from:  ReceptiveAccount  new  to: account.  
Transfer theAmmount:  50  from:  account to: ReceptiveAccount  new.  
self assert: 50 equals: account netTransfer
! !

!AccountTest methodsFor: 'net transfer test' stamp: 'jb 5/27/2023 15:53:12'!
test16emptyPortfolioShouldGive0NetTransfer
self assert: 0 equals: Portfolio  new netTransfer
! !

!AccountTest methodsFor: 'net transfer test' stamp: 'jb 5/27/2023 15:55:48'!
test17PortfolioWithAnAccountWithTransfersShoulGiveCorrectNetTransfer
|account portfolio |
account := ReceptiveAccount  new. 
Transfer theAmmount:  100  from:  ReceptiveAccount  new  to: account.  
Transfer theAmmount:  50  from:  account to: ReceptiveAccount  new.
portfolio := Portfolio  new add: account .  

self assert: account  netTransfer  equals: portfolio netTransfer
! !

!AccountTest methodsFor: 'net transfer test' stamp: 'jb 5/27/2023 16:02:14'!
test18PortfolioWithAnInnerPortfolioWithOneAccountShouldGiveCorrectNetTransfer
|account innerPortfolio  portfolio|
account := ReceptiveAccount  new. 
Transfer theAmmount:  100  from:  ReceptiveAccount  new  to: account.  
Transfer theAmmount:  50  from:  account to: ReceptiveAccount  new.
innerPortfolio  := Portfolio  new add: account .  
portfolio  := Portfolio  new add: innerPortfolio . 
self assert: account  netTransfer  equals: portfolio netTransfer
! !

!AccountTest methodsFor: 'net transfer test' stamp: 'jb 5/27/2023 16:40:37'!
test19PortfolioWithMultiplesAccountAndPortfoliosShouldGiveCorrectNetTransfer
|account1 account2   innerPortfolio  portfolio|
account1  := ReceptiveAccount  new.
account2  := ReceptiveAccount  new. 
Deposit register: 25    on: account1 .
Withdraw  register:  25  on: account1 . 
Transfer theAmmount:  100  from:  ReceptiveAccount  new  to: account1.  
Transfer theAmmount:  50  from:  account2 to: ReceptiveAccount  new.
portfolio   := Portfolio  new add: account1 .  
innerPortfolio  :=  Portfolio  new  add: account2 .
portfolio  add: innerPortfolio  .

self assert: 50   equals: portfolio netTransfer
! !


!classDefinition: #PortfolioReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'jb 5/28/2023 10:40:46'!
test01EmptyPortfolioShouldNotPrintAnything
	
	self assert: ''  equals: Portfolio  new showTree! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'jb 5/28/2023 10:54:06'!
test02PortfolioNamedShouldTellItsName
	|portfolio|
	portfolio  :=PortfolioTreeReport named: 'Portfolio de la familia'.   
	self assert: 'Portfolio de la familia'  equals: portfolio  report! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'jb 5/28/2023 12:47:24'!
test03PortfolioWithPortfolioShouldMakeTheCorrectReport
	|portfolio|
	portfolio  := (PortfolioTreeReport named: 'Portfolio de la familia') with: (PortfolioTreeReport named:  'Portfolio de los hijos') .   
	self assert: 
	'Portfolio de la familia',String crString,String tab,
	'Portfolio de los hijos'  equals: portfolio  report! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'jb 5/28/2023 12:53:39'!
test04PortfolioWithAnAccountShouldMakeTheCorrectReport
	|portfolio|
	portfolio  := (PortfolioTreeReport named: 'Portfolio de la familia') with: (ReceptiveAccountTreeReport  named:  'Cuenta de Angeles') .   
	self assert: 
	'Portfolio de la familia',String crString,String tab,
	'Cuenta de Angeles'  equals: portfolio  report! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'jb 5/28/2023 12:59:08'!
test05PortfolioWithAnAccountAndAPortfolioShouldMakeTheCorrectReport
	|portfolio|
	portfolio  := (PortfolioTreeReport named: 'Portfolio de la familia') with: (ReceptiveAccountTreeReport  named:  'Cuenta de Angeles') with: (PortfolioTreeReport  named:  'Portfolio de los hijos').   
	self assert: 
	'Portfolio de la familia',String crString,String tab,
	'Cuenta de Angeles',String crString,String tab,
	'Portfolio de los hijos'
	   equals: portfolio  report! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'jb 5/28/2023 14:23:32'!
test06PortfolioWithPortfolioWithAccountShouldMakeTheCorrectReport
	|portfolio|
	portfolio  := (PortfolioTreeReport named: 'Portfolio de la familia') with: ((PortfolioTreeReport  named:  'Portfolio de los hijos') with: (ReceptiveAccountTreeReport named: 'Cuenta de Angeles')).   
	self assert: 
	'Portfolio de la familia',String crString,String tab,
	'Portfolio de los hijos' ,String crString,String tab,String tab,
	'Cuenta de Angeles'
	   equals: portfolio  report ! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'jb 5/28/2023 14:19:53'!
_test06PortfolioWithManyAccountsAndPortfoliosShouldMakeTheCorrectReport
	|johnsAccount angiesAccount childrenPortfolio myAccount familyPortfolio |
	
	johnsAccount := ReceptiveAccountTreeReport  named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccountTreeReport named: 'Cuenta de Angeles'.
	childrenPortfolio := (PortfolioTreeReport  named:'Portfolio de hijos' )with:
johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccountTreeReport named: 'Cuenta mia'.
	familyPortfolio := (PortfolioTreeReport  named: 'Portfolio de la familia') with: myAccount with: childrenPortfolio.
	
	self  assert: 'Portfolio de la familia', String  crString , String  tab, 
	'Cuenta mia', 	String  crString, String  tab, 
	'Portfolio de hijos', String  crString , String  tab, String  tab, 
	'Cuenta de Juan' , String  crString , String  tab, String  tab, 
	'Cuenta de Angeles'
	 equals: familyPortfolio report. 
! !


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

!TransferTest methodsFor: 'as yet unclassified' stamp: 'lp 5/29/2023 11:38:36'!
test02chekingLegs

| transaction accountExtracted accountDeposit |

accountExtracted := ReceptiveAccount new.
accountDeposit := ReceptiveAccount  new.


transaction := Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .

self assert:( accountExtracted hasRegistered: transaction extractedLeg).
self assert: (accountDeposit  hasRegistered: transaction  depositLeg).
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'lp 5/29/2023 11:38:48'!
test03transferAreInTransaction

| transfer accountExtracted accountDeposit |

accountExtracted := ReceptiveAccount new.
accountDeposit := ReceptiveAccount  new.


transfer := Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .

self assert:( accountExtracted transactions includes: transfer extractedLeg).
self assert: (accountDeposit transactions includes: transfer depositLeg).
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'lp 5/29/2023 11:42:48'!
test04navLegs

| transfer accountExtracted accountDeposit |

accountExtracted := ReceptiveAccount new.
accountDeposit := ReceptiveAccount  new.


transfer := Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .

self assert:( transfer extractedLeg navigate) equals: transfer depositLeg .
self assert:( transfer depositLeg navigate) equals: transfer extractedLeg .
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


!Account methodsFor: 'reports' stamp: 'jb 5/27/2023 14:18:32'!
accountSummary
	self subclassResponsibility ! !

!Account methodsFor: 'reports' stamp: 'jb 5/27/2023 15:56:51'!
netTransfer
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


!Portfolio methodsFor: 'reports' stamp: 'jb 5/28/2023 12:27:07'!
accountSummary
|accountSummary|
	accountSummary  := self calculateAccountSummary .
	^ accountSummary , 'balance = ', self balance asString! !

!Portfolio methodsFor: 'reports' stamp: 'jb 5/28/2023 12:39:06'!
accumulate: anAccumulator andReport: aBlockWithAnAccumulatorAndAAccount  
	^accounts inject:  anAccumulator into: [:anAcc :anAccount |
		aBlockWithAnAccumulatorAndAAccount  value:  anAcc  value:  anAccount 
		]  ! !

!Portfolio methodsFor: 'reports' stamp: 'lp 5/29/2023 11:53:07'!
calculateAccountSummary
	^accounts inject:  '' into: [:anAccountSummary :anAccount |
		anAccountSummary  add:  anAccount  calculateAccountSummary 
		
		]  ! !

!Portfolio methodsFor: 'reports' stamp: 'jb 5/27/2023 16:14:11'!
netTransfer
^accounts inject:  0  into: [:netTransfer :anAccount |
	netTransfer +  anAccount  netTransfer 
	
	]! !

!Portfolio methodsFor: 'reports' stamp: 'jb 5/28/2023 12:37:16'!
report: aBlockWithAccountAndAccumulator 
	^accounts inject:  '' into: [:anAccountSummary :anAccount |
		anAccountSummary  , anAccount  calculateAccountSummary 
		
		]  ! !

!Portfolio methodsFor: 'reports' stamp: 'jb 5/28/2023 10:40:37'!
showTree
	^''! !

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


!ReceptiveAccount methodsFor: 'reports' stamp: 'lp 5/29/2023 11:56:22'!
accountSummary
	|response|
	response := OrderedCollection new.
	response addAll: self calculateAccountSummary .
	response add:'balance = ',  self balance asString .
	^response! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'lp 5/29/2023 12:16:46'!
calculateAccountSummary
	|response|
	response := OrderedCollection new.
	transactions  do: [:aTransaction | 
		(aTransaction isKindOf:Deposit) ifTrue:[response  add: 'Deposito por ' ,  aTransaction value asString ,'.', String crString].
		(aTransaction isKindOf:Withdraw ) ifTrue:[ response  add: 'Extraccion por ' ,  aTransaction value asString ,'.', String crString].
		(aTransaction isKindOf:DepositLeg ) ifTrue:[ response  add: 'Entrada por Transferencia de ' ,  aTransaction value asString ,'.', String crString].
		(aTransaction isKindOf:ExtractionLeg ) ifTrue:[ response  add: 'Salida por Transferencia de ',  aTransaction value asString ,'.', String crString].
		].
	^response! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'lp 5/29/2023 12:20:40'!
netTransfer
|response|
response := 0.
transactions  do: 	[ :aTransaction | 
	(aTransaction isKindOf:Deposit) ifTrue:[].
		(aTransaction isKindOf:Withdraw ) ifTrue:[].
		(aTransaction isKindOf:DepositLeg ) ifTrue:[ response := response + aTransaction value].
		(aTransaction isKindOf:ExtractionLeg ) ifTrue:[response := response - aTransaction value].
	].
^response! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Account subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #PortfolioTreeReport category: 'Portfolio-Solucion'!
Report subclass: #PortfolioTreeReport
	instanceVariableNames: 'nameForThePortfolio portfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreeReport methodsFor: 'initializing' stamp: 'jb 5/28/2023 11:03:23'!
initializeNamed: aNameForThePortfolio 
	portfolio := Portfolio  new. 
	nameForThePortfolio := aNameForThePortfolio.! !

!PortfolioTreeReport methodsFor: 'initializing' stamp: 'jb 5/28/2023 13:02:48'!
with: anAccount1 with: anAccount2 
	 portfolio  add: anAccount1. 
	portfolio  add: anAccount2 .! !


!PortfolioTreeReport methodsFor: 'reports' stamp: 'jb 5/28/2023 14:42:16'!
report
	
	
	^portfolio  accumulate:  nameForThePortfolio  andReport:  [:anAccumulator :anAccount |
		anAccumulator , String crString  ,String  tab ,anAccount  report
		]! !


!PortfolioTreeReport methodsFor: 'adding' stamp: 'jb 5/28/2023 11:10:46'!
addedTo: aPortfolio 
	portfolio  addedTo:  aPortfolio ! !

!PortfolioTreeReport methodsFor: 'adding' stamp: 'jb 5/28/2023 13:05:29'!
isComposedBy: composedAccount 
	^portfolio  isComposedBy:  composedAccount ! !

!PortfolioTreeReport methodsFor: 'adding' stamp: 'jb 5/28/2023 11:02:44'!
with: aPortfolioReport
	portfolio add: aPortfolioReport ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreeReport class' category: 'Portfolio-Solucion'!
PortfolioTreeReport class
	instanceVariableNames: ''!

!PortfolioTreeReport class methodsFor: 'instance creation' stamp: 'jb 5/28/2023 10:55:05'!
named: aNameForThePortfolio
	^self new initializeNamed: aNameForThePortfolio ! !


!classDefinition: #ReceptiveAccountTreeReport category: 'Portfolio-Solucion'!
Report subclass: #ReceptiveAccountTreeReport
	instanceVariableNames: 'nameforTheAccount account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTreeReport methodsFor: 'initializing' stamp: 'jb 5/28/2023 12:55:51'!
initializeNamed: aNameforTheAccount 
	account := ReceptiveAccount  new. 
	nameforTheAccount := aNameforTheAccount.! !


!ReceptiveAccountTreeReport methodsFor: 'adding' stamp: 'jb 5/28/2023 12:56:42'!
addedTo: aPortfolio 
	account  addedTo:  aPortfolio ! !

!ReceptiveAccountTreeReport methodsFor: 'adding' stamp: 'jb 5/28/2023 13:04:58'!
isComposedBy: anAccount 
	^account  isComposedBy:  anAccount ! !


!ReceptiveAccountTreeReport methodsFor: 'report' stamp: 'jb 5/28/2023 14:42:25'!
report
	^nameforTheAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccountTreeReport class' category: 'Portfolio-Solucion'!
ReceptiveAccountTreeReport class
	instanceVariableNames: ''!

!ReceptiveAccountTreeReport class methodsFor: 'instance creation' stamp: 'jb 5/28/2023 12:54:11'!
named: aNameforTheAccount 
	^self new initializeNamed: aNameforTheAccount ! !


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


!Deposit methodsFor: 'net transfer' stamp: 'jb 5/27/2023 16:40:08'!
affectNetTransfer: netTransfer 
	^netTransfer ! !


!Deposit methodsFor: 'account Summary' stamp: 'lp 5/29/2023 12:00:19'!
affectAccountSummary: anAccountSummary 
	anAccountSummary  add: 'Deposito por ' ,  self value asString ,'.', String crString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLegs category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLegs
	instanceVariableNames: 'transferHead'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLegs methodsFor: 'equal' stamp: 'lp 5/29/2023 11:39:52'!
= aTransaction
	self == aTransaction .! !

!TransferLegs methodsFor: 'equal' stamp: 'lp 5/25/2023 16:13:54'!
hash
	^ super hash! !


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

!TransferLegs methodsFor: 'as yet unclassified' stamp: 'jb 5/27/2023 14:34:53'!
value 
	^ transferHead  value ! !


!TransferLegs methodsFor: 'navigate' stamp: 'lp 5/29/2023 11:43:18'!
navigate
	self subclassResponsibility .! !

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

!DepositLeg methodsFor: 'navigate' stamp: 'lp 5/29/2023 11:45:10'!
navigate
	^ transferHead extractedLeg ! !


!DepositLeg methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 15:39:10'!
affectBalance: aBalanceAmmount
	^ aBalanceAmmount +  transferHead value.! !


!DepositLeg methodsFor: 'reports aux' stamp: 'jb 5/27/2023 16:37:19'!
affectNetTransfer: netTransfer 
	^netTransfer  + self value ! !


!DepositLeg methodsFor: 'account summary' stamp: 'lp 5/29/2023 11:55:00'!
affectAccountSummary: anAccountSummary 
	^anAccountSummary add: 'Entrada por Transferencia de ' ,  self value  asString ,'.', String crString! !


!classDefinition: #ExtractionLeg category: 'Portfolio-Solucion'!
TransferLegs subclass: #ExtractionLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ExtractionLeg methodsFor: 'as yet unclassified' stamp: 'lp 5/25/2023 15:39:26'!
affectBalance: aBalanceAmmount
	^ aBalanceAmmount - transferHead value.! !

!ExtractionLeg methodsFor: 'as yet unclassified' stamp: 'jb 5/27/2023 16:37:51'!
affectNetTransfer: netTransfer 
	^netTransfer  - self value .! !


!ExtractionLeg methodsFor: 'account summary' stamp: 'lp 5/29/2023 11:55:06'!
affectAccountSummary: anAccountSummary 
	^anAccountSummary add: 'Salida por Transferencia de ' ,self  value asString ,'.', String crString! !


!ExtractionLeg methodsFor: 'navigate' stamp: 'lp 5/29/2023 11:43:50'!
navigate
	^transferHead depositLeg ! !


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


!Withdraw methodsFor: 'net transfer' stamp: 'jb 5/27/2023 16:41:11'!
affectNetTransfer: netTransfer 
	^netTransfer ! !


!Withdraw methodsFor: 'account summary' stamp: 'lp 5/29/2023 11:55:14'!
affectAccountSummary: anAccountSummary 
	^  anAccountSummary add: 'Extraccion por ' , (self) value asString ,'.', String crString! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'ammount extractionLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'lp 5/29/2023 11:48:32'!
depositLeg
	depositLeg ifNil:[depositLeg:= DepositLeg of: self].
	^depositLeg! !

!Transfer methodsFor: 'initialization' stamp: 'lp 5/29/2023 11:48:38'!
extractedLeg
	extractionLeg ifNil:[extractionLeg := ExtractionLeg of: self].
	^extractionLeg! !

!Transfer methodsFor: 'initialization' stamp: 'lp 5/29/2023 11:48:41'!
initializeWith: anAmmount 
	
	ammount := anAmmount.
	! !

!Transfer methodsFor: 'initialization' stamp: 'lp 5/29/2023 11:48:49'!
value
	^ ammount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initialization' stamp: 'lp 5/29/2023 11:49:27'!
theAmmount: anAmmount from: accountExtracted to: accountDeposit 
	|aTransfer|
	aTransfer := self new initializeWith: anAmmount .
	accountExtracted register: aTransfer extractedLeg.
	accountDeposit register: aTransfer depositLeg.
	^ aTransfer.! !
