"
I am a generic mesh 2D vertex for the Pompeii graphics API.
"
Class {
	#name : #PompeiiMesh2DVertex,
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
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #'vertex layout' }
PompeiiMesh2DVertex class >> colorOffset [
	^ 16
]

{ #category : #initialization }
PompeiiMesh2DVertex class >> initialize [
	"
	self initialize
	"
	super initialize.
	DefaultPosition := 0@0.
	DefaultColor := Color white.
	DefaultTexcoord := 0@0.
]

{ #category : #'vertex layout' }
PompeiiMesh2DVertex class >> positionOffset [
	^ 0
]

{ #category : #'vertex layout' }
PompeiiMesh2DVertex class >> structureSize [
	^ 32
]

{ #category : #'vertex layout' }
PompeiiMesh2DVertex class >> texcoordOffset [
	^ 8
]

{ #category : #accessing }
PompeiiMesh2DVertex >> color [
	^ color
]

{ #category : #accessing }
PompeiiMesh2DVertex >> color: anObject [
	color := anObject
]

{ #category : #initialization }
PompeiiMesh2DVertex >> initialize [
	super initialize.
	position := DefaultPosition.
	color := DefaultColor.
	texcoord  := DefaultTexcoord.
]

{ #category : #accessing }
PompeiiMesh2DVertex >> position [
	^ position
]

{ #category : #accessing }
PompeiiMesh2DVertex >> position: anObject [
	position := anObject
]

{ #category : #converting }
PompeiiMesh2DVertex >> saveWavefrontOBJInto: out [
	out nextPutAll: 'v '; print: position x; space; print: position y; nextPutAll: ' 0'; lf.
	out nextPutAll: 'vt '; print: texcoord x; space; print: texcoord y; lf
]

{ #category : #accessing }
PompeiiMesh2DVertex >> texcoord [
	^ texcoord
]

{ #category : #accessing }
PompeiiMesh2DVertex >> texcoord: anObject [
	texcoord := anObject
]
