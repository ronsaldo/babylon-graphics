Class {
	#name : #BaselineOfPompeii,
	#superclass : #BaselineOf,
	#category : #BaselineOfPompeii
}

{ #category : #baselines }
BaselineOfPompeii >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec project: #'UFFIOpenGL' with: [
				spec
					className: #ConfigurationOfUFFIOpenGL;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/ronsaldo/UFFIOpenGL/main/' ].
		spec 
			package: #'PompeiiGraphics-Athens' with: [
				spec requires: #(#'PompeiiGraphics-Core' ). ];
			package: #'PompeiiGraphics-Core';
			package: #'PompeiiGraphics-Examples' with: [
				spec requires: #(#'PompeiiGraphics-Core' ). ];
			package: #'PompeiiGraphics-OpenGL' with: [
				spec requires: #(#'PompeiiGraphics-Core' #'UFFIOpenGL' ). ];
			package: #'PompeiiGraphics-Tests' with: [
				spec requires: #('PompeiiGraphics-Core' ). ].
		spec group: #'default' with: #(#'PompeiiGraphics-Core' #'PompeiiGraphics-Examples' #'PompeiiGraphics-OpenGL' #'PompeiiGraphics-Tests').
		spec group: #'API' with: #(#'PompeiiGraphics-Core' #'PompeiiGraphics-Examples' #'PompeiiGraphics-Tests')
		].
		

]
