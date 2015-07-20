Smalltalk interchangeVersion: '1.0'!

Class named: 'OOBMessagesPerformance'
	superclass: 'OOBAbstractBenchmark'
	indexedInstanceVariables: #object
	instanceVariableNames: ''
	classVariableNames: ''
	sharedPools: ''
	classInstanceVariableNames: ''!
Annotation key: 'category' value: 'None Specified-SIF'!
Annotation key: 'package' value: 'OOBench'!

OOBMessagesPerformance method!
invoke: aCount
	aCount timesRepeat:
		[self myOperation].!
Annotation key: 'category' value: 'benchmarking'!

OOBMessagesPerformance method!
myOperation
	|foo|
	foo := 10.
	foo := foo.!
Annotation key: 'category' value: 'benchmarking'!

OOBMessagesPerformance method!
testWithCount: aCount
	| theCount |
	theCount := self countWithDefault: aCount.
	Transcript show: '**** Testing virtual operations'; cr.
	self actionWithSubNumber: 1 message: 'invoke' count: theCount do: [
		self invoke: theCount ].!
Annotation key: 'category' value: 'benchmarking'!

OOBMessagesPerformance classMethod!
bench
	|performance|
	performance := OOBMessagesPerformance 
		newBenchmarkWithAccurate:true testOnly:false.
	performance testWithCount: 50000000.!
Annotation key: 'category' value: 'benchmarking'!

OOBMessagesPerformance classMethod!
majorNumber
	^5!
Annotation key: 'category' value: 'identity'!

OOBMessagesPerformance classMethod!
minorNumber
	^2!
Annotation key: 'category' value: 'identity'!

