Class {
	#name : #CyTkContainerWidget,
	#superclass : #CyTkWidget,
	#instVars : [
		'children',
		'autolayout',
		'sizer'
	],
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #adding }
CyTkContainerWidget >> add: aChild [
	aChild parent ifNotNil: [ aChild parent remove: aChild ].
	aChild parent: self.
	children add: aChild.
	self changed.
	^ aChild
]

{ #category : #adding }
CyTkContainerWidget >> addAll: aCollection [
	aCollection do: [ :el | self add: el ]
]

{ #category : #accessing }
CyTkContainerWidget >> autolayout [
	^ autolayout
]

{ #category : #accessing }
CyTkContainerWidget >> autolayout: anObject [
	autolayout := anObject
]

{ #category : #changes }
CyTkContainerWidget >> boundsChanged [
	autolayout ifTrue: [
		self updateLayout.
	].
	super boundsChanged.
]

{ #category : #drawing }
CyTkContainerWidget >> buildMeshOn: aMeshBuilder [
	aMeshBuilder transform restoreAfter: [
		meshScope ifFalse: [ 
			aMeshBuilder transform translateBy: self drawPosition.
		].
	
		self buildMeshContentOn: aMeshBuilder.
		children do: [ :child | child meshScope ifFalse: [ child buildMeshOn: aMeshBuilder ] ].
	]
]

{ #category : #changes }
CyTkContainerWidget >> changed [
	meshScope ifTrue: [ cachedMesh := nil ].
	super changed.
]

{ #category : #accessing }
CyTkContainerWidget >> children [
	^ children
]

{ #category : #'events-processing' }
CyTkContainerWidget >> findChildForMousePosition: aPosition [
	children reverseDo: [ :child |
		(child bounds containsPoint: aPosition) ifTrue: [ ^ child ]
	].

	^ nil
]

{ #category : #layout }
CyTkContainerWidget >> fit [
	sizer ifNotNil: [
		self extent: sizer minimalExtent.
		autolayout ifFalse: [ self updateLayout ]
	].
]

{ #category : #drawing }
CyTkContainerWidget >> fullDrawOn: canvas [
	canvas transform restoreAfter: [
		canvas transform translateBy: self drawPosition. 
		(clipContents and: meshScope) ifTrue: [ canvas pushClipRectangle: self localBounds ].
		self drawMeshOn: canvas.
		self drawOn: canvas.
		children do: [ :child | child fullDrawOn: canvas].
		(clipContents and: meshScope) ifTrue: [ canvas popClipRectangle ].
	].

]

{ #category : #'events-processing' }
CyTkContainerWidget >> handleClick: event [
	| child childEvent |
	child := self findChildForMousePosition: event position.
	child ifNotNil: [
		childEvent := event toLocalOrigin: child position.
		child processEvent: childEvent.
		event wasHandled: childEvent wasHandled.
	].

	^ super handleClick: event
]

{ #category : #'events-processing' }
CyTkContainerWidget >> handleDoubleClick: event [
	| child childEvent |
	child := self findChildForMousePosition: event position.
	child ifNotNil: [
		childEvent := event toLocalOrigin: child position.
		child processEvent: childEvent.
		event wasHandled: childEvent wasHandled.
	].

	^ super handleDoubleClick: event
]

{ #category : #'events-processing' }
CyTkContainerWidget >> handleMouseButtonDown: event [
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
CyTkContainerWidget >> handleMouseButtonUp: event [
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
CyTkContainerWidget >> handleMouseMove: event [
	| child childEvent |
	child := self findChildForMousePosition: event position.
	child ifNotNil: [
		childEvent := event toLocalOrigin: child position.
		child processEvent: childEvent.
		event wasHandled: childEvent wasHandled.
	].

	^ super handleMouseMove: event
]

{ #category : #'events-processing' }
CyTkContainerWidget >> handleMouseWheel: event [
	| child childEvent |
	child := self findChildForMousePosition: event position.
	child ifNotNil: [
		childEvent := event toLocalOrigin: child position.
		child processEvent: childEvent.
		event wasHandled: childEvent wasHandled.
	].

	^ super handleMouseWheel: event
]

{ #category : #initialization }
CyTkContainerWidget >> initialize [
	super initialize.
	children := OrderedCollection new.
	autolayout := false.
]

{ #category : #accessing }
CyTkContainerWidget >> minimalExtent [
	sizer ifNotNil: [ ^ sizer minimalExtent ].
	^ super minimalExtent
]

{ #category : #removing }
CyTkContainerWidget >> remove: aChild [
	children remove: aChild ifAbsent: [ ^ self ].
	aChild parent: nil.
	self changed.
]

{ #category : #accessing }
CyTkContainerWidget >> sizer [
	^ sizer
]

{ #category : #accessing }
CyTkContainerWidget >> sizer: anObject [
	sizer := anObject
]

{ #category : #layout }
CyTkContainerWidget >> updateLayout [
	sizer ifNotNil: [ sizer applyIntoExtent: self extent position: ZeroPoint].
]
