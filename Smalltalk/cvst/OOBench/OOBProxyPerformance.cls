Smalltalk interchangeVersion: '1.0'!

Class named: 'OOBProxyPerformance'
	superclass: 'OOBAbstractBenchmark'
	indexedInstanceVariables: #none
	instanceVariableNames: ''
	classVariableNames: ''
	sharedPools: ''
	classInstanceVariableNames: ''!
Annotation key: 'category' value: 'OOBench'!
Annotation key: 'package' value: 'OOBench'!

OOBProxyPerformance method!
invokeWithoutProxyWithCount: aCount
	| data |
	data := OOBProxyData new.
	self reset.
	aCount timesRepeat:
		[ data theSize = 1234
			ifFalse: [ Transcript show: 'Error: operation ''theSize'' did not return the ',
				'expected value (1234)!!'; cr. ]].
	self reset.!
Annotation key: 'category' value: 'benchmarking'!

OOBProxyPerformance method!
invokeWithProxyWithCount: aCount
	| data |
	data := OOBCommonProxy proxyWithObject: (OOBProxyData new).
	self reset.
	aCount timesRepeat:
		[ data theSize = 1234
			ifFalse: [ Transcript show: 'Error: operation ''theSize'' did not return the ',
				'expected value (1234)!!'; cr. ]].
	self reset.!
Annotation key: 'category' value: 'benchmarking'!

OOBProxyPerformance method!
testWithCount: aCount
	|count|
	count := self countWithDefault: aCount.
	self actionWithSubNumber: 1 message: 'operation call' count: count
		comment: 'full dynamic proxy' do: [
			self invokeWithProxyWithCount: count ].
	
	self actionWithSubNumber: 2 message: 'operation call, without proxy'
		count: count do: [
			self invokeWithoutProxyWithCount: count ].!
Annotation key: 'category' value: 'benchmarking'!

OOBProxyPerformance classMethod!
bench
	|performance|
	performance := OOBProxyPerformance
		newBenchmarkWithAccurate:true testOnly:false.
	performance testWithCount: 5000000.!
Annotation key: 'category' value: 'benchmarking'!

OOBProxyPerformance classMethod!
majorNumber
	^8.!
Annotation key: 'category' value: 'identity'!

OOBProxyPerformance classMethod!
minorNumber
	^2.!
Annotation key: 'category' value: 'identity'!

