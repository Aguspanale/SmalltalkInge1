!classDefinition: #MarsRoverTest category: #'Mars Rover TDD'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'north south east west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover TDD'!

!MarsRoverTest methodsFor: 'setup' stamp: 'ap 5/9/2024 12:34:58'!
setUp
	north := North new.
	south := South new.
	east := East new.
	west := West new.! !


!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 12:35:19'!
test01MarsRoverStartsAtStartingPosition
	|rover|
	rover := MarsRover at: 3@4 pointing: north.
	
	self assert: 3@4 equals: rover position.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 13:10:18'!
test02MarsRoverStartsPointingToStartingDirection
	|rover|
	rover := MarsRover at: 3@4 pointing: north.
	
	self assert: rover direction isNorth equals: true.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 12:35:29'!
test03MarsRoverStartsAtDifferentStartingPosition
	|rover|
	rover := MarsRover at: 4@3 pointing: south.
	
	self assert: 4@3 equals: rover position.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 13:10:44'!
test04MarsRoverStartsAtDifferentStartingDirection
	|rover|
	rover := MarsRover at: 4@3 pointing: south.
	
	self assert: rover direction isSouth equals: true.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 13:46:32'!
test05MarsRoverMovesSouthCorrectly
	|rover|
	rover := MarsRover at: 4@3 pointing: south.
	
	rover receive: 'f'.
	
	self assert: 4@2 equals: rover position.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 13:46:38'!
test06MarsRoverMovesSouthTwiceCorrectly
	|rover|
	rover := MarsRover at: 4@3 pointing: south.
	
	rover receive: 'ff'.
	
	self assert: 4@1 equals: rover position.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 13:46:50'!
test07MarsRoverMovesForwardMultipleTimesCorrectly
	|rover|
	rover := MarsRover at: 4@3 pointing: north.
	
	rover receive: 'ff'.
	
	self assert: 4@5 equals: rover position.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 13:46:56'!
test08MarsRoverMovesBackwardsMultipleTimesCorrectly
	|rover|
	rover := MarsRover at: 4@3 pointing: south.
	
	rover receive: 'bb'.
	
	self assert: 4@5 equals: rover position.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 13:47:02'!
test09MarsRoverRotatesRightFromSouthCorrectly
	|rover|
	rover := MarsRover at: 4@3 pointing: south.
	
	rover receive: 'r'.
	
	self assert: rover direction isWest equals: true.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 13:47:10'!
test10MarsRoverRotatesRightCorrectly
	|rover|
	rover := MarsRover at: 4@3 pointing: north.
	
	rover receive: 'r'.
	
	self assert: rover direction isEast equals: true.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 13:47:18'!
test11MarsRoverRotatesLeftFromNorthCorrectly
	|rover|
	rover := MarsRover at: 4@3 pointing: north.
	
	rover receive: 'l'.
	
	self assert: rover direction isWest equals: true.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 13:47:26'!
test12MarsRoverRotatesLeftCorrectly
	|rover|
	rover := MarsRover at: 4@3 pointing: south.
	
	rover receive: 'l'.
	
	self assert: rover direction isEast equals: true.! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 14:02:56'!
test13MarsRoverDoesNothingWhenSentK
	|rover|
	rover := MarsRover at: 4@3 pointing: south.
	
	rover receive: 'k'.
	
	self assert: rover direction isSouth equals: true.
	self assert: rover position equals: 4@3.
	! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 14:03:13'!
test14MarsDoesNothingWhenSentAnyUnknownInstruction
	|rover|
	rover := MarsRover at: 4@3 pointing: south.
	
	rover receive: 'a'.
	
	self assert: rover direction isSouth equals: true.
	self assert: rover position equals: 4@3.
	! !

!MarsRoverTest methodsFor: 'TDD tests' stamp: 'ap 5/9/2024 14:05:06'!
test15MarsStopsWhenSentAnyUnknownInstruction
	|rover|
	rover := MarsRover at: 4@3 pointing: south.
	
	rover receive: 'lfrprfl'.
	
	self assert: rover direction isSouth equals: true.
	self assert: rover position equals: 5@3.
	! !



!classDefinition: #CardinalPoint category: #'Mars Rover TDD'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover TDD'!

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:08:49'!
isEast
	^false! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:08:45'!
isNorth
	^false! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:08:42'!
isSouth
	^false! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:08:37'!
isWest
	^false! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 12:30:11'!
step
	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:25:52'!
toTheLeft

	self subclassResponsibility! !

!CardinalPoint methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:25:55'!
toTheRight

	self subclassResponsibility! !


!classDefinition: #East category: #'Mars Rover TDD'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover TDD'!

!East methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:09:08'!
isEast
	^true! !

!East methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 12:31:48'!
step
	^ 1@0! !

!East methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:25:47'!
toTheLeft
	^North new! !

!East methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:19:45'!
toTheRight
	^South new! !


!classDefinition: #North category: #'Mars Rover TDD'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover TDD'!

!North methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:09:19'!
isNorth
	^true! !

!North methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 12:31:58'!
step
	^ 0@1! !

!North methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:25:39'!
toTheLeft
	^West new! !

!North methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:19:54'!
toTheRight
	^East new! !


!classDefinition: #South category: #'Mars Rover TDD'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover TDD'!

!South methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:09:27'!
isSouth
	^true! !

!South methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 12:32:09'!
step
	^ 0@-1! !

!South methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:25:32'!
toTheLeft
	^East new! !

!South methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:20:02'!
toTheRight
	^West new! !


!classDefinition: #West category: #'Mars Rover TDD'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover TDD'!

!West methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:09:34'!
isWest
	^true! !

!West methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 12:32:18'!
step
	^ -1@0! !

!West methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:25:24'!
toTheLeft
	^South new! !

!West methodsFor: 'as yet unclassified' stamp: 'ap 5/9/2024 13:20:09'!
toTheRight
	^North new! !


!classDefinition: #MarsRover category: #'Mars Rover TDD'!
Object subclass: #MarsRover
	instanceVariableNames: 'point direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover TDD'!

!MarsRover methodsFor: 'initialization' stamp: 'ap 5/9/2024 11:59:08'!
initializeAt: aPoint pointing: aDirection 
	point := aPoint.
	direction := aDirection.! !


!MarsRover methodsFor: 'inspecting' stamp: 'ap 5/9/2024 12:04:36'!
direction
	^direction! !

!MarsRover methodsFor: 'inspecting' stamp: 'ap 5/9/2024 12:03:52'!
position
	^point! !


!MarsRover methodsFor: 'private' stamp: 'ap 5/9/2024 13:32:20'!
b

	^ self moveBackwards! !

!MarsRover methodsFor: 'private' stamp: 'ap 5/9/2024 13:32:07'!
f

	^ self moveForwards! !

!MarsRover methodsFor: 'private' stamp: 'ap 5/9/2024 13:31:57'!
l

	^ self rotateLeft! !

!MarsRover methodsFor: 'private' stamp: 'ap 5/9/2024 12:48:23'!
moveBackwards
	point := point - direction step! !

!MarsRover methodsFor: 'private' stamp: 'ap 5/9/2024 12:32:45'!
moveForwards
	point := point + direction step! !

!MarsRover methodsFor: 'private' stamp: 'ap 5/9/2024 13:34:17'!
r
	^ self rotateRight! !

!MarsRover methodsFor: 'private' stamp: 'ap 5/9/2024 13:26:31'!
rotateLeft

	^ direction := direction toTheLeft! !

!MarsRover methodsFor: 'private' stamp: 'ap 5/9/2024 13:20:51'!
rotateRight

	^ direction := direction toTheRight! !


!MarsRover methodsFor: 'interaction' stamp: 'ap 5/9/2024 14:02:20'!
instructions

	^ #($r $f $b $l)! !

!MarsRover methodsFor: 'interaction' stamp: 'ap 5/9/2024 14:06:09'!
receive: aSequenceOfInstructions
	aSequenceOfInstructions do: [:anInstruction |
		 (self instructions includes: anInstruction) ifFalse: [^self] .
		anInstruction asSymbol sendTo: self.
		]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'Mars Rover TDD'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'ap 5/9/2024 11:58:25'!
at: aPoint pointing: aDirection 
	^self new initializeAt: aPoint pointing: aDirection .! !
