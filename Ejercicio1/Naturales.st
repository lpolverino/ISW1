!classDefinition: #I category: 'Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Naturales'!
I class
	instanceVariableNames: 'sucessor'!

!I class methodsFor: 'as yet unclassified' stamp: 'LP 3/29/2023 12:25:43'!
setPrevious: aPrevious
	
	previous := aPrevious! !


!I class methodsFor: 'private' stamp: 'LP 3/29/2023 12:49:35'!
multiplyFrom: aNumber
	
	^aNumber! !

!I class methodsFor: 'private' stamp: 'JFGO 3/25/2023 19:59:30'!
subtractFrom: aNaturalNumber
	^aNaturalNumber previous.! !



!I class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:03:57'!
* aNumber
 	^aNumber ! !

!I class methodsFor: 'operations' stamp: 'JB 3/30/2023 12:49:41'!
+ aNumber
	^aNumber  next ! !

!I class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:29:13'!
> aNumber
	^false! !


!I class methodsFor: 'peano' stamp: 'JB 3/30/2023 13:01:16'!
next 
	sucessor ifNil: [sucessor:= self cloneNamed: self name , 'I'. sucessor  setPredecessor: self ].
	^sucessor! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'LP 3/31/2023 12:31:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucessor := II.! !


!classDefinition: #II category: 'Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Naturales'!
II class
	instanceVariableNames: 'sucessor predecessor'!

!II class methodsFor: 'as yet unclassified' stamp: 'LP 3/29/2023 12:26:34'!
setPrevious: aPrevious
	
	previous := aPrevious! !



!II class methodsFor: 'private auxiliary operations' stamp: 'LP 3/31/2023 12:12:41'!
multiplyFrom: aNumber
	
	^(self * aNumber predecessor) + self
	! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 19:25:46'!
previous
	^previous.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'JFGO 3/25/2023 19:36:52'!
previous: aNaturalNumber
	previous:=aNaturalNumber.! !

!II class methodsFor: 'private auxiliary operations' stamp: 'LP 3/31/2023 12:12:59'!
subtractFrom: aNaturalNumber
	^aNaturalNumber predecessor - self predecessor.! !


!II class methodsFor: 'operations' stamp: 'jb 3/30/2023 20:51:04'!
* aNumber 
	(aNumber  = I) ifTrue:  [^self] . 
	^self + (self* aNumber predecessor)! !

!II class methodsFor: 'operations' stamp: 'JB 3/30/2023 12:59:32'!
+ aNumber
	^self predecessor + aNumber next ! !

!II class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:11:24'!
- aNumber 
	aNumber = I ifTrue: [^self predecessor ].
	^self predecessor  - aNumber  predecessor ! !

!II class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:39:49'!
/ divisor
	
	self  > divisor ifTrue: [self - divisor = I ifTrue:  [^I]. ^I + ((self - divisor) / divisor)].
	^I! !

!II class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:26:10'!
> aNumber
 	aNumber  = I ifTrue:  [^true]. 
	^self predecessor  > aNumber  predecessor ! !

!II class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:02:34'!
predecessor 
	^predecessor! !


!II class methodsFor: 'private' stamp: 'JB 3/30/2023 13:00:35'!
setPredecessor:aNumber
	predecessor:= aNumber ! !


!II class methodsFor: 'peano' stamp: 'jb 3/30/2023 21:41:19'!
next 
	"cambiamos clonedName por createChildNamed y lo que hace es no repetir código
	Esto trae problemas porque cada self crea un child y nosotros queremos que el prototipo sea II. 
	Delegación: No es decirle al prototipo que ejecute, sino decirle prestame el método y yo lo ejecuto.
	"

	sucessor ifNil: [sucessor:= "self" II createChildNamed: self name , 'I'.  sucessor  setPredecessor: self ].
	^sucessor! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'LP 3/31/2023 12:31:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucessor := III.
	predecessor := I.! !


!classDefinition: #III category: 'Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'LP 3/31/2023 12:31:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucessor := IIII.
	predecessor := II.! !


!classDefinition: #IIII category: 'Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'LP 3/31/2023 12:31:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucessor := IIIII.
	predecessor := III.! !


!classDefinition: #IIIII category: 'Naturales'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'LP 3/31/2023 12:31:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucessor := IIIIII.
	predecessor := IIII.! !


!classDefinition: #IIIIII category: 'Naturales'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'LP 3/31/2023 12:31:34'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucessor := nil.
	predecessor := IIIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!