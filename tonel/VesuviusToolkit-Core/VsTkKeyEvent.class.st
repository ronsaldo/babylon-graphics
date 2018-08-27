Class {
	#name : #VsTkKeyEvent,
	#superclass : #VsTkEvent,
	#instVars : [
		'symbol',
		'scanCode',
		'repeat',
		'modifiers'
	],
	#category : #'VesuviusToolkit-Core-Event'
}

{ #category : #accessing }
VsTkKeyEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
VsTkKeyEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
VsTkKeyEvent >> repeat [
	^ repeat
]

{ #category : #accessing }
VsTkKeyEvent >> repeat: anObject [
	repeat := anObject
]

{ #category : #accessing }
VsTkKeyEvent >> scanCode [
	^ scanCode
]

{ #category : #accessing }
VsTkKeyEvent >> scanCode: anObject [
	scanCode := anObject
]

{ #category : #accessing }
VsTkKeyEvent >> symbol [
	^ symbol
]

{ #category : #accessing }
VsTkKeyEvent >> symbol: anObject [
	symbol := anObject
]
