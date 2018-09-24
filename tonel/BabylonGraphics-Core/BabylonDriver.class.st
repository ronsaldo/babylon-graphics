"
I am factory for the objects conforming to the Pompeii Volcanic Graphics API that are implemented by a driver.
"
Class {
	#name : #BabylonDriver,
	#superclass : #Object,
	#instVars : [
		'cachedFonts',
		'mutex'
	],
	#classVars : [
		'CurrentDriver',
		'CurrentDriverSession'
	],
	#category : #'BabylonGraphics-Core-Driver'
}

{ #category : #accessing }
BabylonDriver class >> current [
	(CurrentDriver isNil or: [ CurrentDriverSession ~~ Smalltalk session ]) ifTrue: [
		CurrentDriver := self pickDriver.
		CurrentDriverSession := Smalltalk session
	].
	^ CurrentDriver
]

{ #category : #testing }
BabylonDriver class >> isSuitable [
	^ false
]

{ #category : #testing }
BabylonDriver class >> isSupported [
	^ false
]

{ #category : #'driver selection' }
BabylonDriver class >> pickDriver [
	self allSubclassesDo: [ :sc | sc isSuitable ifTrue: [ ^ sc new ] ].
	self allSubclassesDo: [ :sc | sc isSupported ifTrue: [ ^ sc new ] ].
	Smalltalk globals at: #BabylonSoftRenderingDriver ifPresent: [ :fallback | ^ fallback new ].
	self error: 'Failed to pick a Pompeii driver'.
]

{ #category : #accessing }
BabylonDriver class >> reset [
	CurrentDriver := nil.
	CurrentDriverSession := nil.
]

{ #category : #'instance creation' }
BabylonDriver >> cachedFonts [
	^ cachedFonts ifNil: [ cachedFonts := Dictionary new ]
]

{ #category : #'shape convertion' }
BabylonDriver >> convertMesh2D: aMesh2D [
	^ aMesh2D
]

{ #category : #'shape convertion' }
BabylonDriver >> convertPolygon: aPolygon [
	^ aPolygon
]

{ #category : #'instance creation' }
BabylonDriver >> convexPolygonBuilder [
	^ BabylonConvexPolygonBuilder new
]

{ #category : #'instance creation' }
BabylonDriver >> createFontCache: aLogicalFont [
	^ BabylonFontCache font: aLogicalFont
]

{ #category : #'as yet unclassified' }
BabylonDriver >> createMaterialForTexture: aTexture [
	^ BabylonTextureMaterial new texture: aTexture
]

{ #category : #'as yet unclassified' }
BabylonDriver >> createMaterialForTextureArray: aTextureArray element: aTextureElementIndex [
	^ BabylonTextureArrayElementMaterial new
		textureArray: aTextureArray;
		elementIndex: aTextureElementIndex;
		yourself
]

{ #category : #'as yet unclassified' }
BabylonDriver >> createOSWindowAnimatedWithAttributes: attributes eventHandler: eventHandler [
	^ self createOSWindowOfClass: OSWindow animatedWithAttributes: attributes eventHandler: eventHandler
]

{ #category : #'as yet unclassified' }
BabylonDriver >> createOSWindowOfClass: osWindowClass animatedWithAttributes: attributes eventHandler: eventHandler [
	| visible window |
	
	self flag: 'HACK: Remove this hack when the latest version of OSWindow is integrated.'.
	(osWindowClass respondsTo: #createWithAttributes:eventHandler:) ifTrue: [
		window := osWindowClass createWithAttributes: attributes eventHandler: eventHandler
	] ifFalse: [ 
		visible := attributes visible.
		attributes visible: false.
		window := osWindowClass createWithAttributes: attributes.
		window eventHandler: eventHandler.
		visible ifTrue: [ window show ].
		OSWindowRenderThread enqueueOperation: [ ]. "HACK:"
	].
	^ window
]

{ #category : #'as yet unclassified' }
BabylonDriver >> createOSWindowWithAttributes: attributes eventHandler: eventHandler [
	^ self createOSWindowOfClass: OSWindow animatedWithAttributes: attributes eventHandler: eventHandler
]

{ #category : #'mutual exclusion' }
BabylonDriver >> critical: aBlock [
	mutex critical: aBlock
]

{ #category : #'instance creation' }
BabylonDriver >> font: aLogicalFont [
	mutex critical: [ 
		^ self cachedFonts at: aLogicalFont ifAbsentPut: [ self createFontCache: aLogicalFont ]
	]

]

{ #category : #initialization }
BabylonDriver >> initialize [
	super initialize.
	mutex := Mutex new.
]

{ #category : #'instance creation' }
BabylonDriver >> mesh2DBuilder [
	^ BabylonMesh2DBuilder new driver: self
]

{ #category : #'as yet unclassified' }
BabylonDriver >> setupOSWindowAttributes: attributes [
]

{ #category : #'instance creation' }
BabylonDriver >> surfaceWithExtent: anExtent [
	self subclassResponsibility
]

{ #category : #'instance creation' }
BabylonDriver >> textureFromForm: aForm [
	self subclassResponsibility
]
