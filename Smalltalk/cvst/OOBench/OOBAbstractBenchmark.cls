Smalltalk interchangeVersion: '1.0'!

Class named: 'OOBAbstractBenchmark'
	superclass: 'Object'
	indexedInstanceVariables: #none
	instanceVariableNames: 'internalCount refreshCounter watermark smallScale memoryAtBegin timer then slow accurate testOnly '
	classVariableNames: ''
	sharedPools: ''
	classInstanceVariableNames: ''!
Annotation key: 'category' value: 'OOBench'!
Annotation key: 'package' value: 'OOBench'!

OOBAbstractBenchmark method!
actionWithSubNumber: subNumber message: aMessage count: aCount comment: aComment do: aBlock
	self beginActionWithSubNumber: subNumber message: aMessage count: aCount
		comment: aComment.
	aBlock value.
	self endAction.!
Annotation key: 'category' value: 'time-measuring'!

OOBAbstractBenchmark method!
actionWithSubNumber: subNumber message: aMessage count: aCount do:aBlock
	^self actionWithSubNumber: subNumber message: aMessage count: aCount 
		comment: '' do: aBlock.!
Annotation key: 'category' value: 'time-measuring'!

OOBAbstractBenchmark method!
beginActionWithSubNumber: subNumber message: aMessage count: aCount
	^self beginActionWithSubNumber: subNumber message: aMessage
		count: aCount comment: ''.!
Annotation key: 'category' value: 'time-measuring'!

OOBAbstractBenchmark method!
beginActionWithSubNumber: subNumber message:aMessage count:aCount comment:aComment
	
memoryAtBegin := OOBMemory usedMemory.
	Transcript show: 'Smalltalk: [', self class majorNumber printString,
		'.', self class minorNumber printString, '.', subNumber printString, '] ', aMessage,
		' (', aCount printString, ')'.
	aComment isEmpty
		ifFalse: [ Transcript show: ' -- ', aComment].
	Transcript show: ': '; flush.
	timer reset start.
	smallScale := false.!
Annotation key: 'category' value: 'time-measuring'!

OOBAbstractBenchmark method!
consumedMemory
	^OOBMemory usedMemory - memoryAtBegin.!
Annotation key: 'category' value: 'time-measuring'!

OOBAbstractBenchmark method!
countWithDefault: aCount
	^testOnly 
		ifTrue: [ 1 ]
		ifFalse: [ aCount ].!
Annotation key: 'category' value: 'time-measuring'!

OOBAbstractBenchmark method!
endAction
	timer stop.
	smallScale 
		ifTrue: [ Transcript show: (timer elapsedTime * 5000) printString;
			show: 'e ms ('; show: (self class beautifyBytes: self consumedMemory); 
			show: '+?)'; cr ]
		ifFalse: [ Transcript show: timer elapsedTime printString;
			show: ' ms ('; show: (self class beautifyBytes: self consumedMemory);
			show: ')'; cr].
	smallScale := false.!
Annotation key: 'category' value: 'time-measuring'!

OOBAbstractBenchmark method!
initialize
	internalCount := 0.
	refreshCounter := 0.
	watermark := 0.
	smallScale := False.
	memoryAtBegin := 0.
	timer := OOBStopwatch new.
	then := 0.
	accurate := True.
	testOnly := False.!
Annotation key: 'category' value: 'initialization'!

OOBAbstractBenchmark method!
initializeWithAccurate:aBool testOnly:anotherBool
	"Initializes new benchmark"
       
	self initialize.
	accurate:=aBool.
	testOnly:=anotherBool.!
Annotation key: 'category' value: 'initialization'!

OOBAbstractBenchmark method!
proceed!
Annotation key: 'category' value: 'time-measuring'!

OOBAbstractBenchmark method!
reset
	slow := accurate not.
	accurate ifTrue: [ ^self ].!
Annotation key: 'category' value: 'time-measuring'!

OOBAbstractBenchmark classMethod!
beautifyBytes: aByteCount
	| m f measure |
	f := aByteCount.
	m := 1.
	measure := #('B' 'KB' 'M' 'GB' 'TB').
	[ f > 1024 ]
		whileTrue: [ m := m + 1.
			f := f // 1024 ].
	[ f  < -1024 ]
		whileTrue: [ m := m + 1.
			f := f // 1024 ].
	^f printString, ' ', (measure at: m).!
Annotation key: 'category' value: 'number formatting'!

OOBAbstractBenchmark classMethod!
majorNumber
	^self subclassResponsibility!
Annotation key: 'category' value: 'identity'!

OOBAbstractBenchmark classMethod!
minorNumber
	^self subclassResponsibility!
Annotation key: 'category' value: 'identity'!

OOBAbstractBenchmark classMethod!
newBenchmarkWithAccurate:aBool testOnly:anotherBool
	"Creates a new benchmark"
	^self new initializeWithAccurate: aBool testOnly: anotherBool.!
Annotation key: 'category' value: 'instance creation'!

