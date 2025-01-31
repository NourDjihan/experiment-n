"
## Microdown description of the Experiment
A brief task description should go here.
"
Class {
	#name : #ExperimentN,
	#superclass : #DefaultGithubBasedExperiment,
	#instVars : [
		'validator',
		'participantUUID'
	],
	#category : #'Experiments-ExpN'
}

{ #category : #building }
ExperimentN class >> buildContactAndCommentSurvey [

	| survey |
	survey := PhexSurvey postExperimentSurvey.
	survey title:
		'Experiment Feedback (Perceived usefulness, Ease of Use, and self prediction of future use)'.

	survey addQuestion: (self freeTextQuestion:
			 'If you have any comments on the experiment, please add them here').

	survey addQuestion: (self freeTextQuestion:
			 'If you would be informed about results of this work, please add your e-mail').

	survey addQuestion: (self freeTextQuestion:
			 'If you would participate to a more detailed interview, please add your e-mail').

	survey addQuestion:
		(self yesNoQuestion:
			 'Do you authorize the publication of these data?').

	^ survey
]

{ #category : #building }
ExperimentN class >> buildDemographicSurvey [

	| survey |
	survey := PhexSurvey postExperimentSurvey.
	survey title: 'Demographic information'.

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'What is your highest achieved level of education?'
			 options: #( 'Bachelor or equivalent' 'Master or equivalent'
				    'PhD or higher academic title' 'None of the above' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'What is you current job position? (CS = Computer Science)'
			 options: #( 'Student' 'Software developer or engineer'
				    'Researcher' 'CS Engineer but not in software'
				    'Other CS position' 'Other (not CS)' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How many years of programming experience do you have?'
			 options:
			 #( '< 1' '1-2 years' '3-5 years' '6-10 years' 'More than 10' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How many years of programming experience do you have with Pharo?'
			 options:
			 #( '< 1' '1-2 years' '3-5 years' '6-10 years' 'More than 10' )).

	survey addQuestion: (self
			 singleChoiceQuestion: 'How often do you write code?'
			 options: #( 'At least once per day' 'At least once per week'
				    'At least once per month' 'At least once per year' )).

	survey addQuestion: (self
			 singleChoiceQuestion: 'How often do you write code in Pharo?'
			 options: #( 'At least once per day' 'At least once per week'
				    'At least once per month' 'At least once per year' )).


	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with the sentence: "I''m familiar with debugging"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with the sentence: "I''m familiar with Object-Centric Debugging"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	^ survey
]

{ #category : #building }
ExperimentN class >> buildExperiment [
	<script>
	| tasks postTaskSurvey surveys xp |
	tasks := self buildTasks.
	surveys := self buildExperimentSurveys.

	postTaskSurvey := self buildPostTaskSurvey.
	surveys add: postTaskSurvey.
	tasks first survey: postTaskSurvey uuid.

	postTaskSurvey := self buildPostTaskSurvey.
	surveys add: postTaskSurvey.
	tasks last survey: postTaskSurvey uuid.
	
	xp := self basicNew.
	xp tasks: tasks.
	1 to: surveys size do:[:i| (surveys at: i) order: i]. 
	surveys do:[:s| xp addSurvey: s].
	xp serializeTasks.
	xp serializeSurveys.
	xp inspect
]

{ #category : #building }
ExperimentN class >> buildExperimentSurveys [

	| svs |
	svs := OrderedCollection new.
	svs add: self buildIntroSurvey.
	svs add: self buildDemographicSurvey.
	svs add: self buildPostExperimentSurvey.
	svs add: self buildContactAndCommentSurvey.
	^svs
]

{ #category : #building }
ExperimentN class >> buildIntroSurvey [
	|textStream question survey contents|
	contents := 'Dear Participant,
	
We are researchers investigating on Exp-N. We would be grateful if you could help our research and participate in our experiment on this subject.

In this experiment:

- We analyze developers applying X in different circumstances,
- we collect and store anonymized data from you during the experiment.

The experiment will require around 40 minutes to be completed.

To proceed, please carefully read and agree to the following data handling policy:

In this experiment, we ask you some demographic data such as your level of education and your experience as a developer. None of these questions will be mandatory and we will not ask any further sensitive information. Please do not to share personal and/or sensitive information in the open questions you will find in the experiment. In such a case, we will remove your answer from the final dataset.
		
Your answers are anonymized to the best of our capabilities, moreover the IP address from which you complete the experiment is not saved. You can withdraw from the experiment at any moment by quitting the experimental environment; any uncomplete data will be removed. All the data are used for research purposes only; the data will not be sold or shared to third parties.
	
The data handling and storing is under the responsibility of X, Inria Lille - Nord Europe, contact: X@X.X
The data analysis is under the responsibility of X, X, contact: X
	
Do you agree with or Data Policy Content? *If you do not agree, please leave the experiment*
'.
	
	question := PhexAgreementQuestion new
		  title: contents;
		  yourself.
	survey := PhexSurvey agreementSurvey.
	survey title: 'Experiment introduction and data policy.'.
	survey questions: { question }.
	^ survey
]

{ #category : #building }
ExperimentN class >> buildPostExperimentSurvey [

	| survey |
	survey := PhexSurvey postExperimentSurvey.
	survey title:
		'Experiment Feedback (Perceived usefulness, Ease of Use, and self prediction of future use)'.

	survey addQuestion: (self
			 singleChoiceQuestion:
			 '"The Task was easy." How much do you agree?'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 '"The Task was long." How much do you agree?'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "OCDbg would enable me to accomplish debugging tasks more quickly"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "OCDbg would improve my debugging performance"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "OCDbg would increase my productivity"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "OCDbg would increase my debugging effectiveness"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "OCDbg would make it easier to debug the code"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "I would find OCDbg useful"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "Learning to operate with OCDbg would be easy for me"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "I would find it easy to get OCDbg to do what I want it to do, to track objects manipulations and locate the bug"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "My interaction with OCDbg would be clear and understandable"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "It would be easy for me to become skillful at using OCDbg"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "It is easy to remember how to debug a code using OCDbg"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "I would find OCDbg easy to use"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
				
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: "Assuming OCDbg would be available, I predict that I will use it in the future"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'How much do you agree with: " I would prefer OCDbg to the classic debugging system"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	^ survey
]

{ #category : #building }
ExperimentN class >> buildPostTaskSurvey [

	| survey |
	survey := PhexSurvey new.
	survey title: 'Post-task survey'.


	survey addQuestion: (self
			 singleChoiceQuestion:
			 '"The Task was easy." How much do you agree?'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 '"The Task was long." How much do you agree?'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).


	survey addQuestion: (self
			 singleChoiceQuestion: 'How long have you been interrupted?'
			 options:
				 #( 'Not interrupted' '1-2 minutes' 'up to 5 minutes'
				    'up to 10 minutes' 'more than 10 minutes' )).

	survey addQuestion: (self yesNoQuestion: 'Did you find the bug?').

	survey addQuestion:
		(self freeTextQuestion: 'If you found the bug, please describe it.').

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much the debugger helped to discover the bug?'
			 options:
			 #( 'Not at all' 'Slightly' 'Moderately' 'Normally' 'Extremely' )).


	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much do you agree with: "The debugging method is enjoyable"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much do you agree with: "The debugging method is efficient"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
				
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much do you agree with: "The debugging method is intuitive"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
				
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much do you agree with: "The debugging method is easy to use"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).
				
	survey addQuestion: (self
			 singleChoiceQuestion:
			 'If you found the bug, how much do you agree with: "The debugging method is asy to learn"'
			 options:
				 #( 'Strongly Disagree' 'Disagree' 'Nor disagree or agree'
				    'Agree' 'Strongly Agree' )).

	^ survey
]

{ #category : #building }
ExperimentN class >> buildTasks [

	|tasks task|
	tasks := OrderedCollection new.
	
	task := PhexTask new.
	task title: 'Task 1'.
	task requiredAnswer: 'You must provide an answer'.
	task requiresAnswer: true.
	task description: self task1Source.
	task contents: task description.
	task order: 1.
	tasks add: task.
	
	task := PhexTask new.
	task title: 'Tutorial'.
	task requiredAnswer: 'You have no answer to provide'.
	task requiresAnswer: false.
	task description: self tutorialTaskSource.
	task contents: task description.
	task order: 2.
	tasks add: task.
	
	task := PhexTask new.
	task title: 'Task 2'.
	task requiredAnswer: 'You must provide an answer'.
	task requiresAnswer: true.
	task description: self task2Source.
	task contents: task description.
	task order: 3.
	tasks add: task.
	
	^tasks
]

{ #category : #initialization }
ExperimentN class >> initialize [

]

{ #category : #'as yet unclassified' }
ExperimentN class >> startIt [

	Metacello new
		baseline: 'ClassBlueprintScenarios';
		repository:
			'github://NourDjihan/ClassBlueprintExperimentScenarios/src';
		load.
	ExperimentN buildExperiment.
	PhexTaskLauncherPresenter open loadExperience: ExperimentN
]

{ #category : #'building - sources' }
ExperimentN class >> task1Source [
^ 'Import the model into the Moose inspector'

]

{ #category : #'building - sources' }
ExperimentN class >> task2Source [
^'# Task 2
Microdown description of the task here
'
]

{ #category : #'building - sources' }
ExperimentN class >> tutorialTaskSource [
^'
# Tutorial
## This is an example on how to use Microdown
Your tasks description should be written like this. Microdown supports browsable links such as the following `OrderedCollection`. You can also specify methods like this `OrderedCollection>>#add:`  (click on it).

Lists are written like this:

* An item.
 *  A sub item.
* Another item.
* Etc.

## Embedding Images

You can also embed images like this (requires internet connection):

![an-image](https://user-images.githubusercontent.com/1684221/148937891-c2b44f80-7053-4dc3-a70e-ab07c60b0f16.png)

**This is italic text style**
**This is bold text style**
***This is bold italic text style***

'
]

{ #category : #accessing }
ExperimentN >> description [

	^ 'Experiment-N'
]

{ #category : #installation }
ExperimentN >> downloadAndInstallExternalTools [

	"Metacello new
		baseline: 'BreakpointNavigator';
		repository: 'github://StevenCostiou/BreakpointNavigator:main';
		load"
]

{ #category : #installation }
ExperimentN >> downloadAndInstallSpy [

	"Metacello new
		baseline: 'DebuggingSpy';
		repository: 'github://Pharo-XP-Tools/DebuggingSpy:master';
		load."
	"Metacello new
		baseline: 'DSSpyEventRecorder';
		repository:'github://Pharo-XP-Tools/DebuggingSpy-EventRecorder:main';
		load"
]

{ #category : #installation }
ExperimentN >> downloadAndInstallTasks [

	"Call baseline of tasks code here"

	
]

{ #category : #accessing }
ExperimentN >> experienceId [

	"The experienceId is also used as the root folder containing the tasks and results.
Therefore, use only filename-friendly characters.
"

	^ 'experiment-n'
]

{ #category : #installation }
ExperimentN >> findClass: aSymbol [

	^ self class environment at: aSymbol
]

{ #category : #'task management' }
ExperimentN >> finishTask: aTask [
	super finishTask: aTask.
	aTask order = 1 ifFalse:[^self].
	
]

{ #category : #initialization }
ExperimentN >> generateParticipantUUID [

	^ participantUUID ifNil: [ 
		  | str |
		  str := WriteStream on: String new.
		  str << 'User-'.
		  str << UUID new asString.
		  str << DateAndTime now asNanoSeconds printString.
		  participantUUID := str contents ]
]

{ #category : #accessing }
ExperimentN >> logger [

	^ logger ifNil: [ 
		  logger := (self findClass: #ExperimentLoggerDSSpy) on: self ]
]

{ #category : #accessing }
ExperimentN >> name [

	^ 'Experiment-N'
]

{ #category : #initialization }
ExperimentN >> prepareSystemForExperiment [

	"Called when the experiment is selected and loaded in Phex. Do all experiment initialization logic here"

	"Why not adding everything as a baseline dependincy instead of doing this?
A: Control. Its difficult to selectively modify what happens between a baseline load and any of its dependencies. We do a manual installation instead, controlling the order, and other aspects such as changes logging."

	EpMonitor disableDuring: [ 
		self downloadAndInstallExternalTools.
		self downloadAndInstallSpy.
		self downloadAndInstallTasks.
	 ]
]

{ #category : #testing }
ExperimentN >> runTasksInOrder [

	^ true
]

{ #category : #'task management' }
ExperimentN >> startTask: aTask [
	super startTask: aTask.
	aTask == tasks first ifFalse:[^self].
	
]

{ #category : #actions }
ExperimentN >> validateTask: aTask [

	| str selector |
	str := WriteStream on: String new.
	str << 'test'.
	str << aTask title asCamelCase.
	str << 'Validity'.
	selector := str contents asSymbol.
	(validator respondsTo: selector) ifTrue: [ 
		logger logTaskSuccess: (validator perform: selector) forTask: aTask ]
]
