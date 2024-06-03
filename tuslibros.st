!classDefinition: #CarritoTests category: #tuslibros!
TestCase subclass: #CarritoTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tuslibros'!

!CarritoTests methodsFor: 'as yet unclassified' stamp: 'AP 6/3/2024 15:05:55'!
test01
	|cart|
	cart := Cart acceptingItemsWithId: (OrderedCollection with: 'id1' with: 'id2' with: 'id3').	
	cart add:  'id1' times: 1.
	self assert: (cart amountOf: 'id1') equals: 1. ! !

!CarritoTests methodsFor: 'as yet unclassified' stamp: 'AP 6/3/2024 15:06:33'!
test02
	|cart|
	cart := Cart acceptingItemsWithId: (OrderedCollection with: 'id1' with: 'id2' with: 'id3').	
	cart add:  'id1' times: 2.
	self assert: (cart amountOf: 'id1') equals: 2. ! !

!CarritoTests methodsFor: 'as yet unclassified' stamp: 'AP 6/3/2024 15:14:47'!
test03
	|cart|
	cart := Cart acceptingItemsWithId: (OrderedCollection with: 'id1' with: 'id2' with: 'id3').	
	cart add:  'id1' times: 2.
	cart add:  'id2' times: 1.
	
	self assert: (cart amountOf: 'id1') equals: 2. 
	self assert: (cart amountOf: 'id2') equals: 1. 
	self assert: (cart amountOf: 'id3') equals: 0. 
	! !


!classDefinition: #Cart category: #tuslibros!
Object subclass: #Cart
	instanceVariableNames: 'acceptedIds amounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'tuslibros'!

!Cart methodsFor: 'initialization' stamp: 'AP 6/3/2024 15:44:55'!
amountOf: anId
	^amounts  occurrencesOf: anId! !

!Cart methodsFor: 'initialization' stamp: 'AP 6/3/2024 15:44:01'!
initializeAcceptingItemsWithId: anAcceptedIds 
	acceptedIds := anAcceptedIds.
	amounts := OrderedCollection new.! !


!Cart methodsFor: 'accessing' stamp: 'AP 6/3/2024 15:43:36'!
add: anItemId times: anAmount 
	anAmount timesRepeat: [amounts add: anItemId].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #tuslibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'AP 6/3/2024 14:57:51'!
acceptingItemsWithId: acceptedIds 
	^self new initializeAcceptingItemsWithId: acceptedIds ! !


!Cart class methodsFor: 'accessing' stamp: 'AP 6/3/2024 15:26:53'!
invalidIdErrorDescription
	^'Invalid items for this cart'! !
