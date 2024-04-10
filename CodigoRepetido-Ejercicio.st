!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'ap 4/10/2024 13:15:07'!
assertCustomerBook: aCustomerBook afterDoing: aFirstBlock activeCustomers: aNumberOfActiveCustomers suspendedCustomers: aNumberOfSuspendedCustomers customers: aNumberOfCustomers 

	aFirstBlock value.
	
	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfCustomers equals: aCustomerBook numberOfCustomers.
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AP 4/8/2024 21:20:27'!
assertThatBlock: aBlock executesBefore: anAmountOfMilliseconds
	self assert: (self timeExecution: aBlock) < anAmountOfMilliseconds
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ap 4/10/2024 12:46:04'!
checkThat: aBlock failsWith: anError andDo: anAction
	
	[ aBlock value. self fail ]
		on: anError 
		do: anAction
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ap 4/10/2024 12:40:08'!
checkThat: aBlock failsWith: anError andDoes: anAction
	
	[ aBlock value. self fail ]
		on: anError 
		do: anAction
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AP 4/8/2024 21:20:56'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertThatBlock: [customerBook addCustomerNamed: 'John Lennon'.] executesBefore: 50 * millisecond. 
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'AP 4/8/2024 21:24:39'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	
	self assertThatBlock: [customerBook removeCustomerNamed: paulMcCartney.] executesBefore: 100 * millisecond.
	
	
	
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ap 4/10/2024 12:46:13'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self checkThat: [ customerBook addCustomerNamed: ''] 
		failsWith: Error
		andDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ap 4/10/2024 12:46:20'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self checkThat: [ customerBook removeCustomerNamed: 'Paul McCartney']
		failsWith: NotFound 
		andDo: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ap 4/10/2024 13:17:43'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self assertCustomerBook: customerBook 
		afterDoing: [
			customerBook addCustomerNamed: paulMcCartney.
			customerBook suspendCustomerNamed: paulMcCartney.
			]
		activeCustomers: 0
		suspendedCustomers: 1
		customers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney)
	
	
	
	
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ap 4/10/2024 13:17:56'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self assertCustomerBook: customerBook 
		afterDoing: [
			customerBook addCustomerNamed: paulMcCartney.
			customerBook suspendCustomerNamed: paulMcCartney.
			customerBook removeCustomerNamed: paulMcCartney.
			]
		activeCustomers: 0
		suspendedCustomers: 0
		customers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).
		
	
	



	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ap 4/10/2024 12:46:33'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self checkThat: [ customerBook suspendCustomerNamed: 'George Harrison']
		failsWith: CantSuspend 
		andDo: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ap 4/10/2024 12:46:44'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self checkThat: [ customerBook suspendCustomerNamed: johnLennon]
		failsWith: CantSuspend 
		andDo: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ap 4/10/2024 13:29:01'!
timeExecution: aBlock

	| millisecondsBeforeRunning millisecondsAfterRunning |.
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	^millisecondsAfterRunning - millisecondsBeforeRunning
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'ap 4/10/2024 13:40:08'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'ap 4/10/2024 14:09:18'!
if: aCollection contains: anElement removeItAndExecute: aBlock
	1 to: aCollection size do: 	
	[ :index |
		anElement = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				aBlock value. 
			] 
	].

! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ap 4/10/2024 14:33:46'!
raiseClassError: anErrorMessage

	self error: (anErrorMessage sendTo: self class).! !

!CustomerBook methodsFor: 'customer management' stamp: 'ap 4/10/2024 14:11:00'!
removeCustomerNamed: aName 
 
	self if: active contains: aName removeItAndExecute: [^aName].
	self if: suspended contains: aName removeItAndExecute: [^aName].
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'ap 4/10/2024 14:35:42'!
signalCustomerAlreadyExists 

	self raiseClassError: #customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'ap 4/10/2024 14:35:23'!
signalCustomerNameCannotBeEmpty 

	self raiseClassError: #customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
