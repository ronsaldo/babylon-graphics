"
I am factory for the objects conforming to the Pompeii Volcanic Graphics API that are implemented by a driver.
"
Class {
	#name : #PompeiiDriver,
	#superclass : #Object,
	#instVars : [
		'cachedFonts',
		'mutex'
	],
	#classVars : [
		'CurrentDriver',
		'CurrentDriverSession'
	],
	#category : #'PompeiiGraphics-Core'
}

{ #category : #accessing }
PompeiiDriver class >> current [
	(CurrentDriver isNil or: [ CurrentDriverSession ~~ Smalltalk session ]) ifTrue: [
		CurrentDriver := self pickDriver.
		CurrentDriverSession := Smalltalk session
	].
	^ CurrentDriver
]

{ #category : #testing }
PompeiiDriver class >> isSuitable [
	^ false
]

{ #category : #testing }
PompeiiDriver class >> isSupported [
	^ false
]

{ #category : #'driver selection' }
PompeiiDriver class >> pickDriver [
	self allSubclassesDo: [ :sc | sc isSuitable ifTrue: [ ^ sc new ] ].
	self allSubclassesDo: [ :sc | sc isSupported ifTrue: [ ^ sc new ] ].
	self error: 'Failed to pick a Pompeii driver'.
]

{ #category : #accessing }
PompeiiDriver class >> reset [
	CurrentDriver := nil.
	CurrentDriverSession := nil.
]

{ #category : #'instance creation' }
PompeiiDriver >> cachedFonts [
	^ cachedFonts ifNil: [ cachedFonts := Dictionary new ]
]

{ #category : #'shape convertion' }
PompeiiDriver >> convertMesh2D: aMesh2D [
	^ aMesh2D
]

{ #category : #'shape convertion' }
PompeiiDriver >> convertPolygon: aPolygon [
	^ aPolygon
]

{ #category : #'instance creation' }
PompeiiDriver >> convexPolygonBuilder [
	^ PompeiiConvexPolygonBuilder new
]

{ #category : #'instance creation' }
PompeiiDriver >> createFontCache: aLogicalFont [
	^ PompeiiFontCache font: aLogicalFont
]

{ #category : #'as yet unclassified' }
PompeiiDriver >> createMaterialForTexture: aTexture [
	^ PompeiiTextureMaterial new texture: aTexture
]

{ #category : #'as yet unclassified' }
PompeiiDriver >> createMaterialForTextureArray: aTextureArray element: aTextureElementIndex [
	^ PompeiiTextureArrayElementMaterial new
		textureArray: aTextureArray;
		elementIndex: aTextureElementIndex;
		yourself
]

{ #category : #'as yet unclassified' }
PompeiiDriver >> createOSWindowAnimatedWithAttributes: attributes eventHandler: eventHandler [
	^ self createOSWindowOfClass: OSWindow animatedWithAttributes: attributes eventHandler: eventHandler
]

{ #category : #'as yet unclassified' }
PompeiiDriver >> createOSWindowOfClass: osWindowClass animatedWithAttributes: attributes eventHandler: eventHandler [
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
PompeiiDriver >> createOSWindowWithAttributes: attributes eventHandler: eventHandler [
	^ self createOSWindowOfClass: OSWindow animatedWithAttributes: attributes eventHandler: eventHandler
]

{ #category : #'mutual exclusion' }
PompeiiDriver >> critical: aBlock [
	mutex critical: aBlock
]

{ #category : #'instance creation' }
PompeiiDriver >> font: aLogicalFont [
	mutex critical: [ 
		^ self cachedFonts at: aLogicalFont ifAbsentPut: [ self createFontCache: aLogicalFont ]
	]

]

{ #category : #initialization }
PompeiiDriver >> initialize [
	super initialize.
	mutex := Mutex new.
]

{ #category : #'instance creation' }
PompeiiDriver >> mesh2DBuilder [
	^ PompeiiMesh2DBuilder new driver: self
]

{ #category : #'as yet unclassified' }
PompeiiDriver >> setupOSWindowAttributes: attributes [
]

{ #category : #'instance creation' }
PompeiiDriver >> surfaceWithExtent: anExtent [
	self subclassResponsibility
]

{ #category : #'instance creation' }
PompeiiDriver >> textureFromForm: aForm [
	self subclassResponsibility
]
