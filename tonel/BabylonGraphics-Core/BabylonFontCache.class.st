"
I am used for caching font glyphs in texture atlases.
"
Class {
	#name : #BabylonFontCache,
	#superclass : #BabylonMaterial,
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
	#category : #'BabylonGraphics-Core-Font'
}

{ #category : #'instance creation' }
BabylonFontCache class >> for: font [
	^ self new font: font
]

{ #category : #initialization }
BabylonFontCache class >> initialize [
	FontTextureWidth := 2048
]

{ #category : #initialization }
BabylonFontCache >> activateMaterialIn: aSurface [
	^ aSurface activateFontMaterial: self
]

{ #category : #accessing }
BabylonFontCache >> ascent [
	^ font ascent
]

{ #category : #accessing }
BabylonFontCache >> bits [
	^ bits
]

{ #category : #accessing }
BabylonFontCache >> character: aCharacter [
	^ self codePoint: aCharacter codePoint
]

{ #category : #accessing }
BabylonFontCache >> codePoint: codePoint [
	"Treat Latin 1 in a special for performance reasons. There are the most used characters, so it make
	sense to always load them."
	codePoint < 32 ifTrue: [ ^ self codePoint: 32].
	(codePoint < 256 and: [hasLatin1 not ]) ifTrue: [ self ensureLatin1 ].
	
	^ codePointMap at: codePoint ifAbsentPut: [ self createCodePointEntry: codePoint ]
]

{ #category : #private }
BabylonFontCache >> createCodePointEntry: codePoint [
	^ self createGlyphFormEntry: (font characterFormAt: (Character codePoint: codePoint))
]

{ #category : #private }
BabylonFontCache >> createGlyphFormEntry: glyphForm [
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
	
	^ BabylonFontCacheEntry new
		position: position;
		extent: glyphForm extent;
		advance: glyphForm advance;
		linearAdvance: glyphForm linearAdvance;
		offset: glyphForm offset;
		yourself
]

{ #category : #accessing }
BabylonFontCache >> descent [
	^ font descent
]

{ #category : #'instance creation' }
BabylonFontCache >> ensureLatin1 [
	hasLatin1 := true.
	32 to: 255 do: [ :codePoint | self codePoint: codePoint ].
	
]

{ #category : #private }
BabylonFontCache >> ensureSpaceForWidth: nextWidth height: nextHeight [
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
BabylonFontCache >> extent [
	^ FontTextureWidth @ height
]

{ #category : #accessing }
BabylonFontCache >> font [
	^ font
]

{ #category : #accessing }
BabylonFontCache >> font: anObject [
	font := anObject
]

{ #category : #accessing }
BabylonFontCache >> form [
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
BabylonFontCache >> getPreciseAscent [
	^ font getPreciseAscent
]

{ #category : #measuring }
BabylonFontCache >> getPreciseDescent [
	^ font getPreciseDescent
]

{ #category : #private }
BabylonFontCache >> hasFixedSize [
	^ false
]

{ #category : #accessing }
BabylonFontCache >> height [
	^ height
]

{ #category : #private }
BabylonFontCache >> increaseHeighTo: newHeight [
	| newBits |
	newBits := ByteArray new: newHeight * FontTextureWidth.
	bits ifNotNil: [ LibC memCopy: bits to: newBits size: bits size ].
	bits := newBits.
	height := newHeight.
]

{ #category : #private }
BabylonFontCache >> initialHeight [
	^ self hasFixedSize ifTrue: [ 128"FontTextureWidth" ] ifFalse: [ 0 ]
]

{ #category : #initialization }
BabylonFontCache >> initialize [
	height := self initialHeight.
	destinationX := 1.
	destinationY := 1.
	codePointMap := Dictionary new.
	maxCurrentHeight := 0.
	hasLatin1 := false.
]

{ #category : #accessing }
BabylonFontCache >> lineHeight [
	^ font height
]

{ #category : #private }
BabylonFontCache >> modified [
	"Hook for notifying a change in the font cache."
]

{ #category : #accessing }
BabylonFontCache >> width [
	^ FontTextureWidth
]

{ #category : #measuring }
BabylonFontCache >> widthOfString: aString from: firstIndex to: lastIndex [
	^ font widthOfString: aString from: firstIndex to: lastIndex
]
