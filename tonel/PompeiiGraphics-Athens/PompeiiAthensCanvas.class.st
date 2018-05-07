Class {
	#name : #PompeiiAthensCanvas,
	#superclass : #PompeiiCanvas,
	#instVars : [
		'surface',
		'athensCanvas'
	],
	#category : #'PompeiiGraphics-Athens'
}

{ #category : #accessing }
PompeiiAthensCanvas >> athensCanvas [
	^ athensCanvas
]

{ #category : #accessing }
PompeiiAthensCanvas >> athensCanvas: anObject [
	athensCanvas := anObject
]

{ #category : #'drawing commands' }
PompeiiAthensCanvas >> clear: clearColor [
	surface athensSurface clear: clearColor
]

{ #category : #accessing }
PompeiiAthensCanvas >> surface [
	^ surface
]

{ #category : #accessing }
PompeiiAthensCanvas >> surface: anObject [
	surface := anObject
]
