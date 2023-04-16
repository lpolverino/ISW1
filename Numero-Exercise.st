!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo negativeOneHalf'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:08:06'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:48'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:09:55'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:04'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:10:25'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:15:37'!
test07FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := Numero with: (Numero with: 7) over: (Numero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:11:26'!
test08FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:16:19'!
test09AparentFraccionesAreEqual

	self assert: oneHalf equals: (Numero with: two over: four)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:12:46'!
test10AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:26:23'!
test11MultiplyingFraccionesCanReturnAnEntero

	self assert: (twoFifth) * (fiveHalfs) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:21'!
test12AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:13:30'!
test13AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:14:16'!
test14NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/24/2020 02:23:47'!
test15NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:29:45'!
test16SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (Numero with: negativeOne over: negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/8/2019 21:30:07'!
test17SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (Numero with: one over: negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'jb 4/16/2023 16:35:23'!
setUp

	zero := Numero with: 0.
	one := Numero with: 1.
	two := Numero with: 2.
	three:= Numero with: 3.
	four := Numero with: 4.
	five := Numero with: 5.
	eight := Numero with: 8.
	negativeOne := Numero with: -1.
	negativeTwo := Numero with: -2.
	
	oneHalf := Numero with: one over: two.
	oneFifth := Numero with: one over: five.
	twoFifth := Numero with: two over: five.
	twoTwentyfifth := Numero with: two over: (Numero with: 25).
	fiveHalfs := Numero with: five over: two.
	negativeOneHalf := Numero with: negativeOne over: two
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: 'type value numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'jb 4/16/2023 16:45:16'!
* aMultiplier 
	^ self * aMultiplier. 		! !

!Numero methodsFor: 'arithmetic operations' stamp: 'jb 4/16/2023 16:45:03'!
+ anAdder 
	^self + anAdder.
! !

!Numero methodsFor: 'arithmetic operations' stamp: 'jb 4/16/2023 17:05:19'!
// aDivisor 	 ^self // aDivisor .
	"
	type = #Entero ifTrue:
		[ ^self class with: value // aDivisor integerValue ].
		
	self error: 'Tipo de número no soportado'"! !

!Numero methodsFor: 'arithmetic operations' stamp: 'jb 4/16/2023 17:25:36'!
greatestCommonDivisorWith: anEntero 
	
	^self greatestCommonDivisorWith: anEntero! !

!Numero methodsFor: 'arithmetic operations' stamp: 'jb 4/16/2023 17:36:58'!
negated	^self negated ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'jb 4/16/2023 17:38:34'!
printOn: aStream	^self printOn:aStream! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/8/2019 21:55:04'!
type
	
	^type! !


!Numero methodsFor: 'testing' stamp: 'jb 4/16/2023 17:31:25'!
isNegative	^self isNegative ! !

!Numero methodsFor: 'testing' stamp: 'jb 4/16/2023 17:34:03'!
isOne	^self isOne ! !

!Numero methodsFor: 'testing' stamp: 'jb 4/16/2023 17:32:54'!
isZero
	^self isZero! !


!Numero methodsFor: 'initialization' stamp: 'jb 4/16/2023 16:55:46'!
initializeWith: aValue
	
	type := #Entero.
	value := aValue! !

!Numero methodsFor: 'initialization' stamp: 'jb 4/16/2023 16:56:07'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	type:=#Racional.
	numerator := aNumerator.
	denominator := aDenominator ! !


!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:46'!
denominator

	^denominator! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:33:53'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !

!Numero methodsFor: 'accessing' stamp: 'NR 9/8/2019 20:59:52'!
numerator

	^numerator! !


!Numero methodsFor: 'comparing' stamp: 'jb 4/16/2023 17:19:20'!
= anObject

	^(anObject isKindOf: self class) and: [ type = anObject type]! !

!Numero methodsFor: 'comparing' stamp: 'jb 4/16/2023 17:28:22'!
hash
	^self hash! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:49:48'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !


!Numero class methodsFor: 'instance creation' stamp: 'jb 4/16/2023 16:34:39'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un  Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^Entero new initializeWith: aValue! !

!Numero class methodsFor: 'instance creation' stamp: 'jb 4/16/2023 16:38:28'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	(aDivisor isNegative )ifTrue: [ ^self with: aDividend negated over: aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 

	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	(denominator isOne) ifTrue: [ ^numerator ].

	^Racional new initializeWith: numerator over: denominator! !


!classDefinition: #Racional category: 'Numero-Exercise'!
Numero subclass: #Racional
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Racional methodsFor: 'nil' stamp: 'jb 4/16/2023 16:27:15'!
* aMultiplier
	  ^self class with: (numerator * aMultiplier numerator) over: (denominator * aMultiplier denominator) 

		
	! !

!Racional methodsFor: 'nil' stamp: 'jb 4/16/2023 16:42:20'!
+ anAdder
	
		| newNumerator newDenominator |
		
		newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
		newDenominator := denominator * anAdder denominator.
		
		^ self class with: newNumerator over: newDenominator .

		
	! !

!Racional methodsFor: 'nil' stamp: 'jb 4/16/2023 17:10:26'!
// aDivisor
	self error: 'Tipo de número no soportado'
	! !

!Racional methodsFor: 'nil' stamp: 'jb 4/16/2023 17:20:05'!
= anObject 
	
		
		^ super = anObject and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Racional methodsFor: 'nil' stamp: 'jb 4/16/2023 17:27:04'!
greatestCommonDivisorWith: anEntero
	self error: 'Tipo de número no soportado'! !

!Racional methodsFor: 'nil' stamp: 'jb 4/16/2023 17:28:06'!
hash
	^(numerator hash / denominator hash) hash! !

!Racional methodsFor: 'nil' stamp: 'jb 4/16/2023 17:31:51'!
isNegative
	^denominator  < 0 ! !

!Racional methodsFor: 'nil' stamp: 'jb 4/16/2023 17:34:36'!
isOne
	^false! !

!Racional methodsFor: 'nil' stamp: 'jb 4/16/2023 17:33:44'!
isZero
	^false! !

!Racional methodsFor: 'nil' stamp: 'jb 4/16/2023 17:36:16'!
negated
	^self class with: numerator * (self class with: -1) over: denominator	! !

!Racional methodsFor: 'nil' stamp: 'jb 4/16/2023 17:38:12'!
printOn:aStream
	aStream 
			print: numerator;
			nextPut: $/;
			print: denominator! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Racional subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 16:32:12'!
* aNumber
	^self class with: value * aNumber integerValue .! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 16:43:09'!
+ anAdder
		 ^self class with: value + anAdder integerValue .! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 17:05:48'!
// aDivisor
	
	^self class with: value // aDivisor integerValue .! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 17:20:24'!
= anObject 
	 ^super = anObject and: [value = anObject integerValue] 
! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 17:27:04'!
greatestCommonDivisorWith: anEntero
		^self class with: (value gcd: anEntero integerValue).! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 17:27:45'!
hash 
	^value hash! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 16:55:08'!
initializeWith: aValue
	type:= #Entero.
	denominator := 1. 
	numerator:= aValue.
	value:= numerator . ! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 16:22:32'!
initializeWithAValue: aValue
	type:= #Entero.
	denominator := 1. 
	numerator:= aValue.
	value:= numerator . ! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 17:32:27'!
isNegative
	^ value < 0 ! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 17:34:14'!
isOne
	^value=1! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 17:34:22'!
isZero
	^value=0.! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 17:36:40'!
negated
	^self * (self class with: -1) ! !

!Entero methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 17:37:39'!
pritnOn: aStream
	aStream print: value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'as yet unclassified' stamp: 'jb 4/16/2023 16:55:17'!
with: anInteger
	^self new initializeWith: anInteger.! !
