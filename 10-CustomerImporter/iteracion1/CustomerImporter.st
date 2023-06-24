!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'test' stamp: 'JB 6/24/2023 13:15:57'!
assertTheAdressesBelongsToTheCustomers

	self assertTheAddresesOfJuanAreInTheDataBase.
	self assertTheAddressesOfPepeAreInTheDataBase! !

!ImportTest methodsFor: 'test' stamp: 'JB 6/24/2023 13:15:57'!
test01ImportCustomersImportsTwoCustomers
	self importCustomers: self  inSession: session .
	self assertSessionHasTwoCustomers. 
	self sessionHasCustomerPepeAndJuan.
	self assertTheAdressesBelongsToTheCustomers

! !


!ImportTest methodsFor: 'import' stamp: 'JB 6/24/2023 13:13:18'!
importCustomers: aStream inSession: aSession
	(ImportCustomers intoTheSession: aSession fromTheStream: aStream) import! !


!ImportTest methodsFor: 'refactorings' stamp: 'JB 6/24/2023 12:28:06'!
isTheAddressLocatedInTheProvince: aProvince streetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode belongsToTheCustomerWIthIdentityNumber: anIdentityNumber identityType: anIdentityType      

	
	^ self deny:( 
		(session  select:  [:aCustomer|
			(aCustomer  hasAnAddressThatitsFromProvince:  aProvince
				streetName:  aStreetName
				streetNumber: aStreetNumber
			 	town: aTown 
			  	zipCode: aZipCode) and: (aCustomer identifyAsNumber:  anIdentityNumber   ofType: anIdentityType ) 
			]
		 ofType: Customer) isEmpty)! !

!ImportTest methodsFor: 'refactorings' stamp: 'JB 6/23/2023 20:01:55'!
sessionHasACustomerWithIdentityNumber: anIdentityNumber andIdentityType: identityType 

	^ ((session  select: [:aCustomer| 
				aCustomer identifyAsNumber:anIdentityNumber ofType: identityType 
				]  ofType: Customer)  isEmpty ) not! !

!ImportTest methodsFor: 'refactorings' stamp: 'JB 6/23/2023 20:07:31'!
sessionHasCustomerPepeAndJuan

	self assert: (self sessionHasACustomerWithIdentityNumber:     '22333444'  andIdentityType: 'D'). 
	self assert:  (self sessionHasACustomerWithIdentityNumber: '23-25666777-9'   andIdentityType:'C' )! !


!ImportTest methodsFor: 'assertions' stamp: 'JB 6/24/2023 12:31:35'!
assertSessionHasTwoCustomers

	^ self assert: 2 equals: (session  selectAllOfType:  Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'JB 6/24/2023 12:30:19'!
assertTheAddresesOfJuanAreInTheDataBase

	self isTheAddressLocatedInTheProvince: 'BsAs' streetName: 'San Martin' streetNumber: 3322 town: 'Olivos' zipCode: 1636 belongsToTheCustomerWIthIdentityNumber: '22333444' identityType: 'D'. 
	self isTheAddressLocatedInTheProvince:  'Buenos Aires'  streetName: 'Maipu'    streetNumber:  888 town:  'Florida' zipCode: 1122 belongsToTheCustomerWIthIdentityNumber: '22333444' identityType: 'D'! !

!ImportTest methodsFor: 'assertions' stamp: 'JB 6/24/2023 12:30:41'!
assertTheAddressesOfPepeAreInTheDataBase

	^ self isTheAddressLocatedInTheProvince: 'CABA'   streetName: 'Alem'     streetNumber:  1122 town:  'CABA' zipCode: 	 1001 belongsToTheCustomerWIthIdentityNumber: '23-25666777-9' identityType: 'C'! !


!ImportTest methodsFor: 'set up' stamp: 'JB 6/24/2023 13:05:26'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	
	session beginTransaction. 
	
	lines :=  ReadStream  on: self initializeInput. ! !


!ImportTest methodsFor: 'tear down' stamp: 'JB 6/23/2023 18:22:22'!
tearDown

	session commit.
	session close! !


!ImportTest methodsFor: 'stream private' stamp: 'JB 6/24/2023 13:00:23'!
initializeInput
	^OrderedCollection  
	with: 'C,Pepe,Sanchez,D,22333444'   
	with: 'A,San Martin,3322,Olivos,1636,BsAs'
	with:  'A,Maipu,888,Florida,1122,Buenos Aires'
	with:  'C,Juan,Perez,C,23-25666777-9'
	with:  'A,Alem,1122,CABA,1001,CABA'
	 
	




	! !

!ImportTest methodsFor: 'stream private' stamp: 'JB 6/24/2023 13:04:40'!
nextLine
	^lines  next 

	! !


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


!Address methodsFor: 'testing' stamp: 'JB 6/23/2023 19:43:10'!
itsFromProvince: aProvince streetName: anStreetName streetNumber: anStreetNumber town: aTown zipCode: aZipCode 
	^(  province = aProvince )  and: 
				(  zipCode  = aZipCode  and: 
					(  streetName  = anStreetName and: 
						(  streetNumber  = anStreetNumber and:  
							(  town =  aTown ))))		! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

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


!Customer methodsFor: 'importing' stamp: 'JB 6/23/2023 18:16:04'!
importCustomers

	"
	self importCustomers
	"
	| inputStream session newCustomer line |

	inputStream := UniFileStream new open: 'input.txt' forWrite: false.
	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fourth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData fourth ].

		line := inputStream nextLine. ].

	session commit.
	session close.

	inputStream close.
	! !


!Customer methodsFor: 'testing' stamp: 'JB 6/23/2023 20:33:25'!
hasAnAddressThatitsFromProvince: aProvince streetName: aStreetName streetNumber: aStreetNumber town: aTown zipCode: aZipCode 
	^(addresses  select:[:anAddress |
			anAddress  itsFromProvince:  aProvince streetName: aStreetName streetNumber:  aStreetNumber  town: aTown   zipCode:aZipCode] )isEmpty  not ! !

!Customer methodsFor: 'testing' stamp: 'JB 6/23/2023 18:46:56'!
identifyAsNumber: aNumberOfIdentity ofType: tipeOfIdentity 
	^(aNumberOfIdentity asUnicodeString   =  identificationNumber  ) and: (tipeOfIdentity asUnicodeString  = identificationType ).  ! !


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


!classDefinition: #ImportCustomers category: 'CustomerImporter'!
Object subclass: #ImportCustomers
	instanceVariableNames: 'session stream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportCustomers methodsFor: 'initialization' stamp: 'JB 6/24/2023 13:13:18'!
initializeIntoTheSession: anASession fromTheStream: anAStream
	session := anASession.
	stream := anAStream.! !


!ImportCustomers methodsFor: 'evaluating' stamp: 'JB 6/24/2023 13:13:18'!
import 

	
	| newCustomer line |
	
	line := stream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth .
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := stream nextLine. ].

	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ImportCustomers class' category: 'CustomerImporter'!
ImportCustomers class
	instanceVariableNames: ''!

!ImportCustomers class methodsFor: 'instance creation' stamp: 'JB 6/24/2023 13:13:17'!
intoTheSession: anASession fromTheStream: anAStream
	^self new initializeIntoTheSession: anASession fromTheStream: anAStream! !
