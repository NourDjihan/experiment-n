"
I am a logger that uses the DSSpy framework to log elements from PhexExperiments.
"
Class {
	#name : #ExperimentLoggerDSSpy,
	#superclass : #AbstractExperimentLogger,
	#instVars : [
		'experiment'
	],
	#category : #'Experiments-ExpN'
}

{ #category : #'instance creation' }
ExperimentLoggerDSSpy class >> on: anExperiment [

	^ self basicNew
		  experiment: anExperiment;
		  initialize;
		  yourself
]

{ #category : #logging }
ExperimentLoggerDSSpy >> authorizeDataSending [
	"DSSpy logger authorizeDataSending "
]

{ #category : #logging }
ExperimentLoggerDSSpy >> dsSpyClass [

	"Why like this? DDSpy is installed whe the experiment starts. When developing the experiment (without starting the experiment), the class is not loaded. This prevent some warnings."
	
	"Can be probalby properly fixed by adding DSSpy as a dependency of the baseline"

	^ self class environment at: #DSSpy ifAbsent: [ nil ]
]

{ #category : #logging }
ExperimentLoggerDSSpy >> dsSpyInstrumenterClass [

	^ self class environment at: #DSSpyInstrumenter
]

{ #category : #accessing }
ExperimentLoggerDSSpy >> experiment: anObject [

	experiment := anObject
]

{ #category : #logging }
ExperimentLoggerDSSpy >> experimentFinished: anExperiment [

	"Called by the framework when all the tasks of an Experiment hhave been answered"

	^ self inform:
		  'The experiment: ' , anExperiment name , 'has been finished.'
]

{ #category : #logging }
ExperimentLoggerDSSpy >> experimentLoaded: anExperiment [

	"Called by the framework when an Experiment has been loaded (After systemPreparation phase and also after materializing the tasks from ptx files"

	| dsSpyClass dsSpyInstrumentationClass |
	"dsSpyClass := self dsSpyClass.
	dsSpyInstrumentationClass := self dsSpyInstrumenterClass.
	dsSpyClass logOnlyWhenTaskStarted: true.
	dsSpyInstrumentationClass instrumentSystem"
]

{ #category : #initialization }
ExperimentLoggerDSSpy >> initialize [
	|concreteLogger|
	super initialize."
	concreteLogger := DSEventRecorderLogger new.
	concreteLogger setExperiment: experiment.
	concreteLogger projectName: experiment experienceId.
	concreteLogger participantUUID: experiment generateParticipantUUID.
	DSSpy logger: concreteLogger.
	DSSpy monitorPackageForSourceCodeChanges: {'OCD-Tasks'. 'Reflectivity' } "
	
	
]

{ #category : #logging }
ExperimentLoggerDSSpy >> logTaskSuccess: aBoolean forTask: aTask [

	DSTaskSuccessRecord for: { 
			aTask.
			aBoolean }
]

{ #category : #logging }
ExperimentLoggerDSSpy >> surveyClosed: aSurvey [

	"Called by the framework when a task was finished(answer was submitted) by the user. "

	| dsSpyClass |
	dsSpyClass := self dsSpyClass.
	dsSpyClass ifNil: [ ^ self ].
	dsSpyClass closeSurvey: aSurvey
]

{ #category : #logging }
ExperimentLoggerDSSpy >> taskFinished: aTask [

	"Called by the framework when a task was finished(answer was submitted) by the user. "

	| dsSpyClass |
	dsSpyClass := self dsSpyClass.
	dsSpyClass ifNil: [ ^ self ].
	dsSpyClass endTask: aTask
]

{ #category : #logging }
ExperimentLoggerDSSpy >> taskStarted: aTask [

	"Called by the framework when a task was started by the user. "

	| dsSpyClass |
	dsSpyClass := self dsSpyClass.
	dsSpyClass ifNil: [ ^ self ].
	dsSpyClass startTask: aTask
]
