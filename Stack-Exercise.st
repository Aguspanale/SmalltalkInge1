!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!OOStackTest methodsFor: 'failing' stamp: 'ap 4/18/2024 21:48:13'!
signalFailure: aRenameMe1 
	self class stackEmptyErrorDescription ! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'collection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accessing' stamp: 'ap 4/18/2024 21:13:11'!
collection: aCollection
	collection := aCollection! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/18/2024 21:33:24'!
initialize
	collection := OrderedCollection new.! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/18/2024 21:14:48'!
isEmpty
	^collection size = 0! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/19/2024 12:38:57'!
pop
	self top.
	^collection removeFirst! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/18/2024 21:18:00'!
push: anElement
	collection addFirst: anElement! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/18/2024 21:26:50'!
size
	^collection size ! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/19/2024 13:19:13'!
top
	^(StackState stateOf: self) top: self! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/19/2024 13:03:30'!
topEmpty
	
	collection size > 0 ifTrue: [^collection at: 1] ifFalse: [self error: self class stackEmptyErrorDescription ]! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/19/2024 13:03:45'!
topNotEmpty
	
	^collection at: 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #StackState category: #'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackState class' category: #'Stack-Exercise'!
StackState class
	instanceVariableNames: ''!

!StackState class methodsFor: 'as yet unclassified' stamp: 'ap 4/19/2024 13:20:18'!
represents: aStackToRepresent

	self subclassResponsibility! !

!StackState class methodsFor: 'as yet unclassified' stamp: 'ap 4/19/2024 13:20:39'!
stateOf: aStackToRepresent
	^(self allSubclasses detect: [:aSubclass | aSubclass represents: aStackToRepresent]) new! !


!classDefinition: #StackEmptyState category: #'Stack-Exercise'!
StackState subclass: #StackEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackEmptyState methodsFor: 'as yet unclassified' stamp: 'ap 4/19/2024 13:03:57'!
top: theStackIRepresent
	^theStackIRepresent topEmpty ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackEmptyState class' category: #'Stack-Exercise'!
StackEmptyState class
	instanceVariableNames: ''!

!StackEmptyState class methodsFor: 'as yet unclassified' stamp: 'ap 4/19/2024 13:16:30'!
represents: aStackToRepresent
	^aStackToRepresent isEmpty.! !


!classDefinition: #StackNotEmptyState category: #'Stack-Exercise'!
StackState subclass: #StackNotEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNotEmptyState methodsFor: 'as yet unclassified' stamp: 'ap 4/19/2024 13:04:16'!
top: theStackIRepresent
	^theStackIRepresent topNotEmpty ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackNotEmptyState class' category: #'Stack-Exercise'!
StackNotEmptyState class
	instanceVariableNames: ''!

!StackNotEmptyState class methodsFor: 'as yet unclassified' stamp: 'ap 4/19/2024 13:16:46'!
represents: aStackToRepresent
	^aStackToRepresent isEmpty not.! !
