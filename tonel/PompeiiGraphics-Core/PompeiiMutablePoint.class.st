Class {
	#name : #PompeiiMutablePoint,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'PompeiiGraphics-Core'
}

{ #category : #'instance creation' }
PompeiiMutablePoint >> fromFixedPointForPompeiiRendering [
	^ x fromFixedPointForPompeiiRendering @ y fromFixedPointForPompeiiRendering
]

{ #category : #accessing }
PompeiiMutablePoint >> x [
	^ x
]

{ #category : #accessing }
PompeiiMutablePoint >> x: anObject [
	x := anObject
]

{ #category : #accessing }
PompeiiMutablePoint >> y [
	^ y
]

{ #category : #accessing }
PompeiiMutablePoint >> y: anObject [
	y := anObject
]
