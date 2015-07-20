Smalltalk interchangeVersion: '1.0'!

Class named: 'OOBStopwatch'
	superclass: 'Object'
	indexedInstanceVariables: #none
	instanceVariableNames: 'startTime stopTime running '
	classVariableNames: ''
	sharedPools: ''
	classInstanceVariableNames: ''!
Annotation key: 'category' value: 'None Specified-SIF'!
Annotation key: 'package' value: 'OOBench'!

OOBStopwatch method!
elapsedTime
	startTime = -1
		ifTrue: [ ^0 ].
	running
		ifTrue: [ | now | 
			now := self class currentTimeMillis.
			^now - startTime. ]
		ifFalse: [ ^stopTime - startTime ].!
Annotation key: 'category' value: 'measuring'!

OOBStopwatch method!
initialize
	super initialize.
	startTime := -1.
	stopTime := -1.
	running := false.!
Annotation key: 'category' value: 'initialization'!

OOBStopwatch method!
reset
	startTime := -1.
	stopTime := -1.
	running := false.!
Annotation key: 'category' value: 'measuring'!

OOBStopwatch method!
start
	startTime := self class currentTimeMillis.
	running := true.!
Annotation key: 'category' value: 'measuring'!

OOBStopwatch method!
stop
	stopTime := self class currentTimeMillis.
	running := false.!
Annotation key: 'category' value: 'measuring'!

OOBStopwatch classMethod!
currentTimeMillis
	^Time millisecondClockValue.!
Annotation key: 'category' value: 'measuring'!

