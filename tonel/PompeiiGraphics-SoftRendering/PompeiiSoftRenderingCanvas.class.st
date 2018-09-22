Class {
	#name : #PompeiiSoftRenderingCanvas,
	#superclass : #PompeiiCanvas,
	#instVars : [
		'surface'
	],
	#category : #'PompeiiGraphics-SoftRendering'
}

{ #category : #'drawing commands' }
PompeiiSoftRenderingCanvas >> clear: clearColor [
	^ surface clear: clearColor
]

{ #category : #drawing }
PompeiiSoftRenderingCanvas >> drawConvertedShape: aConvertedShape [
	^ aConvertedShape drawWithSoftRenderingCanvas: self
]

{ #category : #drawing }
PompeiiSoftRenderingCanvas >> drawMesh2D: mesh2D [
	mesh2D evaluatePrimitivesWith: surface
]

{ #category : #accessing }
PompeiiSoftRenderingCanvas >> driver [
	^ surface driver
]

{ #category : #accessing }
PompeiiSoftRenderingCanvas >> surface [
	^ surface
]

{ #category : #accessing }
PompeiiSoftRenderingCanvas >> surface: anObject [
	surface := anObject
]

{ #category : #'drawing commands' }
PompeiiSoftRenderingCanvas >> transform [
	^ surface transform
]
