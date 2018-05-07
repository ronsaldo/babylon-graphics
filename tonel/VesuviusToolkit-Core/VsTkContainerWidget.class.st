Class {
	#name : #VsTkContainerWidget,
	#superclass : #VsTkWidget,
	#instVars : [
		'children',
		'autolayout',
		'sizer'
	],
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #adding }
VsTkContainerWidget >> add: aChild [
	aChild parent ifNotNil: [ aChild parent remove: aChild ].
	aChild parent: self.
	children add: aChild.
	self changed.
]

{ #category : #accessing }
VsTkContainerWidget >> autolayout [
	^ autolayout
]

{ #category : #accessing }
VsTkContainerWidget >> autolayout: anObject [
	autolayout := anObject
]

{ #category : #changes }
VsTkContainerWidget >> boundsChanged [
	autolayout ifTrue: [
		self updateLayout.
	].
	super boundsChanged.
]

{ #category : #drawing }
VsTkContainerWidget >> buildMeshOn: aMeshBuilder [
	aMeshBuilder transform restoreAfter: [
		meshScope ifFalse: [ 
			aMeshBuilder transform translateBy: self drawPosition.
		].
	
		self buildMeshContentOn: aMeshBuilder.
		children do: [ :child | child buildMeshOn: aMeshBuilder ].
	]
]

{ #category : #changes }
VsTkContainerWidget >> changed [
	meshScope ifTrue: [ cachedMesh := nil ].
	super changed.
]

{ #category : #accessing }
VsTkContainerWidget >> children [
	^ children
]

{ #category : #'events-processing' }
VsTkContainerWidget >> findChildForMousePosition: aPosition [
	children reverseDo: [ :child |
		(child bounds containsPoint: aPosition) ifTrue: [ ^ child ]
	].

	^ nil
]

{ #category : #layout }
VsTkContainerWidget >> fit [
	sizer ifNotNil: [
		self extent: sizer minimalExtent.
		autolayout ifFalse: [ self updateLayout ]
	].
]

{ #category : #drawing }
VsTkContainerWidget >> fullDrawOn: canvas [
	canvas transform restoreAfter: [
		canvas transform translateBy: self drawPosition. 
		self drawMeshOn: canvas.
		self drawOn: canvas.
		children do: [ :child | child fullDrawOn: canvas]
	].

]

{ #category : #'events-processing' }
VsTkContainerWidget >> handleMouseButtonDown: event [
	| child childEvent |
	child := self findChildForMousePosition: event position.
	child ifNotNil: [
		childEvent := event toLocalOrigin: child position.
		child processEvent: childEvent.
		event wasHandled: childEvent wasHandled.
	].

	^ super handleMouseButtonDown: event
]

{ #category : #'events-processing' }
VsTkContainerWidget >> handleMouseButtonUp: event [
	| child childEvent |
	child := self findChildForMousePosition: event position.
	child ifNotNil: [
		childEvent := event toLocalOrigin: child position.
		child processEvent: childEvent.
		event wasHandled: childEvent wasHandled.
	].

	^ super handleMouseButtonUp: event
]

{ #category : #'events-processing' }
VsTkContainerWidget >> handleMouseMove: event [
	| child childEvent |
	child := self findChildForMousePosition: event position.
	child ifNotNil: [
		childEvent := event toLocalOrigin: child position.
		child processEvent: childEvent.
		event wasHandled: childEvent wasHandled.
	].

	^ super handleMouseMove: event
]

{ #category : #initialization }
VsTkContainerWidget >> initialize [
	super initialize.
	children := OrderedCollection new.
	autolayout := false.
]

{ #category : #removing }
VsTkContainerWidget >> remove: aChild [
	children remove: aChild ifAbsent: [ ^ self ].
	aChild parent: nil.
	self changed.
]

{ #category : #accessing }
VsTkContainerWidget >> sizer [
	^ sizer
]

{ #category : #accessing }
VsTkContainerWidget >> sizer: anObject [
	sizer := anObject
]

{ #category : #layout }
VsTkContainerWidget >> updateLayout [
	sizer ifNotNil: [ sizer applyIntoExtent: self extent position: ZeroPoint].
]
