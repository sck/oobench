Smalltalk interchangeVersion: '1.0'!

Class named: 'OOBMemory'
	superclass: 'Object'
	indexedInstanceVariables: #none
	instanceVariableNames: ''
	classVariableNames: ''
	sharedPools: ''
	classInstanceVariableNames: ''!
Annotation key: 'category' value: 'None Specified-SIF'!
Annotation key: 'package' value: 'OOBench'!

OOBMemory classMethod!
isSqueak
	^((Smalltalk at: #SqueakPage ifAbsent: [nil]) = nil) not.!
Annotation key: 'category' value: 'memory-usage'!

OOBMemory classMethod!
usedMemory
		
	(self isSqueak) 
		ifTrue: [^999999999999 - Smalltalk bytesLeft]
	  	ifFalse:[^(ObjectMemory current  numOopsNumBytes) last].!
Annotation key: 'category' value: 'memory-usage'!

