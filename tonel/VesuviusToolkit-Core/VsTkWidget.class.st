Class {
	#name : #VsTkWidget,
	#superclass : #Object,
	#traits : 'TVsTkEventHandler',
	#classTraits : 'TVsTkEventHandler classTrait',
	#instVars : [
		'position',
		'extent',
		'parent',
		'visible',
		'meshScope',
		'cachedMesh',
		'hasMouseFocus',
		'hasKeyboardFocus',
		'eventDispatcher'
	],
	#classVars : [
		'ZeroPoint'
	],
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #defaults }
VsTkWidget class >> defaultExtent [
	^ 64@64
]

{ #category : #defaults }
VsTkWidget class >> defaultPosition [
	^ 0@0
]

{ #category : #initialization }
VsTkWidget class >> initialize [
	ZeroPoint := 0@0.
]

{ #category : #converting }
VsTkWidget >> asSizerElement [
	^ VsTkSizerWidgetElement new widget: self
]

{ #category : #accessing }
VsTkWidget >> bounds [
	^ position extent: extent
]

{ #category : #changes }
VsTkWidget >> boundsChanged [
	self changed
]

{ #category : #drawing }
VsTkWidget >> buildMeshContentOn: aMeshBuilder [
]

{ #category : #drawing }
VsTkWidget >> buildMeshOn: aMeshBuilder [
	aMeshBuilder transform restoreAfter: [
		aMeshBuilder transform translateBy: self drawPosition.
		self buildMeshContentOn: aMeshBuilder
	]
]

{ #category : #accessing }
VsTkWidget >> cachedMesh [
	^ cachedMesh
]

{ #category : #accessing }
VsTkWidget >> cachedMesh: anObject [
	cachedMesh := anObject
]

{ #category : #focus }
VsTkWidget >> canHaveKeyboardFocus [
	^ false
]

{ #category : #testing }
VsTkWidget >> canHaveMouseFocus [
	^ true
]

{ #category : #'mouse capture' }
VsTkWidget >> captureMouse [
	self captureMouse: false
]

{ #category : #'mouse capture' }
VsTkWidget >> captureMouse: captureHost [
	self host ifNotNil: [ :host | host setMouseCapture: self captureHost: captureHost]
]

{ #category : #changes }
VsTkWidget >> changed [
	parent ifNotNil: [ parent changed ]
]

{ #category : #drawing }
VsTkWidget >> drawMeshOn: canvas [
	| builder |
	meshScope ifFalse: [ ^ self ].
	
	cachedMesh ifNil: [ 
		builder := canvas driver mesh2DBuilder.
		self buildMeshOn: builder.
		cachedMesh := builder mesh.
	].

	canvas draw: cachedMesh

]

{ #category : #drawing }
VsTkWidget >> drawOn: canvas [
]

{ #category : #accessing }
VsTkWidget >> drawPosition [
	^ position
]

{ #category : #'events-processing' }
VsTkWidget >> eventDispatcher [
	^ eventDispatcher ifNil: [ eventDispatcher := VsTkEventDispatcher new ]
]

{ #category : #accessing }
VsTkWidget >> extent [
	^ extent
]

{ #category : #accessing }
VsTkWidget >> extent: anObject [
	extent := anObject.
	self boundsChanged.
]

{ #category : #drawing }
VsTkWidget >> fullDrawOn: canvas [
	canvas transform restoreAfter: [
		canvas transform translateBy: self drawPosition.
		self drawOn: canvas
	]
	
]

{ #category : #focus }
VsTkWidget >> grabKeyboardFocus [
	self host ifNotNil: [ :host | host setKeyboardFocus: self ]
]

{ #category : #focus }
VsTkWidget >> grabMouseFocus [
	self host ifNotNil: [ :host | host setMouseFocus: self ]
]

{ #category : #'events-processing' }
VsTkWidget >> handleMouseButtonDown: event [
	event wasHandled ifTrue: [ ^ self ].
	
	self canHaveKeyboardFocus ifTrue: [
		self grabKeyboardFocus.
		event wasHandled: true.
	].

	self canHaveMouseFocus ifTrue: [
		self grabMouseFocus.
		event wasHandled: true.
	]
]

{ #category : #'events-processing' }
VsTkWidget >> handleMouseButtonUp: event [
	event wasHandled ifTrue: [ ^ self ].
	
	self canHaveMouseFocus ifTrue: [
		self grabMouseFocus.
		event wasHandled: true.
	]
]

{ #category : #'events-processing' }
VsTkWidget >> handleMouseMove: event [
	event wasHandled ifTrue: [ ^ self ].
	
	self canHaveMouseFocus ifTrue: [
		self grabMouseFocus.
		event wasHandled: true.
	]

]

{ #category : #accessing }
VsTkWidget >> hasKeyboardFocus [
	^ hasKeyboardFocus
]

{ #category : #accessing }
VsTkWidget >> hasKeyboardFocus: anObject [
	hasKeyboardFocus := anObject
]

{ #category : #accessing }
VsTkWidget >> hasMouseFocus [
	^ hasMouseFocus
]

{ #category : #accessing }
VsTkWidget >> hasMouseFocus: anObject [
	hasMouseFocus := anObject
]

{ #category : #accessing }
VsTkWidget >> hide [
	self visible: false
]

{ #category : #accessing }
VsTkWidget >> host [
	^ parent ifNotNil: [ parent host]
]

{ #category : #accessing }
VsTkWidget >> hostBounds [
	^ self hostPosition extent: self extent
]

{ #category : #accessing }
VsTkWidget >> hostPosition [
	^ parent ifNotNil: [ parent hostPosition + position ] ifNil: [ position ]
]

{ #category : #initialization }
VsTkWidget >> initialize [
	super initialize.
	position := self class defaultPosition.
	extent := self class defaultExtent.
	visible := true.
	meshScope := false.
	hasMouseFocus := false.
	hasKeyboardFocus := false.
]

{ #category : #accessing }
VsTkWidget >> localBounds [
	^ self localPosition extent: extent
]

{ #category : #accessing }
VsTkWidget >> localPosition [
	^ ZeroPoint
]

{ #category : #changes }
VsTkWidget >> meshChanged [
	meshScope ifTrue: [
		cachedMesh := nil.
		self changed
	] ifFalse: [ 
		parent ifNotNil: [ parent meshChanged ]
	]
]

{ #category : #accessing }
VsTkWidget >> meshScope [
	^ meshScope
]

{ #category : #accessing }
VsTkWidget >> meshScope: anObject [
	meshScope := anObject
]

{ #category : #accessing }
VsTkWidget >> minimalExtent [
	^ ZeroPoint
]

{ #category : #'events-processing' }
VsTkWidget >> on: eventClass do: anAction [
	self eventDispatcher on: eventClass do: anAction
]

{ #category : #accessing }
VsTkWidget >> parent [
	^ parent
]

{ #category : #accessing }
VsTkWidget >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
VsTkWidget >> position [
	^ position
]

{ #category : #accessing }
VsTkWidget >> position: anObject [
	position := anObject.
	self boundsChanged
]

{ #category : #accessing }
VsTkWidget >> position: aPosition extent: aExtent [
	position := aPosition.
	extent := aExtent.
	self boundsChanged.
]

{ #category : #'events-processing' }
VsTkWidget >> processEvent: anEvent [
	anEvent handleWith: self.
	
	eventDispatcher ifNotNil: [ eventDispatcher processEvent: anEvent ]
]

{ #category : #'mouse capture' }
VsTkWidget >> releaseMouse [
	self releaseMouse: false
]

{ #category : #'mouse capture' }
VsTkWidget >> releaseMouse: captureHost [
	self host ifNotNil: [ :host | host setMouseCapture: nil captureHost: captureHost]
]

{ #category : #accessing }
VsTkWidget >> show [
	self visible: true
]

{ #category : #accessing }
VsTkWidget >> theme [
	^ VsTkTheme current
]

{ #category : #accessing }
VsTkWidget >> visible [
	^ visible
]

{ #category : #accessing }
VsTkWidget >> visible: anObject [
	visible := anObject
]
