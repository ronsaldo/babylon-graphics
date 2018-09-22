"
Class for computing a convex hull
"
Class {
	#name : #BabylonConvexHull,
	#superclass : #BabylonShape,
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #'instance creation' }
BabylonConvexHull class >> points: aCollectionOfPoints [
	^ self new compute: aCollectionOfPoints
]

{ #category : #initialize }
BabylonConvexHull >> compute: rawPoints [
	"Graham Scan convex hull algorithm."
	| lowestLeft sortedPoints result |
	lowestLeft := self findLowestLeft: rawPoints.
	sortedPoints := rawPoints sorted: [ :a :b |
		self windingWithReference: lowestLeft first: a second: b
	].

	result := OrderedCollection new.
	result add: lowestLeft.
	sortedPoints do: [ :point |
		(point closeTo: result last) ifFalse: [
			[ result size >= 2 and: [(self crossWithReference: (result at: result size - 1) first: result last second: point) <= 0]] whileTrue: [
				result removeLast
			].

			result add: point
		]	
	].
	
	^ result
]

{ #category : #initialize }
BabylonConvexHull >> cross: u with: v [
	^ (u x * v y) - (u y * v x)
]

{ #category : #initialize }
BabylonConvexHull >> crossWithReference: referencePoint first: first second: second [
	| u v |
	u := first - referencePoint.
	v := second - referencePoint.
	^ self cross: u with: v
]

{ #category : #initialize }
BabylonConvexHull >> findLowestLeft: points [
	| result |
	result := points anyOne.
	points do: [ :point |
		(point y < result y or: [point y = result y and: [point x < result x]]) ifTrue: [
			result := point
		]
	].

	^ result
]

{ #category : #initialize }
BabylonConvexHull >> windingWithReference: referencePoint first: first second: second [
	| u v |
	u := first - referencePoint.
	v := second - referencePoint.
	^ (self cross: u with: v) >= 0
]
