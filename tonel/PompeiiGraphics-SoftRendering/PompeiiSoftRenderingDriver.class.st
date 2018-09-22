Class {
	#name : #PompeiiSoftRenderingDriver,
	#superclass : #PompeiiDriver,
	#classVars : [
		'UniqueInstance'
	],
	#category : #'PompeiiGraphics-SoftRendering'
}

{ #category : #'instance creation' }
PompeiiSoftRenderingDriver class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #'instance creation' }
PompeiiSoftRenderingDriver >> surfaceWithExtent: anExtent [
	^ PompeiiSoftRenderingSurface extent: anExtent
]
