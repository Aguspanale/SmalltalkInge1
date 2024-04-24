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

!OOStackTest methodsFor: 'test' stamp: 'ap 4/22/2024 23:57:43'!
test11CanNotPushIntoFullStack

	| stack  |
	
	stack := OOLimitedStack limitedTo: 3 .
	((stack push: 'a') push: 'b') push: 'c'.	
	self
		should: [ stack push: 'd' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOLimitedStack stackFullErrorDescription ]
		
! !


!OOStackTest methodsFor: 'failing' stamp: 'ap 4/18/2024 21:48:13'!
signalFailure: aRenameMe1 
	self class stackEmptyErrorDescription ! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'sentenceFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ap 4/24/2024 14:17:14'!
test01EmptyStackShouldReturnEmptyList
	|sentenceStackToTest expect|
	sentenceStackToTest  := OOStack new.
	expect := OrderedCollection  new.
	
	self assert: (sentenceFinder find: 'peperoni' inSentenceStack: sentenceStackToTest) equals: expect.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ap 4/24/2024 14:12:29'!
test02ShouldReturnEmptyListIfNoElementHasPrefix
	|sentenceStackToTest expect|
	sentenceStackToTest  := (OOStack new push: 'pizza') push: 'margherita'.
	expect := OrderedCollection  new.
	
	self assert: (sentenceFinder find: 'peperoni' inSentenceStack: sentenceStackToTest) equals: expect.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ap 4/24/2024 14:26:07'!
test03ShouldReturnElementWithṔrefix
	|sentenceStackToTest expect|
	sentenceStackToTest  := (OOStack new push: 'peperoni pizza') push: 'margherita'.
	expect := OrderedCollection  new.
	expect add: 'peperoni pizza'.
	self assert: (sentenceFinder find: 'peperoni' inSentenceStack: sentenceStackToTest) equals: expect.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ap 4/24/2024 14:31:09'!
test04ShouldReturnMultipleElementsWithṔrefix
	|sentenceStackToTest expect|
	sentenceStackToTest  := (((OOStack new push: 'peperoni pizza') push: 'margherita') push: 'peperoni' ) push: 'peperonccino'.
	expect := OrderedCollection  new.
	expect add: 'peperoni pizza'.
	expect add: 'peperoni'.
	expect add: 'peperonccino'.
	
	self assert: (sentenceFinder find: 'peper' inSentenceStack: sentenceStackToTest) sort equals: expect sort.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ap 4/24/2024 14:32:38'!
test05ShouldNotReturnUnmatchedCasingElements
	|sentenceStackToTest expect|
	sentenceStackToTest  := (((OOStack new push: 'Peperoni pizza') push: 'margherita') push: 'peperoni' ) push: 'peperonccino'.
	expect := OrderedCollection  new.
	expect add: 'peperoni'.
	expect add: 'peperonccino'.
	
	self assert: (sentenceFinder find: 'peper' inSentenceStack: sentenceStackToTest) sort equals: expect sort.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'ap 4/24/2024 14:40:35'!
test05StackIsPreservedAfterFindingElements
	|sentenceStackToTest expect |
	sentenceStackToTest  := (((OOStack new push: 'Peperoni pizza') push: 'margherita') push: 'peperoni' ) push: 'peperonccino'.
	expect := (((OOStack new push: 'Peperoni pizza') push: 'margherita') push: 'peperoni' ) push: 'peperonccino'.

	(sentenceFinder find: 'peper' inSentenceStack: sentenceStackToTest).
	
	self assert: sentenceStackToTest size equals: expect size.
	self assert: sentenceStackToTest top equals: expect top.! !


!SentenceFinderByPrefixTest methodsFor: 'setUp' stamp: 'ap 4/24/2024 13:59:43'!
setUp 
	
	sentenceFinder := SentenceFinderByPrefix new.! !


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

!OOStack methodsFor: 'accessing' stamp: 'ap 4/22/2024 23:51:49'!
isFull
	^false! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/19/2024 12:38:57'!
pop
	self top.
	^collection removeFirst! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/18/2024 21:18:00'!
push: anElement
	collection addFirst: anElement! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/24/2024 13:19:23'!
select: aBlockCondition
	^collection  select: aBlockCondition.! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/18/2024 21:26:50'!
size
	^collection size ! !

!OOStack methodsFor: 'accessing' stamp: 'ap 4/22/2024 23:48:02'!
top
	^(StackState stateOf: self) top! !

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


!classDefinition: #OOLimitedStack category: #'Stack-Exercise'!
OOStack subclass: #OOLimitedStack
	instanceVariableNames: 'limit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOLimitedStack methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:29:22'!
initializeWith: aSizeLimit
	limit := aSizeLimit.! !

!OOLimitedStack methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:30:22'!
isFull
	^collection size = limit 	! !

!OOLimitedStack methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:42:54'!
push: anElement
	(StackState stateOf: self) push: anElement.! !

!OOLimitedStack methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:41:50'!
pushFull: anElement
	^self error: self class stackFullErrorDescription. ! !

!OOLimitedStack methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:40:30'!
pushNotFull: anElement
	collection addFirst: anElement! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOLimitedStack class' category: #'Stack-Exercise'!
OOLimitedStack class
	instanceVariableNames: ''!

!OOLimitedStack class methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:28:38'!
limitedTo: sizeLimit
	^self new initializeWith: sizeLimit.! !

!OOLimitedStack class methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:41:06'!
stackFullErrorDescription
	
	^ 'stack is full!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ap 4/24/2024 14:15:10'!
add: anElement to: aCollection ifMeets: aCondition
	(aCondition value: anElement) ifTrue: [aCollection add: anElement].
	^aCollection 
				
								
		
	
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ap 4/24/2024 13:25:08'!
find: aPrefix inSentenceStack: aSentenceStack
	|sentencesWithPrefix|
	
	sentencesWithPrefix := self selectFrom: aSentenceStack  elementsMeeting: [:aSentence | aSentence beginsWith: aPrefix].
	
	^sentencesWithPrefix 
	
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ap 4/24/2024 13:52:11'!
selectFrom: aStack  elementsMeeting: aBlockCondition
	aStack isEmpty 
		ifTrue: [^OrderedCollection new]
		ifFalse:[
			|anElement elementsMeetingCondition|
			
			anElement := aStack pop.
			
			elementsMeetingCondition := self add: anElement to: (self selectFrom: aStack elementsMeeting: aBlockCondition) ifMeets: aBlockCondition.
			
			aStack push: anElement.
			
			^elementsMeetingCondition 
			].
			
			
							
	
	
	! !


!classDefinition: #StackState category: #'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: 'representedStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackState methodsFor: 'nil' stamp: 'ap 4/22/2024 23:46:58'!
initializeWith: theStackIRepresent
	representedStack := theStackIRepresent .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackState class' category: #'Stack-Exercise'!
StackState class
	instanceVariableNames: ''!

!StackState class methodsFor: 'as yet unclassified' stamp: 'ap 4/19/2024 13:20:18'!
represents: aStackToRepresent

	self subclassResponsibility! !

!StackState class methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:43:33'!
stateOf: aStackToRepresent
	^(self allSubclasses detect: [:aSubclass | aSubclass represents: aStackToRepresent]) new initializeWith: aStackToRepresent ! !


!classDefinition: #StackEmptyState category: #'Stack-Exercise'!
StackState subclass: #StackEmptyState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackEmptyState methodsFor: 'nil' stamp: 'ap 4/22/2024 23:48:33'!
top
	^representedStack topEmpty ! !


!StackEmptyState methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:49:17'!
push: anElement
	^representedStack pushNotFull: anElement. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackEmptyState class' category: #'Stack-Exercise'!
StackEmptyState class
	instanceVariableNames: ''!

!StackEmptyState class methodsFor: 'nil' stamp: 'ap 4/19/2024 13:16:30'!
represents: aStackToRepresent
	^aStackToRepresent isEmpty.! !


!classDefinition: #StackFullState category: #'Stack-Exercise'!
StackState subclass: #StackFullState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackFullState methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:49:37'!
push: anElement
	^representedStack pushFull: anElement. ! !

!StackFullState methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:48:16'!
top
	^representedStack topNotEmpty ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackFullState class' category: #'Stack-Exercise'!
StackFullState class
	instanceVariableNames: ''!

!StackFullState class methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:38:37'!
represents: aStackToRepresent
	^aStackToRepresent isFull.! !


!classDefinition: #StackNotEmptyNorCloseState category: #'Stack-Exercise'!
StackState subclass: #StackNotEmptyNorCloseState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackNotEmptyNorCloseState methodsFor: 'nil' stamp: 'ap 4/22/2024 23:47:44'!
top 
	^representedStack topNotEmpty ! !


!StackNotEmptyNorCloseState methodsFor: 'as yet unclassified' stamp: 'ap 4/22/2024 23:49:28'!
push: anElement
	^representedStack pushNotFull: anElement. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackNotEmptyNorCloseState class' category: #'Stack-Exercise'!
StackNotEmptyNorCloseState class
	instanceVariableNames: ''!

!StackNotEmptyNorCloseState class methodsFor: 'nil' stamp: 'ap 4/22/2024 23:51:18'!
represents: aStackToRepresent
	^aStackToRepresent isEmpty not and: aStackToRepresent isFull not.! !
