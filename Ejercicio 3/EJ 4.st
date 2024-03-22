!classDefinition: #I category: #'EJ 4'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EJ 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'EJ 4'!
I class
	instanceVariableNames: ''!

!I class methodsFor: '-- all --' stamp: 'AP 3/21/2024 21:39:30'!
+ aNumber
	^ aNumber next
	
	! !

!I class methodsFor: '-- all --' stamp: 'AP 3/21/2024 20:51:25'!
next
	^II! !


!classDefinition: #II category: #'EJ 4'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EJ 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'EJ 4'!
II class
	instanceVariableNames: 'previous'!

!II class methodsFor: '-- all --' stamp: 'AP 3/21/2024 21:49:37'!
+ aNumber
	^self previous + aNumber next! !

!II class methodsFor: '-- all --' stamp: 'AP 3/21/2024 21:54:09'!
- aSubstractor
	self previous - aSubstractor previous! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'AP 3/21/2024 22:01:06'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.! !

!II class methodsFor: '-- all --' stamp: 'AP 3/21/2024 21:36:41'!
next
	| newNext |
	newNext := II createChildNamed: self name , 'I'.
	newNext previous: self.
	^newNext! !

!II class methodsFor: '-- all --' stamp: 'AP 3/21/2024 21:25:18'!
previous
	^ previous
	
		! !

!II class methodsFor: '-- all --' stamp: 'AP 3/21/2024 21:35:38'!
previous: aNumber
	previous := aNumber! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'AP 3/21/2024 22:01:06'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.! !

II initializeAfterFileIn!