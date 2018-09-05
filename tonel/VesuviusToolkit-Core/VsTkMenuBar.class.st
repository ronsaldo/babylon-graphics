Class {
	#name : #VsTkMenuBar,
	#superclass : #VsTkBarWidget,
	#instVars : [
		'highlightedMenuItem',
		'isActiveMenu'
	],
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #adding }
VsTkMenuBar >> addMenuItem: label [
	| item |
	item := VsTkMenuItem new
		label: label;
		parentMenu: self;
		yourself.
	self sizer element: item do: [ :el | el expand ].
	self add: item.
	^ item
]

{ #category : #adding }
VsTkMenuBar >> addMenuItem: label action: aBlock [
	^ (self addMenuItem: label)
		on: VsTkActionEvent do: aBlock;
		yourself
]

{ #category : #adding }
VsTkMenuBar >> addMenuItem: label menu: aMenu [
	^ (self addMenuItem: label)
		submenu: aMenu
]

{ #category : #adding }
VsTkMenuBar >> addMenuItem: label menuWith: aBlock [
	| menu |
	menu := VsTkMenu new parentMenu: self.
	aBlock value: menu.
	^ self addMenuItem: label menu: menu
]

{ #category : #adding }
VsTkMenuBar >> addMenuSeparator [
	| separator |
	separator := VsTkMenuSeparator new
		parentMenu: self;
		yourself.
	self sizer element: separator do: [ :el | el expand ].
	self add: separator.
	^ separator
]

{ #category : #drawing }
VsTkMenuBar >> buildMeshContentOn: meshBuilder [
	self theme buildMenuBar: self meshOn: meshBuilder.
]

{ #category : #'menu item connection' }
VsTkMenuBar >> deactivateCompleteMenu [
	self isActiveMenu: false
]

{ #category : #accessing }
VsTkMenuBar >> highlightedMenuItem [
	^ highlightedMenuItem
]

{ #category : #accessing }
VsTkMenuBar >> highlightedMenuItem: anObject [
	(highlightedMenuItem == anObject or: [ isActiveMenu not ]) ifTrue: [ ^ self ].
	
	highlightedMenuItem ifNotNil: [ highlightedMenuItem selected: false ].
	highlightedMenuItem := anObject.
	highlightedMenuItem ifNotNil: [ highlightedMenuItem selected: true ].
]

{ #category : #initialization }
VsTkMenuBar >> initialize [
	super initialize.
	highlightedMenuItem := nil.
	isActiveMenu := false. 
	self
		sizer: VsTkHorizontalBoxSizer new;
		autolayout: true
]

{ #category : #accessing }
VsTkMenuBar >> isActiveMenu [
	^ isActiveMenu
]

{ #category : #accessing }
VsTkMenuBar >> isActiveMenu: newValue [
	newValue ifFalse: [ self highlightedMenuItem: nil ].
	isActiveMenu := newValue.
]

{ #category : #testing }
VsTkMenuBar >> isMenuBar [
	^ true
]

{ #category : #'menu item connection' }
VsTkMenuBar >> menuItemClicked: aMenuItem [
	isActiveMenu ifTrue: [
		aMenuItem fireActionEvent.
		self isActiveMenu: false.
	] ifFalse: [
		self isActiveMenu: true.
		self highlightedMenuItem: aMenuItem.
	]
]

{ #category : #accessing }
VsTkMenuBar >> minimalExtent [
	^ self theme computeMenuBarMinimalExtent: self
]
