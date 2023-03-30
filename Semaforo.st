!classDefinition: #LuzAmarilla category: 'Semaforo'!
DenotativeObject subclass: #LuzAmarilla
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzAmarilla class' category: 'Semaforo'!
LuzAmarilla class
	instanceVariableNames: ''!

!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 'jb 3/30/2023 19:47:38'!
apagar
	Light color: Color black .! !

!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 'jb 3/30/2023 19:47:53'!
prender
	Light color: Color yellow . ! !


!classDefinition: #LuzRoja category: 'Semaforo'!
DenotativeObject subclass: #LuzRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!


!classDefinition: #LuzVerde category: 'Semaforo'!
DenotativeObject subclass: #LuzVerde
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!


!classDefinition: #SemaforoDeMaipuYCorrientes category: 'Semaforo'!
DenotativeObject subclass: #SemaforoDeMaipuYCorrientes
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SemaforoDeMaipuYCorrientes class' category: 'Semaforo'!
SemaforoDeMaipuYCorrientes class
	instanceVariableNames: ''!

!SemaforoDeMaipuYCorrientes class methodsFor: 'as yet unclassified' stamp: 'jb 3/30/2023 19:34:46'!
avisarPrecauciónPorEncendido

	5 timesRepeat: 	[self titilarLuzAmarilla2]	 
	! !

!SemaforoDeMaipuYCorrientes class methodsFor: 'as yet unclassified' stamp: 'jb 3/30/2023 19:33:51'!
prender
	self avisarPrecauciónPorEncendido. 
	! !

!SemaforoDeMaipuYCorrientes class methodsFor: 'as yet unclassified' stamp: 'jb 3/30/2023 19:27:28'!
titilarLuzAmarilla 
	LuzAmarilla prender.
	(Delay for:0.5 *second ) wait. 
	LuzAmarilla apagar.
	(Delay for:0.5 *second ) wait. 
	! !

!SemaforoDeMaipuYCorrientes class methodsFor: 'as yet unclassified' stamp: 'jb 3/30/2023 19:29:30'!
titilarLuzAmarilla2

	LuzAmarilla prender.
	(Delay for:0.5 *second ) wait. 
	LuzAmarilla apagar.
	(Delay for:0.5 *second ) wait! !


!classDefinition: #Temporizador category: 'Semaforo'!
DenotativeObject subclass: #Temporizador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!


!classDefinition: #Titilante category: 'Semaforo'!
DenotativeObject subclass: #Titilante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!
