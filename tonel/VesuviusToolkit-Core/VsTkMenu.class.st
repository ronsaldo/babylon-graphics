Class {
	#name : #VsTkMenu,
	#superclass : #VsTkContainerWidget,
	#instVars : [
		'highlightedMenuItem',
		'isActiveMenu',
		'parentMenu'
	],
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #adding }
VsTkMenu >> addMenuItem: label [
	| item |
	item := VsTkMenuItem new
		label: label;
		parentMenu: self;
		yourself.
	self sizer element: item do: [ :el | el proportion: 1; expand ].
	self add: item.
	^ item
]

{ #category : #adding }
VsTkMenu >> addMenuItem: label action: aBlock [
	^ (self addMenuItem: label)
		on: VsTkActionEvent do: aBlock;
		yourself
]

{ #category : #adding }
VsTkMenu >> addMenuItem: label menu: aMenu [
	^ (self addMenuItem: label)
		submenu: aMenu
]

{ #category : #adding }
VsTkMenu >> addMenuItem: label menuWith: aBlock [
	| menu |
	menu := VsTkMenu new parentMenu: self.
	aBlock value: menu.
	^ self addMenuItem: label menu: menu
]

{ #category : #adding }
VsTkMenu >> addMenuSeparator [
	| separator |
	separator := VsTkMenuSeparator new
		yourself.
	self sizer element: separator do: [ :el | el expand ].
	self add: separator.
	^ separator
]

{ #category : #drawing }
VsTkMenu >> buildMeshContentOn: meshBuilder [
	self theme buildMenu: self meshOn: meshBuilder.
]

{ #category : #'menu item connection' }
VsTkMenu >> deactivateCompleteMenu [
	parentMenu ifNil: [ self popUpKill ] ifNotNil: [ parentMenu deactivateCompleteMenu ]
]

{ #category : #accessing }
VsTkMenu >> highlightedMenuItem [
	^ highlightedMenuItem
]

{ #category : #accessing }
VsTkMenu >> highlightedMenuItem: anObject [
	highlightedMenuItem == anObject ifTrue: [ ^ self ].
	
	highlightedMenuItem ifNotNil: [ highlightedMenuItem selected: false ].
	highlightedMenuItem := anObject.
	highlightedMenuItem ifNotNil: [ highlightedMenuItem selected: true ].
]

{ #category : #initialization }
VsTkMenu >> initialize [
	super initialize.
	highlightedMenuItem := nil.
	parentMenu := nil.
	self
		sizer: VsTkVerticalBoxSizer new
]

{ #category : #accessing }
VsTkMenu >> isActiveMenu [
	^ true
]

{ #category : #actions }
VsTkMenu >> kill [
]

{ #category : #'menu item connection' }
VsTkMenu >> menuItemClicked: aMenuItem [
	aMenuItem submenu ifNotNil: [ ^ self ].
	aMenuItem fireActionEvent.
	self deactivateCompleteMenu

]

{ #category : #accessing }
VsTkMenu >> parentMenu [
	^ parentMenu
]

{ #category : #accessing }
VsTkMenu >> parentMenu: anObject [
	parentMenu := anObject
]

{ #category : #popup }
VsTkMenu >> popUpKill [
	self highlightedMenuItem: nil.
	super popUpKill
]

{ #category : #popup }
VsTkMenu >> prepareToPopUpIn: aHostWindow [
	self fit
]

{ #category : #actions }
VsTkMenu >> spawnIn: window at: aPosition [
]
