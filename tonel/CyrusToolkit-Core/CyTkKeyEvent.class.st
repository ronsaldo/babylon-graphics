Class {
	#name : #CyTkKeyEvent,
	#superclass : #CyTkEvent,
	#instVars : [
		'symbol',
		'scanCode',
		'repeat',
		'modifiers'
	],
	#category : #'CyrusToolkit-Core-Event'
}

{ #category : #accessing }
CyTkKeyEvent >> modifiers [
	^ modifiers
]

{ #category : #accessing }
CyTkKeyEvent >> modifiers: anObject [
	modifiers := anObject
]

{ #category : #accessing }
CyTkKeyEvent >> repeat [
	^ repeat
]

{ #category : #accessing }
CyTkKeyEvent >> repeat: anObject [
	repeat := anObject
]

{ #category : #accessing }
CyTkKeyEvent >> scanCode [
	^ scanCode
]

{ #category : #accessing }
CyTkKeyEvent >> scanCode: anObject [
	scanCode := anObject
]

{ #category : #accessing }
CyTkKeyEvent >> symbol [
	^ symbol
]

{ #category : #accessing }
CyTkKeyEvent >> symbol: anObject [
	symbol := anObject
]
