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

!ReportTest methodsFor: 'account summary test' stamp: 'jb 5/30/2023 20:34:11'!
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
	equals: (AccountSummary  for: account  ) report 

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


!ReportTest methodsFor: 'net transfer private' stamp: 'lp 5/30/2023 17:24:24'!
assertTheNetTransferOf: anAccount isEqualTo:aNetTransferValue

	^ self assert: aNetTransferValue   equals: (NetTransfer  for: anAccount ) report! !

!ReportTest methodsFor: 'net transfer private' stamp: 'jb 5/30/2023 20:19:24'!
assertTheNetTransferOf: portfolio isEqualToTheNetTransferOf: account

	^ self assert: (NetTransfer  for: account)  report  equals: (NetTransfer  for: portfolio) report! !


!ReportTest methodsFor: 'account summary private' stamp: 'lp 5/30/2023 17:07:18'!
assertIfThisReport: response isTheAccountSummaryOf: accountDeposit

	^ self assert: response equals:  (AccountSummary for: accountDeposit ) report! !


!ReportTest methodsFor: 'tree report test' stamp: 'jb 5/31/2023 16:41:41'!
test20PortfoilioWithoutANameShouldMakeException

! !

!ReportTest methodsFor: 'tree report test' stamp: 'jb 5/31/2023 16:41:47'!
test21PortfolioNamedShouldTellItsName
	|portfolio|
	portfolio  :=Portfolio named: 'Portfolio de la familia'.   
	self assert: (OrderedCollection  with: 'Portfolio de la familia')  equals: (TreeReport for: portfolio )  report! !

!ReportTest methodsFor: 'tree report test' stamp: 'jb 5/31/2023 16:41:54'!
test22PortfolioWithPortfolioShouldMakeTheCorrectReport
	|portfolio reportCollection |
	portfolio  :=  Portfolio named: 'Portfolio de la familia' with: (Portfolio named:  'Portfolio de los hijos') .   	reportCollection  := OrderedCollection  with:  'Portfolio de la familia' with: String tab, 'Portfolio de los hijos'. 

	self assert: reportCollection  equals: (TreeReport  for:  portfolio  ) report! !

!ReportTest methodsFor: 'tree report test' stamp: 'jb 5/31/2023 16:41:57'!
test23PortfolioWithAnAccountShouldMakeTheCorrectReport
	|portfolio 	reportCollection|
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (ReceptiveAccount named:  'Cuenta de Angeles' ) .   	reportCollection := OrderedCollection with:  'Portfolio de la familia'  with: String tab, 'Cuenta de Angeles'. 


	self assert:  reportCollection equals:  (TreeReport for:  portfolio)  report! !

!ReportTest methodsFor: 'tree report test' stamp: 'jb 5/31/2023 16:42:00'!
test24PortfolioWithAnAccountAndAPortfolioShouldMakeTheCorrectReport
	|portfolio responseCollection|
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (ReceptiveAccount  named:  'Cuenta de Angeles') with: (Portfolio  named:  'Portfolio de los hijos' ).   	responseCollection  := OrderedCollection  with: 'Portfolio de la familia' with: String tab, 'Cuenta de Angeles'  with: String tab,'Portfolio de los hijos'   .

	self assert: 	responseCollection    equals:  ( TreeReport  for:portfolio  ) report! !

!ReportTest methodsFor: 'tree report test' stamp: 'jb 5/31/2023 16:42:04'!
test25PortfolioWithPortfolioWithAccountShouldMakeTheCorrectReport
	|portfolio  responseCollection|
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (Portfolio  named:  'Portfolio de los hijos' with: (ReceptiveAccount  named: 'Cuenta de Angeles')).   	responseCollection  := OrderedCollection  with:'Portfolio de la familia'  with: String tab, 'Portfolio de los hijos'   with: String tab, String tab,'Cuenta de Angeles' .


	self assert: responseCollection   equals: (TreeReport  for: portfolio ) report ! !

!ReportTest methodsFor: 'tree report test' stamp: 'jb 5/31/2023 16:42:08'!
test26PortfolioWithManyAccountsShouldMakeTheCorrectReport
	|johnsAccount angiesAccount childrenPortfolio myAccount familyPortfolio responseCollection |
	
	johnsAccount := ReceptiveAccount  named: 'Cuenta de Juan'. 
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio  named:'Portfolio de hijos'  with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio  named: 'Portfolio de la familia' with: childrenPortfolio  with:  myAccount .
	responseCollection := OrderedCollection with: 'Portfolio de la familia'
	 with:  String  tab, 'Portfolio de hijos'
	  with: String  tab, String  tab,  'Cuenta de Juan'
	 with:  String  tab, String  tab,  'Cuenta de Angeles'
	 with:  String  tab, 	'Cuenta mia'.

	
	self  assert: responseCollection  
	 equals:  (TreeReport  for: familyPortfolio ) report. 
! !


!ReportTest methodsFor: 'especial report test' stamp: 'jb 5/31/2023 17:19:04'!
test27PortfolioWithANameShouldReportItsNameAndItsBalance
	|portfolio|
	portfolio  :=Portfolio named: 'Portfolio de la familia'.   
	self assert: (OrderedCollection  with: 'Portfolio de la familia' with: String tab,'Balance = 0' )  equals: (EspecialReport for: portfolio )  report! !

!ReportTest methodsFor: 'especial report test' stamp: 'jb 5/31/2023 17:18:54'!
test28PortfolioWithAccountShouldGiveBothOfItsNamesAndBalances
	|portfolio 	reportCollection|
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (ReceptiveAccount named:  'Cuenta de Angeles' ) .   	reportCollection := OrderedCollection with:  'Portfolio de la familia'  with: String tab, 'Cuenta de Angeles' with: String tab,String tab,'Balance = 0' with: String tab, 'Balance = 0'
	
	. 


	self assert:  reportCollection equals:  (EspecialReport  for:  portfolio)  report! !

!ReportTest methodsFor: 'especial report test' stamp: 'jb 5/31/2023 17:33:31'!
test28PortfolioWithAccountWithDepositShouldReportCorrectly
	|portfolio 	reportCollection angelsAccount |	
	angelsAccount :=  ReceptiveAccount named:  'Cuenta de Angeles'. 
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (angelsAccount) .   
	Deposit  register:  100  on: angelsAccount.  	
	reportCollection := OrderedCollection 
	with:  'Portfolio de la familia'  
		with: String tab, 'Cuenta de Angeles'
			with: String tab,String tab,'Depósito por 100'  
			with: String tab,String tab,'Balance = 100'
		 with: String tab, 'Balance = 100'. 


	self assert:  reportCollection equals:  (EspecialReport  for:  portfolio)  report! !

!ReportTest methodsFor: 'especial report test' stamp: 'jb 5/31/2023 17:57:11'!
test29PortfolioWithAccountWithWithdrawShouldReportCorrectly
	|portfolio 	reportCollection angelsAccount |	
	angelsAccount :=  ReceptiveAccount named:  'Cuenta de Angeles'. 
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (angelsAccount) .   
	Withdraw  register:  100  on: angelsAccount.  	
	reportCollection := OrderedCollection 
	with:  'Portfolio de la familia'  
		with: String tab, 'Cuenta de Angeles'
			with: String tab,String tab,'Extracción por 100'  
			with: String tab,String tab,'Balance = -100'
		 with: String tab, 'Balance = -100'. 


	self assert:  reportCollection equals:  (EspecialReport  for:  portfolio)  report! !

!ReportTest methodsFor: 'especial report test' stamp: 'jb 5/31/2023 18:17:51'!
test30PortfolioWithAccountWithExitTransferShouldReportCorrectly
	|portfolio 	reportCollection angelsAccount |	
	angelsAccount :=  ReceptiveAccount named:  'Cuenta de Angeles'. 
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (angelsAccount) .   
	Transfer  	theAmmount: 100  from:   angelsAccount to: ReceptiveAccount  new.	
	reportCollection := OrderedCollection 
	with:  'Portfolio de la familia'  
		with: String tab, 'Cuenta de Angeles'
			with: String tab,String tab,'Salida por extracción de 100'  
			with: String tab,String tab,'Balance = -100'
		 with: String tab, 'Balance = -100'. 


	self assert:  reportCollection equals:  (EspecialReport  for:  portfolio)  report! !

!ReportTest methodsFor: 'especial report test' stamp: 'jb 5/31/2023 18:16:38'!
test31PortfolioWithAccountWithInTransferShouldReportCorrectly
	|portfolio 	reportCollection angelsAccount |	
	angelsAccount :=  ReceptiveAccount named:  'Cuenta de Angeles'. 
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (angelsAccount) .   
	Transfer  	theAmmount: 100  from:   ReceptiveAccount  new to: angelsAccount.	
	reportCollection := OrderedCollection 
	with:  'Portfolio de la familia'  
		with: String tab, 'Cuenta de Angeles'
			with: String tab,String tab,'Entrada por depósito de 100'  
			with: String tab,String tab,'Balance = 100'
		 with: String tab, 'Balance = 100'. 


	self assert:  reportCollection equals:  (EspecialReport  for:  portfolio)  report! !

!ReportTest methodsFor: 'especial report test' stamp: 'jb 5/31/2023 18:22:01'!
test32PortfolioWithAnAccountWithManyTransactionsShouldReportCorrectly
	|portfolio 	reportCollection angelsAccount |	
	angelsAccount :=  ReceptiveAccount named:  'Cuenta de Angeles'. 
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (angelsAccount) .   

	Deposit register:   100 on: angelsAccount .  
	Transfer  	theAmmount: 100  from:   ReceptiveAccount  new to: angelsAccount.	
	reportCollection := OrderedCollection 
	with:  'Portfolio de la familia'  
		with: String tab, 'Cuenta de Angeles'
			with: String tab,String tab,'Depósito por 100'  
			with: String tab,String tab,'Entrada por depósito de 100'  
			with: String tab,String tab,'Balance = 200'
		 with: String tab, 'Balance = 200'. 


	self assert:  reportCollection equals:  (EspecialReport  for:  portfolio)  report! !

!ReportTest methodsFor: 'especial report test' stamp: 'jb 5/31/2023 18:29:27'!
test33PortfolioWithAnAccountAndAPortfolioShouldMakeTheCorrectEspecialReport
	|portfolio responseCollection|
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (ReceptiveAccount  named:  'Cuenta de Angeles') with: (Portfolio  named:  'Portfolio de los hijos' ).   	responseCollection  := OrderedCollection 
	with: 'Portfolio de la familia' 
		with: String tab, 'Cuenta de Angeles'  
			with:  String tab,String tab, 'Balance = 0' 
		with: String tab,'Portfolio de los hijos' . 
			responseCollection  add:  String tab,  String tab, 'Balance = 0' . 
		responseCollection  add: String tab, 'Balance = 0'.  
	
	self assert: 	responseCollection    equals:  ( EspecialReport  for:portfolio  ) report! !

!ReportTest methodsFor: 'especial report test' stamp: 'jb 6/1/2023 11:11:48'!
test34PortfolioWithAccountsWithTransactionShouldReportCorrectly
	|johnsAccount childrenPortfolio myAccount familyPortfolio responseCollection |
	
	johnsAccount := ReceptiveAccount  named: 'Cuenta de Juan'. 	Deposit  register:  100 on: johnsAccount . 

	childrenPortfolio := Portfolio  named:'Portfolio de hijos'  with: johnsAccount .
	myAccount := ReceptiveAccount named: 'Cuenta mia'.	Deposit  register:  100 on:  myAccount .

	familyPortfolio := Portfolio  named: 'Portfolio de la familia' with: childrenPortfolio  with:  myAccount .
	responseCollection := OrderedCollection
	 with: 'Portfolio de la familia'
		 with:  String  tab, 'Portfolio de hijos'
	 		with: String  tab, String  tab,  'Cuenta de Juan'
				with:  String  tab, String  tab,String  tab,  'Depósito por 100'
				with: String  tab, String  tab, String  tab,'Balance = 100'.
	 		responseCollection  add: String  tab, String  tab,  'Balance = 100'.
	
		responseCollection  add:  String  tab,  'Cuenta mia'.
			responseCollection   add: String  tab,String  tab,  'Depósito por 100'.
			responseCollection  add:  String  tab, String  tab,'Balance = 100'.
		responseCollection  add:  String  tab,  'Balance = 200'.
	
	self  assert: responseCollection  
	 equals:  (EspecialReport  for: familyPortfolio ) report. ! !


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
	instanceVariableNames: 'accounts parents nameForThePortfolio'
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

!Portfolio methodsFor: 'initialization' stamp: 'jb 5/31/2023 14:36:10'!
initializeNamed: aNameForThePortfolio 
	
	nameForThePortfolio := aNameForThePortfolio.! !


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


!Portfolio methodsFor: 'report' stamp: 'jb 5/31/2023 14:39:36'!
name 
	^ nameForThePortfolio ! !

!Portfolio methodsFor: 'report' stamp: 'jb 5/31/2023 15:24:20'!
reportAllAccountsTo: aReport 
	accounts do: [ :anAccount |
		  anAccount  reportTo: aReport 
		
		] .! !

!Portfolio methodsFor: 'report' stamp: 'jb 5/31/2023 15:20:13'!
reportTo: aReport 	aReport  reportPortfolio: self. 
	! !

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


!Portfolio class methodsFor: 'instance creation' stamp: 'jb 5/31/2023 14:35:53'!
named: aNameForThePortfolio 
	^self new initializeNamed: aNameForThePortfolio ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'jb 5/31/2023 14:42:18'!
named: aNameForThePortfolio with: anAccount 
	
	^(self new initializeNamed: aNameForThePortfolio  )  add: anAccount ! !

!Portfolio class methodsFor: 'instance creation' stamp: 'jb 5/31/2023 16:01:59'!
named: aNameForThePortfolio with: anAccount with: anotherAccount 
	^ (self named:  aNameForThePortfolio  with: anAccount ) add:anotherAccount

	! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions nameForTheReceptiveAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'jb 5/31/2023 15:45:43'!
initializeNamed: aNameForTheReceptiveAccount 
	nameForTheReceptiveAccount := aNameForTheReceptiveAccount.! !


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


!ReceptiveAccount methodsFor: 'report' stamp: 'jb 5/31/2023 15:52:10'!
name 
	^nameForTheReceptiveAccount ! !

!ReceptiveAccount methodsFor: 'report' stamp: 'jb 5/31/2023 15:55:27'!
reportAllTransactionsTo: anAccountSummary 
	transactions  do:[:aTransaction|
		aTransaction  reportTo:  anAccountSummary 
		]! !

!ReceptiveAccount methodsFor: 'report' stamp: 'jb 5/31/2023 15:48:48'!
reportTo: aReport 	aReport reportReceptiveAccount:  self. 

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'jb 5/31/2023 15:45:31'!
named: aNameForTheReceptiveAccount 

	^self new initializeNamed: aNameForTheReceptiveAccount ! !


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


!AccountTransaction methodsFor: 'report' stamp: 'jb 5/30/2023 20:39:16'!
reportTo: aReport
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


!Deposit methodsFor: 'report' stamp: 'jb 5/30/2023 20:26:11'!
reportTo: anAccountSummary 
	anAccountSummary reportDeposit:   self.! !

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

!TransferLegs methodsFor: 'navigate' stamp: 'lp 5/29/2023 11:43:18'!
navigate
	self subclassResponsibility .! !


!TransferLegs methodsFor: 'value' stamp: 'jb 5/27/2023 14:34:53'!
value 
	^ transferHead  value ! !


!TransferLegs methodsFor: 'initializing' stamp: 'lp 5/25/2023 15:44:54'!
initializeWith: aTransferHead

	transferHead := aTransferHead 
	! !

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


!DepositLeg methodsFor: 'report' stamp: 'jb 5/30/2023 20:27:36'!
reportTo: anAccountSummary 
	anAccountSummary  reportDepositTransfer:  self! !


!DepositLeg methodsFor: 'balance' stamp: 'jb 5/31/2023 14:30:04'!
affectBalance: aBalance

	^aBalance + self value ! !


!classDefinition: #ExtractionLeg category: 'Portfolio-Solucion'!
TransferLegs subclass: #ExtractionLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ExtractionLeg methodsFor: 'navigate' stamp: 'lp 5/29/2023 11:43:50'!
navigate
	^transferHead depositLeg ! !


!ExtractionLeg methodsFor: 'report' stamp: 'jb 5/30/2023 20:27:10'!
reportTo: anAccountSummary 
	anAccountSummary  reportExtractionTransfer:  self! !


!ExtractionLeg methodsFor: 'balance' stamp: 'jb 5/31/2023 14:30:33'!
affectBalance: aBalance

	^aBalance - self  value ! !


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


!Withdraw methodsFor: 'report' stamp: 'jb 5/30/2023 20:26:44'!
reportTo: anAccountSummary 
	anAccountSummary  reportWithdraw:  self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account nameHirarchy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'initializing' stamp: 'jb 5/30/2023 19:52:05'!
initializeFor: anAccount
	account  := anAccount ! !


!Report methodsFor: 'report a transaction' stamp: 'jb 5/30/2023 20:09:51'!
reportDeposit: aDeposit
	self subclassResponsibility ! !

!Report methodsFor: 'report a transaction' stamp: 'jb 5/30/2023 20:10:52'!
reportDepositTransfer: aDepositTransfer
	self subclassResponsibility ! !

!Report methodsFor: 'report a transaction' stamp: 'jb 5/30/2023 20:10:36'!
reportExtractionTransfer: aExtractionTransfer
	self subclassResponsibility ! !

!Report methodsFor: 'report a transaction' stamp: 'jb 5/30/2023 20:10:12'!
reportWithdraw: aWithdraw
	self subclassResponsibility ! !


!Report methodsFor: 'report' stamp: 'jb 5/30/2023 20:29:58'!
report
	account  reportTo: self! !


!Report methodsFor: 'report an account' stamp: 'jb 6/1/2023 11:14:22'!
reportPortfolio: aPortfolio 
	self subclassResponsibility ! !

!Report methodsFor: 'report an account' stamp: 'jb 6/1/2023 11:14:30'!
reportReceptiveAccount: anReceptiveAccount 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'jb 5/30/2023 20:12:37'!
for: anAccount 
	^self new initializeFor: anAccount 
	! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'jb 5/30/2023 19:49:56'!
initializeFor: aReceptiveAccount 
	super initializeFor:  aReceptiveAccount  . 
	report := OrderedCollection new.! !


!AccountSummary methodsFor: 'report a transaction' stamp: 'jb 5/30/2023 19:55:08'!
reportDeposit:aDeposit 
	report add: 'Deposito por ', aDeposit  value asString,'.'.! !

!AccountSummary methodsFor: 'report a transaction' stamp: 'jb 5/30/2023 19:56:49'!
reportDepositTransfer: aDepositLeg
	report add: 'Entrada por Transferencia de ', aDepositLeg  value asString,'.'.! !

!AccountSummary methodsFor: 'report a transaction' stamp: 'jb 5/30/2023 19:53:58'!
reportExtractionTransfer: aExtracionLeg 
	report add: 'Salida por Transferencia de ', aExtracionLeg  value asString,'.'.! !

!AccountSummary methodsFor: 'report a transaction' stamp: 'jb 5/30/2023 19:54:40'!
reportWithdraw: aWithdraw 
	report add: 'Extraccion por ', aWithdraw  value asString,'.'.! !


!AccountSummary methodsFor: 'report' stamp: 'jb 5/30/2023 20:30:28'!
report
	report  ifEmpty: [
		super  report .
		].
	
	report add:'balance = ',  account balance asString .
	^report
	! !


!AccountSummary methodsFor: 'report an account' stamp: 'jb 6/1/2023 11:15:37'!
reportPortfolio: aPortfolio 
	aPortfolio  reportAllAccountsTo:  self! !

!AccountSummary methodsFor: 'report an account' stamp: 'jb 6/1/2023 11:15:08'!
reportReceptiveAccount: aReceptiveAccount 
	aReceptiveAccount  reportAllTransactionsTo:  self! !


!classDefinition: #NetTransfer category: 'Portfolio-Solucion'!
Report subclass: #NetTransfer
	instanceVariableNames: 'response'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!NetTransfer methodsFor: 'initialization' stamp: 'jb 5/30/2023 19:50:18'!
initializeFor: aReceptiveAccount 
	super  initializeFor:  aReceptiveAccount .
	response := 0.! !


!NetTransfer methodsFor: 'report' stamp: 'jb 5/30/2023 20:30:12'!
report
	 super report .
	^response ! !


!NetTransfer methodsFor: 'report a transaction' stamp: 'lp 5/30/2023 17:44:12'!
reportDeposit: aDeposit 
	! !

!NetTransfer methodsFor: 'report a transaction' stamp: 'jb 5/30/2023 20:06:10'!
reportDepositTransfer: aDepositTransfer 
	response := response + aDepositTransfer  value.! !

!NetTransfer methodsFor: 'report a transaction' stamp: 'jb 5/30/2023 20:06:45'!
reportExtractionTransfer:anExtractionTransfer 
	response := response  - anExtractionTransfer  value! !

!NetTransfer methodsFor: 'report a transaction' stamp: 'lp 5/30/2023 17:44:55'!
reportWithdraw: aWithdraw 
	! !


!NetTransfer methodsFor: 'report an account' stamp: 'jb 6/1/2023 11:16:29'!
reportPortfolio: aPortfolio 
	aPortfolio  reportAllAccountsTo:  self! !

!NetTransfer methodsFor: 'report an account' stamp: 'jb 6/1/2023 11:16:02'!
reportReceptiveAccount: aReceptiveAccount 
	aReceptiveAccount  reportAllTransactionsTo:  self! !


!classDefinition: #TreeReport category: 'Portfolio-Solucion'!
Report subclass: #TreeReport
	instanceVariableNames: 'tabCounter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeReport methodsFor: 'tabular' stamp: 'jb 5/31/2023 16:21:38'!
addTabs
	|tabString|
	tabString := ''.  
	  1  to:  tabCounter do: [:iter|
		tabString  := tabString,String tab.
		].
	^tabString 
	! !


!TreeReport methodsFor: 'initializing' stamp: 'jb 5/31/2023 17:45:43'!
initializeFor: anAccount
	nameHirarchy  := OrderedCollection  new.
	tabCounter  :=0.
	super  initializeFor:  anAccount . 
! !


!TreeReport methodsFor: 'report' stamp: 'jb 5/31/2023 15:33:31'!
report
	  super report. 
	^nameHirarchy  ! !


!TreeReport methodsFor: 'report an account' stamp: 'jb 5/31/2023 22:33:29'!
reportPortfolio: aPortfolio 
	self reportTheNameOfTheAccount: aPortfolio 
	 andIndentTheFolowingBLock: 	[aPortfolio  reportAllAccountsTo:self]. 
	! !

!TreeReport methodsFor: 'report an account' stamp: 'jb 5/31/2023 16:17:09'!
reportReceptiveAccount:  aReceptiveAccount 
		nameHirarchy add: self addTabs ,aReceptiveAccount  name. 
			! !

!TreeReport methodsFor: 'report an account' stamp: 'jb 5/31/2023 22:32:44'!
reportTheNameOfTheAccount: anAccount andIndentTheFolowingBLock: aBlockToIndent 
	nameHirarchy add:  self addTabs, anAccount  name. 
	tabCounter := tabCounter + 1. 
	aBlockToIndent value. 
	tabCounter  :=  tabCounter  - 1. ! !


!classDefinition: #EspecialReport category: 'Portfolio-Solucion'!
TreeReport subclass: #EspecialReport
	instanceVariableNames: 'responseCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!EspecialReport methodsFor: 'report an account' stamp: 'jb 5/31/2023 22:36:22'!
reportPortfolio:aPortfolio
	self reportTheNameOfTheAccount:  aPortfolio 
	 	andIndentTheFolowingBLock: 
		[aPortfolio  reportAllAccountsTo:  self. 
		self reportTheBalanceOf:  aPortfolio ].
! !

!EspecialReport methodsFor: 'report an account' stamp: 'jb 5/31/2023 22:35:33'!
reportReceptiveAccount: aReceptiveAccount 
	self reportTheNameOfTheAccount:  aReceptiveAccount  
	 andIndentTheFolowingBLock: [
		aReceptiveAccount  reportAllTransactionsTo:  self.
		self reportTheBalanceOf: aReceptiveAccount.

		]
! !


!EspecialReport methodsFor: 'report a transaction' stamp: 'jb 5/31/2023 18:12:22'!
reportDeposit: aDeposit 
	self reportTheMessage: 'Depósito por ' withTheAmmountOf: aDeposit ! !

!EspecialReport methodsFor: 'report a transaction' stamp: 'jb 5/31/2023 18:15:36'!
reportDepositTransfer: aDepositLeg 
	self reportTheMessage:  'Entrada por depósito de ' withTheAmmountOf: aDepositLeg! !

!EspecialReport methodsFor: 'report a transaction' stamp: 'jb 5/31/2023 18:12:22'!
reportExtractionTransfer: anExtractionLeg 
	self reportTheMessage:   'Salida por extracción de ' withTheAmmountOf: anExtractionLeg! !

!EspecialReport methodsFor: 'report a transaction' stamp: 'jb 5/31/2023 18:12:22'!
reportWithdraw: aWithdraw 
	self reportTheMessage:  'Extracción por '  withTheAmmountOf: aWithdraw 
! !


!EspecialReport methodsFor: 'report a transaction private' stamp: 'jb 5/31/2023 18:37:38'!
reportTheMessage: aString withTheAmmountOf: aDeposit

	^ nameHirarchy  add: self addTabs , aString ,aDeposit  value  asString! !


!EspecialReport methodsFor: 'report an account private' stamp: 'jb 5/31/2023 22:35:33'!
reportTheBalanceOf: aReceptiveAccount

	^ nameHirarchy add:  self addTabs ,   'Balance = ', aReceptiveAccount  balance  asString! !


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
