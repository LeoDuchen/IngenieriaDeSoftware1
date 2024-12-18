!classDefinition: #TestMarsRover category: #TDDMarsRover!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!TestMarsRover methodsFor: 'testing' stamp: 'MP 10/3/2024 12:05:51'!
test01EmtpyCommandDoesntMove
	| marsRover |
	
	marsRover := MarsRover createAt: 0@0.
	marsRover move: ''.
	
	self assert: marsRover position equals: 0@0.! !

!TestMarsRover methodsFor: 'testing' stamp: 'LDMT 10/1/2024 20:35:34'!
test02fCommandMovesForward
	| marsRover |
	
	marsRover := MarsRover createAt: 0@0.
	marsRover move: 'f'.
	
	self assert: marsRover position equals: 0@1.! !

!TestMarsRover methodsFor: 'testing' stamp: 'LD 10/2/2024 17:14:00'!
test03bCommandMovesBackwards
	| marsRover |
	
	marsRover := MarsRover createAt: 0@0.
	marsRover move: 'b'.
	
	self assert: marsRover position equals: 0@-1.! !

!TestMarsRover methodsFor: 'testing' stamp: 'LD 10/2/2024 17:50:17'!
test04ffCommandMovesForwardTwice
	| marsRover  |
	
	marsRover := MarsRover createAt: 0@0.
	marsRover move: 'ff'.
	
	self assert: marsRover position equals: 0@2.! !

!TestMarsRover methodsFor: 'testing' stamp: 'LD 10/2/2024 17:50:06'!
test05fCommandTwiceMovesForwardTwice
	|  marsRover |
	
	marsRover := MarsRover createAt: 0@0.
	marsRover move: 'f'.
	marsRover move: 'f'.

	self assert: marsRover position equals: 0@2.! !

!TestMarsRover methodsFor: 'testing' stamp: 'LD 10/2/2024 17:49:30'!
test06rfCommandRotatesRightAndMovesForward
	| marsRover |
	
	marsRover := MarsRover createAt: 0@0.
	marsRover move: 'rf'.
	
	self assert: marsRover position equals: 1@0.! !

!TestMarsRover methodsFor: 'testing' stamp: 'LD 10/2/2024 17:50:01'!
test07lbCommandRotatesLeftAndMovesBackwards
	| marsRover |
	
	marsRover := MarsRover createAt: 0@0.
	marsRover move: 'lb'.
	
	self assert: marsRover position equals: 1@0.! !

!TestMarsRover methodsFor: 'testing' stamp: 'LD 10/2/2024 17:49:56'!
test08rrfCommandRotatesRightTwiceAndMovesForward
	| marsRover |
	
	marsRover := MarsRover createAt: 0@0.
	marsRover move: 'rrf'.
	
	self assert: marsRover position equals: 0@-1.! !

!TestMarsRover methodsFor: 'testing' stamp: 'MP 10/3/2024 12:01:52'!
test09frrfrblllffbfrrrbbbffCommandMovesToTheCorrectPosition
	| marsRover |
	
	marsRover := MarsRover createAt: 0@0.
	marsRover move: 'frrfrblllffbfrrrbbbff'.

	self assert: marsRover position equals: 2@2.! !

!TestMarsRover methodsFor: 'testing' stamp: 'MP 10/3/2024 12:22:07'!
test10CannotContinueMovingAfterInvalidCommand

	| marsRover action actionOnError |
		
	marsRover := MarsRover createAt: 0@0.
	
	action := [ marsRover move: 'ffbrlfxlrfblr' ].
	actionOnError := [ :anError | 
			self assert: anError messageText = MarsRover CannotMoveAfterInvalidCommandMessage.
			self assert: marsRover position equals: 0@2 ].

	self should: action raise: Error withExceptionDo: actionOnError.! !


!classDefinition: #MarsRover category: #TDDMarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position cardinalOrientation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!MarsRover methodsFor: 'movement' stamp: 'LDMT 10/1/2024 21:23:54'!
move: commandSequence
	
	commandSequence do: [ :command | 
		self processCommand: command.
	].
	! !

!MarsRover methodsFor: 'movement' stamp: 'LDMT 10/1/2024 21:27:39'!
moveDown
	position := position + (0@-1)! !

!MarsRover methodsFor: 'movement' stamp: 'LDMT 10/1/2024 21:27:52'!
moveLeft
	position := position + (-1@0)! !

!MarsRover methodsFor: 'movement' stamp: 'LDMT 10/1/2024 21:27:46'!
moveRight
	position := position + (1@0)! !

!MarsRover methodsFor: 'movement' stamp: 'LDMT 10/1/2024 21:29:37'!
moveUp
	position := position + (0@1)! !


!MarsRover methodsFor: 'accessing' stamp: 'LDMT 10/1/2024 20:34:39'!
position
	^position! !


!MarsRover methodsFor: 'initialization' stamp: 'MP 10/3/2024 12:24:09'!
initializeAt: aPosition
	position := aPosition.
	cardinalOrientation := MarsRoverCardinalOrientationNorth new.! !


!MarsRover methodsFor: 'private' stamp: 'MP 10/3/2024 12:09:13'!
processCommand: command

	(command = $f) ifTrue: [^cardinalOrientation moveForward: self].
	(command = $b) ifTrue: [^cardinalOrientation moveBackwards: self].
	(command = $r) ifTrue: [^cardinalOrientation rotateRight: self].
	(command = $l) ifTrue: [^cardinalOrientation rotateLeft: self].
	
	self error: self class CannotMoveAfterInvalidCommandMessage.! !


!MarsRover methodsFor: 'orientation' stamp: 'MP 10/3/2024 12:23:10'!
orientateToEast
	cardinalOrientation := MarsRoverCardinalOrientationEast new.! !

!MarsRover methodsFor: 'orientation' stamp: 'MP 10/3/2024 12:24:09'!
orientateToNorth
	cardinalOrientation := MarsRoverCardinalOrientationNorth new.! !

!MarsRover methodsFor: 'orientation' stamp: 'MP 10/3/2024 12:23:49'!
orientateToSouth
	cardinalOrientation := MarsRoverCardinalOrientationSouth new.! !

!MarsRover methodsFor: 'orientation' stamp: 'MP 10/3/2024 12:23:37'!
orientateToWest
	cardinalOrientation := MarsRoverCardinalOrientationWest new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #TDDMarsRover!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'LDMT 10/1/2024 20:36:01'!
createAt: aPosition
	^MarsRover new initializeAt: aPosition.
	! !


!MarsRover class methodsFor: 'error' stamp: 'MP 10/3/2024 12:09:13'!
CannotMoveAfterInvalidCommandMessage

	^'Invalid Command'! !


!classDefinition: #MarsRoverCardinalOrientation category: #TDDMarsRover!
Object subclass: #MarsRoverCardinalOrientation
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!MarsRoverCardinalOrientation methodsFor: 'movement' stamp: 'LDMT 10/1/2024 21:38:41'!
moveBackwards: aMarsRover
	self subclassResponsibility ! !

!MarsRoverCardinalOrientation methodsFor: 'movement' stamp: 'LDMT 10/1/2024 21:37:48'!
moveForward: aMarsRover
	self subclassResponsibility ! !


!MarsRoverCardinalOrientation methodsFor: 'rotation' stamp: 'LD 10/2/2024 17:15:08'!
rotateLeft: aMarsRover
	self subclassResponsibility ! !

!MarsRoverCardinalOrientation methodsFor: 'rotation' stamp: 'LDMT 10/1/2024 21:44:06'!
rotateRight: aMarsRover
	self subclassResponsibility ! !


!classDefinition: #MarsRoverCardinalOrientationEast category: #TDDMarsRover!
MarsRoverCardinalOrientation subclass: #MarsRoverCardinalOrientationEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!MarsRoverCardinalOrientationEast methodsFor: 'movement' stamp: 'LDMT 10/1/2024 21:39:50'!
moveBackwards: aMarsRover
	aMarsRover moveLeft! !

!MarsRoverCardinalOrientationEast methodsFor: 'movement' stamp: 'LDMT 10/1/2024 21:39:42'!
moveForward: aMarsRover
	aMarsRover moveRight! !


!MarsRoverCardinalOrientationEast methodsFor: 'rotation' stamp: 'LD 10/2/2024 17:53:27'!
rotateLeft: aMarsRover
	aMarsRover orientateToNorth.! !

!MarsRoverCardinalOrientationEast methodsFor: 'rotation' stamp: 'LD 10/2/2024 17:35:33'!
rotateRight: aMarsRover
	aMarsRover orientateToSouth.! !


!classDefinition: #MarsRoverCardinalOrientationNorth category: #TDDMarsRover!
MarsRoverCardinalOrientation subclass: #MarsRoverCardinalOrientationNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!MarsRoverCardinalOrientationNorth methodsFor: 'rotation' stamp: 'LD 10/2/2024 17:15:03'!
rotateLeft: aMarsRover
	aMarsRover orientateToWest.! !

!MarsRoverCardinalOrientationNorth methodsFor: 'rotation' stamp: 'LDMT 10/1/2024 21:44:49'!
rotateRight: aMarsRover
	aMarsRover orientateToEast.! !


!MarsRoverCardinalOrientationNorth methodsFor: 'movement' stamp: 'LDMT 10/1/2024 21:38:33'!
moveBackwards: aMarsRover
	aMarsRover moveDown! !

!MarsRoverCardinalOrientationNorth methodsFor: 'movement' stamp: 'LDMT 10/1/2024 21:36:45'!
moveForward: aMarsRover
	aMarsRover moveUp! !


!classDefinition: #MarsRoverCardinalOrientationSouth category: #TDDMarsRover!
MarsRoverCardinalOrientation subclass: #MarsRoverCardinalOrientationSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!MarsRoverCardinalOrientationSouth methodsFor: 'rotation' stamp: 'LD 10/2/2024 17:54:24'!
rotateLeft: aMarsRover
	aMarsRover orientateToEast.! !

!MarsRoverCardinalOrientationSouth methodsFor: 'rotation' stamp: 'LD 10/2/2024 17:54:39'!
rotateRight: aMarsRover
	aMarsRover orientateToWest.! !


!MarsRoverCardinalOrientationSouth methodsFor: 'movement' stamp: 'LD 10/2/2024 17:54:50'!
moveBackwards: aMarsRover
	aMarsRover moveUp! !

!MarsRoverCardinalOrientationSouth methodsFor: 'movement' stamp: 'LD 10/2/2024 17:37:35'!
moveForward: aMarsRover
	aMarsRover moveDown! !


!classDefinition: #MarsRoverCardinalOrientationWest category: #TDDMarsRover!
MarsRoverCardinalOrientation subclass: #MarsRoverCardinalOrientationWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TDDMarsRover'!

!MarsRoverCardinalOrientationWest methodsFor: 'movement' stamp: 'LD 10/2/2024 17:15:47'!
moveBackwards: aMarsRover
	aMarsRover moveRight! !

!MarsRoverCardinalOrientationWest methodsFor: 'movement' stamp: 'LD 10/2/2024 17:55:03'!
moveForward: aMarsRover
	aMarsRover moveLeft! !


!MarsRoverCardinalOrientationWest methodsFor: 'rotation' stamp: 'LD 10/2/2024 17:55:11'!
rotateLeft: aMarsRover
	aMarsRover orientateToSouth.! !

!MarsRoverCardinalOrientationWest methodsFor: 'rotation' stamp: 'LD 10/2/2024 17:55:18'!
rotateRight: aMarsRover
	aMarsRover orientateToNorth.! !
