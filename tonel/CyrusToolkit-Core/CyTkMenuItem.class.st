Class {
	#name : #CyTkMenuItem,
	#superclass : #CyTkMeshWidget,
	#instVars : [
		'parentMenu',
		'label',
		'selected',
		'submenu'
	],
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #drawing }
CyTkMenuItem >> buildMeshContentOn: meshBuilder [
	self theme buildMenuItem: self meshOn: meshBuilder.
]

{ #category : #'events-processing' }
CyTkMenuItem >> handleClick: anEvent [
	parentMenu menuItemClicked: self
]

{ #category : #'events-processing' }
CyTkMenuItem >> handleMouseEnter: anEvent [
	parentMenu highlightedMenuItem: self
]

{ #category : #initialization }
CyTkMenuItem >> initialize [
	super initialize.
	label := ''.
	selected := false.
	
]

{ #category : #menu }
CyTkMenuItem >> killSubMenu [
	submenu ifNil: [ ^ self ].
	submenu popUpKill
]

{ #category : #accessing }
CyTkMenuItem >> label [
	^ label
]

{ #category : #accessing }
CyTkMenuItem >> label: anObject [
	label := anObject
]

{ #category : #accessing }
CyTkMenuItem >> minimalExtent [
	^ self theme computeMenuItemMinimalExtent: self
]

{ #category : #accessing }
CyTkMenuItem >> parentMenu [
	^ parentMenu
]

{ #category : #accessing }
CyTkMenuItem >> parentMenu: anObject [
	parentMenu := anObject
]

{ #category : #menu }
CyTkMenuItem >> popSubMenu [
	| spawnPosition |
	submenu ifNil: [ ^ self ].
	
	spawnPosition := parentMenu isMenuBar
		ifTrue: [self hostBounds bottomLeft]
		ifFalse: [self hostBounds topRight].
	submenu popUpIn: self host at: spawnPosition
]

{ #category : #accessing }
CyTkMenuItem >> selected [
	^ selected
]

{ #category : #accessing }
CyTkMenuItem >> selected: newValue [
	selected := newValue.
	newValue ifTrue: [
		self popSubMenu
	] ifFalse: [
		self killSubMenu
	].

	self changed
]

{ #category : #accessing }
CyTkMenuItem >> submenu [
	^ submenu
]

{ #category : #accessing }
CyTkMenuItem >> submenu: anObject [
	submenu := anObject
]
