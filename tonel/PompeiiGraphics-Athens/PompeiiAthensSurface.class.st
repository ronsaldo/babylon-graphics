Class {
	#name : #PompeiiAthensSurface,
	#superclass : #PompeiiSurface,
	#instVars : [
		'athensSurface'
	],
	#category : #'PompeiiGraphics-Athens'
}

{ #category : #geometry }
PompeiiAthensSurface class >> extent: anExtent [
	^ self new initializeWithExtent: anExtent
]

{ #category : #converting }
PompeiiAthensSurface >> asForm [
	^ athensSurface asForm
]

{ #category : #accessing }
PompeiiAthensSurface >> athensSurface [
	^ athensSurface
]

{ #category : #converting }
PompeiiAthensSurface >> drawDuring: aBlock [
	| canvas |
	athensSurface drawDuring: [ :athensCanvas |
		canvas := PompeiiAthensCanvas new
			athensCanvas: athensCanvas;
			surface: self;
			yourself.
		aBlock value: canvas
	]
]

{ #category : #initialization }
PompeiiAthensSurface >> initializeWithExtent: anExtent [
	athensSurface := AthensCairoSurface extent: anExtent.
]
