'From Cuis 6.0 [latest update: #5706] on 17 May 2023 at 4:36:27 pm'!
!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolioBalance portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'jb 5/17/2023 15:27:56'!
balance
	^((accounts sum: [:anAccount| anAccount  balance ] ifEmpty: [0 ]) +( portfolios  sum: [:anAccount| anAccount  balance ] ifEmpty: [0 ]) )! !


!Portfolio methodsFor: 'adding' stamp: 'jb 5/17/2023 16:27:44'!
accounts 
	^accounts! !

!Portfolio methodsFor: 'adding' stamp: 'jb 5/17/2023 16:18:40'!
addAccount: anAccount 
	
	(self hasAccount:  anAccount)  ifFalse:  [
			accounts  add: anAccount .
		]ifTrue:[
			self error: self class cannotPutTheSameAccountTwice 
		]! !

!Portfolio methodsFor: 'adding' stamp: 'jb 5/17/2023 16:35:15'!
addPortfolio: aPortfolioToAdd 
	aPortfolioToAdd  accounts do:[:anAccount |
		(self hasAccount: anAccount)  ifTrue:[
				self error: self class cannotPutTheSameAccountTwice 
			]
		]. 
	aPortfolioToAdd  portfolios do: [:anPortfolio|
		(self hasPortfolio:  anPortfolio )  ifTrue:[
				self error: self class cannotPutTheSamePortfolioTwice 
			]
		
		].
	portfolios  add: aPortfolioToAdd ! !

!Portfolio methodsFor: 'adding' stamp: 'jb 5/17/2023 16:16:39'!
hasAccount: anAccount 
	
	accounts detect: [:anAccountsInAccounts|
		anAccountsInAccounts  = anAccount  
		 ] ifFound: [
			^true
		] ifNone: [
		
			portfolios  detect: [:aPortfolio|
					aPortfolio  hasAccount: anAccount 
				]  ifFound: [
					^ true
					]ifNone: [
						^false
			
			]
	]! !

!Portfolio methodsFor: 'adding' stamp: 'jb 5/17/2023 16:32:16'!
hasPortfolio: aPortfolio
	|acc|
	acc := true. 
	portfolios  do: [:aPortfolioFiled |
		aPortfolioFiled  = aPortfolio  ifTrue:[
			acc:= false. 
					] ifFalse:[
				acc := acc and: (aPortfolioFiled  hasPortfolio:  aPortfolio). 
			]
		
		]
	^acc! !

!Portfolio methodsFor: 'adding' stamp: 'jb 5/17/2023 16:27:37'!
portfolios 
	^portfolios! !


!Portfolio methodsFor: 'initializing' stamp: 'jb 5/17/2023 15:26:33'!
initialize 

	accounts  := OrderedCollection  new.	
	portfolios  := OrderedCollection  new. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error handling' stamp: 'jb 5/17/2023 15:02:30'!
cannotPutTheSameAccountTwice
	^'No se pueden poner dos cuentas igualessss' ! !

!Portfolio class methodsFor: 'error handling' stamp: 'jb 5/17/2023 15:30:25'!
cannotPutTheSamePortfolioTwice
	^'no podes hacer eso. error 404 not found, null pointer'! !
