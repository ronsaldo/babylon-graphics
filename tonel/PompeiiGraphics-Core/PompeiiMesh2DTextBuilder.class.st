"
I am used for drawing text using a textured font
"
Class {
	#name : #PompeiiMesh2DTextBuilder,
	#superclass : #PompeiiMesh2DPartBuilder,
	#instVars : [
		'font',
		'destPosition',
		'rowStartPosition',
		'preciseAscent',
		'preciseDescent',
		'columnIndex'
	],
	#classVars : [
		'ZeroPoint'
	],
	#category : #'PompeiiGraphics-Core-Shape'
}

{ #category : #initialization }
PompeiiMesh2DTextBuilder class >> initialize [
	ZeroPoint := 0@0.
]

{ #category : #drawing }
PompeiiMesh2DTextBuilder >> draw: aString [
	self drawCharacters: aString from: 1 to: aString size
]

{ #category : #alignment }
PompeiiMesh2DTextBuilder >> draw: aText onRectangleCenter: aRectangle [
	self drawCharacters: aText from: 1 to: aText size onRectangleCenter: aRectangle
]

{ #category : #alignment }
PompeiiMesh2DTextBuilder >> draw: aText onRectangleCenterLeft: aRectangle [
	self drawCharacters: aText from: 1 to: aText size onRectangleCenterLeft: aRectangle
]

{ #category : #alignment }
PompeiiMesh2DTextBuilder >> draw: aText onRectangleCenterRight: aRectangle [
	self drawCharacters: aText from: 1 to: aText size onRectangleCenterRight: aRectangle
]

{ #category : #drawing }
PompeiiMesh2DTextBuilder >> drawCharacter: aCharacter [
	| glyphInfo extent position offset |
	(String crlf includes: aCharacter) ifTrue: [ ^ self newline ].
	aCharacter = Character tab ifTrue: [ ^ self tab ].
	aCharacter = Character space ifTrue: [ ^ self space ].

	builder beginTriangles: font.
	
	glyphInfo := font character: aCharacter.
	extent := glyphInfo extent.
	position := glyphInfo position.
	offset := glyphInfo offset.
	
	builder 
		addVertex: (evaluator computeVertex: destPosition + offset texcoord: position);
		addVertex: (evaluator computeVertex: destPosition + offset + (extent x @ 0) texcoord: position + (extent x @ 0));
		addVertex: (evaluator computeVertex: destPosition + offset + extent texcoord: position + extent);
		addVertex: (evaluator computeVertex: destPosition + offset + (0@extent y) texcoord: position + (0@extent y));
		
		addIndex: 0; addIndex: 1; addIndex: 2;
		addIndex: 2; addIndex: 3; addIndex: 0.
		
	destPosition := destPosition + (glyphInfo advance x @ 0).
	columnIndex := columnIndex + 1
	
]

{ #category : #drawing }
PompeiiMesh2DTextBuilder >> drawCharacters: aString from: start to: end [
	start to: end do: [ :index | self drawCharacter: (aString at: index) ]
]

{ #category : #drawing }
PompeiiMesh2DTextBuilder >> drawCharacters: aString from: start to: end onRectangleCenter: aRectangle [
	| stringWidth rectangleWidth deltaX deltaY |
	stringWidth := font widthOfString: aString from: start to: end.
	rectangleWidth := aRectangle width.
	deltaX := (rectangleWidth - stringWidth) / 2 max: 0.
	deltaY := ((aRectangle height - self fontHeight)  / 2 max: 0) + self preciseAscent.
	self
		position: aRectangle origin + (deltaX asInteger @  deltaY asInteger);
		drawCharacters: aString from: start to: end
]

{ #category : #drawing }
PompeiiMesh2DTextBuilder >> drawCharacters: aString from: start to: end onRectangleCenterLeft: aRectangle [
	| deltaY |
	deltaY := ((aRectangle height - self fontHeight)  / 2 max: 0) + self preciseAscent.
	self
		position: aRectangle origin + (0 @  deltaY asInteger);
		drawCharacters: aString from: start to: end
]

{ #category : #accessing }
PompeiiMesh2DTextBuilder >> font [
	^ font
]

{ #category : #accessing }
PompeiiMesh2DTextBuilder >> font: aFont [
	font := aFont forPompeiiDriver: builder driver.
	preciseAscent := nil.
	preciseDescent := nil.
]

{ #category : #drawing }
PompeiiMesh2DTextBuilder >> fontHeight [
	^ self preciseAscent + self preciseDescent
]

{ #category : #initialization }
PompeiiMesh2DTextBuilder >> initialize [
	super initialize.
	self position: ZeroPoint.
]

{ #category : #drawing }
PompeiiMesh2DTextBuilder >> newline [
	rowStartPosition := rowStartPosition + (0@ font lineHeight).
	destPosition := rowStartPosition.
	columnIndex := 0
]

{ #category : #accessing }
PompeiiMesh2DTextBuilder >> position [
	^ destPosition
]

{ #category : #accessing }
PompeiiMesh2DTextBuilder >> position: aPosition [
	destPosition := aPosition.
	rowStartPosition := destPosition.
	columnIndex := 0.
]

{ #category : #accessing }
PompeiiMesh2DTextBuilder >> preciseAscent [
	^ preciseAscent ifNil: [ preciseAscent := font getPreciseAscent ]
]

{ #category : #accessing }
PompeiiMesh2DTextBuilder >> preciseDescent [
	^ preciseDescent ifNil: [ preciseDescent := font getPreciseDescent ]
]

{ #category : #drawing }
PompeiiMesh2DTextBuilder >> space [
	destPosition := destPosition + (self spaceWidth@0).
	columnIndex := columnIndex + 1
]

{ #category : #drawing }
PompeiiMesh2DTextBuilder >> spaceWidth [
	^ (font character: Character space) advance x
]

{ #category : #drawing }
PompeiiMesh2DTextBuilder >> tab [
	| newColumnIndex spaceCount |
	newColumnIndex := columnIndex + 3 alignedTo: 4.
	spaceCount := newColumnIndex - columnIndex.
	columnIndex := newColumnIndex.

	destPosition := destPosition + ((self spaceWidth*spaceCount)@0)
]
