"
I am used for caching font glyphs in texture atlases.
"
Class {
	#name : #PompeiiFontCache,
	#superclass : #PompeiiMaterial,
	#instVars : [
		'font',
		'bits',
		'height',
		'destinationY',
		'destinationX',
		'maxCurrentHeight',
		'codePointMap',
		'form',
		'hasLatin1'
	],
	#classVars : [
		'FontTextureWidth'
	],
	#category : #'PompeiiGraphics-Core-Font'
}

{ #category : #'instance creation' }
PompeiiFontCache class >> for: font [
	^ self new font: font
]

{ #category : #initialization }
PompeiiFontCache class >> initialize [
	FontTextureWidth := 2048
]

{ #category : #initialization }
PompeiiFontCache >> activateMaterialIn: aSurface [
	^ aSurface activateFontMaterial: self
]

{ #category : #accessing }
PompeiiFontCache >> ascent [
	^ font ascent
]

{ #category : #accessing }
PompeiiFontCache >> bits [
	^ bits
]

{ #category : #accessing }
PompeiiFontCache >> character: aCharacter [
	^ self codePoint: aCharacter codePoint
]

{ #category : #accessing }
PompeiiFontCache >> codePoint: codePoint [
	"Treat Latin 1 in a special for performance reasons. There are the most used characters, so it make
	sense to always load them."
	codePoint < 32 ifTrue: [ ^ self codePoint: 32].
	(codePoint < 256 and: [hasLatin1 not ]) ifTrue: [ self ensureLatin1 ].
	
	^ codePointMap at: codePoint ifAbsentPut: [ self createCodePointEntry: codePoint ]
]

{ #category : #private }
PompeiiFontCache >> createCodePointEntry: codePoint [
	^ self createGlyphFormEntry: (font characterFormAt: (Character codePoint: codePoint))
]

{ #category : #private }
PompeiiFontCache >> createGlyphFormEntry: glyphForm [
	| sourceWidth sourceHeight sourceX sourceY value position |
	self ensureSpaceForWidth: glyphForm width height: glyphForm height.
	
	sourceWidth := glyphForm width.
	sourceHeight := glyphForm height.
	glyphForm bits doWithIndex: [ :pixel :index |
		sourceX := (index - 1) % sourceWidth.
		sourceY := (index - 1) // sourceWidth.
		value := ((pixel>>24) bitAnd: 255).
		
		bits at: (destinationY + sourceY) * FontTextureWidth + destinationX + sourceX + 1 put: value
	].

	position := destinationX @destinationY.
	destinationX := destinationX + glyphForm width + 1.
	
	self modified.
	
	^ PompeiiFontCacheEntry new
		position: position;
		extent: glyphForm extent;
		advance: glyphForm advance;
		linearAdvance: glyphForm linearAdvance;
		offset: glyphForm offset;
		yourself
]

{ #category : #accessing }
PompeiiFontCache >> descent [
	^ font descent
]

{ #category : #'instance creation' }
PompeiiFontCache >> ensureLatin1 [
	hasLatin1 := true.
	32 to: 255 do: [ :codePoint | self codePoint: codePoint ].
	
]

{ #category : #private }
PompeiiFontCache >> ensureSpaceForWidth: nextWidth height: nextHeight [
	destinationX + nextWidth + 1 > FontTextureWidth ifTrue: [
		destinationX := 1.
		destinationY := destinationY + maxCurrentHeight + 1.
		maxCurrentHeight := 0.
	].

	maxCurrentHeight := maxCurrentHeight max: nextHeight.
	destinationY + maxCurrentHeight + 1 > height ifTrue: [
		self increaseHeighTo: (destinationY + maxCurrentHeight + 1) asLargerPowerOfTwo
	].

	bits ifNil: [ 
		"Fixed size case"
		bits := ByteArray new: height * FontTextureWidth
	].
	form := nil.
]

{ #category : #accessing }
PompeiiFontCache >> extent [
	^ FontTextureWidth @ height
]

{ #category : #accessing }
PompeiiFontCache >> font [
	^ font
]

{ #category : #accessing }
PompeiiFontCache >> font: anObject [
	font := anObject
]

{ #category : #accessing }
PompeiiFontCache >> form [
	| grays |
	form ifNil: [
		self ensureLatin1.
		grays := (0 to: 255) collect: [:brightness | Color gray: brightness asFloat / 255.0].
		form := ColorForm extent: self extent depth: -8.
		form colors: grays.
		form unhibernate.
		bits ifNotNil: [ 
			LibC memCopy: bits to: form bits size: bits size.
		]
	].
	^ form
]

{ #category : #measuring }
PompeiiFontCache >> getPreciseAscent [
	^ font getPreciseAscent
]

{ #category : #measuring }
PompeiiFontCache >> getPreciseDescent [
	^ font getPreciseDescent
]

{ #category : #private }
PompeiiFontCache >> hasFixedSize [
	^ false
]

{ #category : #accessing }
PompeiiFontCache >> height [
	^ height
]

{ #category : #private }
PompeiiFontCache >> increaseHeighTo: newHeight [
	| newBits |
	self error: 'Cannot increase font size'.
	newBits := ByteArray new: newHeight * FontTextureWidth.
	bits ifNotNil: [ LibC memCopy: bits to: newBits size: bits size ].
	bits := newBits.
	height := newHeight.
]

{ #category : #private }
PompeiiFontCache >> initialHeight [
	^ self hasFixedSize ifTrue: [ 128"FontTextureWidth" ] ifFalse: [ 0 ]
]

{ #category : #initialization }
PompeiiFontCache >> initialize [
	height := self initialHeight.
	destinationX := 1.
	destinationY := 1.
	codePointMap := Dictionary new.
	maxCurrentHeight := 0.
	hasLatin1 := false.
]

{ #category : #accessing }
PompeiiFontCache >> lineHeight [
	^ font height
]

{ #category : #private }
PompeiiFontCache >> modified [
	"Hook for notifying a change in the font cache."
]

{ #category : #accessing }
PompeiiFontCache >> width [
	^ FontTextureWidth
]

{ #category : #measuring }
PompeiiFontCache >> widthOfString: aString from: firstIndex to: lastIndex [
	^ font widthOfString: aString from: firstIndex to: lastIndex
]
