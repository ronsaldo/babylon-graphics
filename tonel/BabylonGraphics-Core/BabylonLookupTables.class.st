Class {
	#name : #BabylonLookupTables,
	#superclass : #SharedPool,
	#classVars : [
		'LinearDecodeTable',
		'SRGBDecodeTable',
		'SRGBEncodeTable'
	],
	#category : #'BabylonGraphics-Core-Color'
}

{ #category : #'class initialization' }
BabylonLookupTables class >> computeLookupTables [
	SRGBDecodeTable := (1 to: 256) collect: [ :i |
		((i-1) / 255.0) babylonSRGBToLinear
	].

	LinearDecodeTable := (1 to: 256) collect: [ :i |
		(i-1) / 255.0
	].

	SRGBEncodeTable := (1 to: 4096) collect: [ :i |
		((i-1)/4095.0) babylonLinearToSRGB babylonEncodeColorChannel
	].
]

{ #category : #'class initialization' }
BabylonLookupTables class >> initialize [
	self computeLookupTables
]
