Class {
	#name : #CyTkMenuBar,
	#superclass : #CyTkBarWidget,
	#instVars : [
		'highlightedMenuItem',
		'isActiveMenu'
	],
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #adding }
CyTkMenuBar >> addMenuItem: label [
	| item |
	item := CyTkMenuItem new
		label: label;
		parentMenu: self;
		yourself.
	self sizer element: item do: [ :el | el expand ].
	self add: item.
	^ item
]

{ #category : #adding }
CyTkMenuBar >> addMenuItem: label action: aBlock [
	^ (self addMenuItem: label)
		on: CyTkActionEvent do: aBlock;
		yourself
]

{ #category : #adding }
CyTkMenuBar >> addMenuItem: label menu: aMenu [
	^ (self addMenuItem: label)
		submenu: aMenu
]

{ #category : #adding }
CyTkMenuBar >> addMenuItem: label menuWith: aBlock [
	| menu |
	menu := CyTkMenu new parentMenu: self.
	aBlock value: menu.
	^ self addMenuItem: label menu: menu
]

{ #category : #adding }
CyTkMenuBar >> addMenuSeparator [
	| separator |
	separator := CyTkMenuSeparator new
		parentMenu: self;
		yourself.
	self sizer element: separator do: [ :el | el expand ].
	self add: separator.
	^ separator
]

{ #category : #drawing }
CyTkMenuBar >> buildMeshContentOn: meshBuilder [
	self theme buildMenuBar: self meshOn: meshBuilder.
]

{ #category : #'menu item connection' }
CyTkMenuBar >> deactivateCompleteMenu [
	self isActiveMenu: false
]

{ #category : #accessing }
CyTkMenuBar >> highlightedMenuItem [
	^ highlightedMenuItem
]

{ #category : #accessing }
CyTkMenuBar >> highlightedMenuItem: anObject [
	(highlightedMenuItem == anObject or: [ isActiveMenu not ]) ifTrue: [ ^ self ].
	
	highlightedMenuItem ifNotNil: [ highlightedMenuItem selected: false ].
	highlightedMenuItem := anObject.
	highlightedMenuItem ifNotNil: [ highlightedMenuItem selected: true ].
]

{ #category : #initialization }
CyTkMenuBar >> initialize [
	super initialize.
	highlightedMenuItem := nil.
	isActiveMenu := false. 
	self
		sizer: CyTkHorizontalBoxSizer new;
		autolayout: true
]

{ #category : #accessing }
CyTkMenuBar >> isActiveMenu [
	^ isActiveMenu
]

{ #category : #accessing }
CyTkMenuBar >> isActiveMenu: newValue [
	newValue ifFalse: [ self highlightedMenuItem: nil ].
	isActiveMenu := newValue.
]

{ #category : #testing }
CyTkMenuBar >> isMenuBar [
	^ true
]

{ #category : #'menu item connection' }
CyTkMenuBar >> menuItemClicked: aMenuItem [
	isActiveMenu ifTrue: [
		aMenuItem fireActionEvent.
		self isActiveMenu: false.
	] ifFalse: [
		self isActiveMenu: true.
		self highlightedMenuItem: aMenuItem.
	]
]

{ #category : #accessing }
CyTkMenuBar >> minimalExtent [
	^ self theme computeMenuBarMinimalExtent: self
]
