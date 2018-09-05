Class {
	#name : #VsTkMenuItem,
	#superclass : #VsTkMeshWidget,
	#instVars : [
		'parentMenu',
		'label',
		'selected',
		'submenu'
	],
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #drawing }
VsTkMenuItem >> buildMeshContentOn: meshBuilder [
	self theme buildMenuItem: self meshOn: meshBuilder.
]

{ #category : #'events-processing' }
VsTkMenuItem >> handleClick: anEvent [
	parentMenu menuItemClicked: self
]

{ #category : #'events-processing' }
VsTkMenuItem >> handleMouseEnter: anEvent [
	parentMenu highlightedMenuItem: self
]

{ #category : #initialization }
VsTkMenuItem >> initialize [
	super initialize.
	label := ''.
	selected := false.
	
]

{ #category : #menu }
VsTkMenuItem >> killSubMenu [
	submenu ifNil: [ ^ self ].
	submenu popUpKill
]

{ #category : #accessing }
VsTkMenuItem >> label [
	^ label
]

{ #category : #accessing }
VsTkMenuItem >> label: anObject [
	label := anObject
]

{ #category : #accessing }
VsTkMenuItem >> minimalExtent [
	^ self theme computeMenuItemMinimalExtent: self
]

{ #category : #accessing }
VsTkMenuItem >> parentMenu [
	^ parentMenu
]

{ #category : #accessing }
VsTkMenuItem >> parentMenu: anObject [
	parentMenu := anObject
]

{ #category : #menu }
VsTkMenuItem >> popSubMenu [
	| spawnPosition |
	submenu ifNil: [ ^ self ].
	
	spawnPosition := parentMenu isMenuBar
		ifTrue: [self hostBounds bottomLeft]
		ifFalse: [self hostBounds topRight].
	submenu popUpIn: self host at: spawnPosition
]

{ #category : #accessing }
VsTkMenuItem >> selected [
	^ selected
]

{ #category : #accessing }
VsTkMenuItem >> selected: newValue [
	selected := newValue.
	newValue ifTrue: [
		self popSubMenu
	] ifFalse: [
		self killSubMenu
	].

	self changed
]

{ #category : #accessing }
VsTkMenuItem >> submenu [
	^ submenu
]

{ #category : #accessing }
VsTkMenuItem >> submenu: anObject [
	submenu := anObject
]
