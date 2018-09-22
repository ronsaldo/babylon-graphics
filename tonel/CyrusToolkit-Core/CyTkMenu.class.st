Class {
	#name : #CyTkMenu,
	#superclass : #CyTkContainerWidget,
	#instVars : [
		'highlightedMenuItem',
		'isActiveMenu',
		'parentMenu'
	],
	#category : #'CyrusToolkit-Core-Widget'
}

{ #category : #adding }
CyTkMenu >> addMenuItem: label [
	| item |
	item := CyTkMenuItem new
		label: label;
		parentMenu: self;
		yourself.
	self sizer element: item do: [ :el | el proportion: 1; expand ].
	self add: item.
	^ item
]

{ #category : #adding }
CyTkMenu >> addMenuItem: label action: aBlock [
	^ (self addMenuItem: label)
		on: CyTkActionEvent do: aBlock;
		yourself
]

{ #category : #adding }
CyTkMenu >> addMenuItem: label menu: aMenu [
	^ (self addMenuItem: label)
		submenu: aMenu
]

{ #category : #adding }
CyTkMenu >> addMenuItem: label menuWith: aBlock [
	| menu |
	menu := CyTkMenu new parentMenu: self.
	aBlock value: menu.
	^ self addMenuItem: label menu: menu
]

{ #category : #adding }
CyTkMenu >> addMenuSeparator [
	| separator |
	separator := CyTkMenuSeparator new
		yourself.
	self sizer element: separator do: [ :el | el expand ].
	self add: separator.
	^ separator
]

{ #category : #drawing }
CyTkMenu >> buildMeshContentOn: meshBuilder [
	self theme buildMenu: self meshOn: meshBuilder.
]

{ #category : #'menu item connection' }
CyTkMenu >> deactivateCompleteMenu [
	parentMenu ifNil: [ self popUpKill ] ifNotNil: [ parentMenu deactivateCompleteMenu ]
]

{ #category : #accessing }
CyTkMenu >> highlightedMenuItem [
	^ highlightedMenuItem
]

{ #category : #accessing }
CyTkMenu >> highlightedMenuItem: anObject [
	highlightedMenuItem == anObject ifTrue: [ ^ self ].
	
	highlightedMenuItem ifNotNil: [ highlightedMenuItem selected: false ].
	highlightedMenuItem := anObject.
	highlightedMenuItem ifNotNil: [ highlightedMenuItem selected: true ].
]

{ #category : #initialization }
CyTkMenu >> initialize [
	super initialize.
	highlightedMenuItem := nil.
	parentMenu := nil.
	self
		sizer: CyTkVerticalBoxSizer new
]

{ #category : #accessing }
CyTkMenu >> isActiveMenu [
	^ true
]

{ #category : #actions }
CyTkMenu >> kill [
]

{ #category : #'menu item connection' }
CyTkMenu >> menuItemClicked: aMenuItem [
	aMenuItem submenu ifNotNil: [ ^ self ].
	aMenuItem fireActionEvent.
	self deactivateCompleteMenu

]

{ #category : #accessing }
CyTkMenu >> parentMenu [
	^ parentMenu
]

{ #category : #accessing }
CyTkMenu >> parentMenu: anObject [
	parentMenu := anObject
]

{ #category : #popup }
CyTkMenu >> popUpKill [
	self highlightedMenuItem: nil.
	super popUpKill
]

{ #category : #popup }
CyTkMenu >> prepareToPopUpIn: aHostWindow [
	self fit
]

{ #category : #actions }
CyTkMenu >> spawnIn: window at: aPosition [
]
