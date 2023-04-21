!classDefinition: #Heap category: #'Collections-Sequenceable'!
SequenceableCollection subclass: #Heap
	instanceVariableNames: 'array tally sortBlock indexUpdateBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Collections-Sequenceable'!
!Heap commentStamp: 'nice 9/30/2010 23:22' prior: 0!
Class Heap implements a special data structure commonly referred to as 'heap' [ http://en.wikipedia.org/wiki/Heap_%28data_structure%29 ]
A Heap is a kind of binary tree stored in a linear array - see details after the instance variables description.

Heaps are good at handling priority queues because:
1) greatest priority element according to the sort block will be stored in first position and thus accessed in O(1) operations
2) worse time for inserting or removing an element is in O(log n) operations, where n is the size of the Heap
	Insertion/Removal times are more efficient than above upper bound, provided that:
	a) Elements are only removed at the beginning
	b) Elements are added with arbitrary sort order.
3) there is no need to fully sort the Heap, which makes it more efficient than a SortedCollection

The heap can be fully sorted by sending the message #fullySort.
Worse time for fully sorting the Heap is in O(n log n) operations, but this is rarely used a feature.
Remind that the Heap does not fully sort the collection if you don't ask.
Thus don't expect #do: and other iterators to enumerate elements according to the sortBlock order.

Instance variables:
	array		<Array>		The data repository
	tally		<Integer>	The number of elements in the heap
	sortBlock	<Block|nil>	A two-argument block defining the sort order,
							or nil in which case the default sort order is
								[:element1 :element2| element1 <= element2]
	indexUpdateBlock 	<Block|nil> 
							A two-argument block of the form [:data :index | ... ]
							which allows an application object to keep track of its
							index within the heap.  Useful for quick heap update
							when object's sort value changes (for example, when an
							object in a priority queue has its priority increased
							by an external event, you don't want to have to search
							through the whole heap to find the index before fixing
							the heap).  No update occurs if nil.
									
The Heap can be viewed as a binary tree (every node in the tree has at most two children).
The root is stored in first slot of internal array.
The children are stored in next two slots.
The children of children in next four slots.
etc...
For a node A of index i (1 based), the two children B1 and B2 are thus stored in indices (2*i) and (2*i+1).
Of course, the children indices must be less than the tally otherwise they are considered inexistent.

The Heap does arrange to preserve the following invariant:
For any children B of a node A, A is sorted before B, in other words, (self sort: A before: B) = true
This implies that the root is always the first element according to sort order.

!


!Heap methodsFor: 'accessing' stamp: 'ar 9/10/1999 13:02'!
at: index
	"Return the element at the given position within the receiver"
	(index < 1 or:[index > tally]) ifTrue:[^self errorSubscriptBounds: index].
	^array at: index! !

!Heap methodsFor: 'accessing' stamp: 'ar 7/1/1999 04:14'!
at: index put: newObject
	"Heaps are accessed with #add: not #at:put:"
	^self shouldNotImplement! !

!Heap methodsFor: 'accessing' stamp: 'md 1/19/2006 09:56'!
first
	"Return the first element in the receiver"
	^array at: 1! !

!Heap methodsFor: 'accessing' stamp: 'nice 9/30/2010 23:27'!
fullySort
	"Fully sort the heap.
	This method preserves the heap invariants and can thus be sent safely"
	self privateReverseSort.
	1 to: tally // 2 do: [:i | array swap: i with: 1 + tally - i]! !

!Heap methodsFor: 'accessing' stamp: 'stephane.ducasse 4/13/2009 21:05'!
indexUpdateBlock: aBlockOrNil

	indexUpdateBlock := aBlockOrNil.

! !

!Heap methodsFor: 'accessing' stamp: 'ar 9/10/1999 14:08'!
reSort
	"Resort the entire heap"
	self isEmpty ifTrue:[^self].
	tally // 2 to: 1 by: -1 do:[:i| self downHeap: i].! !

!Heap methodsFor: 'accessing' stamp: 'ar 9/10/1999 13:02'!
size
	"Return the number of elements in the receiver"
	^tally! !

!Heap methodsFor: 'accessing' stamp: 'ar 7/1/1999 04:21'!
sortBlock
	^sortBlock! !

!Heap methodsFor: 'accessing' stamp: 'jmv 12/30/2009 11:25'!
sortBlock: aBlock
	sortBlock _ aBlock.
	self reSort! !


!Heap methodsFor: 'testing' stamp: 'ar 9/10/1999 13:03'!
isEmpty
	"Answer whether the receiver contains any elements."
	^tally = 0! !

!Heap methodsFor: 'testing' stamp: 'jmv 3/1/2010 11:27'!
sorts: element1 before: element2
	"Return true if element1 should be sorted before element2.
	This method defines the sort order in the receiver"
	^ sortBlock
		ifNil: [element1 <= element2]
		ifNotNil: [sortBlock value: element1 value: element2]! !


!Heap methodsFor: 'adding' stamp: 'jcg 3/8/2003 02:07'!
add: anObject
	"Include newObject as one of the receiver's elements. Answer newObject."
	tally = array size ifTrue:[self grow].
	array at: (tally := tally + 1) put: anObject.
	self updateObjectIndex: tally.
	self upHeap: tally.
	^anObject! !


!Heap methodsFor: 'removing' stamp: 'ar 9/10/1999 13:04'!
remove: oldObject ifAbsent: aBlock
	"Remove oldObject as one of the receiver's elements. If several of the 
	elements are equal to oldObject, only one is removed. If no element is 
	equal to oldObject, answer the result of evaluating anExceptionBlock. 
	Otherwise, answer the argument, oldObject."
	1 to: tally do:[:i| 
		(array at: i) = oldObject ifTrue:[^self privateRemoveAt: i]].
	^aBlock value! !

!Heap methodsFor: 'removing' stamp: 'jmv 5/7/2012 21:54'!
removeAll

	array atAllPut: nil.
	tally _ 0! !

!Heap methodsFor: 'removing' stamp: 'ar 9/10/1999 13:05'!
removeAt: index
	"Remove the element at given position"
	(index < 1 or:[index > tally]) ifTrue:[^self errorSubscriptBounds: index].
	^self privateRemoveAt: index! !

!Heap methodsFor: 'removing' stamp: 'ar 9/10/1999 13:05'!
removeFirst
	"Remove the first element from the receiver"
	^self removeAt: 1! !


!Heap methodsFor: 'comparing' stamp: 'jmv 5/13/2015 11:36'!
= otherCollection

	self == otherCollection ifTrue: [^ true].
	self species == otherCollection species ifFalse: [^ false].

	sortBlock = otherCollection sortBlock
		ifFalse: [ ^false ].

	^self hasEqualElements: otherCollection ! !


!Heap methodsFor: 'enumerating' stamp: 'ar 9/10/1999 13:05'!
do: aBlock
	"Evaluate aBlock with each of the receiver's elements as the argument."
	1 to: tally do:[:i| aBlock value: (array at: i)]! !

!Heap methodsFor: 'enumerating' stamp: 'jmv 11/26/2014 20:04'!
select: aBlock 
	"Evaluate aBlock with each of my elements as the argument. Collect into
	a new collection like the receiver, only those elements for which aBlock
	evaluates to true."

	| answer |
	answer _ self species sortBlock: sortBlock.
	self do: [ :each |
		(aBlock value: each)
			ifTrue: [ answer add: each ]].
	^ answer! !


!Heap methodsFor: 'growing' stamp: 'ar 7/1/1999 04:17'!
grow
	"Become larger."
	self growTo: self size + self growSize.! !

!Heap methodsFor: 'growing' stamp: 'ar 7/1/1999 04:18'!
growSize
	"Return the size by which the receiver should grow if there are no empty slots left."
	^array size max: 5! !

!Heap methodsFor: 'growing' stamp: 'ar 7/1/1999 04:18'!
growTo: newSize
	"Grow to the requested size."
	| newArray |
	newArray _ Array new: (newSize max: tally).
	newArray replaceFrom: 1 to: array size with: array startingAt: 1.
	array _ newArray! !

!Heap methodsFor: 'growing' stamp: 'ar 7/1/1999 04:18'!
trim
	"Remove any empty slots in the receiver."
	self growTo: self size.! !


!Heap methodsFor: 'private-heap' stamp: 'jcg 3/8/2003 02:11'!
downHeap: anIndex
	"Check the heap downwards for correctness starting at anIndex.
	 Everything above (i.e. left of) anIndex is ok."
	| value k n j |
	anIndex = 0 ifTrue:[^self].
	n := tally bitShift: -1.
	k := anIndex.
	value := array at: anIndex.
	[k <= n] whileTrue:[
		j := k + k.
		"use max(j,j+1)"
		(j < tally and:[self sorts: (array at: j+1) before: (array at: j)])
				ifTrue:[ j := j + 1].
		"check if position k is ok"
		(self sorts: value before: (array at: j)) 
			ifTrue:[	"yes -> break loop"
					n := k - 1]
			ifFalse:[	"no -> make room at j by moving j-th element to k-th position"
					array at: k put: (array at: j).
					self updateObjectIndex: k.
					"and try again with j"
					k := j]].
	array at: k put: value.
	self updateObjectIndex: k.! !

!Heap methodsFor: 'private-heap' stamp: 'jcg 3/8/2003 02:11'!
downHeapSingle: anIndex
	"This version is optimized for the case when only one element in the receiver can be at a wrong position. It avoids one comparison at each node when travelling down the heap and checks the heap upwards after the element is at a bottom position. Since the probability for being at the bottom of the heap is much larger than for being somewhere in the middle this version should be faster."
	| value k n j |
	anIndex = 0 ifTrue:[^self].
	n := tally bitShift: -1.
	k := anIndex.
	value := array at: anIndex.
	[k <= n] whileTrue:[
		j := k + k.
		"use max(j,j+1)"
		(j < tally and:[self sorts: (array at: j+1) before: (array at: j)])
				ifTrue:[	j := j + 1].
		array at: k put: (array at: j).
		self updateObjectIndex: k.
		"and try again with j"
		k := j].
	array at: k put: value.
	self updateObjectIndex: k.
	self upHeap: k! !

!Heap methodsFor: 'private-heap' stamp: 'jcg 3/8/2003 02:12'!
upHeap: anIndex
	"Check the heap upwards for correctness starting at anIndex.
	 Everything below anIndex is ok."
	| value k kDiv2 tmp |
	anIndex = 0 ifTrue:[^self].
	k := anIndex.
	value := array at: anIndex.
	[ (k > 1) and:[self sorts: value before: (tmp := array at: (kDiv2 := k bitShift: -1))] ] 
		whileTrue:[
			array at: k put: tmp.
			self updateObjectIndex: k.
			k := kDiv2].
	array at: k put: value.
	self updateObjectIndex: k.! !


!Heap methodsFor: 'private' stamp: 'ar 7/1/1999 04:19'!
array
	^array! !

!Heap methodsFor: 'private' stamp: 'ar 9/15/2000 17:12'!
privateRemoveAt: index
	"Remove the element at the given index and make sure the sorting order is okay"
	| removed |
	removed _ array at: index.
	array at: index put: (array at: tally).
	array at: tally put: nil.
	tally _ tally - 1.
	index > tally ifFalse:[
		"Use #downHeapSingle: since only one element has been removed"
		self downHeapSingle: index].
	^removed! !

!Heap methodsFor: 'private' stamp: 'nice 9/30/2010 23:26'!
privateReverseSort
	"Arrange to have the array sorted in reverse order.
	WARNING: this method breaks the heap invariants. It's up to the sender to restore them afterwards."
	| oldTally |
	oldTally := tally.
	[tally > 1] whileTrue:
		[array swap: 1 with: tally.
		tally := tally - 1.
		self downHeapSingle: 1].
	tally := oldTally! !

!Heap methodsFor: 'private' stamp: 'ar 7/1/1999 04:35'!
setCollection: aCollection
	array _ aCollection.
	tally _ 0.! !

!Heap methodsFor: 'private' stamp: 'ar 9/10/1999 13:18'!
setCollection: aCollection tally: newTally
	array _ aCollection.
	tally _ newTally.! !

!Heap methodsFor: 'private' stamp: 'jcg 3/8/2003 02:08'!
updateObjectIndex: index
	"If indexUpdateBlock is not nil, notify the object at index of its new position in the heap array."
	indexUpdateBlock ifNotNil: [
		indexUpdateBlock value: (array at: index) value: index]! !


!Heap methodsFor: 'copying' stamp: 'SqR 2/20/2015 21:13'!
postCopy

	array _ array copy.
	tally _ tally copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Heap class' category: #'Collections-Sequenceable'!
Heap class
	instanceVariableNames: ''!

!Heap class methodsFor: 'instance creation' stamp: 'ar 7/1/1999 04:20'!
new
	^self new: 10! !

!Heap class methodsFor: 'instance creation' stamp: 'ar 7/1/1999 04:20'!
new: n
	^super new setCollection: (Array new: n)! !

!Heap class methodsFor: 'instance creation' stamp: 'jmv 3/7/2015 23:04'!
newFrom: aCollection
	"Create a new heap with all the elements from aCollection"
	^(self basicNew)
		setCollection: aCollection asArray copy tally: aCollection size;
		reSort;
		yourself! !

!Heap class methodsFor: 'instance creation' stamp: 'ar 9/10/1999 14:13'!
sortBlock: aBlock
	"Create a new heap sorted by the given block"
	^self new sortBlock: aBlock! !

!Heap class methodsFor: 'instance creation' stamp: 'ar 5/23/2001 17:22'!
withAll: aCollection sortBlock: sortBlock
	"Create a new heap with all the elements from aCollection"
	^(self basicNew)
		setCollection: aCollection asArray copy tally: aCollection size;
		sortBlock: sortBlock;
		yourself! !


!Heap class methodsFor: 'examples' stamp: 'jmv 3/13/2012 12:35'!
heapExample	"Heap heapExample"
	"Create a sorted collection of numbers, remove the elements
	sequentially and add new objects randomly.
	Note: This is the kind of benchmark a heap is designed for."
	| n rnd array time |
	n := 5000. "# of elements to sort"
	rnd := Random new.
	array := (1 to: n) collect:[:i| rnd next].
	"First, the heap version"
	time := Time millisecondsToRun:[| sorted |
		sorted := Heap withAll: array.
		1 to: n do: [ :i | 
			sorted removeFirst.
			sorted add: rnd next].
	].
	Transcript newLine; show:'Time for Heap: ', time printString,' msecs'.
	"The quicksort version"
	time := Time millisecondsToRun:[| sorted |
		sorted := SortedCollection withAll: array.
		1 to: n do:[:i| 
			sorted removeFirst.
			sorted add: rnd next].
	].
	Transcript newLine; show:'Time for SortedCollection: ', time printString,' msecs'.
! !

!Heap class methodsFor: 'examples' stamp: 'jmv 3/13/2012 12:36'!
heapSortExample	"Heap heapSortExample"
	"Sort a random collection of Floats and compare the results with
	SortedCollection (using the quick-sort algorithm) and 
	ArrayedCollection>>mergeSortFrom:to:by: (using the merge-sort algorithm)."
	| n rnd array time |
	n := 10000. "# of elements to sort"
	rnd := Random new.
	array := (1 to: n) collect:[:i| rnd next].
	"First, the heap version"
	time := Time millisecondsToRun: [
		| sorted |
		sorted := Heap withAll: array.
		1 to: n do: [ :i | sorted removeFirst ]].
	Transcript newLine; show:'Time for heap-sort: ', time printString,' msecs'.
	"The quicksort version"
	time := Time millisecondsToRun:[| sorted |
		sorted := SortedCollection withAll: array.
	].
	Transcript newLine; show:'Time for quick-sort: ', time printString,' msecs'.
	"The merge-sort version"
	time := Time millisecondsToRun:[
		array mergeSortFrom: 1 to: array size by: [:v1 :v2| v1 <= v2].
	].
	Transcript newLine; show:'Time for merge-sort: ', time printString,' msecs'.
! !


!classDefinition: #Interval category: #'Collections-Sequenceable'!
SequenceableCollection subclass: #Interval
	instanceVariableNames: 'start stop count'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Collections-Sequenceable'!
!Interval commentStamp: '<historical>' prior: 0!
I represent a finite arithmetic progression.!


!Interval methodsFor: 'accessing' stamp: 'jmv 2/9/2010 22:55'!
anyOne
 	"This message will fail for an empty Interval, super would not."
 	^self at: 1! !

!Interval methodsFor: 'accessing' stamp: 'jmv 4/9/2016 16:18'!
at: i 
	"Answer the anInteger'th element."

	(i >= 1 and: [i <= count])
		ifTrue: [
			count=1 ifTrue: [ ^start ].
			^start + ((stop-start)/(count-1)*(i-1))]
		ifFalse: [self errorSubscriptBounds: i]! !

!Interval methodsFor: 'accessing' stamp: 'ST-80 5/31/1983 9:10:35'!
at: anInteger put: anObject 
	"Storing into an Interval is not allowed."

	self error: 'you can not store into an interval'! !

!Interval methodsFor: 'accessing' stamp: 'stp 8/19/2000 23:52'!
extent 
	"Answer the max - min of the receiver interval."
	"(10 to: 50) extent"

	^stop - start! !

!Interval methodsFor: 'accessing' stamp: 'ST-80 5/31/1983 9:10:35'!
first
	^start! !

!Interval methodsFor: 'accessing' stamp: 'jmv 4/9/2016 16:00'!
increment
	"Answer the receiver's interval increment."

	^stop = start ifFalse: [stop-start / (count-1)] ifTrue:[1]! !

!Interval methodsFor: 'accessing' stamp: 'jmv 4/28/2022 11:20:19'!
isEmpty
	^self size = 0! !

!Interval methodsFor: 'accessing' stamp: 'jmv 4/9/2016 15:59'!
last 
	"Refer to the comment in SequenceableCollection|last."

	^ stop! !

!Interval methodsFor: 'accessing' stamp: 'jmv 4/9/2016 16:03'!
rangeIncludes: aNumber
	"Return true if the number lies in the interval between start and stop."

	^stop >= start
		ifTrue: [ aNumber between: start and: stop ]
		ifFalse: [ aNumber between: stop and: start ]! !

!Interval methodsFor: 'accessing' stamp: 'jmv 4/9/2016 15:57'!
size

	^ count! !


!Interval methodsFor: 'comparing' stamp: 'jmv 4/9/2016 16:02'!
= otherCollection

	self == otherCollection ifTrue: [^ true].
	"(1 to: 3) = #( 1 2 3) -> false"
	otherCollection isInterval ifFalse: [ ^false ].
	^ start = otherCollection first
		and: [count = otherCollection size
			and: [self last = otherCollection last]]! !

!Interval methodsFor: 'comparing' stamp: 'jmv 11/4/2019 11:07:17'!
hash
	"Hash is reimplemented because = is implemented."

	^ (start hash bitXor: stop hash) bitXor: count hash! !


!Interval methodsFor: 'adding' stamp: 'ST-80 5/31/1983 9:10:35'!
add: newObject 
	"Adding to an Interval is not allowed."
	self shouldNotImplement! !


!Interval methodsFor: 'removing' stamp: 'ST-80 5/31/1983 9:10:35'!
remove: newObject 
	"Removing from an Interval is not allowed."

	self error: 'elements cannot be removed from an Interval'! !


!Interval methodsFor: 'enumerating' stamp: 'jmv 4/9/2016 16:01'!
do: aBlock

	1 to: count do: [ :i |
		aBlock value: (self at: i) ]		! !

!Interval methodsFor: 'enumerating' stamp: 'dhn 5/14/2016 22:18'!
permutationsDo: aBlock
	"Repeatly value aBlock with a single copy of the receiver. Reorder the copy
	so that aBlock is presented all (self size factorial) possible permutations.

	(1 to: 4) permutationsDo: [:each | Transcript newLine; show: each printString].
	"

	self asArray permutationsDo: aBlock
! !

!Interval methodsFor: 'enumerating' stamp: 'jmv 4/9/2016 16:02'!
reverseDo: aBlock 
	"Evaluate aBlock for each element of my interval, in reverse order."
	
	count to: 1 by: -1 do: [ :i |
		aBlock value: (self at: i) ]	! !


!Interval methodsFor: 'printing' stamp: 'jmv 4/9/2016 16:23'!
printOn: aStream
	| s |
	aStream nextPut: $(;
	 print: start;
	 nextPutAll: ' to: ';
	 print: stop.
	s _ self increment.
	s ~= 1 ifTrue: [aStream nextPutAll: ' by: '; print: s].
	aStream nextPut: $)! !

!Interval methodsFor: 'printing' stamp: 'ST-80 5/31/1983 9:10:35'!
storeOn: aStream 
	"This is possible because we know numbers store and print the same"

	self printOn: aStream! !


!Interval methodsFor: 'private' stamp: 'jmv 4/9/2016 16:25'!
setFrom: startNumber to: stopNumber count: countInteger
	"start and stop can be integers, fractions, floats, whatever.
	Usually stop>start, but stop=start and stop<start are also possible."

	start _ startNumber.
	stop _ stopNumber.
	count _ countInteger! !

!Interval methodsFor: 'private' stamp: 'ST-80 5/31/1983 9:10:35'!
species
	^Array! !


!Interval methodsFor: 'testing' stamp: 'HAW 5/2/2020 11:53:30'!
includes: aNumber

	| index |
	
	aNumber isNumber ifFalse: [ ^ false ].
	
	^ start = stop 
		ifTrue: [ start = aNumber ]
		ifFalse: [ 
			index := (aNumber - start) / (stop-start) * (count-1) + 1.
			index isInteger and: [ index between: 1 and: count ]]! !

!Interval methodsFor: 'testing' stamp: 'HAW 6/11/2022 19:29:34'!
includesAllOf: aCollection

	^aCollection isInterval
		ifTrue: [ (self includes: aCollection first)
			and: [ (self includes: aCollection last)
			and: [ self increment = aCollection increment or: [ super includesAllOf:aCollection ]]]]
		ifFalse: [ super includesAllOf: aCollection ]! !

!Interval methodsFor: 'testing' stamp: 'rhi 8/12/2003 09:52'!
isInterval

	^ true! !


!Interval methodsFor: 'arithmetic' stamp: 'jmv 4/9/2016 16:25'!
+ number

	^ start + number to: stop + number count: count! !

!Interval methodsFor: 'arithmetic' stamp: 'jmv 4/9/2016 16:25'!
- number

	^ start - number to: stop - number count: count! !


!Interval methodsFor: 'converting' stamp: 'RNG 5/8/2020 20:59:03'!
asSourceCodeInterval

	^ SourceCodeInterval from: start to: stop! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Interval class' category: #'Collections-Sequenceable'!
Interval class
	instanceVariableNames: ''!

!Interval class methodsFor: 'instance creation' stamp: 'jmv 4/9/2016 16:41'!
from: startInteger to: stopInteger 
	"Answer an instance of me, starting at startNumber, ending at 
	stopNumber, and with an interval increment of 1."

	^self basicNew
		setFrom: startInteger
		to: stopInteger
		count: (stopInteger-startInteger) abs + 1! !

!Interval class methodsFor: 'instance creation' stamp: 'sqr 12/15/2018 00:19:19'!
from: start to: stop by: step
	"Answer an instance of me, starting at start, ending at 
	stop, and with an interval increment of step.
	The actual interval creation uses start, stop and count, to avoid accumulation of rounding errors.
	We need to tell apart things like
		(0.0 to: 2.4 by: 0.1)	the caller wants to honor end
	from
		(0.0 to: 10.0 by: 3.0) 	the caller actually wants to end at 9.0.
		
	Before this,
		(0 to: 2.4 by: 0.1) last 
	used to answer 2.3"
	| count end |
	count _ stop - start / step + 1.
	(count isFloat and: [count isWithin: 5 floatsFrom: count rounded asFloat])
		ifTrue: [
			count _ count rounded.
			end _ stop ]
		ifFalse: [
			count _ count truncated.
			end _ count-1 * step + start ].
	^self from: start to: end count: count! !

!Interval class methodsFor: 'instance creation' stamp: 'jmv 4/9/2016 19:25'!
from: start to: stop count: n
	"Answer an instance of me, starting at start, ending at 
	stop, and with n elements."

	^self basicNew setFrom: start to: stop count: n! !

!Interval class methodsFor: 'instance creation' stamp: 'jmv 7/4/2016 22:17'!
integersFrom: start to: stop count: n
	"Answer an instance of me, starting at start, ending at 
	stop, and with n elements. All the elements will be integer numbers."

	| answer |
	answer _ self from: start asInteger to: stop asInteger count: n.
	answer increment isFraction
		ifTrue: [answer _ answer collect: [ :each | each rounded ]].
	^answer! !

!Interval class methodsFor: 'instance creation' stamp: 'jmv 7/9/2017 16:59:23'!
newFrom: aCollection 
	"Answer an instance of me containing the same elements as aCollection."

    | newInterval n |

    (n := aCollection size) <= 1 ifTrue: [
		n = 0 ifTrue: [^self from: 1 to: 0].
		^self from: aCollection first to: aCollection last].
    	newInterval := self from: aCollection first to: aCollection last by: (aCollection last - aCollection first) // (n - 1).
	(newInterval hasEqualElements: aCollection)
		ifFalse: [ self error: 'The argument is not an arithmetic progression' ].
	^newInterval

"
	Interval newFrom: {1. 2. 3}
	{33. 5. -23} as: Interval
	{33. 5. -22} as: Interval.   ' (an error)'
	(-4 to: -12 by: -1) as: Interval
"! !


!classDefinition: #LinkedList category: #'Collections-Sequenceable'!
SequenceableCollection subclass: #LinkedList
	instanceVariableNames: 'firstLink lastLink'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Collections-Sequenceable'!
!LinkedList commentStamp: '<historical>' prior: 0!
I represent a collection of links, which are containers for other objects. Using the message sequence addFirst:/removeLast causes the receiver to behave as a stack; using addLast:/removeFirst causes the receiver to behave as a queue.!


!LinkedList methodsFor: 'accessing' stamp: 'jmv 5/25/2014 15:45'!
at: index

	^self at: index ifAbsent: [ self errorSubscriptBounds: index ]! !

!LinkedList methodsFor: 'accessing' stamp: 'jmv 5/25/2014 15:44'!
at: index ifAbsent: exceptionBlock

	| i |
	index < 1 ifTrue: [ ^exceptionBlock value ].
	i _ 0.
	self do: [ :link |
		(i _ i + 1) = index ifTrue: [ ^ link ]].
	^ exceptionBlock value! !

!LinkedList methodsFor: 'accessing' stamp: 'ST-80 5/31/1983 9:10:35'!
first
	"Answer the first link;  create an error if the receiver is empty."

	self emptyCheck.
	^firstLink! !

!LinkedList methodsFor: 'accessing' stamp: 'ST-80 5/31/1983 9:10:35'!
last
	"Answer the last link;  create an error if the receiver is empty."

	self emptyCheck.
	^lastLink! !


!LinkedList methodsFor: 'testing' stamp: 'ST-80 5/31/1983 9:10:35'!
isEmpty
	^firstLink == nil! !


!LinkedList methodsFor: 'adding' stamp: 'ST-80 5/31/1983 9:10:35'!
add: aLink 
	"Add aLink to the end of the receiver's list."

	^self addLast: aLink! !

!LinkedList methodsFor: 'adding' stamp: 'ajh 8/22/2002 14:17'!
add: link before: otherLink

	| aLink |
	firstLink == otherLink ifTrue: [^ self addFirst: link].
	aLink _ firstLink.
	[aLink == nil] whileFalse: [
		aLink nextLink == otherLink ifTrue: [
			link nextLink: aLink nextLink.
			aLink nextLink: link.
			^ link
		].
		 aLink _ aLink nextLink.
	].
	^ self errorNotFound: otherLink! !

!LinkedList methodsFor: 'adding' stamp: 'ST-80 5/31/1983 9:10:35'!
addFirst: aLink 
	"Add aLink to the beginning of the receiver's list."

	self isEmpty ifTrue: [lastLink _ aLink].
	aLink nextLink: firstLink.
	firstLink _ aLink.
	^aLink! !

!LinkedList methodsFor: 'adding' stamp: 'ST-80 5/31/1983 9:10:35'!
addLast: aLink 
	"Add aLink to the end of the receiver's list."

	self isEmpty
		ifTrue: [firstLink _ aLink]
		ifFalse: [lastLink nextLink: aLink].
	lastLink _ aLink.
	^aLink! !


!LinkedList methodsFor: 'removing' stamp: 'jmv 3/1/2010 11:30'!
remove: aLink ifAbsent: aBlock  
	"Remove aLink from the receiver. If it is not there, answer the result of
	evaluating aBlock."

	| tempLink |
	aLink == firstLink
		ifTrue: [firstLink _ aLink nextLink.
				aLink == lastLink
					ifTrue: [lastLink _ nil]]
		ifFalse: [tempLink _ firstLink.
				[tempLink ifNil: [^aBlock value].
				 tempLink nextLink == aLink]
					whileFalse: [tempLink _ tempLink nextLink].
				tempLink nextLink: aLink nextLink.
				aLink == lastLink
					ifTrue: [lastLink _ tempLink]].
	aLink nextLink: nil.
	^aLink! !

!LinkedList methodsFor: 'removing' stamp: 'ST-80 5/31/1983 9:10:35'!
removeFirst
	"Remove the first element.  If the receiver is empty, cause an error;
	otherwise answer the removed element.  Using the sequence addFirst:/removeFirst
	causes the receiver to behave as a stack; using addLast:/removeFirst causes the
	receiver to behave as a queue."

	| oldLink |
	self emptyCheck.
	oldLink _ firstLink.
	firstLink == lastLink
		ifTrue: [firstLink _ nil. lastLink _ nil]
		ifFalse: [firstLink _ oldLink nextLink].
	oldLink nextLink: nil.
	^oldLink! !

!LinkedList methodsFor: 'removing' stamp: 'ST-80 5/31/1983 9:10:35'!
removeLast
	"Remove the receiver's last element.  If the receiver is empty, cause an error;
	otherwise answer the removed element.  Using addLast:/removeLast causes the
	receiver to behave as a stack; using addFirst:/removeLast causes the receiver to
	behave as a queue."

	| oldLink aLink |
	self emptyCheck.
	oldLink _ lastLink.
	firstLink == lastLink
		ifTrue: [firstLink _ nil. lastLink _ nil]
		ifFalse: [aLink _ firstLink.
				[aLink nextLink == oldLink] whileFalse:
					[aLink _ aLink nextLink].
				 aLink nextLink: nil.
				 lastLink _ aLink].
	oldLink nextLink: nil.
	^oldLink! !


!LinkedList methodsFor: 'enumerating' stamp: 'ST-80 5/31/1983 9:10:35'!
do: aBlock
	| aLink |
	aLink _ firstLink.
	[aLink == nil] whileFalse:
		[aBlock value: aLink.
		 aLink _ aLink nextLink]! !

!LinkedList methodsFor: 'enumerating' stamp: 'ajh 8/6/2002 16:39'!
species

	^ Array! !


!classDefinition: #OrderedCollection category: #'Collections-Sequenceable'!
SequenceableCollection subclass: #OrderedCollection
	instanceVariableNames: 'array firstIndex lastIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Collections-Sequenceable'!
!OrderedCollection commentStamp: '<historical>' prior: 0!
I represent a collection of objects ordered by the collector.!


!OrderedCollection methodsFor: 'accessing' stamp: 'Squeak1.0 9/20/1996 10:50:05'!
at: anInteger 
	"Answer my element at index anInteger. at: is used by a knowledgeable
	client to access an existing element"

	(anInteger < 1 or: [anInteger + firstIndex - 1 > lastIndex])
		ifTrue: [self errorNoSuchElement]
		ifFalse: [^ array at: anInteger + firstIndex - 1]! !

!OrderedCollection methodsFor: 'accessing' stamp: 'Squeak1.0 9/20/1996 10:50:05'!
at: anInteger put: anObject 
	"Put anObject at element index anInteger. at:put: cannot be used to
	append, front or back, to an ordered collection; it is used by a
	knowledgeable client to replace an element."

	| index |
	index _ anInteger asInteger.
	(index < 1 or: [index + firstIndex - 1 > lastIndex])
		ifTrue: [self errorNoSuchElement]
		ifFalse: [^array at: index + firstIndex - 1 put: anObject]! !

!OrderedCollection methodsFor: 'accessing' stamp: 'jmv 4/28/2022 11:20:47'!
isEmpty
	^self size = 0! !

!OrderedCollection methodsFor: 'accessing' stamp: 'ST-80 5/31/1983 9:10:35'!
size
	^lastIndex - firstIndex + 1! !


!OrderedCollection methodsFor: 'adding' stamp: 'ST-80 5/31/1983 9:10:35'!
add: newObject 
	^self addLast: newObject! !

!OrderedCollection methodsFor: 'adding' stamp: 'ST-80 5/31/1983 9:10:35'!
add: newObject after: oldObject 
	"Add the argument, newObject, as an element of the receiver.  Put it
	in the position just succeeding oldObject.  Answer newObject."
	
	| index |
	index _ self find: oldObject.
	self insert: newObject before: index + 1.
	^newObject! !

!OrderedCollection methodsFor: 'adding' stamp: 'ar 7/15/2008 23:03'!
add: newObject afterIndex: index 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just after index. Answer newObject."
	(index between: 0 and: self size) ifFalse:[^self errorSubscriptBounds: index].
	self insert: newObject before: firstIndex + index.
	^ newObject! !

!OrderedCollection methodsFor: 'adding' stamp: 'ST-80 5/31/1983 9:10:35'!
add: newObject before: oldObject 
	"Add the argument, newObject, as an element of the receiver.  Put it
	in the position just preceding oldObject.  Answer newObject."
	
	| index |
	index _ self find: oldObject.
	self insert: newObject before: index.
	^newObject! !

!OrderedCollection methodsFor: 'adding' stamp: 'ar 7/15/2008 23:05'!
add: newObject beforeIndex: index 
	"Add the argument, newObject, as an element of the receiver. Put it in 
	the sequence just before index. Answer newObject."
	(index between: 1 and: self size+1) ifFalse:[^self errorSubscriptBounds: index].
	self insert: newObject before: firstIndex + index - 1.
	^ newObject! !

!OrderedCollection methodsFor: 'adding' stamp: 'ST-80 5/31/1983 9:10:35'!
addAllFirst: anOrderedCollection 
	"Add each element of anOrderedCollection at the beginning of the receiver.	
	Answer anOrderedCollection."

	anOrderedCollection reverseDo: [:each | self addFirst: each].
	^anOrderedCollection! !

!OrderedCollection methodsFor: 'adding' stamp: 'ul 4/12/2015 23:55'!
addAllLast: aCollection 
	"Add each element of aCollection at the end of me. Answer aCollection."

	^aCollection do: [ :each | self addLast: each ]! !

!OrderedCollection methodsFor: 'adding' stamp: 'Squeak1.0 9/20/1996 10:50:05'!
addFirst: newObject 
	"Add newObject to the beginning of the receiver. Answer newObject."

	firstIndex = 1 ifTrue: [self makeRoomAtFirst].
	firstIndex _ firstIndex - 1.
	array at: firstIndex put: newObject.
	^ newObject! !

!OrderedCollection methodsFor: 'adding' stamp: 'Squeak1.0 9/20/1996 10:50:05'!
addLast: newObject 
	"Add newObject to the end of the receiver. Answer newObject."

	lastIndex = array size ifTrue: [self makeRoomAtLast].
	lastIndex _ lastIndex + 1.
	array at: lastIndex put: newObject.
	^ newObject! !

!OrderedCollection methodsFor: 'adding' stamp: 'ajh 5/22/2003 12:03'!
at: index ifAbsentPut: block
	"Return value at index, however, if value does not exist (nil or out of bounds) then add block's value at index (growing self if necessary)"

	| v |
	index <= self size ifTrue: [
		^ (v _ self at: index)
			ifNotNil: [v]
			ifNil: [self at: index put: block value]
	].
	[self size < index] whileTrue: [self add: nil].
	^ self at: index put: block value! !

!OrderedCollection methodsFor: 'adding' stamp: 'Squeak1.0 9/20/1996 10:50:05'!
growSize
	^ array size max: 2! !


!OrderedCollection methodsFor: 'copying' stamp: 'jmv 5/14/2015 09:45'!
copy

	^self copyFrom: 1 to: self size! !

!OrderedCollection methodsFor: 'copying' stamp: 'di 12/12/2000 10:15'!
copyFrom: startIndex to: endIndex 
	"Answer a copy of the receiver that contains elements from position
	startIndex to endIndex."

	| targetCollection |
	endIndex < startIndex ifTrue: [^self species new: 0].
	targetCollection _ self species new: endIndex + 1 - startIndex.
	startIndex to: endIndex do: [:index | targetCollection addLast: (self at: index)].
	^ targetCollection! !

!OrderedCollection methodsFor: 'copying' stamp: 'Squeak1.2 6/29/1997 10:40:55'!
copyReplaceFrom: start to: stop with: replacementCollection 
	"Answer a copy of the receiver with replacementCollection's elements in
	place of the receiver's start'th to stop'th elements. This does not expect
	a 1-1 map from replacementCollection to the start to stop elements, so it
	will do an insert or append."

	| newOrderedCollection delta startIndex stopIndex |
	"if start is less than 1, ignore stop and assume this is inserting at the front. 
	if start greater than self size, ignore stop and assume this is appending. 
	otherwise, it is replacing part of me and start and stop have to be within my 
	bounds. "
	delta _ 0.
	startIndex _ start.
	stopIndex _ stop.
	start < 1
		ifTrue: [startIndex _ stopIndex _ 0]
		ifFalse: [startIndex > self size
				ifTrue: [startIndex _ stopIndex _ self size + 1]
				ifFalse: 
					[(stopIndex < (startIndex - 1) or: [stopIndex > self size])
						ifTrue: [self errorOutOfBounds].
					delta _ stopIndex - startIndex + 1]].
	newOrderedCollection _ 
		self species new: self size + replacementCollection size - delta.
	1 to: startIndex - 1 do: [:index | newOrderedCollection add: (self at: index)].
	1 to: replacementCollection size do: 
		[:index | newOrderedCollection add: (replacementCollection at: index)].
	stopIndex + 1 to: self size do: [:index | newOrderedCollection add: (self at: index)].
	^newOrderedCollection! !

!OrderedCollection methodsFor: 'copying' stamp: 'ST-80 5/31/1983 9:10:35'!
copyWith: newElement 
	"Answer a copy of the receiver that is 1 bigger than the receiver and 
	includes the argument, newElement, at the end."

	| newCollection |
	newCollection _ self copy.
	newCollection add: newElement.
	^newCollection! !

!OrderedCollection methodsFor: 'copying' stamp: 'sw 1/26/96'!
reversed
	"Answer a copy of the receiver with element order reversed.  "
	| newCol |
	newCol _ self species new.
	self reverseDo:
		[:elem | newCol addLast: elem].
	^ newCol

"#(2 3 4 'fred') reversed"! !


!OrderedCollection methodsFor: 'enumerating' stamp: 'len 11/28/2016 10:50:21'!
collect: aBlock 
	"Evaluate aBlock with each of my elements as the argument. Collect the 
	resulting values into a collection that is like me. Answer the new 
	collection. Override superclass in order to use addLast:, not at:put:."

	| newCollection |
	newCollection _ self species new: self size.
	newCollection resetTo: 1.
	firstIndex to: lastIndex do: [ :index |
		newCollection addLast: (aBlock value: (array at: index))].
	^ newCollection! !

!OrderedCollection methodsFor: 'enumerating' stamp: 'bf 5/18/2000 17:34'!
collect: aBlock from: fromIndex to: toIndex
	"Override superclass in order to use addLast:, not at:put:."
	| result |
	(fromIndex < 1 or:[toIndex + firstIndex - 1 > lastIndex])
		ifTrue: [^self errorNoSuchElement].
	result _ self species new: toIndex - fromIndex + 1.
	firstIndex + fromIndex - 1 to: firstIndex + toIndex - 1 do:
		[:index | result addLast: (aBlock value: (array at: index))].
	^ result
! !

!OrderedCollection methodsFor: 'enumerating' stamp: 'jmv 10/13/2021 10:40:07'!
collect: collectBlock thenSelect: selectBlock
	"Evaluate collectBlock with each my elements as the argument. Collect the 
	resulting values into a collection that is like me, but only those elements for which
	selectBlock evaluates to true. Answer the new collection.
	Overriden for performance."

	| newCollection newElement |
	newCollection _ self species new.
	newCollection resetTo: 1.
	firstIndex to: lastIndex do: [ :index |
		newElement _ collectBlock value: (array at: index).
		(selectBlock value: newElement)
			ifTrue: [ newCollection addLast: newElement ]].
	^ newCollection! !

!OrderedCollection methodsFor: 'enumerating' stamp: 'jmv 9/3/2014 22:50'!
do: aBlock 

	firstIndex to: lastIndex do: [ :index |
		aBlock value: (array at: index) ]! !

!OrderedCollection methodsFor: 'enumerating' stamp: 'jmv 9/3/2014 22:52'!
reverseDo: aBlock 

	lastIndex to: firstIndex by: -1 do: [ :index |
		aBlock value: (array at: index) ]! !

!OrderedCollection methodsFor: 'enumerating' stamp: 'jmv 10/13/2021 10:36:49'!
select: aBlock 
	"Evaluate aBlock with each of my elements as the argument. Collect into
	a new collection like the receiver, only those elements for which aBlock
	evaluates to true."

	| newCollection element |
	newCollection _ self species new.
	newCollection resetTo: 1.
	firstIndex to: lastIndex do: [ :index |
		(aBlock value: (element _ array at: index))
			ifTrue: [ newCollection addLast: element ]].
	^ newCollection! !

!OrderedCollection methodsFor: 'enumerating' stamp: 'jmv 10/13/2021 10:42:23'!
select: selectBlock thenCollect: collectBlock
	"Evaluate selectBlock with each my elements as the argument. For those who evaluate to true,
	collect the result of evaluating collectBlock on them into a collection that is like me.
	Answer the new collection.
	Overriden for performance."

	| newCollection each |
	newCollection _ self species new.
	newCollection resetTo: 1.
	firstIndex to: lastIndex do: [ :index |
		each _ array at: index.
		(selectBlock value: each) ifTrue: [
			newCollection addLast: (collectBlock value: each) ]].
	^ newCollection! !

!OrderedCollection methodsFor: 'enumerating' stamp: 'di 8/31/1999 13:13'!
with: otherCollection collect: twoArgBlock 
	"Collect and return the result of evaluating twoArgBlock with 
	corresponding elements from this collection and otherCollection."
	| result |
	otherCollection size = self size ifFalse: [self error: 'otherCollection must be the same size'].
	result _ self species new: self size.
	1 to: self size do:
		[:index | result addLast: (twoArgBlock value: (self at: index)
									value: (otherCollection at: index))].
	^ result! !

!OrderedCollection methodsFor: 'enumerating' stamp: 'jmv 11/30/2016 14:51:19'!
with: otherCollection with: thirdCollection collect: threeArgBlock
	"Collect and return the result of evaluating twoArgBlock with 
	corresponding elements from this collection and otherCollection."
	| result |
	otherCollection size = self size ifFalse: [self error: 'otherCollection must be the same size'].
	result _ self species new: self size.
	1 to: self size do: [ :index |
		result addLast:
			(threeArgBlock
				value: (self at: index)
				value: (otherCollection at: index)
				value: (thirdCollection at: index) )].
	^ result! !

!OrderedCollection methodsFor: 'enumerating' stamp: 'bf 5/16/2000 16:30'!
withIndexCollect: elementAndIndexBlock 
	"Just like with:collect: except that the iteration index supplies the second argument to the block. Override superclass in order to use addLast:, not at:put:."

	| newCollection |
	newCollection _ self species new: self size.
	firstIndex to: lastIndex do:
		[:index |
		newCollection addLast: (elementAndIndexBlock
			value: (array at: index)
			value: index - firstIndex + 1)].
	^ newCollection! !


!OrderedCollection methodsFor: 'inspecting' stamp: 'sqr 5/22/2020 19:53:21'!
inspectorClass 
	"Answer the class of the inspector to be used on the receiver.  Called by inspect; 
	use basicInspect to get a normal (less useful) type of inspector."

	^SequenceableCollectionInspector! !


!OrderedCollection methodsFor: 'removing' stamp: 'jmv 9/3/2014 22:54'!
remove: oldObject ifAbsent: absentBlock

	firstIndex to: lastIndex do: [ :index |
		oldObject = (array at: index)
			ifTrue: [
				self removeIndex: index.
				^ oldObject ]].
	^ absentBlock value! !

!OrderedCollection methodsFor: 'removing' stamp: 'jmv 3/30/2011 08:56'!
removeAll

	array from: firstIndex to: lastIndex put: nil.
	lastIndex _ firstIndex - 1! !

!OrderedCollection methodsFor: 'removing' stamp: 'ul 10/17/2010 03:10'!
removeAllSuchThat: aBlock 
	"Remove each element of the receiver for which aBlock evaluates to true.
	The method in Collection is O(N^2), this is O(N)."

	| n |
	n := firstIndex.
	firstIndex to: lastIndex do: [:index |
	    (aBlock value: (array at: index)) ifFalse: [
			array at: n put: (array at: index).
			n := n + 1]].
	array from: n to: lastIndex put: nil.
	lastIndex := n - 1! !

!OrderedCollection methodsFor: 'removing' stamp: 'ar 5/22/2000 12:19'!
removeAt: index
	| removed |
	removed _ self at: index.
	self removeIndex: index + firstIndex - 1.
	^removed! !

!OrderedCollection methodsFor: 'removing' stamp: 'Squeak1.0 9/20/1996 10:50:05'!
removeFirst
	"Remove the first element of the receiver and answer it. If the receiver is 
	empty, create an error notification."
	| firstObject |
	self emptyCheck.
	firstObject _ array at: firstIndex.
	array at: firstIndex put: nil.
	firstIndex _ firstIndex + 1.
	^ firstObject! !

!OrderedCollection methodsFor: 'removing' stamp: 'ajh 6/22/2003 14:37'!
removeFirst: n
	"Remove first n object into an array"

	| list |
	list _ Array new: n.
	1 to: n do: [:i |
		list at: i put: self removeFirst].
	^ list! !

!OrderedCollection methodsFor: 'removing' stamp: 'Squeak1.0 9/20/1996 10:50:05'!
removeLast
	"Remove the last element of the receiver and answer it. If the receiver is 
	empty, create an error notification."
	| lastObject |
	self emptyCheck.
	lastObject _ array at: lastIndex.
	array at: lastIndex put: nil.
	lastIndex _ lastIndex - 1.
	^ lastObject! !

!OrderedCollection methodsFor: 'removing' stamp: 'ajh 6/22/2003 14:36'!
removeLast: n
	"Remove last n object into an array with last in last position"

	| list |
	list _ Array new: n.
	n to: 1 by: -1 do: [:i |
		list at: i put: self removeLast].
	^ list! !


!OrderedCollection methodsFor: 'sorting' stamp: 'ul 11/2/2009 04:56'!
sort
	"Sort this array into ascending order using the '<=' operator."

	self sort: nil! !

!OrderedCollection methodsFor: 'sorting' stamp: 'ul 11/2/2009 05:18'!
sort: aSortBlock 
	"Sort this collection using aSortBlock. The block should take two arguments
	and return true if the first element should preceed the second one.
	If aSortBlock is nil then <= is used for comparison."

	self ifNotEmpty: [
		array
			mergeSortFrom: firstIndex
			to: lastIndex
			by: aSortBlock ]! !


!OrderedCollection methodsFor: 'private' stamp: 'ST-80 5/31/1983 9:10:35'!
errorNoSuchElement
	self error: 'attempt to index non-existent element in an ordered collection'! !

!OrderedCollection methodsFor: 'private' stamp: 'jmv 9/3/2014 22:55'!
find: oldObject
	"Answer an index in the range [firstIndex, lastIndex]"

	firstIndex to: lastIndex do: [ :index |
		(array at: index) = oldObject ifTrue: [ ^index ]].
	self errorNotFound: oldObject! !

!OrderedCollection methodsFor: 'private' stamp: 'sqr 12/20/2013 15:14'!
insert: anObject before: spot
	"Spot is an index in the range [firstIndex, lastIndex]"

	| delta spotIndex|
	spotIndex _ spot.
	delta _ spotIndex - firstIndex.
	firstIndex = 1 ifTrue: 
		[self makeRoomAtFirst.
		spotIndex _ firstIndex + delta].
	firstIndex _ firstIndex - 1.
	array
		replaceFrom: firstIndex
		to: spotIndex - 2
		with: array
		startingAt: firstIndex + 1.
	array at: spotIndex - 1 put: anObject.
	^anObject! !

!OrderedCollection methodsFor: 'private' stamp: 'sqr 12/20/2013 15:11'!
makeRoomAtFirst

	| size newArray newFirst newLast lastGap writeGap |
	size _ self size.
	lastGap _ size - lastIndex.
	lastGap - 4 * 5 > size ifTrue:
		[
			newLast _ size - (lastGap bitShift: -5).
			writeGap _ newLast - lastIndex.
			writeGap > 0 ifTrue:
				[
					newFirst _ firstIndex + writeGap.
					newLast to: newFirst by: -1 do:
						[:each | array at: each put: (array at: each - writeGap)].
					array from: firstIndex to: newFirst - 1 put: nil.
					firstIndex _ newFirst.
					lastIndex _ newLast.
					^self
				]
		].
	newLast _ size + self growSize.
	newArray _ Array new: newLast.
	newFirst _ firstIndex + newLast - lastIndex.
	newArray replaceFrom: newFirst to: newLast with: array startingAt: firstIndex.
	array _ newArray.
	firstIndex _ newFirst.
	lastIndex _ newLast! !

!OrderedCollection methodsFor: 'private' stamp: 'sqr 12/20/2013 15:12'!
makeRoomAtLast

	| size newArray newFirst newLast |
	size _ self size.
	firstIndex - 4 * 5 > size ifTrue:
		[
			newFirst _ (firstIndex bitShift: -5) + 1.
			newFirst < firstIndex ifTrue:
				[
					newLast _ lastIndex - firstIndex + newFirst.
					array
						replaceFrom: newFirst
						to: newLast
						with: array
						startingAt: firstIndex.
					array from: newLast + 1 to: lastIndex put: nil.
					firstIndex _ newFirst.
					lastIndex _ newLast.
					^self
				]
		].
	newArray _ Array new: size + self growSize.
	newLast _ lastIndex - firstIndex + 1.
	newArray replaceFrom: 1 to: newLast with: array startingAt: firstIndex.
	array _ newArray.
	firstIndex _ 1.
	lastIndex _ newLast! !

!OrderedCollection methodsFor: 'private' stamp: 'sqr 12/20/2013 15:16'!
removeIndex: removedIndex
 	"The removedIndex value is in the range [firstIndex, lastIndex]"

	array 
		replaceFrom: removedIndex 
		to: lastIndex - 1 
		with: array 
		startingAt: removedIndex+1.
	array at: lastIndex put: nil.
	lastIndex _ lastIndex - 1! !

!OrderedCollection methodsFor: 'private' stamp: 'di 11/14/97 12:54'!
reset
	firstIndex _ array size // 3 max: 1.
	lastIndex _ firstIndex - 1! !

!OrderedCollection methodsFor: 'private' stamp: 'ar 4/16/1999 07:59'!
resetTo: index
	firstIndex _ index.
	lastIndex _ firstIndex - 1! !

!OrderedCollection methodsFor: 'private' stamp: 'di 11/14/97 12:54'!
setCollection: anArray
	array _ anArray.
	self reset! !

!OrderedCollection methodsFor: 'private' stamp: 'apb 10/15/2000 18:10'!
setContents: anArray
	array _ anArray.
	firstIndex _ 1.
	lastIndex _ array size.! !

!OrderedCollection methodsFor: 'private' stamp: 'jmv 11/26/2014 20:28'!
species
	"aSortedCollection collect: should answer an OrderedCollection"

	^OrderedCollection! !


!OrderedCollection methodsFor: 'comparing' stamp: 'jmv 2/19/2015 20:32'!
= otherCollection 
	"Answer true if the receiver is equivalent to the otherCollection.
	First test for identity, then rule out different species and sizes of
	collections. As a last resort, examine each element of the receiver
	and the otherCollection."


	"species is not enough. a SortedCollection is never equal to an OrderedCollection"
	self == otherCollection ifTrue: [^ true].
	self class == otherCollection class ifFalse: [^ false].
	^ self hasEqualElements: otherCollection! !


!OrderedCollection methodsFor: 'converting' stamp: 'len 11/29/2016 08:54:14'!
asNewArray
	^ array copyFrom: firstIndex to: lastIndex! !


!OrderedCollection methodsFor: 'initialization' stamp: 'HAW 5/18/2019 16:49:45'!
initializeOfSize: aSize

	array := Array new: aSize.
	firstIndex := 1.
	lastIndex := aSize.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OrderedCollection class' category: #'Collections-Sequenceable'!
OrderedCollection class
	instanceVariableNames: ''!

!OrderedCollection class methodsFor: 'instance creation' stamp: 'ST-80 5/31/1983 9:10:35'!
new
	^self new: 10! !

!OrderedCollection class methodsFor: 'instance creation' stamp: 'Squeak1.0 9/20/1996 10:50:05'!
new: anInteger 
	"If a subclass adds fields, then it is necessary for that subclass to
	reimplement new:."

	^ super new setCollection: (Array new: anInteger)! !

!OrderedCollection class methodsFor: 'instance creation' stamp: 'len 11/28/2016 19:18:39'!
newFrom: aCollection
	"Create a new collection containing all the elements from aCollection"

	^(self new: aCollection size)
		resetTo: 1;
		addAll: aCollection;
		yourself! !

!OrderedCollection class methodsFor: 'instance creation' stamp: 'HAW 5/18/2019 16:49:03'!
ofSize: aSize

	"See superclass implementation"
	
	^ super new initializeOfSize: aSize! !


!classDefinition: #SortedCollection category: #'Collections-Sequenceable'!
OrderedCollection subclass: #SortedCollection
	instanceVariableNames: 'sortBlock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Collections-Sequenceable'!
!SortedCollection commentStamp: 'jmv 5/11/2016 09:52' prior: 0!
I represent a collection of objects ordered by some property of the objects themselves. The ordering is specified in a BlockClosure.!


!SortedCollection methodsFor: 'accessing' stamp: 'sma 4/28/2000 17:47'!
at: anInteger put: anObject
	self shouldNotImplement! !

!SortedCollection methodsFor: 'accessing' stamp: 'len 7/15/2016 17:43:15'!
indexOf: anElement startingAt: start ifAbsent: exceptionBlock
	| sortBlockToUse firstCandidate |
	self isEmpty ifTrue: [^ exceptionBlock value].
	sortBlockToUse _ sortBlock ifNil: [[:a :b | a <= b ]].
	"if first element to check is it, answer so."
	firstCandidate _ self at: start.
	firstCandidate = anElement ifTrue: [ ^ start ].
	"if first element to check is already too late, answer 'NotHere' "
	(sortBlockToUse value: anElement value: firstCandidate) ifTrue: [
		^ exceptionBlock value ].
	"Ok. Look for it."
	^self
		findBinaryIndex: [ :some | 
			some = anElement
				ifTrue: [0]
				ifFalse: [ (sortBlockToUse value: anElement value: some) ifTrue: [-1] ifFalse: [1]]]
		do: [ :i | i ]
		ifNone: [ :i1 :i2 | exceptionBlock value ]! !

!SortedCollection methodsFor: 'accessing' stamp: 'jmv 6/2/2016 10:10'!
quickIndexOf: anElement 
	"Answer the index of anElement within the receiver. If the receiver does 
	not contain anElement, answer 0."

	| sortBlockToUse |
	sortBlockToUse _ sortBlock ifNil: [[:a :b | a <= b ]].
	^self
		findBinaryIndex: [ :some | 
			some = anElement
				ifTrue: [0]
				ifFalse: [ (sortBlockToUse value: anElement value: some) ifTrue: [-1] ifFalse: [1]]]
		do: [ :i | i ]
		ifNone: [ :i1 :i2 | 0 ]! !

!SortedCollection methodsFor: 'accessing' stamp: 'jmv 5/11/2016 09:52'!
sortBlock
	"Answer the BlockClosure which is the criterion for sorting elements of 
	the receiver."

	^sortBlock! !

!SortedCollection methodsFor: 'accessing' stamp: 'jmv 12/30/2009 11:36'!
sortBlock: aBlock 
	"Make the argument, aBlock, be the criterion for ordering elements of the 
	receiver."

	sortBlock _ aBlock.
	self size > 0 ifTrue: [ self reSort ]! !


!SortedCollection methodsFor: 'adding' stamp: 'go 4/27/2000 13:19'!
add: newObject
	^ super insert: newObject before: (self indexForInserting: newObject)! !

!SortedCollection methodsFor: 'adding' stamp: 'jmv 11/30/2014 11:36'!
addAll: aCollection
	"optimization"
	aCollection size > (self size // 3)
		ifTrue:
			[aCollection do: [:each | self addLast: each].
			self reSort]
		ifFalse: [aCollection do: [:each | self add: each]].
	^ aCollection! !

!SortedCollection methodsFor: 'adding' stamp: 'go 4/26/2000 17:26'!
addFirst: newObject
	self shouldNotImplement! !


!SortedCollection methodsFor: 'comparing' stamp: 'jmv 2/19/2015 20:30'!
= aSortedCollection
	"Answer true if my and aSortedCollection's species are the same,
	and if our blocks are the same, and if our elements are the same."

	"Any object is equal to itself"
	self == aSortedCollection ifTrue: [ ^ true ].

	"species is not enough. a SortedCollection is never equal to an OrderedCollection"
	self class == aSortedCollection class ifFalse: [ ^ false ].

	sortBlock = aSortedCollection sortBlock
		ifFalse: [ ^false ].

	^self hasEqualElements: aSortedCollection ! !


!SortedCollection methodsFor: 'copying' stamp: 'SqR 2/20/2015 20:51'!
copy

	^self shallowCopy postCopy! !

!SortedCollection methodsFor: 'copying' stamp: 'SqR 2/20/2015 21:11'!
postCopy

	array _ array copy.
	firstIndex _ firstIndex copy.
	lastIndex _ lastIndex copy! !


!SortedCollection methodsFor: 'enumerating' stamp: 'jmv 11/30/2014 15:55'!
select: aBlock 
	"Evaluate aBlock with each of my elements as the argument. Collect into
	a new collection like the receiver, only those elements for which aBlock
	evaluates to true."

	| newCollection element |
	"Use self class and not self species. SortedCollection is special,
	the answer for #collect: (an OrderedCollection) is of different kind than
	the answer for #select: or #copy"
	newCollection _ self class sortBlock: sortBlock.
	firstIndex to: lastIndex do: [ :index |
		(aBlock value: (element _ array at: index))
			ifTrue: [ newCollection addLast: element ]].
	^ newCollection! !


!SortedCollection methodsFor: 'private' stamp: 'stp 04/23/1999 05:32'!
defaultSort: i to: j 
	"Sort elements i through j of self to be nondescending according to
	sortBlock."	"Assume the default sort block ([:x :y | x <= y])."

	| di dij dj tt ij k l n |
	"The prefix d means the data at that index."
	(n _ j + 1  - i) <= 1 ifTrue: [^self].	"Nothing to sort." 
	 "Sort di,dj."
	di _ array at: i.
	dj _ array at: j.
	(di <= dj) "i.e., should di precede dj?"
		ifFalse: 
			[array swap: i with: j.
			 tt _ di.
			 di _ dj.
			 dj _ tt].
	n > 2
		ifTrue:  "More than two elements."
			[ij _ (i + j) // 2.  "ij is the midpoint of i and j."
			 dij _ array at: ij.  "Sort di,dij,dj.  Make dij be their median."
			 (di <= dij) "i.e. should di precede dij?"
			   ifTrue: 
				[(dij <= dj) "i.e., should dij precede dj?"
				  ifFalse: 
					[array swap: j with: ij.
					 dij _ dj]]
			   ifFalse:  "i.e. di should come after dij"
				[array swap: i with: ij.
				 dij _ di].
			n > 3
			  ifTrue:  "More than three elements."
				["Find k>i and l<j such that dk,dij,dl are in reverse order.
				Swap k and l.  Repeat this procedure until k and l pass each other."
				 k _ i.
				 l _ j.
				 [[l _ l - 1.  k <= l and: [dij <= (array at: l)]]
				   whileTrue.  "i.e. while dl succeeds dij"
				  [k _ k + 1.  k <= l and: [(array at: k) <= dij]]
				   whileTrue.  "i.e. while dij succeeds dk"
				  k <= l]
				   whileTrue:
					[array swap: k with: l]. 
	"Now l<k (either 1 or 2 less), and di through dl are all less than or equal to dk
	through dj.  Sort those two segments."
				self defaultSort: i to: l.
				self defaultSort: k to: j]]! !

!SortedCollection methodsFor: 'private' stamp: 'jmv 3/2/2010 16:33'!
indexForInserting: newObject

	| index low high |
	low _ firstIndex.
	high _ lastIndex.
	sortBlock
		ifNil: [
			[index _ high + low // 2.  low > high]
				whileFalse: [
					((array at: index) <= newObject)
						ifTrue: [low _ index + 1]
						ifFalse: [high _ index - 1]]]
		ifNotNil: [
			[index _ high + low // 2.  low > high]
				whileFalse: [
					(sortBlock value: (array at: index) value: newObject)
						ifTrue: [low _ index + 1]
						ifFalse: [high _ index - 1]]].
	^low! !

!SortedCollection methodsFor: 'private' stamp: 'go 4/26/2000 17:17'!
insert: anObject before: spot
	self shouldNotImplement! !

!SortedCollection methodsFor: 'private' stamp: 'ul 6/8/2011 23:18'!
reSort

	firstIndex < lastIndex ifTrue: [ 
		array quickSortFrom: firstIndex to: lastIndex by: sortBlock ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SortedCollection class' category: #'Collections-Sequenceable'!
SortedCollection class
	instanceVariableNames: ''!

!SortedCollection class methodsFor: 'instance creation' stamp: 'jmv 3/7/2015 22:48'!
new: anInteger sortBlock: aBlock 
	"Answer an instance of me such that its elements are sorted according to 
	the criterion specified in aBlock."

	^(self new: anInteger) sortBlock: aBlock! !

!SortedCollection class methodsFor: 'instance creation' stamp: 'jmv 3/7/2015 22:48'!
sortBlock: aBlock 
	"Answer an instance of me such that its elements are sorted according to 
	the criterion specified in aBlock."

	^(self new: 10) sortBlock: aBlock! !


!classDefinition: #OrderedDictionary category: #'Collections-Sequenceable'!
Dictionary subclass: #OrderedDictionary
	instanceVariableNames: 'orderedKeys'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Collections-Sequenceable'!
!OrderedDictionary commentStamp: '<historical>' prior: 0!
Like Python's OrderedDict!


!OrderedDictionary methodsFor: 'removing' stamp: 'jmv 3/9/2018 14:33:08'!
removeKey: key ifAbsent: aBlock 

	super removeKey: key ifAbsent: [
		^ aBlock value ].
	orderedKeys remove: key! !


!OrderedDictionary methodsFor: 'enumerating' stamp: 'jmv 3/9/2018 14:45:35'!
associationsDo: aBlock 
	"Evaluate aBlock for each of the receiver's elements (key/value 
	associations)."

	orderedKeys do: [ :key |
		aBlock value: (self associationAt: key ifAbsent: nil) ]! !

!OrderedDictionary methodsFor: 'enumerating' stamp: 'jmv 3/9/2018 14:45:31'!
do: aBlock
	"Evaluate aBlock for each of the receiver's values."

	orderedKeys do: [ :key |
		aBlock value: (self at: key ifAbsent: nil) ]! !

!OrderedDictionary methodsFor: 'enumerating' stamp: 'jmv 3/9/2018 14:45:24'!
keysDo: aBlock 
	"Evaluate aBlock for each of the receiver's keys."

	orderedKeys do: aBlock ! !


!OrderedDictionary methodsFor: 'accessing' stamp: 'jmv 5/25/2018 10:36:46'!
keysSortedSafely
	"Answer a sorted Collection containing the receiver's keys.
	Redefined from Dictionary: for us, propery sorted keys are keys in the order they were added."
	^ orderedKeys! !


!OrderedDictionary methodsFor: 'private' stamp: 'jmv 3/9/2018 14:33:17'!
atNewIndex: index put: anAssociation

	super atNewIndex: index put: anAssociation.
	orderedKeys add: anAssociation key! !

!OrderedDictionary methodsFor: 'private' stamp: 'jmv 3/9/2018 14:33:19'!
init: n

	super init: n.
	orderedKeys _ OrderedCollection new: n! !


!classDefinition: #SharedQueue category: #'Collections-Sequenceable'!
Object subclass: #SharedQueue
	instanceVariableNames: 'contentsArray readPosition writePosition accessProtect readSynch'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Collections-Sequenceable'!
!SharedQueue commentStamp: '<historical>' prior: 0!
I provide synchronized communication of arbitrary objects between Processes. An object is sent by sending the message nextPut: and received by sending the message next. If no object has been sent when a next message is sent, the Process requesting the object will be suspended until one is sent.!


!SharedQueue methodsFor: 'accessing' stamp: 'bf 2/11/2006 15:17'!
flush
	"Throw out all pending contents"
	accessProtect critical: [
		"nil out flushed slots --bf 02/11/2006"
		contentsArray from: readPosition to: writePosition-1 put: nil.
		readPosition := 1.
		writePosition := 1.
		"Reset the read synchronization semaphore"
		readSynch initSignals].! !

!SharedQueue methodsFor: 'accessing' stamp: 'nice 12/26/2009 21:24'!
flushAllSuchThat: aBlock
	"Remove from the queue all objects that satisfy aBlock."
	^accessProtect critical: [
		| value newReadPos |
		newReadPos := writePosition.
		writePosition-1 to: readPosition by: -1 do:
			[:i | value := contentsArray at: i.
			contentsArray at: i put: nil.
			(aBlock value: value) ifTrue: [
				"We take an element out of the queue, and therefore, we need to decrement 
				the readSynch signals"
				readSynch wait.
			] ifFalse: [
				newReadPos := newReadPos - 1.
				contentsArray at: newReadPos put: value]].
		readPosition := newReadPos.
		value]! !

!SharedQueue methodsFor: 'accessing' stamp: 'nice 12/26/2009 21:25'!
next
	"Answer the object that was sent through the receiver first and has not 
	yet been received by anyone. If no object has been sent, suspend the 
	requesting process until one is."

	readSynch wait.
	^accessProtect
		critical: [
			| value |
			readPosition = writePosition
					ifTrue: 
						[self error: 'Error in SharedQueue synchronization'.
						 value := nil]
					ifFalse: 
						[value := contentsArray at: readPosition.
						 contentsArray at: readPosition put: nil.
						 readPosition := readPosition + 1].
			value].! !

!SharedQueue methodsFor: 'accessing' stamp: 'nice 12/26/2009 21:25'!
nextOrNil
	"Answer the object that was sent through the receiver first and has not 
	yet been received by anyone. If no object has been sent, answer <nil>."

	^accessProtect critical: [
		| value |
		readPosition >= writePosition ifTrue: [
			value := nil
		] ifFalse: [
			value := contentsArray at: readPosition.
			contentsArray at: readPosition put: nil.
			readPosition := readPosition + 1
		].
		readPosition >= writePosition ifTrue: [readSynch initSignals].
		value
	].! !

!SharedQueue methodsFor: 'accessing' stamp: 'nice 12/26/2009 21:26'!
nextOrNilSuchThat: aBlock
	"Answer the next object that satisfies aBlock, skipping any intermediate objects.
	If no object has been sent, answer <nil> and leave me intact.
	NOTA BENE:  aBlock MUST NOT contain a non-local return (^)."

	^accessProtect critical: [
		| value readPos |
		value := nil.
		readPos := readPosition.
		[readPos < writePosition and: [value isNil]] whileTrue: [
			value := contentsArray at: readPos.
			readPos := readPos + 1.
			(aBlock value: value) ifTrue: [
				readPosition to: readPos - 1 do: [ :j |
					contentsArray at: j put: nil.
				].
				readPosition := readPos.
			] ifFalse: [
				value := nil.
			].
		].
		readPosition >= writePosition ifTrue: [readSynch initSignals].
		value.
	].
"===
q := SharedQueue new.
1 to: 10 do: [ :i | q nextPut: i].
c := OrderedCollection new.
[
	v := q nextOrNilSuchThat: [ :e | e odd].
	v notNil
] whileTrue: [
	c add: {v. q size}
].
{c. q} explore
==="! !

!SharedQueue methodsFor: 'accessing' stamp: 'ST-80 5/31/1983 9:10:35'!
nextPut: value 
	"Send value through the receiver.  If a Process has been suspended waiting to 
	receive a value through the receiver, allow it to proceed."

	accessProtect
		critical: [writePosition > contentsArray size
						ifTrue: [self makeRoomAtEnd].
				 contentsArray at: writePosition put: value.
				 writePosition _ writePosition + 1].
	readSynch signal.
	^value! !

!SharedQueue methodsFor: 'accessing' stamp: 'nice 12/26/2009 21:34'!
peek
	"Answer the object that was sent through the receiver first and has not 
	yet been received by anyone but do not remove it from the receiver. If 
	no object has been sent, return nil"

	^accessProtect
		critical: [
			| value |
			readPosition >= writePosition
					ifTrue: [readPosition := 1.
							writePosition := 1.
							value := nil]
					ifFalse: [value := contentsArray at: readPosition].
			value].! !

!SharedQueue methodsFor: 'accessing' stamp: 'ST-80 5/31/1983 9:10:35'!
size
	"Answer the number of objects that have been sent through the
	receiver and not yet received by anyone."

	^writePosition - readPosition! !


!SharedQueue methodsFor: 'testing' stamp: 'ST-80 5/31/1983 9:10:35'!
isEmpty
	"Answer whether any objects have been sent through the receiver
	and not yet received by anyone."

	^readPosition = writePosition! !


!SharedQueue methodsFor: 'private' stamp: 'nice 4/4/2006 22:09'!
initialize: size

	contentsArray := Array new: size.
	readPosition := 1.
	writePosition := 1.
	accessProtect := Semaphore forMutualExclusion.
	readSynch := Semaphore new! !

!SharedQueue methodsFor: 'private' stamp: 'ul 10/18/2010 02:35'!
makeRoomAtEnd

	| contentsSize |
	contentsSize := writePosition - readPosition.
	contentsSize * 2 > contentsArray size
		ifTrue: [
			"grow"
			contentsArray := (contentsArray class new: contentsArray size * 2)
				replaceFrom: 1
				to: contentsSize
				with: contentsArray
				startingAt: readPosition;
				yourself ]
		ifFalse: [
			(contentsArray size > 10 and: [ contentsSize * 4 <= contentsArray size ])
				ifTrue: [
					"shrink"
					contentsArray := (contentsArray class new: (contentsSize * 2 max: 10))
						replaceFrom: 1
						to: contentsSize
						with: contentsArray
						startingAt: readPosition;
						yourself ]
				ifFalse: [
					"just move the elements to the front"
					contentsArray
						replaceFrom: 1
						to: contentsSize
						with: contentsArray
						startingAt: readPosition.
					contentsArray
						from: contentsSize + 1
						to: contentsArray size
						put: nil ] ].
	readPosition := 1.
	writePosition := contentsSize + 1! !

!SharedQueue methodsFor: 'private' stamp: 'ar 10/4/2006 12:43'!
printOn: aStream
	super printOn: aStream.
	"Print a guesstimate of the size of the queue without aquiring the lock properly"
	aStream nextPut: $(.
	aStream print: writePosition - readPosition.
	aStream nextPut: $).! !


!SharedQueue methodsFor: 'copying' stamp: 'SqR 2/20/2015 21:11'!
postCopy
	contentsArray := contentsArray copy.
	accessProtect := Semaphore forMutualExclusion.
	readSynch := Semaphore new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SharedQueue class' category: #'Collections-Sequenceable'!
SharedQueue class
	instanceVariableNames: ''!

!SharedQueue class methodsFor: 'instance creation' stamp: 'ST-80 5/31/1983 9:10:35'!
new
	"Answer a new instance of SharedQueue that has 10 elements."

	^self new: 10! !

!SharedQueue class methodsFor: 'instance creation' stamp: 'nice 4/4/2006 22:10'!
new: anInteger 
	^super new initialize: anInteger! !
