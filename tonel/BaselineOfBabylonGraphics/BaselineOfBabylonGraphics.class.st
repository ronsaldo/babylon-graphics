Class {
	#name : #BaselineOfBabylonGraphics,
	#superclass : #BaselineOf,
	#category : #BaselineOfBabylonGraphics
}

{ #category : #baselines }
BaselineOfBabylonGraphics >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec project: #'UFFIOpenGL' with: [
				spec
					className: #ConfigurationOfUFFIOpenGL;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/ronsaldo/UFFIOpenGL/main/' ].
		spec 
			package: #'BabylonGraphics-Athens' with: [
				spec requires: #(#'BabylonGraphics-Core' ). ];
			package: #'BabylonGraphics-Core';
			package: #'BabylonGraphics-Examples' with: [
				spec requires: #(#'BabylonGraphics-Core' ). ];
			package: #'BabylonGraphics-OpenGL' with: [
				spec requires: #(#'BabylonGraphics-Core' #'UFFIOpenGL' ). ];
			package: #'BabylonGraphics-Tests' with: [
				spec requires: #('BabylonGraphics-Core' ). ].
		spec group: #'default' with: #(#'BabylonGraphics-Core' #'BabylonGraphics-Examples' #'BabylonGraphics-OpenGL' #'BabylonGraphics-Tests').
		spec group: #'API' with: #(#'BabylonGraphics-Core' #'BabylonGraphics-Examples' #'BabylonGraphics-Tests')
		].
		

]
