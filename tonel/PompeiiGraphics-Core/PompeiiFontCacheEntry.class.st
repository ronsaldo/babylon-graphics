"
I describe a glyph in a font atlas.
"
Class {
	#name : #PompeiiFontCacheEntry,
	#superclass : #Object,
	#instVars : [
		'position',
		'extent',
		'advance',
		'linearAdvance',
		'offset'
	],
	#category : #'PompeiiGraphics-Core-Font'
}

{ #category : #accessing }
PompeiiFontCacheEntry >> advance [
	^ advance
]

{ #category : #accessing }
PompeiiFontCacheEntry >> advance: anObject [
	advance := anObject
]

{ #category : #accessing }
PompeiiFontCacheEntry >> extent [
	^ extent
]

{ #category : #accessing }
PompeiiFontCacheEntry >> extent: anObject [
	extent := anObject
]

{ #category : #accessing }
PompeiiFontCacheEntry >> linearAdvance [
	^ linearAdvance
]

{ #category : #accessing }
PompeiiFontCacheEntry >> linearAdvance: anObject [
	linearAdvance := anObject
]

{ #category : #accessing }
PompeiiFontCacheEntry >> offset [
	^ offset
]

{ #category : #accessing }
PompeiiFontCacheEntry >> offset: anObject [
	offset := anObject
]

{ #category : #accessing }
PompeiiFontCacheEntry >> position [
	^ position
]

{ #category : #accessing }
PompeiiFontCacheEntry >> position: anObject [
	position := anObject
]
