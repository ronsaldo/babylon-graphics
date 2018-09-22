"
I am a generic mesh 2D vertex for the Pompeii graphics API.
"
Class {
	#name : #BabylonMesh2DVertex,
	#superclass : #Object,
	#instVars : [
		'position',
		'color',
		'texcoord'
	],
	#classVars : [
		'DefaultColor',
		'DefaultPosition',
		'DefaultTexcoord'
	],
	#category : #'BabylonGraphics-Core-Shape'
}

{ #category : #'vertex layout' }
BabylonMesh2DVertex class >> colorOffset [
	^ 16
]

{ #category : #initialization }
BabylonMesh2DVertex class >> initialize [
	"
	self initialize
	"
	super initialize.
	DefaultPosition := 0@0.
	DefaultColor := Color white.
	DefaultTexcoord := 0@0.
]

{ #category : #'vertex layout' }
BabylonMesh2DVertex class >> positionOffset [
	^ 0
]

{ #category : #'vertex layout' }
BabylonMesh2DVertex class >> structureSize [
	^ 32
]

{ #category : #'vertex layout' }
BabylonMesh2DVertex class >> texcoordOffset [
	^ 8
]

{ #category : #accessing }
BabylonMesh2DVertex >> color [
	^ color
]

{ #category : #accessing }
BabylonMesh2DVertex >> color: anObject [
	color := anObject
]

{ #category : #initialization }
BabylonMesh2DVertex >> initialize [
	super initialize.
	position := DefaultPosition.
	color := DefaultColor.
	texcoord  := DefaultTexcoord.
]

{ #category : #accessing }
BabylonMesh2DVertex >> position [
	^ position
]

{ #category : #accessing }
BabylonMesh2DVertex >> position: anObject [
	position := anObject
]

{ #category : #converting }
BabylonMesh2DVertex >> saveWavefrontOBJInto: out [
	out nextPutAll: 'v '; print: position x; space; print: position y; nextPutAll: ' 0'; lf.
	out nextPutAll: 'vt '; print: texcoord x; space; print: texcoord y; lf
]

{ #category : #accessing }
BabylonMesh2DVertex >> texcoord [
	^ texcoord
]

{ #category : #accessing }
BabylonMesh2DVertex >> texcoord: anObject [
	texcoord := anObject
]
