"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestBabylonGraphicsSoftRendering,
	#superclass : #PackageManifest,
	#category : #'BabylonGraphics-SoftRendering-Manifest'
}

{ #category : #'code-critics' }
ManifestBabylonGraphicsSoftRendering class >> ruleRBLongMethodsRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#BabylonSoftRenderingSurface #shadeCCWTriangleV1:v2:v3:with: #false)) #'2018-09-23T14:02:34.523063-03:00') )
]

{ #category : #'code-critics' }
ManifestBabylonGraphicsSoftRendering class >> ruleRBToDoWithIncrementRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#BabylonSoftRenderingSurface #shadeCCWTriangleV1:v2:v3:with: #false)) #'2018-09-23T14:02:38.724716-03:00') )
]
