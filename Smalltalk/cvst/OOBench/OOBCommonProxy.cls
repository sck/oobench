Smalltalk interchangeVersion: '1.0'!

Class named: 'OOBCommonProxy'
	superclass: 'Object'
	indexedInstanceVariables: #none
	instanceVariableNames: 'obj '
	classVariableNames: ''
	sharedPools: ''
	classInstanceVariableNames: ''!
Annotation key: 'category' value: 'None Specified-SIF'!
Annotation key: 'package' value: 'OOBench'!

OOBCommonProxy method!
doesNotUnderstand: aMessage
	^obj perform: aMessage selector withArguments: aMessage arguments.!
Annotation key: 'category' value: 'forwarding'!

OOBCommonProxy method!
initializeWithObject: anObject
	obj := anObject.!
Annotation key: 'category' value: 'initialization'!

OOBCommonProxy classMethod!
proxyWithObject: anObject
	^self new initializeWithObject: anObject.!
Annotation key: 'category' value: 'instance creation'!

