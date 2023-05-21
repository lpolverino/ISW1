'From Cuis 6.0 [latest update: #5706] on 21 May 2023 at 6:53:24 pm'!
!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialElement subclass: #Portfolio
	instanceVariableNames: 'financialElements parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'adding' stamp: 'jb 5/21/2023 17:02:43'!
add: aFinancialElementToAdd 
		self checkIfItCanAddThisFinancialElement:  aFinancialElementToAdd . 
		financialElements  add: aFinancialElementToAdd. 
		(aFinancialElementToAdd  isKindOf:  Portfolio ) ifTrue: [
			aFinancialElementToAdd  changeFather: self. 
			]! !

!Portfolio methodsFor: 'adding' stamp: 'jb 5/21/2023 18:16:48'!
changeFather: aPortfolio
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 18:25:36'!
checkIfItCanAddThisFinancialElement: aFinancialElementToAdd
	
	
	(self roots ) do: [:aRoot |
		(aRoot doesAnyOfItsElementsHasAnAccountInCommonWith:  aFinancialElementToAdd notStoppingBy: self) ifTrue: [
			self error: self class cannotAddAlreadyExistingAccount 
		]
	].
	(self doesAnyOfItsElementsHasAnAccountInCommonWith:  aFinancialElementToAdd notStoppingBy: self) ifTrue: [
			self error: self class cannotAddAlreadyExistingAccount 
		]! !

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

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 18:31:44'!
roots
	|collectionOfRoots| 
	collectionOfRoots  := OrderedCollection new. 
 	parents  ifEmpty: [
		collectionOfRoots  add:self .
		^collectionOfRoots 
		].
	parents  do:[:aParent|
		collectionOfRoots  addAll:  aParent  roots. 
		
		]. 
	^collectionOfRoots  ! !

!Portfolio methodsFor: 'adding private' stamp: 'jb 5/21/2023 16:34:08'!
sharesAnAccountWith: aFinancialElement 
	 ^aFinancialElement  doesItHaveAnAccountInCommonWith: self.! !


!Portfolio methodsFor: 'balance' stamp: 'jb 5/20/2023 20:24:52'!
balance
	^ financialElements sum:[:aFinancialElement | aFinancialElement  balance] ifEmpty: [0] ! !


!Portfolio methodsFor: 'initialization' stamp: 'jb 5/21/2023 18:16:48'!
initialize
financialElements  := OrderedCollection new. 
	
parents := OrderedCollection  new. 
! !


!Portfolio methodsFor: 'register' stamp: 'jb 5/20/2023 20:32:36'!
hasRegistered: aRegister 
	^ financialElements  anySatisfy: [:aFinancialElement | aFinancialElement  hasRegistered:  aRegister]
	! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'jb 5/21/2023 18:40:18'!
transactions
	|transactions|
	transactions := OrderedCollection  new. 
	financialElements  do: [:aFinancialElement|
		transactions  addAll:  aFinancialElement  transactions .	
	].
	^transactions ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'lp 5/18/2023 13:24:59'!
cannotAddAlreadyExistingAccount
^'The Account is Already in the Portfolio'! !
