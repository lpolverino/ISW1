!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'lp 6/29/2023 14:53:49'!
test01aValidInputStreamIsImportedCorrectlyToTheSession

	CustomerImporter valueFrom: self validImportData into: session..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedWithAddresses ! !

!ImportTest methodsFor: 'tests' stamp: 'lp 6/29/2023 14:48:25'!
test02importWithNilDataRaisesAnError
	self assertSessionIsNotModifyByImporting: self nilImportData
		andRaisesAnErrorWithMessage: CustomerImporter  nilStreamErrorMessage 

! !

!ImportTest methodsFor: 'tests' stamp: 'lp 6/29/2023 14:46:17'!
test03importEmptyDataShouldNotModifySession
	 self assertThatDoesNotModifyTheSessionWhenImportedTheEmptyInput: self emptyImportData  .  


! !

!ImportTest methodsFor: 'tests' stamp: 'lp 6/29/2023 14:46:43'!
test04importDataWithALineJumpShouldNotModifySession
			self assertThatDoesNotModifyTheSessionWhenImportedTheEmptyInput: self importDataWithOnlyALineJump 


! !

!ImportTest methodsFor: 'tests' stamp: 'lp 6/29/2023 14:48:12'!
test05importAnAddressBeforACustomerShouldRaiseAnError
	self assertSessionIsNotModifyByImporting: self importDataWithOnlyAnAdress
		andRaisesAnErrorWithMessage: CustomerImporter  cannotImportAddressWithoutCustomer 







! !

!ImportTest methodsFor: 'tests' stamp: 'lp 6/29/2023 14:51:50'!
test06importDataWithWrongSizedCustomerRecordShouldRaiseAnError
	self assertPepeSanchezWasImportedCorrectlyWithTheInvalidInputStream: self invalidImportDataWrongSizeCustomer
		thenRaisesAnErrorWithMessage: CustomerImporter  notEnoughDataToImport 







! !

!ImportTest methodsFor: 'tests' stamp: 'lp 6/29/2023 14:51:02'!
test07importDataWithWrongSizedAddressShouldRaiseAnError	self assertThatTheFieldsAreImportedUntilAnErrorAppearsWithTheInputStream: self invalidDatawrongSizedAddress 
		raisesAnErrorWithMessage: CustomerImporter  notEnoughDataToImport 







! !

!ImportTest methodsFor: 'tests' stamp: 'lp 6/29/2023 14:51:34'!
test08importDataWithInvalidDataTypeShouldRaiseAnError
	self assertPepeSanchezWasImportedCorrectlyWithTheInvalidInputStream:  self invalidDataWrongType
		thenRaisesAnErrorWithMessage: CustomerImporter  inputTypeNotSupported







! !

!ImportTest methodsFor: 'tests' stamp: 'JB 6/28/2023 18:59:22'!
test09importDataWithWrongAddressNumberShouldRaisAnError 	self assertThatImportsUntilInvalidAddressFieldAndRaisesAnError: self invalidInputWrongAddressNumber 







! !

!ImportTest methodsFor: 'tests' stamp: 'JB 6/28/2023 18:59:22'!
test10importDataWithWrongZipCodeAddressShouldRaiseAnError		self assertThatImportsUntilInvalidAddressFieldAndRaisesAnError:  self invalidInputWrongZipCode






! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'JB 6/28/2023 17:50:05'!
assertJuanPerezWasImported

	^ self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'! !

!ImportTest methodsFor: 'assertions' stamp: 'lp 6/29/2023 14:53:49'!
assertJuanPerezWasImportedWithAddresses

	| importedCustomer |

	importedCustomer := self assertJuanPerezWasImported.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'lp 6/29/2023 15:00:35'!
assertPepeSanchezWasImportedCorrectlyWithTheInvalidInputStream: anInvalidInputStream thenRaisesAnErrorWithMessage: anErrorMessage 

	^self whenImportingTheInvalidStream:  anInvalidInputStream  assert: [ self assertPepeSanchezWasImportedCorrecty.]  andShouldRaisesAnErrorWithMessage: anErrorMessage ! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'lp 6/29/2023 14:59:38'!
assertSessionIsNotModifyByImporting: anInvalidInputStream andRaisesAnErrorWithMessage: anErrorMessage 
	^ self whenImportingTheInvalidStream: anInvalidInputStream assert: [self assert:  self isSessionEmpty  .  		] andShouldRaisesAnErrorWithMessage: anErrorMessage! !

!ImportTest methodsFor: 'assertions' stamp: 'lp 6/29/2023 15:01:08'!
assertThatDoesNotModifyTheSessionWhenImportedTheEmptyInput: aEmptyInputStream

	CustomerImporter valueFrom: aEmptyInputStream into: session. 		
			self assert:  self isSessionEmpty! !

!ImportTest methodsFor: 'assertions' stamp: 'lp 6/29/2023 14:51:02'!
assertThatImportsUntilInvalidAddressFieldAndRaisesAnError: anInvalidInputStream

	^ self  assertThatTheFieldsAreImportedUntilAnErrorAppearsWithTheInputStream:  anInvalidInputStream  raisesAnErrorWithMessage: CustomerImporter   invalidAddressFields! !

!ImportTest methodsFor: 'assertions' stamp: 'lp 6/29/2023 14:59:38'!
assertThatTheFieldsAreImportedUntilAnErrorAppearsWithTheInputStream: invalidInputStream raisesAnErrorWithMessage: messageError 

	self whenImportingTheInvalidStream: invalidInputStream   assert: [ self assertPepeSanchezWasImportedCorrecty.  
				self assertJuanPerezWasImported .] andShouldRaisesAnErrorWithMessage: messageError ! !

!ImportTest methodsFor: 'assertions' stamp: 'JB 6/28/2023 16:37:15'!
isSessionEmpty

	^ (session  selectAllOfType: Customer) isEmpty! !

!ImportTest methodsFor: 'assertions' stamp: 'lp 6/29/2023 15:01:47'!
whenImportingTheInvalidStream: anInvalidInputStream assert: aBlockWithAssertions andShouldRaisesAnErrorWithMessage: anErrorMessage

	^ self  should:  [
		CustomerImporter valueFrom:  anInvalidInputStream  into: session. 				
		] raise: Error
	  withExceptionDo:[:anError|
				self assert: anErrorMessage equals: anError messageText. 
				aBlockWithAssertions  value.
		]! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:27:50'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'lp 6/29/2023 14:46:17'!
emptyImportData

	^ ReadStream  on:  ''! !

!ImportTest methodsFor: 'test data' stamp: 'lp 6/29/2023 14:46:42'!
importDataWithOnlyALineJump

	^ ReadStream  on: '
	'! !

!ImportTest methodsFor: 'test data' stamp: 'lp 6/29/2023 14:47:01'!
importDataWithOnlyAnAdress

	^ ReadStream on:  'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'JB 6/28/2023 18:31:07'!
invalidDataWrongType

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
X,Juan,Perez,C,23-25666777-9'! !

!ImportTest methodsFor: 'test data' stamp: 'JB 6/28/2023 17:48:06'!
invalidDatawrongSizedAddress

	^ ReadStream  on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001'! !

!ImportTest methodsFor: 'test data' stamp: 'lp 6/29/2023 14:49:07'!
invalidImportDataWrongSizeCustomer

	^ ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C'! !

!ImportTest methodsFor: 'test data' stamp: 'JB 6/28/2023 18:43:03'!
invalidInputWrongAddressNumber

	^ ReadStream  on:		'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,xxx,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'JB 6/28/2023 18:42:46'!
invalidInputWrongZipCode

	^ ReadStream  on:		'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,xxx,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'lp 6/29/2023 14:46:04'!
nilImportData
	^nil! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream newCustomer line'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'JB 6/28/2023 16:03:16'!
value
	[ self thereIsRecordsToImport ] whileTrue: [ self importRecord . ].

	! !


!CustomerImporter methodsFor: 'import' stamp: 'lp 6/29/2023 15:04:56'!
checkForInvalidInputType

	^ (self thereIsACustomerToImport  or: (self  thereIsAnAddressToImport or: self isEmptyLine  )) ifFalse:  [
		self error: self class  inputTypeNotSupported
		]! !

!CustomerImporter methodsFor: 'import' stamp: 'lp 6/29/2023 15:06:04'!
importAddress: addressData

	|  newAddress |
			
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			[newAddress streetNumber: addressData third asNumber.
			newAddress zipCode: addressData fifth asNumber
			]on:  Error
			 do:[self error:  self class invalidAddressFields ].
			newAddress town: addressData fourth.
			newAddress province: addressData sixth! !

!CustomerImporter methodsFor: 'import' stamp: 'JB 6/28/2023 16:05:13'!
importCustomer: customerData

	newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer! !

!CustomerImporter methodsFor: 'import' stamp: 'lp 6/29/2023 15:06:35'!
importRecord
	
	self checkForInvalidInputType.
	self importANewCustomerIfItsACustomerRecord.	self importNewAddressIfItsAnAddressRecord.
	! !


!CustomerImporter methodsFor: 'data processing' stamp: 'JB 6/28/2023 16:01:04'!
proccessImportData

	^ line findTokens: $,! !


!CustomerImporter methodsFor: 'import-private' stamp: 'lp 6/29/2023 15:19:36'!
ifTheData:  dataToImport hasExactlyThisAmmountOfFields: anExpectedSizeNumber do: aBlockCollaborationWithData



			 (dataToImport  size = anExpectedSizeNumber ) ifFalse:[
				self error: self class notEnoughDataToImport 
				]
				 ifTrue:[
		
		aBlockCollaborationWithData value: dataToImport  ]! !

!CustomerImporter methodsFor: 'import-private' stamp: 'JB 6/28/2023 17:26:20'!
importANewCustomerIfItsACustomerRecord

	^ (self thereIsACustomerToImport) ifTrue: [
		self importDataIfTheRecordIsOfTheCorrectLenght
	
	]
! !

!CustomerImporter methodsFor: 'import-private' stamp: 'lp 6/29/2023 15:19:49'!
importAddressIfTheRecordIsOfTheCorrectLenght

	self ifTheData:  self proccessImportData  hasExactlyThisAmmountOfFields: 6 do:[:addressData |
		self  importAddress:  addressData 
		] ! !

!CustomerImporter methodsFor: 'import-private' stamp: 'lp 6/29/2023 15:19:36'!
importDataIfTheRecordIsOfTheCorrectLenght

			self  ifTheData:  self  proccessImportData  hasExactlyThisAmmountOfFields: 5   do: 
			[:customerData |
				 self importCustomer:  customerData 
				]
			! !

!CustomerImporter methodsFor: 'import-private' stamp: 'JB 6/28/2023 16:59:51'!
importNewAddressIfItsAnAddressRecord
^ (self thereIsAnAddressToImport ) ifTrue: [ 
	self importNewAddressIfThereWasACustomerimportedBefore 
]! !

!CustomerImporter methodsFor: 'import-private' stamp: 'lp 6/29/2023 15:15:38'!
importNewAddressIfThereWasACustomerimportedBefore

	(self thereIsNotACustomerBeingImported   ) ifTrue: [
		self error:  self class cannotImportAddressWithoutCustomer  
		] ifFalse: [ 
		self importAddressIfTheRecordIsOfTheCorrectLenght
			]! !

!CustomerImporter methodsFor: 'import-private' stamp: 'JB 6/28/2023 18:30:30'!
isEmptyLine

	^( self isReturnCarriegeString) or: (line isEmpty )! !

!CustomerImporter methodsFor: 'import-private' stamp: 'JB 6/28/2023 18:30:30'!
isReturnCarriegeString

	^ line = (String with: $	"09")! !

!CustomerImporter methodsFor: 'import-private' stamp: 'JB 6/28/2023 16:11:30'!
thereIsACustomerToImport

	^ line beginsWith: 'C'! !

!CustomerImporter methodsFor: 'import-private' stamp: 'JB 6/28/2023 16:11:55'!
thereIsAnAddressToImport

	^ line beginsWith: 'A'! !

!CustomerImporter methodsFor: 'import-private' stamp: 'lp 6/29/2023 15:15:38'!
thereIsNotACustomerBeingImported

	^ newCustomer  isNil! !

!CustomerImporter methodsFor: 'import-private' stamp: 'JB 6/28/2023 16:07:06'!
thereIsRecordsToImport

	line := readStream nextLine.
		^line notNil! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'JB 6/28/2023 16:51:38'!
checkForNilStream: aReadStream

	^ aReadStream  ifNil:  [
		self error: self  nilStreamErrorMessage  
		]! !

!CustomerImporter class methodsFor: 'instance creation' stamp: 'JB 6/28/2023 16:52:30'!
from: aReadStream into: aSession	self checkForNilStream: aReadStream. 
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'error message' stamp: 'JB 6/28/2023 16:49:04'!
cannotImportAddressWithoutCustomer
	 ^'cannot import an address without a previuos imported customer'! !

!CustomerImporter class methodsFor: 'error message' stamp: 'JB 6/28/2023 18:05:05'!
inputTypeNotSupported
	^'wrong input type' ! !

!CustomerImporter class methodsFor: 'error message' stamp: 'JB 6/28/2023 18:55:43'!
invalidAddressFields
	^'input not suported' ! !

!CustomerImporter class methodsFor: 'error message' stamp: 'JB 6/28/2023 16:31:51'!
nilStreamErrorMessage
	^'cannot import with  a  nil imput stream' ! !

!CustomerImporter class methodsFor: 'error message' stamp: 'JB 6/28/2023 17:38:29'!
notEnoughDataToImport
	^'The  data wasn´t suficient to be imported in the data base' ! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
