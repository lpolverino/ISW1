!classDefinition: #TestDePerforación category: 'ISW1-2023-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!TestDePerforación methodsFor: 'assertions' stamp: 'lp 5/8/2023 20:25:55'!
assertGolpeRompeMechaDelTaladro:aExcavadora
	
	self should: [aExcavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: aExcavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'assertions' stamp: 'lp 5/8/2023 20:45:04'!
assertSi:aBlock enUnaPerforadoraSinExcavarDa: aExpectedValue

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: aExpectedValue equals: (aBlock value: excavadora)

	! !

!TestDePerforación methodsFor: 'assertions' stamp: 'lp 5/8/2023 20:54:16'!
assertSiLaProfundidaHastaEncontrarUnSueloDeTipo: aCapa nosDaIgualA:aExpectedValue

	^ self assertSi: [:excavadora|  (excavadora calcularProfundidadDelSueloHasta: aCapa new)] enUnaPerforadoraSinExcavarDa: aExpectedValue ! !

!TestDePerforación methodsFor: 'assertions' stamp: 'lp 5/8/2023 20:51:40'!
assertSiLasCapasDeTipo: aCapa nosDaIgualA:expectedTImes

	^ self assertSi: [:excavadora|  (excavadora contarCapas:aCapa new)] enUnaPerforadoraSinExcavarDa: expectedTImes! !

!TestDePerforación methodsFor: 'assertions' stamp: 'lp 5/8/2023 20:35:23'!
assertSueloEsTierraAlImpactarUnaVezConMechaSoft: sueloAExcavar

	| excavadora |
	excavadora := self excavadoraConMechaSoftAExcavar: sueloAExcavar.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !


!TestDePerforación methodsFor: 'excavadora Creation' stamp: 'lp 5/8/2023 20:37:40'!
excavadoraConMechaDiamanteAExcavar: sueloAExacavar
	
	| excavadora |
	excavadora := Perforadora sobreSuelo: sueloAExacavar.
	
	^excavadora ponerMechaDiamante .
	
	
	! !

!TestDePerforación methodsFor: 'excavadora Creation' stamp: 'lp 5/8/2023 20:34:42'!
excavadoraConMechaSoftAExcavar: sueloAExacavar
	
	| excavadora |
	excavadora := Perforadora sobreSuelo: sueloAExacavar.
	
	^excavadora ponerMechaSoft.
	
	
	! !

!TestDePerforación methodsFor: 'excavadora Creation' stamp: 'lp 5/8/2023 20:34:30'!
excavadoraConMechaWidiaAExcavar: sueloAExacavar
	
	| excavadora |
	excavadora := Perforadora sobreSuelo: sueloAExacavar.
	
	^excavadora ponerMechaWidia.
	
	
	! !


!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:30:50'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	self assertSueloEsTierraAlImpactarUnaVezConMechaSoft: sueloAExcavar .
	
	
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:31:00'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	self assertSueloEsTierraAlImpactarUnaVezConMechaSoft: sueloAExcavar 
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:35:50'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.} .
	
	excavadora := self excavadoraConMechaSoftAExcavar: sueloAExcavar .
	
	self assertGolpeRompeMechaDelTaladro: excavadora.
	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 21:48:41'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
			
	
	excavadora := self excavadoraConMechaWidiaAExcavar: sueloAExcavar .
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:36:07'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora :=self excavadoraConMechaWidiaAExcavar: sueloAExcavar .
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: CapaDeSuelo arenoso equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:36:26'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.	
			CapaDeSuelo tierra.
} .
	
	excavadora := self excavadoraConMechaWidiaAExcavar: sueloAExcavar .
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assertGolpeRompeMechaDelTaladro: excavadora.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:37:29'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := self excavadoraConMechaDiamanteAExcavar: sueloAExcavar.
	
	self assertGolpeRompeMechaDelTaladro: excavadora 
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:37:52'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := self excavadoraConMechaDiamanteAExcavar: sueloAExcavar.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo concretoConResistencia: 5) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:37:59'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.
			} .
	
	excavadora := self excavadoraConMechaDiamanteAExcavar: sueloAExcavar.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (CapaDeSuelo concretoConResistencia: 4) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:38:34'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			'Mica'.
			'Marmol'
			} .
	
	excavadora := self excavadoraConMechaSoftAExcavar: sueloAExcavar.
	
	excavadora darGolpeDeTaladro.
	
	self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:38:48'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := self excavadoraConMechaSoftAExcavar: sueloAExcavar.
	
	excavadora darGolpeDeTaladro.
	
	self assert: excavadora elementsInContainer isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:03:09'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: (CapaDeSuelo arenoso) equals: excavadora capaDeSueloInmediata ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 16:46:32'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso} .
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:52:15'!
test14PuedeContarLasCapasDeTipoArenoso
	
	self assertSiLasCapasDeTipo: Arenoso nosDaIgualA:2. 
	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:52:33'!
test15PuedeContarLasCapasDeTipoTierra


	self assertSiLasCapasDeTipo: Tierra nosDaIgualA:1. 

	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:53:06'!
test16PuedeContarLasCapasDeTipoConcreto

	self assertSiLasCapasDeTipo: Concreto nosDaIgualA: 1

	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:55:57'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso


	self assertSiLaProfundidaHastaEncontrarUnSueloDeTipo:Arenoso nosDaIgualA:0

! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:56:28'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	self assertSiLaProfundidaHastaEncontrarUnSueloDeTipo:Tierra  nosDaIgualA: 2

	! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:57:36'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto


	self assertSiLaProfundidaHastaEncontrarUnSueloDeTipo:Concreto  nosDaIgualA: 42! !

!TestDePerforación methodsFor: 'test' stamp: 'lp 5/8/2023 20:10:27'!
test20NoSePuedeTener2CapasIgualesConsecutivas

		| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo arenoso.
			} .
		
	self should: [excavadora := Perforadora sobreSuelo: sueloAExcavar.]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'hay capas iguales conjuntas' equals: unError messageText.].	

	! !


!classDefinition: #CapaDeSuelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: 'tipo resistencia altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeSuelo methodsFor: 'initialization' stamp: 'FRT 5/5/2023 16:08:54'!
initializeArenoso
	
	tipo := #Arenoso.
	altura := nil.! !

!CapaDeSuelo methodsFor: 'initialization' stamp: 'ARM 5/8/2023 13:10:22'!
initializeConcretoConResistencia: resistenciaInicial 

	resistencia := resistenciaInicial.
	tipo := #Concreto.
	altura := nil.! !

!CapaDeSuelo methodsFor: 'initialization' stamp: 'FRT 5/5/2023 16:08:42'!
initializeTierra
	
	tipo := #Tierra.
	altura := nil.! !


!CapaDeSuelo methodsFor: 'tipo' stamp: 'ARM 4/27/2023 20:13:01'!
esArenoso
	^tipo = #Arenoso! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'ARM 4/27/2023 20:15:50'!
esConcreto
	^tipo = #Concreto! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'ARM 4/27/2023 20:14:55'!
esTierra
	^tipo = #Tierra! !


!CapaDeSuelo methodsFor: 'comparing' stamp: 'ARM 5/8/2023 13:10:22'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class) and: [ tipo = unaCapaDeSuelo tipo and: [resistencia = unaCapaDeSuelo resistencia]]! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'ARM 5/8/2023 13:10:22'!
hash

	^tipo hash + resistencia hash! !


!CapaDeSuelo methodsFor: 'impactado' stamp: 'lp 5/8/2023 21:03:35'!
impactar: aPerforadora
	self subclassResponsibility ! !


!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
sinResistencia
	^resistencia = 0! !


!CapaDeSuelo methodsFor: 'accessing' stamp: 'FRT 5/5/2023 16:48:52'!
altura

	^ altura.! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'ARM 5/8/2023 13:10:35'!
resistencia

	^ resistencia.! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:18:41'!
tipo

	^tipo! !


!CapaDeSuelo methodsFor: 'scan' stamp: 'lp 5/8/2023 21:09:45'!
scan
	 self subclassResponsibility ! !


!CapaDeSuelo methodsFor: 'setters' stamp: 'FRT 5/5/2023 16:07:55'!
setAltura: unaAltura

	altura := unaAltura! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'lp 5/8/2023 17:32:50'!
arenoso

	^Arenoso new initializeArenoso! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'lp 5/8/2023 17:33:54'!
concretoConResistencia: resistencia 

	^Concreto new initializeConcretoConResistencia: resistencia ! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'lp 5/8/2023 17:33:24'!
tierra

	^Tierra new initializeTierra! !


!classDefinition: #Arenoso category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Arenoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Arenoso methodsFor: 'scan' stamp: 'lp 5/8/2023 21:09:45'!
scan
	^7! !


!Arenoso methodsFor: 'Impacto' stamp: 'lp 5/8/2023 21:03:36'!
impactar: aPerforadora 
	aPerforadora golpeandoArenoso! !


!classDefinition: #Concreto category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Concreto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Concreto methodsFor: 'impactado' stamp: 'lp 5/8/2023 21:03:36'!
impactar: aPerforadora 
	aPerforadora golpeandoConcreto.! !


!Concreto methodsFor: 'scan' stamp: 'lp 5/8/2023 21:09:45'!
scan
	^50! !


!classDefinition: #Tierra category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #Tierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Tierra methodsFor: 'impactado' stamp: 'lp 5/8/2023 21:03:36'!
impactar: aPerforadora 
	aPerforadora golpeandoTierra! !


!Tierra methodsFor: 'scan' stamp: 'lp 5/8/2023 21:09:45'!
scan
	^10! !


!classDefinition: #Mecha category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Mecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Mecha methodsFor: 'testing' stamp: 'lp 5/8/2023 18:36:05'!
estaRota
	self subclassResponsibility ! !

!Mecha methodsFor: 'testing' stamp: 'lp 5/8/2023 18:52:52'!
hayMecha
	self  subclassResponsibility ! !


!Mecha methodsFor: 'error' stamp: 'lp 5/8/2023 18:21:21'!
mechaRotaMessageError

	^ self error: 'Se rompió'! !


!Mecha methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:03:38'!
impactarCapaArenosa: aPerforadora
	self subclassResponsibility ! !

!Mecha methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:11:15'!
impactarCapaConcreto: aPerforadora
	self subclassResponsibility ! !

!Mecha methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:31:11'!
impactarCapaTierra: aPerforadora
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mecha class' category: 'ISW1-2023-1C-Parcial-1'!
Mecha class
	instanceVariableNames: ''!

!Mecha class methodsFor: 'as yet unclassified' stamp: 'lp 5/8/2023 19:00:27'!
mechaRotaErrorMessage
	^'No se puede perforar ya que la mecha esta rota'! !

!Mecha class methodsFor: 'as yet unclassified' stamp: 'lp 5/8/2023 19:00:08'!
sinMechaErrorMessage
	^'No hay mecha para perforar'! !


!classDefinition: #Diamante category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Diamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Diamante methodsFor: 'testing' stamp: 'lp 5/8/2023 18:36:23'!
estaRota
	^false! !

!Diamante methodsFor: 'testing' stamp: 'lp 5/8/2023 18:54:12'!
hayMecha
	^true! !


!Diamante methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:34:18'!
impactarCapaArenosa: aPerforadora
	aPerforadora sueloArenosoImpactadoPorMechaDiamante.
	"^self mechaRotaMessageError"! !

!Diamante methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:12:24'!
impactarCapaConcreto: aPerforadora
	aPerforadora sueloConcretoImpactadoPorMechaDiamante.
	! !

!Diamante methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:32:00'!
impactarCapaTierra: aPerforadora
	aPerforadora sueloTierraImpactadoPorMechaDiamante .! !


!classDefinition: #Rota category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Rota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Rota methodsFor: 'testing' stamp: 'lp 5/8/2023 18:36:32'!
estaRota
	^true! !

!Rota methodsFor: 'testing' stamp: 'lp 5/8/2023 18:54:18'!
hayMecha
	^true! !


!Rota methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:55:21'!
impactarCapaArenosa: aPerforadora
	Mecha mechaRotaErrorMessage ! !

!Rota methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:55:34'!
impactarCapaConcreto: aPerforadora
	Mecha mechaRotaErrorMessage ! !

!Rota methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:55:28'!
impactarCapaTierra: aPerforadora
	Mecha mechaRotaErrorMessage ! !


!classDefinition: #SinMecha category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #SinMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SinMecha methodsFor: 'testing' stamp: 'lp 5/8/2023 18:55:50'!
estaRota
	^false! !

!SinMecha methodsFor: 'testing' stamp: 'lp 5/8/2023 18:54:26'!
hayMecha
	^false! !


!SinMecha methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:56:05'!
impactarCapaArenosa: aPerforadora
	Mecha sinMechaErrorMessage ! !

!SinMecha methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:56:31'!
impactarCapaConcreto: aPerforadora
	Mecha sinMechaErrorMessage ! !

!SinMecha methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:56:24'!
impactarCapaTierra: aPerforadora
	Mecha sinMechaErrorMessage ! !


!classDefinition: #Soft category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Soft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Soft methodsFor: 'testing' stamp: 'lp 5/8/2023 18:36:38'!
estaRota
	^false! !

!Soft methodsFor: 'testing' stamp: 'lp 5/8/2023 18:54:32'!
hayMecha
	^true! !


!Soft methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:07:43'!
impactarCapaArenosa: aPerforadora
	aPerforadora sueloArenosoImpactadoPorMechaSoft .
! !

!Soft methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:32:34'!
impactarCapaConcreto: aPerforadora
	aPerforadora sueloConcretoImpactadoPorMechaSoft.! !

!Soft methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:32:19'!
impactarCapaTierra: aPerforadora
	aPerforadora sueloTierraImpactadoPorMechaSoft.! !


!classDefinition: #Widia category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #Widia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Widia methodsFor: 'testing' stamp: 'lp 5/8/2023 18:36:43'!
estaRota
	^false! !

!Widia methodsFor: 'testing' stamp: 'lp 5/8/2023 18:54:35'!
hayMecha
	^true! !


!Widia methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:09:30'!
impactarCapaArenosa: aPerforadora
	aPerforadora sueloArenosoImpactadoPorMechaWidia .! !

!Widia methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:33:25'!
impactarCapaConcreto: aPerforadora
	aPerforadora sueloConcretoImpactadoPorMechaWidie ! !

!Widia methodsFor: 'Impacto' stamp: 'lp 5/8/2023 18:33:37'!
impactarCapaTierra: aPerforadora
	aPerforadora sueloTierraImpactadoPorMechaWidie ! !


!classDefinition: #Perforadora category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'tipoDeSuelo mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 5/1/2023 20:07:29'!
pasarAProximaCapa
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self]. 
	(capasDeSueloDebajo first isKindOf: CapaDeSuelo) ifFalse:[
			container addAll: capasDeSueloDebajo.
		]! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 4/27/2023 20:46:30'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: CapaDeSuelo arenoso;
			yourself! !


!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 21:17:39'!
alGolpearTantasVeces: veces hacer: aBlock conLaPerforadora: con 

	^ vecesQueGolpeoCapaActual = veces ifTrue: [aBlock value:con]! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 18:09:38'!
golpeandoArenoso

		mechaPuesta impactarCapaArenosa:self.
	! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 18:39:45'!
golpeandoConcreto
	
		mechaPuesta impactarCapaConcreto: self.
	! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 18:31:23'!
golpeandoTierra
	
	mechaPuesta  impactarCapaTierra: self.
! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 21:17:39'!
golpearDosVecesUnaCapaDeTierraDebeTransformarlaAArenosa

	^ self alGolpearTantasVeces: 2 hacer: [ :aPerfodaroda| aPerfodaroda transformarCapaEnArenoso ] conLaPerforadora:self! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 18:16:24'!
sueloArenosoImpactadoPorMechaDiamante
	^self romperMecha ! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 18:16:30'!
sueloArenosoImpactadoPorMechaSoft
	^ self pasarAProximaCapa ! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 18:16:35'!
sueloArenosoImpactadoPorMechaWidia
	^ self pasarAProximaCapa ! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 18:14:33'!
sueloConcretoImpactadoPorMechaDiamante
	vecesQueGolpeoCapaActual even ifTrue: [ capasDeSueloDebajo first bajaUnDecimoDeResistencia].
			capasDeSueloDebajo first sinResistencia ifTrue: [ ^self transformarCapaEnArenoso].
			^vecesQueGolpeoCapaActual! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 18:16:44'!
sueloConcretoImpactadoPorMechaSoft
	^self romperMecha ! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 21:17:39'!
sueloConcretoImpactadoPorMechaWidie
	
	self alGolpearTantasVeces: 3 hacer: [:aPerfodadora| aPerfodadora romperMecha  ] conLaPerforadora:self .
			^self ! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 18:16:08'!
sueloTierraImpactadoPorMechaDiamante
	self pasarAProximaCapa! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 21:15:16'!
sueloTierraImpactadoPorMechaSoft

	self golpearDosVecesUnaCapaDeTierraDebeTransformarlaAArenosa .
	^self
			! !

!Perforadora methodsFor: 'excavation -private' stamp: 'lp 5/8/2023 21:15:16'!
sueloTierraImpactadoPorMechaWidie
	
	self golpearDosVecesUnaCapaDeTierraDebeTransformarlaAArenosa. 
			^self ! !


!Perforadora methodsFor: 'excavation' stamp: 'lp 5/8/2023 21:19:54'!
darGolpeDeTaladro
		
	self sinMecha ifTrue: [self error: 'No puede perforar'].

	self hacerGolpe. 

	! !

!Perforadora methodsFor: 'excavation' stamp: 'lp 5/8/2023 21:19:54'!
hacerGolpe

	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.

	self capaDeSueloInmediata impactar:self! !


!Perforadora methodsFor: 'assertions Suelo' stamp: 'lp 5/8/2023 21:09:45'!
assertCapasConjuntasNoIguales: capasDeSueloAExcavarInicialmente
|capaAnterior|
	capasDeSueloAExcavarInicialmente do:[:capa| | capaActual|
		capaActual := capa scan.
		capaActual = capaAnterior ifTrue:[^true].
		capaAnterior := capaActual .
		].
	^false! !

!Perforadora methodsFor: 'assertions Suelo' stamp: 'lp 5/8/2023 21:21:06'!
assertSIHayCapasNoIgualesEvitandoLasPiedras: capasDeSueloAExcavarInicialmente

	^ (self assertCapasConjuntasNoIguales: (self extraerPiedrasDelSuelo: capasDeSueloAExcavarInicialmente))  ifTrue:[self error:'hay capas iguales conjuntas']! !

!Perforadora methodsFor: 'assertions Suelo' stamp: 'lp 5/8/2023 20:23:47'!
extraerPiedrasDelSuelo: capasDeSueloAExcavarInicialmente
	^ capasDeSueloAExcavarInicialmente select:[:capa| (capa isKindOf: String) not]! !


!Perforadora methodsFor: 'initialization' stamp: 'lp 5/8/2023 21:21:06'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	self assertSIHayCapasNoIgualesEvitandoLasPiedras: capasDeSueloAExcavarInicialmente. 
	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	container := OrderedCollection new.
	mechaPuesta := SinMecha new.! !


!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:17:21'!
capaDeSueloInmediata
	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'lp 5/8/2023 18:35:50'!
conMechaRota

	^mechaPuesta estaRota.! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:12:20'!
elementsInContainer
	^container asArray! !

!Perforadora methodsFor: 'accessing' stamp: 'lp 5/8/2023 18:59:15'!
sinMecha

	^mechaPuesta hayMecha not.! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:17'!
sobreSueloArenoso
	^capasDeSueloDebajo first esArenoso! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:16:14'!
sobreSueloConcreto
	^capasDeSueloDebajo first esConcreto! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:58'!
sobreSueloTierra
	^capasDeSueloDebajo first esTierra! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'lp 5/8/2023 17:53:48'!
ponerMechaDiamante
	mechaPuesta := Diamante new! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'lp 5/8/2023 17:53:56'!
ponerMechaSoft
	mechaPuesta := Soft new! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'lp 5/8/2023 17:54:03'!
ponerMechaWidia
	mechaPuesta := Widia new! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'lp 5/8/2023 18:27:55'!
romperMecha
	mechaPuesta := Rota new.
	self error: 'Se rompió'! !


!Perforadora methodsFor: 'scan' stamp: 'lp 5/8/2023 19:23:01'!
calcularProfundidadDelSuelo

	^self calcularProfundidadDelSuelo: capasDeSueloDebajo.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'lp 5/8/2023 19:20:35'!
calcularProfundidadDelSuelo:aSuelo

	
	^(aSuelo select:[:capa | (capa altura = nil) not]) sum:[:capa| capa altura] ifEmpty:[^0]
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'lp 5/8/2023 21:27:18'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	| valor acc  |
	
	valor := 0.
	
	valor := tipoDeCapa scan.
	
	acc := 0.
	
	capasDeSueloDebajo do: [:capa | |altura |
		valor = capa scan ifTrue: [ ^ acc ].
		altura := capa altura.
		altura = nil ifTrue: [ altura := 0 ].
		acc := acc + altura.
	].
	  ^ acc
	
! !

!Perforadora methodsFor: 'scan' stamp: 'lp 5/8/2023 21:09:45'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	
	| valor |
	
	valor := 0.
	valor := tipoDeCapa scan .

	^ (capasDeSueloDebajo select:[:capa | valor = capa scan]) size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: 'ISW1-2023-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:07:05'!
sobreSuelo: capasDeSueloAExcavar 

	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !
