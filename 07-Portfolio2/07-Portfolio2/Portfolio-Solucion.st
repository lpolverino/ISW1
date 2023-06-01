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

!ReportTest methodsFor: 'account creation' stamp: 'lp 6/1/2023 13:12:53'!
createAccountWithEveryTransaction: account

Deposit register: 100 on: account. 
Withdraw register: 50 on:account .

Transfer theAmmount: 20 from: account  to: ReceptiveAccount  new .
Transfer theAmmount: 30 from: ReceptiveAccount  new  to: account! !

!ReportTest methodsFor: 'account creation' stamp: 'lp 6/1/2023 14:36:59'!
cuentaDeAngeles

	^ ReceptiveAccount named:  'Cuenta de Angeles'! !

!ReportTest methodsFor: 'account creation' stamp: 'lp 6/1/2023 14:42:25'!
cuentaDeJuan

	^ ReceptiveAccount  named: 'Cuenta de Juan'! !

!ReportTest methodsFor: 'account creation' stamp: 'lp 6/1/2023 14:42:48'!
cuentaMia

	^ ReceptiveAccount named: 'Cuenta mia'! !

!ReportTest methodsFor: 'account creation' stamp: 'jb 6/1/2023 12:51:45'!
receptiveAccountWith100Deposit
|account|
account  := ReceptiveAccount  new. 
	Deposit register: 100 on:  account . 
	^account ! !

!ReportTest methodsFor: 'account creation' stamp: 'jb 6/1/2023 12:54:42'!
receptiveAccountWith100ExitTransfer
|account|
account  := ReceptiveAccount  new. 
	Transfer theAmmount:  100  from:  account  to: ReceptiveAccount  new. 
	^account ! !

!ReportTest methodsFor: 'account creation' stamp: 'jb 6/1/2023 13:00:11'!
receptiveAccountWith100InTransfer
|account|
account  := ReceptiveAccount  new. 
	Transfer theAmmount:  100  from:   ReceptiveAccount  new to: account . 
	^account ! !

!ReportTest methodsFor: 'account creation' stamp: 'jb 6/1/2023 12:53:29'!
receptiveAccountWith100Withdraw
|account|
account  := ReceptiveAccount  new. 
	Withdraw  register:100 on:  account . 
	^account ! !

!ReportTest methodsFor: 'account creation' stamp: 'lp 6/1/2023 15:18:44'!
receptiveAccountWithA100DepositA25WithdrawAndA150InTransfer
|account1    |
account1  := self receptiveAccountWith100Deposit .
Withdraw  register:  25  on: account1 . 
Transfer theAmmount:  150  from:  ReceptiveAccount  new  to: account1.
^account1  
! !

!ReportTest methodsFor: 'account creation' stamp: 'lp 6/1/2023 14:15:50'!
receptiveAccountWithEnterTransferOf100AndExitTransferOf50
|account |
account := self receptiveAccountWith100InTransfer  .
Transfer theAmmount:  50  from:  account to: ReceptiveAccount  new.  
^account
! !


!ReportTest methodsFor: 'account summary private' stamp: 'jb 6/1/2023 12:45:14'!
assertEmptyAccountSummaryReportFor: aReceptiveAccount

self assertIfThisReport:  (OrderedCollection with: 'Balance = 0') isTheAccountSummaryOf: aReceptiveAccount .! !

!ReportTest methodsFor: 'account summary private' stamp: 'lp 5/30/2023 17:07:18'!
assertIfThisReport: response isTheAccountSummaryOf: accountDeposit

	^ self assert: response equals:  (AccountSummary for: accountDeposit ) report! !


!ReportTest methodsFor: 'account summary report creation' stamp: 'jb 6/1/2023 12:52:39'!
accountSummaryReportForReceptiveAccountWith100Deposit

	^ OrderedCollection with: 'Depósito por 100.' with:'Balance = 100'! !

!ReportTest methodsFor: 'account summary report creation' stamp: 'jb 6/1/2023 12:57:44'!
accountSummaryReportForReceptiveAccountWith100ExitTransfer

	^  OrderedCollection with: 'Salida por transferencia de 100.' with:'Balance = -100'.
! !

!ReportTest methodsFor: 'account summary report creation' stamp: 'jb 6/1/2023 12:59:20'!
accountSummaryReportForReceptiveAccountWith100InTransfer

	^  OrderedCollection with: 'Entrada por transferencia de 100.'with:'Balance = 100'.
! !

!ReportTest methodsFor: 'account summary report creation' stamp: 'jb 6/1/2023 12:56:21'!
accountSummaryReportForReceptiveAccountWith100Withdraw

	^ OrderedCollection with: 'Extracción por 100.' with:'Balance = -100'! !

!ReportTest methodsFor: 'account summary report creation' stamp: 'lp 6/1/2023 13:25:01'!
accountSummaryReportForReceptvieAccountWith100DepositAndWithdraw

	^ OrderedCollection with:'Extracción por 100.' with:'Depósito por 100.' with:'Balance = 0'! !

!ReportTest methodsFor: 'account summary report creation' stamp: 'lp 6/1/2023 13:15:07'!
createAccountSummaryForAllTransactions

	^ OrderedCollection with:'Depósito por 100.' with:'Extracción por 50.' with:'Salida por transferencia de 20.' with: 'Entrada por transferencia de 30.' with:'Balance = 60'! !


!ReportTest methodsFor: 'account summary test' stamp: 'jb 6/1/2023 12:45:34'!
test01empyAccountSummaryReportGivesOnlyTheBalance

self assertEmptyAccountSummaryReportFor:  ReceptiveAccount  new.! !

!ReportTest methodsFor: 'account summary test' stamp: 'jb 6/1/2023 12:52:59'!
test02AccountSummaryGivesADeposit

self assertIfThisReport: self accountSummaryReportForReceptiveAccountWith100Deposit  
	isTheAccountSummaryOf:  self receptiveAccountWith100Deposit  ! !

!ReportTest methodsFor: 'account summary test' stamp: 'jb 6/1/2023 12:56:10'!
test03AccountSummaryGivesAWithdraw

self assertIfThisReport: self  accountSummaryReportForReceptiveAccountWith100Withdraw  isTheAccountSummaryOf: self receptiveAccountWith100Withdraw ! !

!ReportTest methodsFor: 'account summary test' stamp: 'jb 6/1/2023 12:58:30'!
test04AccountSummaryGivesAExitTransfer

self assertIfThisReport:  self  accountSummaryReportForReceptiveAccountWith100ExitTransfer 

	 isTheAccountSummaryOf: self receptiveAccountWith100ExitTransfer 
	
	
	
	 
! !

!ReportTest methodsFor: 'account summary test' stamp: 'jb 6/1/2023 13:00:46'!
test05AccountSummaryGivesAInTransfer

self assertIfThisReport: self accountSummaryReportForReceptiveAccountWith100InTransfer 
 isTheAccountSummaryOf: self receptiveAccountWith100InTransfer ! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 6/1/2023 13:15:35'!
test06AccountSummaryGivesMany
|account |
account := ReceptiveAccount  new.

self createAccountWithEveryTransaction: account.

self assert: self createAccountSummaryForAllTransactions equals: (AccountSummary  for: ( account)) report 
! !

!ReportTest methodsFor: 'account summary test' stamp: 'jb 6/1/2023 12:45:55'!
test07emptyPortfolioAccountSumaryGivesBalance0
self assertEmptyAccountSummaryReportFor:  Portfolio  new! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 6/1/2023 13:38:03'!
test08PortfolioWithAnAccountAccountSumary

self assertIfThisReport:
	 self accountSummaryReportForReceptiveAccountWith100Withdraw 
isTheAccountSummaryOf: 
	self portfolioWithReceptiveAccountWithWithdrawOf100 
! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 6/1/2023 13:30:26'!
test09PortfolioWithAnotherPortfolioAccountSumary
self assertIfThisReport: 
	self accountSummaryReportForReceptiveAccountWith100Withdraw
 isTheAccountSummaryOf: 
	(self  portfolioWith: self portfolioWithReceptiveAccountWithWithdrawOf100 )
! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 6/1/2023 13:37:46'!
test10PortfolioWithTwoAccountsAccountSumary
self assertIfThisReport: 
	self accountSummaryReportForReceptvieAccountWith100DepositAndWithdraw 
isTheAccountSummaryOf: 
	self portfolioWithReceptiveAccountWithWithdrawOf100AndDepositOf100.
! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 6/1/2023 13:43:33'!
test11PortfolioWithaPortfolioWithAnotherPortfolioInsideAccountSumary
| portfolio      |
portfolio := self portfolioWithReceptiveAccountWithWithdrawOf100AndDepositOf100 .

portfolio add: (self portfolioWith: Portfolio new).
self assertIfThisReport:
	self accountSummaryReportForReceptvieAccountWith100DepositAndWithdraw 
isTheAccountSummaryOf: 
	portfolio
! !

!ReportTest methodsFor: 'account summary test' stamp: 'lp 6/1/2023 13:43:48'!
test12PortfolioWithPortfolioAndAnAccountGiveCorrectAccountSummary
| portfolio |

portfolio:= self portfolioWith: self receptiveAccountWith100Withdraw .

portfolio add:(self portfolioWith: self receptiveAccountWith100Deposit) .
self assertIfThisReport:
	self accountSummaryReportForReceptvieAccountWith100DepositAndWithdraw 
isTheAccountSummaryOf: 
	portfolio
! !


!ReportTest methodsFor: 'especial report creation' stamp: 'lp 6/1/2023 15:42:06'!
especiaReportParaPortfolioConUnaCuentaConVarasTransacciones

	^ OrderedCollection 
	with:  'Portfolio de la familia'  
		with: String tab, 'Cuenta de Angeles'
			with: String tab,String tab,'Depósito por 100.'  
			with: String tab,String tab,'Entrada por transferencia de 100.'  
			with: String tab,String tab,'Balance = 200'
		 with: String tab, 'Balance = 200'! !

!ReportTest methodsFor: 'especial report creation' stamp: 'lp 6/1/2023 15:31:56'!
especialReportParaPortfolioDeLaFamilia

	^ OrderedCollection  with: 'Portfolio de la familia' with: String tab,'Balance = 0'! !

!ReportTest methodsFor: 'especial report creation' stamp: 'lp 6/1/2023 15:31:11'!
especialReportParaPortfolioDeLaFamiliaConCuentaDeAngeles

	^ OrderedCollection with:  'Portfolio de la familia'  with: String tab, 'Cuenta de Angeles' with: String tab,String tab,'Balance = 0' with: String tab, 'Balance = 0'! !

!ReportTest methodsFor: 'especial report creation' stamp: 'lp 6/1/2023 15:32:36'!
especialReportParaPortfolioDeLaFamiliaConLaCuentaDeAngelesQueTieneUnDepositoDe100

	^ OrderedCollection 
	with:  'Portfolio de la familia'  
		with: String tab, 'Cuenta de Angeles'
			with: String tab,String tab,'Depósito por 100.'  
			with: String tab,String tab,'Balance = 100'
		 with: String tab, 'Balance = 100'! !

!ReportTest methodsFor: 'especial report creation' stamp: 'lp 6/1/2023 15:35:55'!
especialReportParaPortfolioDelaFamiliaConLaCuentaDeAngelesQueTieneUnaEntradaPorTransferenciaPor100

	^ OrderedCollection 
	with:  'Portfolio de la familia'  
		with: String tab, 'Cuenta de Angeles'
			with: String tab,String tab,'Entrada por transferencia de 100.'  
			with: String tab,String tab,'Balance = 100'
		 with: String tab, 'Balance = 100'! !

!ReportTest methodsFor: 'especial report creation' stamp: 'lp 6/1/2023 15:34:05'!
especialReportParaPortfolioDelaFamiliaConLaCuentaDeAngelesQueTieneUnaExtraccionPor100

	^ OrderedCollection 
	with:  'Portfolio de la familia'  
		with: String tab, 'Cuenta de Angeles'
			with: String tab,String tab,'Extracción por 100.'  
			with: String tab,String tab,'Balance = -100'
		 with: String tab, 'Balance = -100'! !

!ReportTest methodsFor: 'especial report creation' stamp: 'lp 6/1/2023 15:35:20'!
especialReportParaPortfolioDelaFamiliaConLaCuentaDeAngelesQueTieneUnaSalidaPorTransferenciaPor100

	^ OrderedCollection 
	with:  'Portfolio de la familia'  
		with: String tab, 'Cuenta de Angeles'
			with: String tab,String tab,'Salida por transferencia de 100.'  
			with: String tab,String tab,'Balance = -100'
		 with: String tab, 'Balance = -100'! !


!ReportTest methodsFor: 'especial report private' stamp: 'lp 6/1/2023 15:24:30'!
especiaReportFor: aPortfolio
 ^(EspecialReport for: aPortfolio )  report! !


!ReportTest methodsFor: 'especial report test' stamp: 'lp 6/1/2023 15:31:57'!
test27PortfolioWithANameShouldReportItsNameAndItsBalance
	self assert: (self especialReportParaPortfolioDeLaFamilia ) 
	 equals:
	(self especiaReportFor: self portfafolioDeLaFamilia ) ! !

!ReportTest methodsFor: 'especial report test' stamp: 'lp 6/1/2023 15:31:35'!
test28PortfolioWithAccountShouldGiveBothOfItsNamesAndBalances

	self assert:
	  self especialReportParaPortfolioDeLaFamiliaConCuentaDeAngeles
	 equals: 
	( self especiaReportFor: self portafolioDeLaFamiliaConCuentaDeAngeles ).  ! !

!ReportTest methodsFor: 'especial report test' stamp: 'lp 6/1/2023 15:33:08'!
test28PortfolioWithAccountWithDepositShouldReportCorrectly
	|portfolio 	angelsAccount |	
	angelsAccount :=  self cuentaDeAngeles. 
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (angelsAccount) .   
	Deposit  register:  100  on: angelsAccount.  

	self assert:  
		self especialReportParaPortfolioDeLaFamiliaConLaCuentaDeAngelesQueTieneUnDepositoDe100 
	equals:
		 (self especiaReportFor: portfolio) ! !

!ReportTest methodsFor: 'especial report test' stamp: 'lp 6/1/2023 15:34:17'!
test29PortfolioWithAccountWithWithdrawShouldReportCorrectly
	|portfolio 	angelsAccount |	
	angelsAccount :=  self cuentaDeAngeles. 
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (angelsAccount) .   
	Withdraw  register:  100  on: angelsAccount.  


	self assert:  self especialReportParaPortfolioDelaFamiliaConLaCuentaDeAngelesQueTieneUnaExtraccionPor100 equals:   (self especiaReportFor: portfolio) ! !

!ReportTest methodsFor: 'especial report test' stamp: 'lp 6/1/2023 15:37:09'!
test30PortfolioWithAccountWithExitTransferShouldReportCorrectly
	|portfolio 	angelsAccount |	
	angelsAccount :=  self cuentaDeAngeles. 
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (angelsAccount) .   
	Transfer  	theAmmount: 100  from:   angelsAccount to: ReceptiveAccount  new.	
	self assert: 
		 self especialReportParaPortfolioDelaFamiliaConLaCuentaDeAngelesQueTieneUnaSalidaPorTransferenciaPor100 
	equals:
	   	(self especiaReportFor: portfolio) ! !

!ReportTest methodsFor: 'especial report test' stamp: 'lp 6/1/2023 15:42:27'!
test31PortfolioWithAccountWithInTransferShouldReportCorrectly
	|portfolio 	angelsAccount |	
	angelsAccount :=  self cuentaDeAngeles. 
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (angelsAccount) .   
	Transfer  	theAmmount: 100  from:   ReceptiveAccount  new to: angelsAccount.	
	self assert: 
	 	self especialReportParaPortfolioDelaFamiliaConLaCuentaDeAngelesQueTieneUnaEntradaPorTransferenciaPor100
	 equals:
	 	 (self especiaReportFor: portfolio) ! !

!ReportTest methodsFor: 'especial report test' stamp: 'lp 6/1/2023 15:43:01'!
test32PortfolioWithAnAccountWithManyTransactionsShouldReportCorrectly
	|portfolio 	angelsAccount |	
	angelsAccount :=  self cuentaDeAngeles. 
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (angelsAccount) .   

	Deposit register:   100 on: angelsAccount .  
	Transfer  	theAmmount: 100  from:   ReceptiveAccount  new to: angelsAccount.


	self assert:
		self especiaReportParaPortfolioConUnaCuentaConVarasTransacciones
	 equals:
	 	(self especiaReportFor: portfolio) ! !

!ReportTest methodsFor: 'especial report test' stamp: 'lp 6/1/2023 15:28:47'!
test33PortfolioWithAnAccountAndAPortfolioShouldMakeTheCorrectEspecialReport
	|portfolio responseCollection|
	portfolio  := Portfolio named: 'Portfolio de la familia' with: (ReceptiveAccount  named:  'Cuenta de Angeles') with: (Portfolio  named:  'Portfolio de los hijos' ).   	responseCollection  := OrderedCollection 
	with: 'Portfolio de la familia' 
		with: String tab, 'Cuenta de Angeles'  
			with:  String tab,String tab, 'Balance = 0' 
		with: String tab,'Portfolio de los hijos' . 
			responseCollection  add:  String tab,  String tab, 'Balance = 0' . 
		responseCollection  add: String tab, 'Balance = 0'.  
	
	self assert: 	responseCollection    equals:  (self especiaReportFor: portfolio) ! !

!ReportTest methodsFor: 'especial report test' stamp: 'lp 6/1/2023 15:28:56'!
test34PortfolioWithAccountsWithTransactionShouldReportCorrectly
	|johnsAccount childrenPortfolio myAccount familyPortfolio responseCollection |
	
	johnsAccount := self cuentaDeJuan. 	Deposit  register:  100 on: johnsAccount . 

	childrenPortfolio := Portfolio  named:'Portfolio de hijos'  with: johnsAccount .
	myAccount := self cuentaMia.	Deposit  register:  100 on:  myAccount .

	familyPortfolio := Portfolio  named: 'Portfolio de la familia' with: childrenPortfolio  with:  myAccount .
	responseCollection := OrderedCollection
	 with: 'Portfolio de la familia'
		 with:  String  tab, 'Portfolio de hijos'
	 		with: String  tab, String  tab,  'Cuenta de Juan'
				with:  String  tab, String  tab,String  tab,  'Depósito por 100.'
				with: String  tab, String  tab, String  tab,'Balance = 100'.
	 		responseCollection  add: String  tab, String  tab,  'Balance = 100'.
	
		responseCollection  add:  String  tab,  'Cuenta mia'.
			responseCollection   add: String  tab,String  tab,  'Depósito por 100.'.
			responseCollection  add:  String  tab, String  tab,'Balance = 100'.
		responseCollection  add:  String  tab,  'Balance = 200'.
	
	self  assert: responseCollection  
	 equals:   (self especiaReportFor: familyPortfolio ) ! !


!ReportTest methodsFor: 'net transfer private' stamp: 'lp 6/1/2023 14:09:45'!
assertIfNetTransferIs0OfTheEmpty:anAccount

	 self assertTheNetTransferOf: anAccount isEqualTo: 0! !

!ReportTest methodsFor: 'net transfer private' stamp: 'lp 5/30/2023 17:24:24'!
assertTheNetTransferOf: anAccount isEqualTo:aNetTransferValue

	^ self assert: aNetTransferValue   equals: (NetTransfer  for: anAccount ) report! !

!ReportTest methodsFor: 'net transfer private' stamp: 'jb 5/30/2023 20:19:24'!
assertTheNetTransferOf: portfolio isEqualToTheNetTransferOf: account

	^ self assert: (NetTransfer  for: account)  report  equals: (NetTransfer  for: portfolio) report! !


!ReportTest methodsFor: 'net transfer test' stamp: 'lp 6/1/2023 14:10:12'!
test13emptyAccountShouldGive0NetTransfer
self assertIfNetTransferIs0OfTheEmpty: ( ReceptiveAccount new).

! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 6/1/2023 14:13:47'!
test14anAccountWithAnOnlyTransferGivesCorrectNetTransfer
self assertTheNetTransferOf: self receptiveAccountWith100InTransfer isEqualTo:100. 

! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 6/1/2023 14:15:14'!
test15AccountWithTwoTransfersGiveCorrectNetTransfer
self assertTheNetTransferOf: self receptiveAccountWithEnterTransferOf100AndExitTransferOf50 isEqualTo: 50. 
! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 6/1/2023 14:10:27'!
test16emptyPortfolioShouldGive0NetTransfer
self assertIfNetTransferIs0OfTheEmpty: Portfolio new.
! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 6/1/2023 14:17:29'!
test17PortfolioWithAnAccountWithTransfersShoulGiveCorrectNetTransfer
self assertTheNetTransferOf:
	 (self portfolioWith: self receptiveAccountWithEnterTransferOf100AndExitTransferOf50)
 isEqualToTheNetTransferOf:
	 self receptiveAccountWithEnterTransferOf100AndExitTransferOf50 
! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 6/1/2023 14:20:25'!
test18PortfolioWithAnInnerPortfolioWithOneAccountShouldGiveCorrectNetTransfer
self assertTheNetTransferOf: 
	(self portfolioWith: (self portfolioWith: self receptiveAccountWithEnterTransferOf100AndExitTransferOf50 )) 
isEqualToTheNetTransferOf:
	 self receptiveAccountWithEnterTransferOf100AndExitTransferOf50 
! !

!ReportTest methodsFor: 'net transfer test' stamp: 'lp 6/1/2023 15:19:24'!
test19PortfolioWithMultiplesAccountAndPortfoliosShouldGiveCorrectNetTransfer


self assertTheNetTransferOf:
	((self portfolioWith: (self portfolioWith: self receptiveAccountWith100ExitTransfer )) add: self receptiveAccountWithA100DepositA25WithdrawAndA150InTransfer  )
isEqualTo: 
	50 
! !


!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 15:07:47'!
crearPortfolioDeLaFamiliaConCuentaMiaYConPortfolioDeLosHijosConCuentaDeJuanYAngeles

	^ self createNamedPortfolio: 'Portfolio de la familia'
					 				with:( self createPortfolioDeLosHijosConCuentaDeJuanYAngeles )
					 				with:  self cuentaMia! !

!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 14:49:02'!
createNamedPortfolio:aPortfolioNamed with:anAccount with:anotherAccount
	^ Portfolio named:aPortfolioNamed with: anAccount with: anotherAccount.   	! !

!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 15:03:03'!
createPortfolioDeFamiliaConPortfolioDeHijosYCnCuentaDeAngeles

	^ self createNamedPortfolio: 'Portfolio de la familia' with: self cuentaDeAngeles with: self portafolioDeLosNiños! !

!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 15:04:54'!
createPortfolioDeFamiliaConPortfolioDeLosHijosQueTienenLaCuentaDeAngeles

	^ Portfolio named: 'Portfolio de la familia' with: (Portfolio  named:  'Portfolio de los hijos' with: (self cuentaDeAngeles ))! !

!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 15:07:05'!
createPortfolioDeLosHijosConCuentaDeJuanYAngeles

	^ self createNamedPortfolio: 'Portfolio de hijos' with:self cuentaDeJuan  with: self cuentaDeAngeles! !

!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 14:37:28'!
portafolioDeLaFamiliaConCuentaDeAngeles

	^ Portfolio named: 'Portfolio de la familia' with: (self cuentaDeAngeles )! !

!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 14:33:28'!
portafolioDeLaFamiliaConPortfolioDeLosHijos

	^ Portfolio named: 'Portfolio de la familia' with: (self portafolioDeLosNiños)! !

!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 14:32:25'!
portafolioDeLosNiños

	^ Portfolio named:  'Portfolio de los hijos'! !

!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 14:30:21'!
portfafolioDeLaFamilia
	|portfolio|
	portfolio  :=Portfolio named: 'Portfolio de la familia'.   
	^portfolio 
	! !

!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 13:28:57'!
portfolioWith: aAccountToAdd
|portfolio  |
portfolio := Portfolio new.
portfolio add: aAccountToAdd .

^portfolio 

! !

!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 13:27:24'!
portfolioWithReceptiveAccountWithWithdrawOf100
|portfolio|
portfolio := Portfolio new.
portfolio  add: self receptiveAccountWith100Withdraw .
^portfolio 

! !

!ReportTest methodsFor: 'portfolio creation' stamp: 'lp 6/1/2023 13:36:08'!
portfolioWithReceptiveAccountWithWithdrawOf100AndDepositOf100
|portfolio|
portfolio := Portfolio new.
portfolio  add: self receptiveAccountWith100Withdraw .
portfolio  add: self receptiveAccountWith100Deposit .
^portfolio 

! !


!ReportTest methodsFor: 'tree report creation' stamp: 'lp 6/1/2023 15:11:00'!
treeReportDelPortfolioDeLaFamilia

	^ OrderedCollection  with: 'Portfolio de la familia'! !

!ReportTest methodsFor: 'tree report creation' stamp: 'lp 6/1/2023 15:15:47'!
treeReportDelPortfolioDeLaFamiliaConCuentaMiaYConPortfolioDeLosHijosConUnaCuentaDeJuanYUnaDeAngeles

	^ OrderedCollection with: 'Portfolio de la familia'
	 									with:  String  tab, 'Portfolio de hijos'
	 									with: String  tab, String  tab,  'Cuenta de Juan'
										with:  String  tab, String  tab,  'Cuenta de Angeles'
										with:  String  tab, 	'Cuenta mia'! !

!ReportTest methodsFor: 'tree report creation' stamp: 'lp 6/1/2023 15:11:35'!
treeReportDelPortfolioDeLaFamiliaConUnPortfolioDeLosHijos

	^ OrderedCollection  with:  'Portfolio de la familia' with: String tab, 'Portfolio de los hijos'! !

!ReportTest methodsFor: 'tree report creation' stamp: 'lp 6/1/2023 15:14:23'!
treeReportDelPortfolioDeLaFamiliaConUnPortfolioDeLosNiñosConUnaCuetaDeAngeles

	^ OrderedCollection  with:'Portfolio de la familia'  with: String tab, 'Portfolio de los hijos'   with: String tab, String tab,'Cuenta de Angeles'! !

!ReportTest methodsFor: 'tree report creation' stamp: 'lp 6/1/2023 15:12:19'!
treeReportDelPortfolioDeLaFamiliaConUnaCuentaDeAngeles

	^ OrderedCollection with:  'Portfolio de la familia'  with: String tab, 'Cuenta de Angeles'! !

!ReportTest methodsFor: 'tree report creation' stamp: 'lp 6/1/2023 15:13:22'!
treeReportDelPortfolioDeLaFamiliaConUnaCuentaDeAngelesYunPortfolioDeLosNiños

	^ OrderedCollection  with: 'Portfolio de la familia' with: String tab, 'Cuenta de Angeles'  with: String tab,'Portfolio de los hijos'! !


!ReportTest methodsFor: 'tree report private' stamp: 'lp 6/1/2023 15:00:38'!
treeReportFor:anAccount
	 	^(TreeReport for:  anAccount )  report! !


!ReportTest methodsFor: 'tree report test' stamp: 'lp 6/1/2023 15:11:00'!
test21PortfolioNamedShouldTellItsName
	self assert: 
		( self treeReportDelPortfolioDeLaFamilia)
	 equals:
		(self treeReportFor: self portfafolioDeLaFamilia).
	! !

!ReportTest methodsFor: 'tree report test' stamp: 'lp 6/1/2023 15:11:35'!
test22PortfolioWithPortfolioShouldMakeTheCorrectReport

	self assert:
		 ( self treeReportDelPortfolioDeLaFamiliaConUnPortfolioDeLosHijos)
	equals:
		(self treeReportFor: self portafolioDeLaFamiliaConPortfolioDeLosHijos).
		 ! !

!ReportTest methodsFor: 'tree report test' stamp: 'lp 6/1/2023 15:12:19'!
test23PortfolioWithAnAccountShouldMakeTheCorrectReport
	self assert: 
		(self treeReportDelPortfolioDeLaFamiliaConUnaCuentaDeAngeles) 
	equals:
		(self treeReportFor: self portafolioDeLaFamiliaConCuentaDeAngeles).! !

!ReportTest methodsFor: 'tree report test' stamp: 'lp 6/1/2023 15:13:38'!
test24PortfolioWithAnAccountAndAPortfolioShouldMakeTheCorrectReport
	self assert: 
		self treeReportDelPortfolioDeLaFamiliaConUnaCuentaDeAngelesYunPortfolioDeLosNiños 
	equals:
		(self treeReportFor: (self createPortfolioDeFamiliaConPortfolioDeHijosYCnCuentaDeAngeles))
	  ! !

!ReportTest methodsFor: 'tree report test' stamp: 'lp 6/1/2023 15:14:47'!
test25PortfolioWithPortfolioWithAccountShouldMakeTheCorrectReport
	
	self assert: 
		self treeReportDelPortfolioDeLaFamiliaConUnPortfolioDeLosNiñosConUnaCuetaDeAngeles 
	equals: 
		(self treeReportFor: self createPortfolioDeFamiliaConPortfolioDeLosHijosQueTienenLaCuentaDeAngeles).! !

!ReportTest methodsFor: 'tree report test' stamp: 'lp 6/1/2023 15:16:14'!
test26PortfolioWithManyAccountsShouldMakeTheCorrectReport
	self  assert: 
		self treeReportDelPortfolioDeLaFamiliaConCuentaMiaYConPortfolioDeLosHijosConUnaCuentaDeJuanYUnaDeAngeles
	 equals: 
	 	(self treeReportFor: self crearPortfolioDeLaFamiliaConCuentaMiaYConPortfolioDeLosHijosConCuentaDeJuanYAngeles )
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


!AccountSummary methodsFor: 'report a transaction' stamp: 'jb 6/1/2023 12:16:28'!
reportDeposit:aDeposit 
	report add: 'Depósito por ', aDeposit  value asString,'.'.! !

!AccountSummary methodsFor: 'report a transaction' stamp: 'jb 6/1/2023 12:22:22'!
reportDepositTransfer: aDepositLeg
	report add: 'Entrada por transferencia de ', aDepositLeg  value asString,'.'.! !

!AccountSummary methodsFor: 'report a transaction' stamp: 'jb 6/1/2023 12:22:03'!
reportExtractionTransfer: aExtracionLeg 
	report add: 'Salida por transferencia de ', aExtracionLeg  value asString,'.'.! !

!AccountSummary methodsFor: 'report a transaction' stamp: 'jb 6/1/2023 12:16:43'!
reportWithdraw: aWithdraw 
	report add: 'Extracción por ', aWithdraw  value asString,'.'.! !


!AccountSummary methodsFor: 'report' stamp: 'jb 6/1/2023 12:13:25'!
report
	report  ifEmpty: [
		super  report .
		].
	
	report add:'Balance = ',  account balance asString .
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


!TreeReport methodsFor: 'report an account' stamp: 'jb 6/1/2023 12:34:38'!
reportPortfolio: aPortfolio 
	self reportTheNameOfTheAccount: aPortfolio 
	 andExecuteTheFolowingBLock: 	[aPortfolio  reportAllAccountsTo:self]. 
	! !

!TreeReport methodsFor: 'report an account' stamp: 'jb 5/31/2023 16:17:09'!
reportReceptiveAccount:  aReceptiveAccount 
		nameHirarchy add: self addTabs ,aReceptiveAccount  name. 
			! !


!TreeReport methodsFor: 'report an account private' stamp: 'jb 6/1/2023 12:34:38'!
reportTheNameOfTheAccount: anAccount andExecuteTheFolowingBLock: aBlockToIndent 
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

!EspecialReport methodsFor: 'report an account' stamp: 'jb 6/1/2023 12:39:45'!
reportPortfolio:aPortfolio
	self reportTheNameOfTheAccount:  aPortfolio 
	 	andExecuteTheFolowingBLock: [aPortfolio  
			reportAllAccountsTo:  self. 
			self reportTheBalanceOf:  aPortfolio ].
! !

!EspecialReport methodsFor: 'report an account' stamp: 'jb 6/1/2023 12:29:22'!
reportReceptiveAccount: aReceptiveAccount 
	self reportTheNameOfTheReceptiveAccountAndReportItsAccountSummaryIndented: aReceptiveAccount! !


!EspecialReport methodsFor: 'report an account private' stamp: 'jb 6/1/2023 12:38:36'!
indentAccountSummaryReportOf: aReceptiveAccount
	^self indent: ((AccountSummary  for:  aReceptiveAccount ) report).! !

!EspecialReport methodsFor: 'report an account private' stamp: 'jb 5/31/2023 22:35:33'!
reportTheBalanceOf: aReceptiveAccount

	^ nameHirarchy add:  self addTabs ,   'Balance = ', aReceptiveAccount  balance  asString! !

!EspecialReport methodsFor: 'report an account private' stamp: 'jb 6/1/2023 12:38:59'!
reportTheNameOfTheReceptiveAccountAndReportItsAccountSummaryIndented: aReceptiveAccount

	self reportTheNameOfTheAccount: aReceptiveAccount  andExecuteTheFolowingBLock: [
		nameHirarchy  addAll:  (self indentAccountSummaryReportOf:  aReceptiveAccount  ).]! !


!EspecialReport methodsFor: 'tabular' stamp: 'jb 6/1/2023 12:11:01'!
indent: aCollectionOfReportMessage
	|aCollection|
	aCollection  := OrderedCollection  new. 
	
	aCollectionOfReportMessage  do:[:aMessage|
		aCollection  add: self addTabs , aMessage .
		
		]. 
	^aCollection 
	! !


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
