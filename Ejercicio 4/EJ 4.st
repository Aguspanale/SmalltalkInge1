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

!I class methodsFor: '-- all --' stamp: 'AP 3/22/2024 09:11:51'!
* aMultiplicand
	^aMultiplicand! !

!I class methodsFor: '-- all --' stamp: 'AP 3/21/2024 21:39:30'!
+ aNumber
	^ aNumber next
	
	! !

!I class methodsFor: '-- all --' stamp: 'AP 3/22/2024 09:48:16'!
- aSubstractor
	^ Error signal: I descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: '-- all --' stamp: 'AP 3/22/2024 09:59:22'!
/ aDividend
	|response|
	self == aDividend 
		ifTrue: [response := I] 
		ifFalse: [response := Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	
	^response! !

!I class methodsFor: '-- all --' stamp: 'AP 3/22/2024 09:50:39'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No hay fracciones'! !

!I class methodsFor: '-- all --' stamp: 'AP 3/22/2024 09:45:33'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No soporto negativos'! !

!I class methodsFor: '-- all --' stamp: 'AP 3/21/2024 20:51:25'!
next
	^II! !

!I class methodsFor: '-- all --' stamp: 'AP 3/21/2024 23:56:57'!
substractedTo: aNumber
	^aNumber previous! !


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

!II class methodsFor: '-- all --' stamp: 'AP 3/22/2024 09:13:29'!
* aMultiplicand
	^self previous * aMultiplicand + aMultiplicand! !

!II class methodsFor: '-- all --' stamp: 'AP 3/21/2024 21:49:37'!
+ aNumber
	^self previous + aNumber next! !

!II class methodsFor: '-- all --' stamp: 'AP 3/22/2024 09:31:55'!
- aSubstractor
	^ aSubstractor substractedTo: self! !

!II class methodsFor: '-- all --' stamp: 'AP 3/22/2024 10:00:49'!
/ aDividend
	|response|
	self == aDividend 
		ifTrue: [response := I] 
		ifFalse: ([response := I + (self - aDividend / aDividend)] on: Error do: [[response := Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]]).
	
	^response! !

!II class methodsFor: '-- all --' stamp: 'AP 3/22/2024 09:49:40'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'no hay fracciones'! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'AP 3/22/2024 10:04:57'!
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

!II class methodsFor: '-- all --' stamp: 'AP 3/21/2024 23:56:24'!
substractedTo: aNumber
	^self previous substractedTo: aNumber previous! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'AP 3/22/2024 10:04:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.! !


!classDefinition: #III category: #'EJ 4'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EJ 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'EJ 4'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'AP 3/22/2024 10:04:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := II.! !


!classDefinition: #IIII category: #'EJ 4'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'EJ 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'EJ 4'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'AP 3/22/2024 10:04:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!