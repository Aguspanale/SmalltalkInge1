!classDefinition: #Falso category: #Ej3Inge1!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej3Inge1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #Ej3Inge1!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:10:34'!
no
	^Verdadero! !

!Falso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:11:03'!
o: unBooleano
	^unBooleano! !

!Falso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:11:19'!
siFalso: unBloque
	^unBloque! !

!Falso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:11:22'!
siVerdadero: unBloque
	^nil! !

!Falso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:17:54'!
y: unBooleano
	^Falso! !


!classDefinition: #TestsFalso category: #Ej3Inge1!
DenotativeObject subclass: #TestsFalso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej3Inge1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestsFalso class' category: #Ej3Inge1!
TestsFalso class
	instanceVariableNames: ''!

!TestsFalso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:19:32'!
testFalsoNoEsVerdadero
	Assert that: Falso no isEqualTo: Verdadero! !

!TestsFalso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:21:25'!
testFalsoOFalsoEsFalso
	Assert that: (Falso o: Falso) isEqualTo: Falso! !

!TestsFalso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:21:49'!
testFalsoOVerdaderoEsVerdadero
	Assert that: (Falso o: Verdadero) isEqualTo: Verdadero! !

!TestsFalso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:22:43'!
testFalsoSiFalsoEjecutaBloque
	Assert that: (Falso siFalso: [1 + 1]) value isEqualTo: 2! !

!TestsFalso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:23:09'!
testFalsoSiVerdaderoNoEjecutaBloque
	Assert that: (Falso siVerdadero: [1 + 1]) value isEqualTo: nil! !

!TestsFalso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:24:13'!
testFalsoYFalsoEsFalso
	Assert that: (Falso y: Falso) isEqualTo: Falso! !

!TestsFalso class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:23:41'!
testFalsoYVerdaderoEsFalso
	Assert that: (Falso y: Verdadero) isEqualTo: Falso! !


!classDefinition: #TestsVerdadero category: #Ej3Inge1!
DenotativeObject subclass: #TestsVerdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej3Inge1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestsVerdadero class' category: #Ej3Inge1!
TestsVerdadero class
	instanceVariableNames: ''!

!TestsVerdadero class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:17:54'!
testVerdaderoNoEsFalso
	Assert that: Verdadero no isEqualTo: Falso! !

!TestsVerdadero class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:17:54'!
testVerdaderoOFalsoEsVerdadero
	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero! !

!TestsVerdadero class methodsFor: '-- all --' stamp: 'AP 3/18/2024 23:15:23'!
testVerdaderoOVerdaderoEsVerdadero
	Assert that: (Verdadero o: Verdadero) isEqualTo: Verdadero! !

!TestsVerdadero class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:09:59'!
testVerdaderoSiFalsoNoEjecutaBloque
	Assert that: (Verdadero siFalso: [1 + 1]) value isEqualTo: nil! !

!TestsVerdadero class methodsFor: '-- all --' stamp: 'AP 3/18/2024 23:36:17'!
testVerdaderoSiVerdaderoEjecutaBloque
	Assert that: (Verdadero siVerdadero: [1 + 1]) value isEqualTo: 2! !

!TestsVerdadero class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:17:54'!
testVerdaderoYFalsoEsFalso
	Assert that: (Verdadero y: Falso) isEqualTo: Falso! !

!TestsVerdadero class methodsFor: '-- all --' stamp: 'AP 3/18/2024 23:05:38'!
testVerdaderoYVerdaderoEsVerdadero
	Assert that: (Verdadero y: Verdadero) isEqualTo: Verdadero! !


!classDefinition: #Verdadero category: #Ej3Inge1!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ej3Inge1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #Ej3Inge1!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: '-- all --' stamp: 'AP 3/19/2024 00:17:54'!
no
	^Falso! !

!Verdadero class methodsFor: '-- all --' stamp: 'AP 3/18/2024 23:15:07'!
o: unBooleano
	^Verdadero! !

!Verdadero class methodsFor: '-- all --' stamp: 'AP 3/18/2024 23:58:54'!
siFalso: unBloque
	^nil! !

!Verdadero class methodsFor: '-- all --' stamp: 'AP 3/18/2024 23:38:10'!
siVerdadero: unBloque
	^unBloque! !

!Verdadero class methodsFor: '-- all --' stamp: 'AP 3/18/2024 23:10:38'!
y: unBooleano
	^unBooleano! !
