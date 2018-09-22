Class {
	#name : #PompeiiLinearColor,
	#superclass : #Object,
	#instVars : [
		'r',
		'g',
		'b',
		'a'
	],
	#classVars : [
		'LinearDecodeTable',
		'SRGBDecodeTable',
		'SRGBEncodeTable'
	],
	#category : #'PompeiiGraphics-Core-Color'
}

{ #category : #'class initialization' }
PompeiiLinearColor class >> computeLookupTables [
	SRGBDecodeTable := (1 to: 256) collect: [ :i |
		((i-1) / 255.0) pompeiiSRGBToLinear
	].

	LinearDecodeTable := (1 to: 256) collect: [ :i |
		(i-1) / 255.0
	].

	SRGBEncodeTable := (1 to: 4096) collect: [ :i |
		((i-1)/4095.0) pompeiiLinearToSRGB pompeiiEncodeColorChannel
	].
]

{ #category : #'class initialization' }
PompeiiLinearColor class >> decodeLinearChannel: value [
	^ SRGBDecodeTable at: value + 1.
]

{ #category : #'class initialization' }
PompeiiLinearColor class >> decodeSRGBChannel: value [
	^ SRGBDecodeTable at: value + 1.
]

{ #category : #'class initialization' }
PompeiiLinearColor class >> encodeSRGBChannel: value [
	value >= 1.0 ifTrue: [ ^ 255 ].
	value <= 0.0 ifTrue: [ ^ 0 ].
	
	^ SRGBEncodeTable at: (value*4095.0 + 0.5) asInteger + 1.
]

{ #category : #'class initialization' }
PompeiiLinearColor class >> initialize [
	self computeLookupTables
]

{ #category : #'as yet unclassified' }
PompeiiLinearColor class >> r: r g: g b: b a: a [
	^ self new
		r: r;
		g: g;
		b: b;
		a: a;
		yourself
]

{ #category : #arithmetic }
PompeiiLinearColor >> * other [
	| otherColor |
	otherColor := other asPompeiiLinearColor.
	^ self class r: r*otherColor r g: g*otherColor g b: b*otherColor b a: a*otherColor a
]

{ #category : #arithmetic }
PompeiiLinearColor >> + other [
	^ self class r: r+other r g: g+other g b: b+other b a: a+other a
]

{ #category : #arithmetic }
PompeiiLinearColor >> / other [
	^ self class r: r/other r g: g/other g b: b/other b a: a/other a
]

{ #category : #accessing }
PompeiiLinearColor >> a [
	^ a
]

{ #category : #accessing }
PompeiiLinearColor >> a: anObject [
	a := anObject
]

{ #category : #converting }
PompeiiLinearColor >> asBGRA32 [
	| er eg eb ea |
	er := self encodeSRGBChannel: r.
	eg := self encodeSRGBChannel: g.
	eb := self encodeSRGBChannel: b.
	ea := self encodeLinearChannel: a.
	
	^ eb | (eg << 8) | (er << 16) | (ea << 24)
]

{ #category : #converting }
PompeiiLinearColor >> asColor [
	^ Color r: r pompeiiLinearToSRGB g: g pompeiiLinearToSRGB b: b pompeiiLinearToSRGB alpha: a
]

{ #category : #converting }
PompeiiLinearColor >> asPompeiiLinearColor [
	^ self
]

{ #category : #accessing }
PompeiiLinearColor >> b [
	^ b
]

{ #category : #accessing }
PompeiiLinearColor >> b: anObject [
	b := anObject
]

{ #category : #converting }
PompeiiLinearColor >> encodeLinearChannel: value [
	value >= 1.0 ifTrue: [ ^ 255 ].
	value <= 0.0 ifTrue: [ ^ 0 ].
	
	^ (value*255.0 + 0.5) asInteger
]

{ #category : #converting }
PompeiiLinearColor >> encodeSRGBChannel: value [
	value >= 1.0 ifTrue: [ ^ 255 ].
	value <= 0.0 ifTrue: [ ^ 0 ].
	
	^ SRGBEncodeTable at: (value*4095.0 + 0.5) asInteger + 1.
]

{ #category : #accessing }
PompeiiLinearColor >> g [
	^ g
]

{ #category : #accessing }
PompeiiLinearColor >> g: anObject [
	g := anObject
]

{ #category : #accessing }
PompeiiLinearColor >> iconOrThumbnailOfSize: aNumberOrPoint [ 
	^ self asColor iconOrThumbnailOfSize: aNumberOrPoint 
]

{ #category : #accessing }
PompeiiLinearColor >> r [
	^ r
]

{ #category : #accessing }
PompeiiLinearColor >> r: anObject [
	r := anObject
]

{ #category : #accessing }
PompeiiLinearColor >> r: newR g: newG b: newB a: newA [
	r := newR.
	g := newG.
	b := newB.
	a := newA.
	
]
