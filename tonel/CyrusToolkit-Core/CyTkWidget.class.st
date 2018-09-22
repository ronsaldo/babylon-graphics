Class {
	#name : #CyTkWidget,
	#superclass : #Object,
	#traits : 'TCyTkEventHandler',
	#classTraits : 'TCyTkEventHandler classTrait',
	#instVars : [
		'position',
		'extent',
		'parent',
		'visible',
		'meshScope',
		'cachedMesh',
		'hasMouseFocus',
		'hasKeyboardFocus',
		'eventDispatcher',
		'dragState',
		'clipContents'
	],
	#classVars : [
		'ZeroPoint'
	],
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #defaults }
CyTkWidget class >> defaultExtent [
	^ 64@64
]

{ #category : #defaults }
CyTkWidget class >> defaultPosition [
	^ 0@0
]

{ #category : #initialization }
CyTkWidget class >> initialize [
	ZeroPoint := 0@0.
]

{ #category : #converting }
CyTkWidget >> asSizerElement [
	^ CyTkSizerWidgetElement new widget: self
]

{ #category : #accessing }
CyTkWidget >> bounds [
	^ position extent: extent
]

{ #category : #changes }
CyTkWidget >> boundsChanged [
	self changed
]

{ #category : #drawing }
CyTkWidget >> buildMeshContentOn: aMeshBuilder [
]

{ #category : #drawing }
CyTkWidget >> buildMeshOn: aMeshBuilder [
	aMeshBuilder transform restoreAfter: [
		aMeshBuilder transform translateBy: self drawPosition.
		self buildMeshContentOn: aMeshBuilder
	]
]

{ #category : #accessing }
CyTkWidget >> cachedMesh [
	^ cachedMesh
]

{ #category : #accessing }
CyTkWidget >> cachedMesh: anObject [
	cachedMesh := anObject
]

{ #category : #dragging }
CyTkWidget >> canHaveDragEvents [
	^ false
]

{ #category : #focus }
CyTkWidget >> canHaveKeyboardFocus [
	^ false
]

{ #category : #testing }
CyTkWidget >> canHaveMouseFocus [
	^ true
]

{ #category : #'mouse capture' }
CyTkWidget >> captureMouse [
	self captureMouse: false
]

{ #category : #'mouse capture' }
CyTkWidget >> captureMouse: captureHost [
	self host ifNotNil: [ :host | host setMouseCapture: self captureHost: captureHost]
]

{ #category : #'mouse capture' }
CyTkWidget >> captureMouseWithHost [
	^ self captureMouse: true
]

{ #category : #changes }
CyTkWidget >> changed [
	parent ifNotNil: [ parent changed ]
]

{ #category : #accessing }
CyTkWidget >> clipContents [
	^ clipContents
]

{ #category : #accessing }
CyTkWidget >> clipContents: anObject [
	clipContents := anObject
]

{ #category : #accessing }
CyTkWidget >> dragState [
	^ dragState
]

{ #category : #accessing }
CyTkWidget >> dragState: aDragState [
	dragState := aDragState
]

{ #category : #drawing }
CyTkWidget >> drawMeshOn: canvas [
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
CyTkWidget >> drawOn: canvas [
]

{ #category : #accessing }
CyTkWidget >> drawPosition [
	^ position
]

{ #category : #'events-processing' }
CyTkWidget >> eventDispatcher [
	^ eventDispatcher ifNil: [ eventDispatcher := CyTkEventDispatcher new ]
]

{ #category : #accessing }
CyTkWidget >> extent [
	^ extent
]

{ #category : #accessing }
CyTkWidget >> extent: aNewExtent [
	extent = aNewExtent ifTrue: [ ^ self ].
	extent := aNewExtent.
	self boundsChanged.
]

{ #category : #accessing }
CyTkWidget >> extentForLayoutComputation [
	^ self minimalExtent
]

{ #category : #'event firing' }
CyTkWidget >> fireActionEvent [
	self processEvent: (CyTkActionEvent source: self)
]

{ #category : #drawing }
CyTkWidget >> fullDrawOn: canvas [
	canvas transform restoreAfter: [
		canvas transform translateBy: self drawPosition.
		(clipContents and: meshScope) ifTrue: [ canvas pushClipRectangle: self localBounds ].
		self drawOn: canvas.
		(clipContents and: meshScope) ifTrue: [ canvas popClipRectangle ].
	]
	
]

{ #category : #focus }
CyTkWidget >> grabKeyboardFocus [
	self host ifNotNil: [ :host | host setKeyboardFocus: self ]
]

{ #category : #focus }
CyTkWidget >> grabMouseFocus [
	self host ifNotNil: [ :host | host setMouseFocus: self ]
]

{ #category : #'events-processing' }
CyTkWidget >> handleMouseButtonDown: event [
	event wasHandled ifTrue: [ ^ self ].
	
	self canHaveKeyboardFocus ifTrue: [
		self grabKeyboardFocus.
		event wasHandled: true.
	].

	self canHaveMouseFocus ifTrue: [
		self grabMouseFocus.
		event wasHandled: true.
	].

	self canHaveDragEvents ifTrue: [
		dragState ifNil: [
			CyTkDragState new widget: self; handleMouseButtonDown: event. 
		] ifNotNil: [
			dragState handleMouseButtonDown: event
		]
	].

]

{ #category : #'events-processing' }
CyTkWidget >> handleMouseButtonUp: event [
	event wasHandled ifTrue: [ ^ self ].
	
	self canHaveMouseFocus ifTrue: [
		self grabMouseFocus.
		event wasHandled: true.
	].

	self canHaveDragEvents ifTrue: [
		dragState ifNotNil: [
			dragState handleMouseButtonUp: event
		]
	].

]

{ #category : #'events-processing' }
CyTkWidget >> handleMouseMove: event [
	event wasHandled ifTrue: [ ^ self ].
	
	self canHaveMouseFocus ifTrue: [
		self grabMouseFocus.
		event wasHandled: true.
	].

	self canHaveDragEvents ifTrue: [
		dragState ifNotNil: [
			dragState handleMouseMove: event
		]
	].
]

{ #category : #accessing }
CyTkWidget >> hasKeyboardFocus [
	^ hasKeyboardFocus
]

{ #category : #accessing }
CyTkWidget >> hasKeyboardFocus: anObject [
	hasKeyboardFocus := anObject
]

{ #category : #accessing }
CyTkWidget >> hasMouseFocus [
	^ hasMouseFocus
]

{ #category : #accessing }
CyTkWidget >> hasMouseFocus: anObject [
	hasMouseFocus := anObject
]

{ #category : #accessing }
CyTkWidget >> height [
	^ extent y
]

{ #category : #accessing }
CyTkWidget >> hide [
	self visible: false
]

{ #category : #accessing }
CyTkWidget >> host [
	^ parent ifNotNil: [ parent host]
]

{ #category : #accessing }
CyTkWidget >> hostBounds [
	^ self hostPosition extent: self extent
]

{ #category : #accessing }
CyTkWidget >> hostPosition [
	^ parent ifNotNil: [ parent hostPosition + position ] ifNil: [ position ]
]

{ #category : #initialization }
CyTkWidget >> initialize [
	super initialize.
	position := self class defaultPosition.
	extent := self class defaultExtent.
	visible := true.
	meshScope := false.
	hasMouseFocus := false.
	hasKeyboardFocus := false.
	clipContents := true.
]

{ #category : #testing }
CyTkWidget >> isMenuBar [
	^ false
]

{ #category : #accessing }
CyTkWidget >> localBounds [
	^ self localPosition extent: extent
]

{ #category : #accessing }
CyTkWidget >> localPosition [
	^ ZeroPoint
]

{ #category : #changes }
CyTkWidget >> meshChanged [
	meshScope ifTrue: [
		cachedMesh := nil.
		self changed
	] ifFalse: [ 
		parent ifNotNil: [ parent meshChanged ]
	]
]

{ #category : #accessing }
CyTkWidget >> meshScope [
	^ meshScope
]

{ #category : #accessing }
CyTkWidget >> meshScope: anObject [
	meshScope := anObject
]

{ #category : #accessing }
CyTkWidget >> minimalExtent [
	^ ZeroPoint
]

{ #category : #'events-processing' }
CyTkWidget >> on: eventClass do: anAction [
	self eventDispatcher on: eventClass do: anAction
]

{ #category : #accessing }
CyTkWidget >> parent [
	^ parent
]

{ #category : #accessing }
CyTkWidget >> parent: anObject [
	parent := anObject
]

{ #category : #popup }
CyTkWidget >> popUpIn: aHostWindow at: aPosition [
	aHostWindow ifNil: [ ^ self ].
	aHostWindow popUp: self at: aPosition
]

{ #category : #popup }
CyTkWidget >> popUpKill [
	self host ifNotNil: [:host | host killPopUp: self]
]

{ #category : #accessing }
CyTkWidget >> position [
	^ position
]

{ #category : #accessing }
CyTkWidget >> position: anObject [
	position := anObject.
	self boundsChanged
]

{ #category : #accessing }
CyTkWidget >> position: aPosition extent: aExtent [
	position := aPosition.
	extent := aExtent.
	self boundsChanged.
]

{ #category : #popup }
CyTkWidget >> prepareToPopUpIn: aHostWindow [

]

{ #category : #'events-processing' }
CyTkWidget >> processEvent: anEvent [
	anEvent handleWith: self.
	
	eventDispatcher ifNotNil: [ eventDispatcher processEvent: anEvent ]
]

{ #category : #'mouse capture' }
CyTkWidget >> releaseMouse [
	self releaseMouse: false
]

{ #category : #'mouse capture' }
CyTkWidget >> releaseMouse: captureHost [
	self host ifNotNil: [ :host | host setMouseCapture: nil captureHost: captureHost]
]

{ #category : #'mouse capture' }
CyTkWidget >> releaseMouseWithHost [
	^ self releaseMouse: true
]

{ #category : #accessing }
CyTkWidget >> show [
	self visible: true
]

{ #category : #accessing }
CyTkWidget >> theme [
	^ CyTkTheme current
]

{ #category : #accessing }
CyTkWidget >> visible [
	^ visible
]

{ #category : #accessing }
CyTkWidget >> visible: anObject [
	visible := anObject
]

{ #category : #accessing }
CyTkWidget >> width [
	^ extent x
]
