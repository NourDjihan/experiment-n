"
# Task Title

## A Header

Normal text example.
Microdown supports browsable links `Object>>#actAsExecutor` or just for classes `Object`.

A list: 

* item1 blah.
* item2 blah.

Final remark. 
"
Class {
	#name : #MicrodownSTON,
	#superclass : #Object,
	#category : #'Experiments-Utils'
}

{ #category : #'as yet unclassified' }
MicrodownSTON class >> fromClassComment: aClass [
	"Step1: Write microdown code in any class. Step2: Call this method using the class with comment as argument, and put the returned value in your task description in the files"
	^ STON toString: aClass comment
]
