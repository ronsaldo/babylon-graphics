Class {
	#name : #BabylonSoftRenderingCanvas,
	#superclass : #BabylonCanvas,
	#instVars : [
		'surface'
	],
	#category : #'BabylonGraphics-SoftRendering'
}

{ #category : #'drawing commands' }
BabylonSoftRenderingCanvas >> clear: clearColor [
	^ surface clear: clearColor
]

{ #category : #drawing }
BabylonSoftRenderingCanvas >> drawConvertedShape: aConvertedShape [
	^ aConvertedShape drawWithSoftRenderingCanvas: self
]

{ #category : #drawing }
BabylonSoftRenderingCanvas >> drawMesh2D: mesh2D [
	mesh2D evaluatePrimitivesWith: surface
]

{ #category : #accessing }
BabylonSoftRenderingCanvas >> driver [
	^ surface driver
]

{ #category : #accessing }
BabylonSoftRenderingCanvas >> surface [
	^ surface
]

{ #category : #accessing }
BabylonSoftRenderingCanvas >> surface: anObject [
	surface := anObject
]

{ #category : #'drawing commands' }
BabylonSoftRenderingCanvas >> transform [
	^ surface transform
]
