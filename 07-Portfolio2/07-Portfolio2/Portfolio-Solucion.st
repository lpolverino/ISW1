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


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 17:07:18'!
assertIfThisReport: response isTheAccountSummaryOf: accountDeposit

	^ self assert: response equals:  (AccountSummary for: accountDeposit ) report! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 16:14:10'!
test01empyAccountSummaryReportGivesOnlyTheBalance


self assert: (OrderedCollection with: 'balance = 0') equals: (AccountSummary for: ReceptiveAccount new) report
! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 17:07:20'!
test02AccountSummaryGivesADeposit
|account response|
account := ReceptiveAccount  new.
Deposit register: 100 on: account .
response := OrderedCollection with: 'Deposito por 100.' with:'balance = 100'.


self assertIfThisReport: response isTheAccountSummaryOf: account ! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 17:07:19'!
test03AccountSummaryGivesAWithdraw
|account response |
account := ReceptiveAccount  new.
Withdraw register: 100 on: account .
response := OrderedCollection with: 'Extraccion por 100.' with:'balance = -100'.


self assertIfThisReport: response isTheAccountSummaryOf: account ! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 17:07:20'!
test04AccountSummaryGivesAExitTransfer
|accountExtracted accountDeposit response |
accountExtracted := ReceptiveAccount  new.
accountDeposit := ReceptiveAccount new.

Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .

response := OrderedCollection with: 'Salida por Transferencia de 100.' with:'balance = -100'.


self assertIfThisReport: response isTheAccountSummaryOf: accountExtracted 
! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 17:07:19'!
test05AccountSummaryGivesAInTransfer
|accountExtracted accountDeposit response |
accountExtracted := ReceptiveAccount new.
accountDeposit := ReceptiveAccount new.

Transfer theAmmount: 100 from: accountExtracted  to: accountDeposit .

response := OrderedCollection with: 'Entrada por Transferencia de 100.'with:'balance = 100'.


self assertIfThisReport: response isTheAccountSummaryOf: accountDeposit! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 15:53:26'!
test06AccountSummaryGivesMany
|account accountToExtract accountToDeposit response |
account := ReceptiveAccount  new.
accountToExtract := ReceptiveAccount new.
accountToDeposit := ReceptiveAccount new.

Deposit register: 100 on: account. 
Withdraw register: 50 on:account .

Transfer theAmmount: 20 from: account  to: accountToDeposit .
Transfer theAmmount: 30 from: accountToExtract  to: account .

response := OrderedCollection with:'Deposito por 100.' with:'Extraccion por 50.' with:'Salida por Transferencia de 20.' with: 'Entrada por Transferencia de 30.' with:'balance = 60'.


self assert: response
	equals: account accountSummary

! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 17:08:42'!
test07emptyPortfolioAccountSumaryGivesBalance0
|portfolio report|

portfolio := Portfolio new.
report := OrderedCollection  with:'balance = 0'.

self assertIfThisReport: report isTheAccountSummaryOf: portfolio 
! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 17:10:33'!
test08PortfolioWithAnAccountAccountSumary
| portfolio account report|
account := ReceptiveAccount  new.
Withdraw register: 100 on: account .

portfolio := Portfolio new.
portfolio add: account .

report := OrderedCollection with:'Extraccion por 100.' with:
'balance = -100'.
self assertIfThisReport: report isTheAccountSummaryOf: portfolio
! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 17:13:31'!
test09PortfolioWithAnotherPortfolioAccountSumary
|portfolioToAdd portfolio account report |
account := ReceptiveAccount  new.
Withdraw register: 100 on: account .

portfolio := Portfolio new.
portfolioToAdd := Portfolio new.
portfolioToAdd  add: account .
portfolio add: portfolioToAdd .

report:= OrderedCollection with:'Extraccion por 100.' with:'balance = -100'.


self assertIfThisReport: report isTheAccountSummaryOf: portfolio
! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 17:13:40'!
test10PortfolioWithTwoAccountsAccountSumary
| portfolio accountDeposit accountWithDraw report |
accountWithDraw := ReceptiveAccount  new.
Withdraw register: 100 on: accountWithDraw .

accountDeposit := ReceptiveAccount  new.
Deposit register: 10 on: accountDeposit .

portfolio := Portfolio new.
portfolio add: accountWithDraw .
portfolio add: accountDeposit .

report:= OrderedCollection with:'Extraccion por 100.' with:'Deposito por 10.' with:'balance = -90'.

self assertIfThisReport: report isTheAccountSummaryOf: portfolio
! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 17:13:51'!
test11PortfolioWithaPortfolioWithAnotherPortfolioInsideAccountSumary
| portfolio portfolioChild portfolioGrandson accountDeposit accountWithDraw report |
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

report:= OrderedCollection with:'Extraccion por 100.' with:'Deposito por 10.' with:'balance = -90'.

self assertIfThisReport: report isTheAccountSummaryOf: portfolio
! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 5/30/2023 17:14:04'!
test12PortfolioWithPortfolioAndAnAccountGiveCorrectAccountSummary
| portfolio portfolioChild accountDeposit accountWithDraw report |
accountWithDraw := ReceptiveAccount  new.
Withdraw register: 100 on: accountWithDraw .

accountDeposit := ReceptiveAccount  new.
Deposit register: 10 on: accountDeposit .

portfolioChild:=Portfolio new.
portfolio := Portfolio new.

portfolioChild add: accountWithDraw .
portfolio add: accountDeposit .


portfolio add: portfolioChild .
report:= OrderedCollection with:'Deposito por 10.' with:'Extraccion por 100.' with:'balance = -90'.

self assertIfThisReport: report isTheAccountSummaryOf: portfolio
! !


!ReportTest methodsFor: 'net transfer test' stamp: 'lp 5/30/2023 17:24:24'!
assertTheNetTransferOf: anAccount isEqualTo:aNetTransferValue

	^ self assert: aNetTransferValue   equals: (NetTransfer  for: anAccount ) report! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 5/30/2023 17:20:39'!
assertTheNetTransferOf: portfolio isEqualToTheNetTransferOf: account

	^ self assert: account  netTransfer  equals: portfolio netTransfer! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 5/30/2023 17:21:49'!
test13emptyAccountShouldGive0NetTransfer
self assertTheNetTransferOf: ( ReceptiveAccount new) isEqualTo: 0.
! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 5/30/2023 17:28:12'!
test14anAccountWithAnOnlyTransferGivesCorrectNetTransfer
|account |
account := ReceptiveAccount  new. 
Transfer theAmmount:  100  from:  ReceptiveAccount  new  to: account.  
self assertTheNetTransferOf: account isEqualTo:100. 

! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 5/30/2023 17:28:38'!
test15AccountWithTwoTransfersGiveCorrectNetTransfer
|account |
account := ReceptiveAccount  new. 
Transfer theAmmount:  100  from:  ReceptiveAccount  new  to: account.  
Transfer theAmmount:  50  from:  account to: ReceptiveAccount  new.  
self assertTheNetTransferOf: account isEqualTo: 50. 
! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 5/30/2023 17:29:08'!
test16emptyPortfolioShouldGive0NetTransfer
self assertTheNetTransferOf: Portfolio new isEqualTo: 0
! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 5/30/2023 17:20:39'!
test17PortfolioWithAnAccountWithTransfersShoulGiveCorrectNetTransfer
|account portfolio |
account := ReceptiveAccount  new. 
Transfer theAmmount:  100  from:  ReceptiveAccount  new  to: account.  
Transfer theAmmount:  50  from:  account to: ReceptiveAccount  new.
portfolio := Portfolio  new add: account .  

self assertTheNetTransferOf: portfolio isEqualToTheNetTransferOf: account
! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 5/30/2023 17:20:39'!
test18PortfolioWithAnInnerPortfolioWithOneAccountShouldGiveCorrectNetTransfer
|account innerPortfolio  portfolio|
account := ReceptiveAccount  new. 
Transfer theAmmount:  100  from:  ReceptiveAccount  new  to: account.  
Transfer theAmmount:  50  from:  account to: ReceptiveAccount  new.
innerPortfolio  := Portfolio  new add: account .  
portfolio  := Portfolio  new add: innerPortfolio . 
self assertTheNetTransferOf: portfolio isEqualToTheNetTransferOf: account 
! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 5/30/2023 17:29:35'!
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
self assertTheNetTransferOf: portfolio isEqualTo: 50 
! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'accountForExtraction accountForDeposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'setup' stamp: 'lp 5/30/2023 10:47:31'!
setUp
accountForExtraction:= ReceptiveAccount new.
accountForDeposit:=ReceptiveAccount  new.
! !


!TransferTest methodsFor: 'assertions' stamp: 'lp 5/30/2023 11:04:20'!
assertAreEmptyTheTransactionsOfTheAccounts: anCollectionOfAccounts

	anCollectionOfAccounts  do:[: account |
		self assert: (account transactions size = 0 ).	]! !

!TransferTest methodsFor: 'assertions' stamp: 'lp 5/30/2023 10:52:52'!
forTransactionAssert: aBlock

| transaction |
transaction := Transfer theAmmount: 100 from: accountForExtraction  to: accountForDeposit .

aBlock value:transaction .! !


!TransferTest methodsFor: 'testing' stamp: 'lp 5/30/2023 10:56:35'!
test01NewTransfer

Transfer theAmmount: 100 from: accountForExtraction  to: accountForDeposit .

self assert: accountForExtraction balance equals: -100.
self assert: accountForDeposit  balance equals: 100.! !

!TransferTest methodsFor: 'testing' stamp: 'lp 5/30/2023 15:41:25'!
test02hasRegiteredTheTransactionLeg

self forTransactionAssert: [:aTransaction |
	self assert:( accountForExtraction hasRegistered: aTransaction extractedLeg).
	self assert: (accountForDeposit  hasRegistered: aTransaction  depositLeg).
]
! !

!TransferTest methodsFor: 'testing' stamp: 'lp 5/30/2023 10:53:59'!
test03transferAreInTransaction
self forTransactionAssert: [:aTransaction |

	self assert:( accountForExtraction transactions includes: aTransaction extractedLeg).
	self assert: (accountForDeposit transactions includes: aTransaction depositLeg).
]! !

!TransferTest methodsFor: 'testing' stamp: 'lp 5/30/2023 10:54:48'!
test04navDepositLeg

self forTransactionAssert: [:aTransaction |
	self assert:( aTransaction depositLeg navigate) equals: aTransaction extractedLeg .
]! !

!TransferTest methodsFor: 'testing' stamp: 'lp 5/30/2023 10:55:16'!
test05navExtractedLeg
self forTransactionAssert: [:aTransaction |
self assert:( aTransaction extractedLeg navigate) equals: aTransaction depositLeg .]
! !

!TransferTest methodsFor: 'testing' stamp: 'lp 5/30/2023 11:03:36'!
test06MustBePoositive

|aNotPositiveAmmount |

aNotPositiveAmmount := -100.


self should: [Transfer theAmmount: aNotPositiveAmmount from:accountForExtraction  to:accountForDeposit ] 
	raise:Error 
	withExceptionDo:[:anError|
		anError messageText = Transfer notPositiveAmmountProvided.
		self assertAreEmptyTheTransactionsOfTheAccounts: (OrderedCollection with:accountForExtraction with:accountForDeposit)]. 
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


!Portfolio methodsFor: 'reports' stamp: 'lp 5/30/2023 15:57:34'!
accountSummary
|accountSummary|
	accountSummary := OrderedCollection new.
	accountSummary addAll: self calculateAccountSummary .
	accountSummary add: 'balance = ', self balance asString.
	^accountSummary ! !

!Portfolio methodsFor: 'reports' stamp: 'jb 5/28/2023 12:39:06'!
accumulate: anAccumulator andReport: aBlockWithAnAccumulatorAndAAccount  
	^accounts inject:  anAccumulator into: [:anAcc :anAccount |
		aBlockWithAnAccumulatorAndAAccount  value:  anAcc  value:  anAccount 
		]  ! !

!Portfolio methodsFor: 'reports' stamp: 'lp 5/30/2023 15:56:11'!
calculateAccountSummary
	|report|

	report := OrderedCollection new.
	accounts do: [ :anAccount |
		report  addAll:  anAccount  calculateAccountSummary 
		
		] .
	^ report.! !

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


!Portfolio methodsFor: 'report' stamp: 'lp 5/30/2023 17:13:17'!
calculateAccountSummaryFor: anAccountSummary 
	accounts do: [ :anAccount |
		  anAccount  calculateAccountSummaryFor:anAccountSummary 
		
		] .! !

!Portfolio methodsFor: 'report' stamp: 'lp 5/30/2023 17:41:17'!
netTransferFor: aNetTransfer 
	accounts do: [ :anAccount |
		  anAccount  netTransferFor: aNetTransfer 
		
		] .! !

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

!ReceptiveAccount methodsFor: 'reports' stamp: 'lp 5/30/2023 15:45:34'!
calculateAccountSummary
	|response|
	response := OrderedCollection new.
	transactions  do: [:aTransaction | 
		aTransaction reportAccountSummary: response.
		].
	^response! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'lp 5/30/2023 16:42:08'!
calculateAccountSummaryFor: anAccountSummary 
	transactions  do: [:aTransaction | 
		aTransaction reportToAccountSummary:anAccountSummary .
		].
! !

!ReceptiveAccount methodsFor: 'reports' stamp: 'lp 5/30/2023 16:08:54'!
netTransfer

^transactions  inject:0 into: 	[:response :aTransaction | 
	aTransaction reportNetTransfer: response.
	].! !


!ReceptiveAccount methodsFor: 'report' stamp: 'lp 5/30/2023 17:33:41'!
netTransferFor: aNetTransfer 
	
^transactions do: 	[ :aTransaction | 
	aTransaction reportToNetTransfer: aNetTransfer .
	].! !


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

!Deposit methodsFor: 'account Summary' stamp: 'lp 5/30/2023 15:47:11'!
reportAccountSummary: response 
	response  add: 'Deposito por ' , self  value asString ,'.'.! !


!Deposit methodsFor: 'net Transfer' stamp: 'lp 5/30/2023 16:10:40'!
reportNetTransfer: response 
	^0! !


!Deposit methodsFor: 'report' stamp: 'lp 5/30/2023 16:46:34'!
reportToAccountSummary: anAccountSummary 
	anAccountSummary reportThisDepositWith:value.! !

!Deposit methodsFor: 'report' stamp: 'lp 5/30/2023 17:43:26'!
reportToNetTransfer: aNetTransfer 
	aNetTransfer reportDeposit: self.! !

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

!DepositLeg methodsFor: 'account summary' stamp: 'lp 5/30/2023 15:52:19'!
reportAccountSummary: response 
	response  add: 'Entrada por Transferencia de ' , self  value asString ,'.'.! !


!DepositLeg methodsFor: 'netTransfer' stamp: 'lp 5/30/2023 16:08:03'!
reportNetTransfer: response 
	^response + transferHead value! !


!DepositLeg methodsFor: 'report' stamp: 'lp 5/30/2023 16:58:09'!
reportToAccountSummary: anAccountSummary 
	anAccountSummary reportDepositLegWith: transferHead value.! !

!DepositLeg methodsFor: 'report' stamp: 'lp 5/30/2023 17:35:15'!
reportToNetTransfer: aNetTransfer 
	aNetTransfer reportDepositLegWith: transferHead value! !


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

!ExtractionLeg methodsFor: 'account summary' stamp: 'lp 5/30/2023 15:51:48'!
reportAccountSummary: response 
	response  add: 'Salida por Transferencia de ' , self  value asString ,'.'.! !


!ExtractionLeg methodsFor: 'navigate' stamp: 'lp 5/29/2023 11:43:50'!
navigate
	^transferHead depositLeg ! !


!ExtractionLeg methodsFor: 'net Transfer' stamp: 'lp 5/30/2023 16:09:48'!
reportNetTransfer: response 
	^ response - transferHead value.! !


!ExtractionLeg methodsFor: 'report' stamp: 'lp 5/30/2023 16:59:49'!
reportToAccountSummary: anAccountSummary 
	anAccountSummary reportExtractionTransferWith: transferHead value.! !

!ExtractionLeg methodsFor: 'report' stamp: 'lp 5/30/2023 17:39:04'!
reportToNetTransfer: aNetTransfer 
	aNetTransfer reportExtractionLegWith: transferHead value.! !


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

!Withdraw methodsFor: 'net transfer' stamp: 'lp 5/30/2023 16:11:05'!
reportNetTransfer: response 
	^0! !


!Withdraw methodsFor: 'account summary' stamp: 'lp 5/29/2023 11:55:14'!
affectAccountSummary: anAccountSummary 
	^  anAccountSummary add: 'Extraccion por ' , (self) value asString ,'.', String crString! !

!Withdraw methodsFor: 'account summary' stamp: 'lp 5/30/2023 15:51:11'!
reportAccountSummary: response 
	response  add: 'Extraccion por ' , self  value asString ,'.'.! !


!Withdraw methodsFor: 'report' stamp: 'lp 5/30/2023 16:53:35'!
reportToAccountSummary: anAccountSummary 
	anAccountSummary reportThisWithdrawWith: value.! !

!Withdraw methodsFor: 'report' stamp: 'lp 5/30/2023 17:44:36'!
reportToNetTransfer: aNetTransfer 
	aNetTransfer reportWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'receptiveAccount report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'lp 5/30/2023 16:15:49'!
initializeFor: aReceptiveAccount 
	receptiveAccount := aReceptiveAccount.! !


!AccountSummary methodsFor: 'report' stamp: 'lp 5/30/2023 16:45:08'!
report

	report := OrderedCollection new.
	receptiveAccount calculateAccountSummaryFor: self.
	report add:'balance = ',  receptiveAccount balance asString .
	^report
	! !

!AccountSummary methodsFor: 'report' stamp: 'lp 5/30/2023 16:59:10'!
reportDepositLegWith: aDepositLegValue
	report add: 'Entrada por Transferencia de ', aDepositLegValue asString,'.'.! !

!AccountSummary methodsFor: 'report' stamp: 'lp 5/30/2023 16:59:49'!
reportExtractionTransferWith: aExtracionLegValue 
	report add: 'Salida por Transferencia de ', aExtracionLegValue asString,'.'.! !

!AccountSummary methodsFor: 'report' stamp: 'lp 5/30/2023 16:47:52'!
reportThisDepositWith: aValue 
	report add: 'Deposito por ', aValue asString,'.'.! !

!AccountSummary methodsFor: 'report' stamp: 'lp 5/30/2023 16:55:22'!
reportThisWithdrawWith: aValue 
	report add: 'Extraccion por ', aValue asString,'.'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'lp 5/30/2023 16:15:27'!
for: aReceptiveAccount 
	^self new initializeFor: aReceptiveAccount ! !


!classDefinition: #NetTransfer category: 'Portfolio-Solucion'!
Report subclass: #NetTransfer
	instanceVariableNames: 'account response'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!NetTransfer methodsFor: 'initialization' stamp: 'lp 5/30/2023 17:37:18'!
initializeFor: aReceptiveAccount 
	account := aReceptiveAccount.
	response := 0.! !


!NetTransfer methodsFor: 'report' stamp: 'lp 5/30/2023 17:38:21'!
report
	 account netTransferFor: self.
	^response ! !

!NetTransfer methodsFor: 'report' stamp: 'lp 5/30/2023 17:44:12'!
reportDeposit: aDeposit 
	! !

!NetTransfer methodsFor: 'report' stamp: 'lp 5/30/2023 17:36:25'!
reportDepositLegWith: aNetTransferValue 
	response := response + aNetTransferValue .! !

!NetTransfer methodsFor: 'report' stamp: 'lp 5/30/2023 17:39:31'!
reportExtractionLegWith: aNetTransferValue 
	response := response  - aNetTransferValue ! !

!NetTransfer methodsFor: 'report' stamp: 'lp 5/30/2023 17:44:55'!
reportWithdraw: aWithdraw 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NetTransfer class' category: 'Portfolio-Solucion'!
NetTransfer class
	instanceVariableNames: ''!

!NetTransfer class methodsFor: 'instance creation' stamp: 'lp 5/30/2023 17:24:40'!
for: aReceptiveAccount 
	^self new initializeFor: aReceptiveAccount ! !


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


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'ammount extractionLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'private for testing' stamp: 'lp 5/29/2023 11:48:32'!
depositLeg
	depositLeg ifNil:[depositLeg:= DepositLeg of: self].
	^depositLeg! !

!Transfer methodsFor: 'private for testing' stamp: 'lp 5/29/2023 11:48:38'!
extractedLeg
	extractionLeg ifNil:[extractionLeg := ExtractionLeg of: self].
	^extractionLeg! !


!Transfer methodsFor: 'initialization' stamp: 'lp 5/29/2023 11:48:41'!
initializeWith: anAmmount 
	
	ammount := anAmmount.
	! !


!Transfer methodsFor: 'testing' stamp: 'lp 5/29/2023 11:48:49'!
value
	^ ammount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initialization' stamp: 'lp 5/30/2023 10:33:51'!
notPositiveAmmountProvided
	'cannot procced with a transfer that has an not positive ammount '! !

!Transfer class methodsFor: 'initialization' stamp: 'lp 5/30/2023 10:35:06'!
theAmmount: anAmmount from: accountExtracted to: accountDeposit 
	|aTransfer|
	anAmmount >= 0 ifFalse: [self error: self class notPositiveAmmountProvided].
	aTransfer := self new initializeWith: anAmmount .
	accountExtracted register: aTransfer extractedLeg.
	accountDeposit register: aTransfer depositLeg.
	^ aTransfer.! !
