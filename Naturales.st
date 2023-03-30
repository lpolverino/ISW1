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


!I class methodsFor: '--** private fileout/in **--' stamp: 'JB 3/30/2023 13:45:52'!
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

!II class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:05:49'!
* aNumber 
	aNumber  = I ifTrue:  [aNumber *self] . 
	^aNumber predecessor  * (self + self)! !

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


!II class methodsFor: 'peano' stamp: 'JB 3/30/2023 13:01:06'!
next 
	sucessor ifNil: [sucessor:= self cloneNamed: self name , 'I'.  sucessor  setPredecessor: self ].
	^sucessor! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'JB 3/30/2023 13:45:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucessor := III.
	predecessor := I.! !


!classDefinition: #III category: 'Naturales'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Naturales'!
III class
	instanceVariableNames: 'sucessor predecessor'!

!III class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:15'!
* aNumber 
	aNumber  = I ifTrue:  [aNumber *self] . 
	^aNumber predecessor  * (self + self)! !

!III class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:15'!
+ aNumber
	^self predecessor + aNumber next ! !

!III class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:15'!
- aNumber 
	aNumber = I ifTrue: [^self predecessor ].
	^self predecessor  - aNumber  predecessor ! !

!III class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:15'!
/ divisor
	
	self  > divisor ifTrue: [self - divisor = I ifTrue:  [^I]. ^I + ((self - divisor) / divisor)].
	^I! !

!III class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:15'!
> aNumber
 	aNumber  = I ifTrue:  [^true]. 
	^self predecessor  > aNumber  predecessor ! !

!III class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:15'!
predecessor 
	^predecessor! !


!III class methodsFor: 'private' stamp: 'JB 3/30/2023 13:40:15'!
setPredecessor:aNumber
	predecessor:= aNumber ! !


!III class methodsFor: 'peano' stamp: 'JB 3/30/2023 13:40:15'!
next 
	sucessor ifNil: [sucessor:= self cloneNamed: self name , 'I'.  sucessor  setPredecessor: self ].
	^sucessor! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'JB 3/30/2023 13:45:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucessor := IIII.
	predecessor := II.! !


!classDefinition: #IIII category: 'Naturales'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Naturales'!
IIII class
	instanceVariableNames: 'sucessor predecessor'!

!IIII class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:15'!
* aNumber 
	aNumber  = I ifTrue:  [aNumber *self] . 
	^aNumber predecessor  * (self + self)! !

!IIII class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:15'!
+ aNumber
	^self predecessor + aNumber next ! !

!IIII class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:15'!
- aNumber 
	aNumber = I ifTrue: [^self predecessor ].
	^self predecessor  - aNumber  predecessor ! !

!IIII class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:16'!
/ divisor
	
	self  > divisor ifTrue: [self - divisor = I ifTrue:  [^I]. ^I + ((self - divisor) / divisor)].
	^I! !

!IIII class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:16'!
> aNumber
 	aNumber  = I ifTrue:  [^true]. 
	^self predecessor  > aNumber  predecessor ! !

!IIII class methodsFor: 'operations' stamp: 'JB 3/30/2023 13:40:16'!
predecessor 
	^predecessor! !


!IIII class methodsFor: 'private' stamp: 'JB 3/30/2023 13:40:16'!
setPredecessor:aNumber
	predecessor:= aNumber ! !


!IIII class methodsFor: 'peano' stamp: 'JB 3/30/2023 13:40:16'!
next 
	sucessor ifNil: [sucessor:= self cloneNamed: self name , 'I'.  sucessor  setPredecessor: self ].
	^sucessor! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'JB 3/30/2023 13:45:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucessor := nil.
	predecessor := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!