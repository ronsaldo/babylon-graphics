Class {
	#name : #BabylonSoftRenderingDriver,
	#superclass : #BabylonDriver,
	#classVars : [
		'UniqueInstance'
	],
	#category : #'BabylonGraphics-SoftRendering'
}

{ #category : #'instance creation' }
BabylonSoftRenderingDriver class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #'instance creation' }
BabylonSoftRenderingDriver >> surfaceWithExtent: anExtent [
	^ BabylonSoftRenderingSurface extent: anExtent
]
