Class {
	#name : #PompeiiAthensDriver,
	#superclass : #PompeiiDriver,
	#category : #'PompeiiGraphics-Athens'
}

{ #category : #testing }
PompeiiAthensDriver class >> isSupported [
	^ true
]

{ #category : #'instance creation' }
PompeiiAthensDriver >> surfaceWithExtent: anExtent [
	^ PompeiiAthensSurface extent: anExtent
]
