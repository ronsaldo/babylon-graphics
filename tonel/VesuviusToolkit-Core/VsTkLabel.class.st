Class {
	#name : #VsTkLabel,
	#superclass : #VsTkMeshWidget,
	#instVars : [
		'text'
	],
	#category : #'VesuviusToolkit-Core-Widget'
}

{ #category : #drawing }
VsTkLabel >> buildMeshContentOn: meshBuilder [
	self theme buildLabel: self meshOn: meshBuilder.
]

{ #category : #initialization }
VsTkLabel >> initialize [
	super initialize.
	text := ''.
]

{ #category : #accessing }
VsTkLabel >> minimalExtent [
	^ self theme computeLabelMinimalExtent: self
]

{ #category : #accessing }
VsTkLabel >> text [
	^ text
]

{ #category : #accessing }
VsTkLabel >> text: aString [
	text := aString.
	self changed.
]
