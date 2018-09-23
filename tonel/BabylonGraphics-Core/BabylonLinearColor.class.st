Class {
	#name : #BabylonLinearColor,
	#superclass : #Object,
	#instVars : [
		'r',
		'g',
		'b',
		'a'
	],
	#pools : [
		'BabylonLookupTables'
	],
	#category : #'BabylonGraphics-Core-Color'
}

{ #category : #'as yet unclassified' }
BabylonLinearColor class >> decodeBGRA: pixelValue [
	^ self new decodeBGRA: pixelValue
]

{ #category : #'class initialization' }
BabylonLinearColor class >> decodeLinearChannel: value [
	^ LinearDecodeTable at: value + 1.
]

{ #category : #'class initialization' }
BabylonLinearColor class >> decodeSRGBChannel: value [
	^ SRGBDecodeTable at: value + 1.
]

{ #category : #'class initialization' }
BabylonLinearColor class >> encodeSRGBChannel: value [
	value >= 1.0 ifTrue: [ ^ 255 ].
	value <= 0.0 ifTrue: [ ^ 0 ].
	
	^ SRGBEncodeTable at: (value*4095.0 + 0.5) asInteger + 1.
]

{ #category : #'as yet unclassified' }
BabylonLinearColor class >> r: r g: g b: b a: a [
	^ self new
		r: r;
		g: g;
		b: b;
		a: a;
		yourself
]

{ #category : #arithmetic }
BabylonLinearColor >> * other [
	| otherColor |
	otherColor := other asBabylonLinearColor.
	^ self class r: r*otherColor r g: g*otherColor g b: b*otherColor b a: a*otherColor a
]

{ #category : #arithmetic }
BabylonLinearColor >> + other [
	^ self class r: r+other r g: g+other g b: b+other b a: a+other a
]

{ #category : #arithmetic }
BabylonLinearColor >> / other [
	^ self class r: r/other r g: g/other g b: b/other b a: a/other a
]

{ #category : #accessing }
BabylonLinearColor >> a [
	^ a
]

{ #category : #accessing }
BabylonLinearColor >> a: anObject [
	a := anObject
]

{ #category : #converting }
BabylonLinearColor >> asBGRA32 [
	| er eg eb ea |
	er := self encodeSRGBChannel: r.
	eg := self encodeSRGBChannel: g.
	eb := self encodeSRGBChannel: b.
	ea := self encodeLinearChannel: a.
	
	^ eb | (eg << 8) | (er << 16) | (ea << 24)
]

{ #category : #converting }
BabylonLinearColor >> asBabylonLinearColor [
	^ self
]

{ #category : #converting }
BabylonLinearColor >> asColor [
	^ Color r: r babylonLinearToSRGB g: g babylonLinearToSRGB b: b babylonLinearToSRGB alpha: a
]

{ #category : #converting }
BabylonLinearColor >> asPremultipliedBGRA32 [
	| er eg eb ea |
	er := self encodeSRGBChannel: a*r.
	eg := self encodeSRGBChannel: a*g.
	eb := self encodeSRGBChannel: a*b.
	ea := self encodeLinearChannel: a.
	
	^ eb | (eg << 8) | (er << 16) | (ea << 24)
]

{ #category : #accessing }
BabylonLinearColor >> b [
	^ b
]

{ #category : #accessing }
BabylonLinearColor >> b: anObject [
	b := anObject
]

{ #category : #converting }
BabylonLinearColor >> decodeBGRA: pixelValue [
	b := SRGBDecodeTable at: (pixelValue & 16rff) + 1.
	g := SRGBDecodeTable at: (pixelValue >> 8) & 16rff + 1.
	r := SRGBDecodeTable at: (pixelValue >> 16) & 16rff + 1.
	a := LinearDecodeTable at: (pixelValue >> 24) & 16rff + 1.
]

{ #category : #converting }
BabylonLinearColor >> encodeLinearChannel: value [
	value >= 1.0 ifTrue: [ ^ 255 ].
	value <= 0.0 ifTrue: [ ^ 0 ].
	
	^ (value*255.0 + 0.5) asInteger
]

{ #category : #converting }
BabylonLinearColor >> encodeSRGBChannel: value [
	value >= 1.0 ifTrue: [ ^ 255 ].
	value <= 0.0 ifTrue: [ ^ 0 ].
	
	^ SRGBEncodeTable at: (value*4095.0 + 0.5) asInteger + 1.
]

{ #category : #accessing }
BabylonLinearColor >> g [
	^ g
]

{ #category : #accessing }
BabylonLinearColor >> g: anObject [
	g := anObject
]

{ #category : #accessing }
BabylonLinearColor >> iconOrThumbnailOfSize: aNumberOrPoint [ 
	^ self asColor iconOrThumbnailOfSize: aNumberOrPoint 
]

{ #category : #accessing }
BabylonLinearColor >> r [
	^ r
]

{ #category : #accessing }
BabylonLinearColor >> r: anObject [
	r := anObject
]

{ #category : #accessing }
BabylonLinearColor >> r: newR g: newG b: newB a: newA [
	r := newR.
	g := newG.
	b := newB.
	a := newA.
	
]
