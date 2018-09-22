"
I describe a glyph in a font atlas.
"
Class {
	#name : #BabylonFontCacheEntry,
	#superclass : #Object,
	#instVars : [
		'position',
		'extent',
		'advance',
		'linearAdvance',
		'offset'
	],
	#category : #'BabylonGraphics-Core-Font'
}

{ #category : #accessing }
BabylonFontCacheEntry >> advance [
	^ advance
]

{ #category : #accessing }
BabylonFontCacheEntry >> advance: anObject [
	advance := anObject
]

{ #category : #accessing }
BabylonFontCacheEntry >> extent [
	^ extent
]

{ #category : #accessing }
BabylonFontCacheEntry >> extent: anObject [
	extent := anObject
]

{ #category : #accessing }
BabylonFontCacheEntry >> linearAdvance [
	^ linearAdvance
]

{ #category : #accessing }
BabylonFontCacheEntry >> linearAdvance: anObject [
	linearAdvance := anObject
]

{ #category : #accessing }
BabylonFontCacheEntry >> offset [
	^ offset
]

{ #category : #accessing }
BabylonFontCacheEntry >> offset: anObject [
	offset := anObject
]

{ #category : #accessing }
BabylonFontCacheEntry >> position [
	^ position
]

{ #category : #accessing }
BabylonFontCacheEntry >> position: anObject [
	position := anObject
]
