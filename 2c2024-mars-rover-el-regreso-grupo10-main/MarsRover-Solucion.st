!classDefinition: #TestLogger category: #'MarsRover-Solucion'!
TestCase subclass: #TestLogger
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestLogger methodsFor: 'tests' stamp: 'MP 10/26/2024 22:44:10'!
test01LoggerForAFreshMarsRoverLogsNothing
	| marsRover logger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	logger := MarsRoverLogger new.
	marsRover addObserverForPosition: logger. 
	marsRover addObserverForHeading: logger.
	
	self assert: logger logs equals: OrderedCollection new.! !

!TestLogger methodsFor: 'tests' stamp: 'MP 10/26/2024 22:44:35'!
test02LoggerLogsMarsRoverMovingFoward
	| marsRover logger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	logger := MarsRoverLogger new.
	marsRover addObserverForPosition: logger.
	marsRover addObserverForHeading: logger. 
	
	marsRover processCommands: 'f'.
	
	self assert: logger logs equals: (OrderedCollection with: 0@1)! !

!TestLogger methodsFor: 'tests' stamp: 'MP 10/26/2024 22:44:53'!
test03LoggerLogsMarsRoverMovingFoward
	| marsRover logger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	logger := MarsRoverLogger new.
	marsRover addObserverForPosition: logger.
	marsRover addObserverForHeading: logger.
	
	marsRover processCommands: 'f'.
	marsRover processCommands: 'b'.
	
	self assert: logger logs equals: (OrderedCollection with: 0@1 with: 0@0).! !

!TestLogger methodsFor: 'tests' stamp: 'MP 10/26/2024 22:45:10'!
test04LoggerLogsMarsRoverRotatesAndMoves
	| marsRover logger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	logger := MarsRoverLogger new.
	marsRover addObserverForPosition: logger.
	marsRover addObserverForHeading: logger. 
	
	marsRover processCommands: 'f'.
	marsRover processCommands: 'b'.
	marsRover processCommands: 'r'.
	marsRover processCommands: 'f'.
	
	self assert: logger logs equals: (OrderedCollection with: 0@1 with: 0@0 with: #East with: 1@0).! !

!TestLogger methodsFor: 'tests' stamp: 'MP 10/26/2024 16:27:15'!
test05PositionLoggerLogsMarsRoverForwardMovement
	| marsRover logger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	logger := MarsRoverLogger new.
	marsRover addObserverForPosition: logger. 
	
	marsRover processCommands: 'f'.
	
	self assert: logger logs equals: (OrderedCollection with: 0@1).! !

!TestLogger methodsFor: 'tests' stamp: 'MP 10/26/2024 16:27:15'!
test06PositionLoggerLogsMarsRoverMovementsAndIgnoresRotations
	| marsRover logger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	logger := MarsRoverLogger new.
	marsRover addObserverForPosition: logger. 
	
	marsRover processCommands: 'frrrf'.
	
	self assert: logger logs equals: (OrderedCollection with: 0@1 with: -1@1).! !

!TestLogger methodsFor: 'tests' stamp: 'MP 10/28/2024 22:33:38'!
test07HeadingLoggerLogsMarsRoverRotations
	| marsRover logger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	logger := MarsRoverLogger new.
	marsRover addObserverForHeading: logger. 
	
	marsRover processCommands: 'r'.
	
	self assert: logger logs equals: (OrderedCollection with: #East).! !

!TestLogger methodsFor: 'tests' stamp: 'MP 10/28/2024 22:34:10'!
test08HeadingLoggerLogsMarsRoverRotationsAndIgnoresChangesInPosition
	| marsRover logger |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	logger := MarsRoverLogger new.
	marsRover addObserverForHeading: logger. 
	
	marsRover processCommands: 'rffl'.
	
	self assert: logger logs equals: (OrderedCollection with: #East with: #North).! !

!TestLogger methodsFor: 'tests' stamp: 'MP 10/26/2024 22:45:30'!
test09MultipleLoggers
	| marsRover loggerGeneric loggerPosition loggerRotation |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	loggerGeneric := MarsRoverLogger new.
	loggerPosition := MarsRoverLogger new.
	loggerRotation := MarsRoverLogger new.
	
	marsRover addObserverForPosition: loggerGeneric. 
	marsRover addObserverForHeading: loggerGeneric.
	marsRover addObserverForPosition: loggerPosition. 
	marsRover addObserverForHeading: loggerRotation. 
	
	marsRover processCommands: 'rffl'.
	
	self assert: loggerGeneric logs equals: (OrderedCollection with: #East with: 1@0 with: 2@0 with: #North).
	self assert: loggerPosition logs equals: (OrderedCollection with: 1@0 with: 2@0).
	self assert: loggerRotation logs equals: (OrderedCollection with: #East with: #North).! !


!classDefinition: #TestMarsRover category: #'MarsRover-Solucion'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:42:57'!
test01MarsRoverDoestNotMoveWhenNoCommandsAreSent

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: '' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:05'!
test02RoverFacingNorthCanMoveForward

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'f' endsAt: 0@1 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:13'!
test03RoverFacingNorthCanMoveBackward

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'b' endsAt: 0@-1 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:24'!
test04RoverFacingNorthHeadsEastAfterTurningRight

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'r' endsAt: 0@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:43:55'!
test05RoverFacingNorthHeadsWestAfterTurningLeft
	
	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'l' endsAt: 0@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:44:26'!
test06RoverFacingEastHeadsSouthWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'r' endsAt: 0@0 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:44:43'!
test07RoverFacingSouthHeadsWestWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'r' endsAt: 0@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:00'!
test08RoverFacingWestHeadsNorthWhenTurningRight
	
	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'r' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:20'!
test09RoverFacingEastHeadsNorthWhenTurningLeft
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'l' endsAt: 0@0 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:45:52'!
test10RoverFacingSouthHeadsEastWhenTurningLeft

	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'l' endsAt: 0@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:46:17'!
test11RoverFacingWestHeadsSouthWhenTurningLeft

	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'l' endsAt: 0@0 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:47:36'!
test12RoverFacingEastCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'f' endsAt: 1@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:47:55'!
test13RoverFacingEastCanMoveBackwards

	self assertRoverStartingAt: 0@0 heading: #East afterProcessing: 'b' endsAt: -1@0 heading: #East! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:48:20'!
test14RoverFacingSouthCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'f' endsAt: 0@-1 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:48:38'!
test15RoverFacingSouthCanMoveBackward
	
	self assertRoverStartingAt: 0@0 heading: #South afterProcessing: 'b' endsAt: 0@1 heading: #South! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:49:10'!
test16RoverFacingWestCanMoveForward
	
	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'f' endsAt: -1@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:49:46'!
test17RoverFacingWestCanMoveBackward

	self assertRoverStartingAt: 0@0 heading: #West afterProcessing: 'b' endsAt: 1@0 heading: #West! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 7/1/2021 00:50:56'!
test18RoverCanProcessMultipleCommands

	self assertRoverStartingAt: 0@0 heading: #North afterProcessing: 'ff' endsAt: 0@2 heading: #North! !

!TestMarsRover methodsFor: 'tdd tests' stamp: 'LL 6/30/2021 16:05:43'!
test19RoverStopsWhenProcessingAnInvalidCommand

	| marsRover |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	
	self should: [ marsRover processCommands: 'fxf' ] 
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: marsRover invalidCommandErrorMessage.
			self assert: (marsRover isAt: 0@1 heading: #North).
		].
	
	! !


!TestMarsRover methodsFor: 'assertions' stamp: 'LL 7/1/2021 00:42:36'!
assertRoverStartingAt: aPosition heading: aCardinalPoint afterProcessing: aStringOfCommands endsAt: aFinalPosition heading: aFinalCardinalPoint

	| marsRover |
	marsRover := MarsRover startingAt: aPosition heading: aCardinalPoint.
	
	marsRover processCommands: aStringOfCommands.
	
	self assert: (marsRover isAt: aFinalPosition heading: aFinalCardinalPoint)! !


!classDefinition: #TestWindow category: #'MarsRover-Solucion'!
TestCase subclass: #TestWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!TestWindow methodsFor: 'tests' stamp: 'MP 10/26/2024 22:47:03'!
test01WindowForAFreshMarsRoverRegistersInitialState
	| marsRover window |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	window := MarsRoverWindow new.
	marsRover addObserverForPosition: window.
	marsRover addObserverForHeading: window.
	
	self assert: window state equals: Dictionary new.! !

!TestWindow methodsFor: 'tests' stamp: 'MP 10/26/2024 22:47:11'!
test02WindowForAMarsRoverRegistersMovingForward
	| marsRover window |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	window := MarsRoverWindow new.
	marsRover addObserverForPosition: window.
	marsRover addObserverForHeading: window.
	
	marsRover processCommands: 'f'. 
	
	self assert: window state equals: (Dictionary with: #Position->(0@1)).! !

!TestWindow methodsFor: 'tests' stamp: 'MP 10/26/2024 22:47:15'!
test03WindowForAMarsRoverRegistersRotation
	| marsRover window |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	window := MarsRoverWindow new.
	marsRover addObserverForPosition: window.
	marsRover addObserverForHeading: window.
	
	marsRover processCommands: 'r'. 
	
	self assert: window state equals: (Dictionary with: #Heading->#East).! !

!TestWindow methodsFor: 'tests' stamp: 'MP 10/28/2024 22:35:46'!
test04WindowForAMarsRoverRegistersActualStateAfterRotationsAndMovements
	| marsRover window |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	window := MarsRoverWindow new.
	marsRover addObserverForPosition: window.
	marsRover addObserverForHeading: window.
	
	marsRover processCommands: 'rffrf'. 
	
	self assert: window state equals: (Dictionary with: #Position->(2@-1) with: #Heading->#South).! !

!TestWindow methodsFor: 'tests' stamp: 'MP 10/28/2024 22:36:26'!
test05PositionWindowForAMarsRoverRegistersPositionAndIgnoresTheHeading
	| marsRover window |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	window := MarsRoverWindow new.
	marsRover addObserverForPosition: window.
	
	marsRover processCommands: 'rffrf'. 
	
	self assert: window state equals: (Dictionary with: #Position->(2@-1)).! !

!TestWindow methodsFor: 'tests' stamp: 'MP 10/28/2024 22:36:50'!
test06HeadingWindowForAMarsRoverRegistersHeadingAndIgnoresPosition
	| marsRover window |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	window := MarsRoverWindow new.
	marsRover addObserverForHeading: window.
	
	marsRover processCommands: 'rffrf'. 
	
	self assert: window state equals: (Dictionary with: #Heading->#South).! !

!TestWindow methodsFor: 'tests' stamp: 'MP 10/26/2024 22:47:31'!
test07MultipleWindows
	| marsRover windowGeneric windowPosition windowHeading |
	marsRover := MarsRover startingAt: 0@0 heading: #North.
	windowGeneric := MarsRoverWindow new.
	windowPosition := MarsRoverWindow new.
	windowHeading := MarsRoverWindow new.
	
	marsRover addObserverForPosition: windowGeneric.
	marsRover addObserverForHeading: windowGeneric.
	marsRover addObserverForPosition: windowPosition.
	marsRover addObserverForHeading: windowHeading .
	
	marsRover processCommands: 'rffrf'. 
	
	self assert: windowGeneric state equals: (Dictionary with: #Position->(2@-1) with: #Heading->#South).
	self assert: windowPosition state equals: (Dictionary with: #Position->(2@-1)).
	self assert: windowHeading state equals: (Dictionary with: #Heading->#South).! !


!classDefinition: #MarsRover category: #'MarsRover-Solucion'!
Object subclass: #MarsRover
	instanceVariableNames: 'positionProxy headProxy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRover methodsFor: 'initialization' stamp: 'MP 10/28/2024 22:26:49'!
initializeStartingAt: aPosition heading: aCardinalPoint 

	positionProxy := PositionProxy initializeFor: aPosition.
	headProxy := HeadProxy initializeFor: (MarsRoverHead of: self facing: aCardinalPoint)! !


!MarsRover methodsFor: 'process commands' stamp: 'MP 10/18/2024 18:19:39'!
processCommands: aStringWithCommands

	aStringWithCommands do: [ :aCommand | 
		self assertCommandIsValid: aCommand.
		self processCommand: aCommand.
	].
	
! !


!MarsRover methodsFor: 'testing' stamp: 'MP 10/29/2024 00:14:05'!
isAt: aPosition heading: aCardinalPoint

	^ positionProxy proxee = aPosition and: [ headProxy proxee isHeading: aCardinalPoint ]! !


!MarsRover methodsFor: 'private - process commands' stamp: 'LL 6/30/2021 15:54:11'!
assertCommandIsValid: aCommand

	^ (self isInvalidCommand: aCommand) ifTrue: [ self error: self invalidCommandErrorMessage ]! !

!MarsRover methodsFor: 'private - process commands' stamp: 'LL 6/30/2021 15:48:06'!
invalidCommandErrorMessage

	^'Invalid command'! !

!MarsRover methodsFor: 'private - process commands' stamp: 'MP 10/29/2024 00:14:05'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^headProxy proxee movingForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^headProxy proxee movingBackwards ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^headProxy proxee rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^headProxy proxee rotateLeft ].
! !


!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:26:42'!
isBackwardCommand: command

	^ command = $b! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:26:27'!
isForwardCommand: command

	^ command = $f! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:51:21'!
isInvalidCommand: aCommand
	^(self isForwardCommand: aCommand) not and: 
		[ (self isBackwardCommand: aCommand) not and: 
			[ (self isRotateRightCommand: aCommand) not and: 
				[ (self isRotateLeftCommand: aCommand) not ] ] ]! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:50:53'!
isRotateLeftCommand: command

	^ command = $l! !

!MarsRover methodsFor: 'private - commands' stamp: 'LL 6/30/2021 15:27:33'!
isRotateRightCommand: command

	^ command = $r! !


!MarsRover methodsFor: 'dd - moving' stamp: 'MP 10/27/2024 20:16:01'!
moveDown
	
	positionProxy update: (0@-1)! !

!MarsRover methodsFor: 'dd - moving' stamp: 'MP 10/27/2024 20:16:04'!
moveLeft
	
	positionProxy update: (-1@0).! !

!MarsRover methodsFor: 'dd - moving' stamp: 'MP 10/27/2024 20:16:08'!
moveRight
	
	positionProxy update: (1@0).! !

!MarsRover methodsFor: 'dd - moving' stamp: 'MP 10/27/2024 20:16:11'!
moveUp
	
	positionProxy update: (0@1).! !


!MarsRover methodsFor: 'dd - heading' stamp: 'MP 10/27/2024 20:15:56'!
headEast
	
	headProxy update: (MarsRoverHeadFacingEast of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'MP 10/27/2024 20:15:52'!
headNorth
	
	headProxy update: (MarsRoverHeadFacingNorth of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'MP 10/27/2024 20:15:48'!
headSouth
	
	headProxy update: (MarsRoverHeadFacingSouth of: self).! !

!MarsRover methodsFor: 'dd - heading' stamp: 'MP 10/27/2024 20:15:44'!
headWest
	
	headProxy update: (MarsRoverHeadFacingWest of: self).! !


!MarsRover methodsFor: 'observing' stamp: 'MP 10/26/2024 16:14:12'!
addObserverForHeading: anObserver
	headProxy addObserver: anObserver.
	! !

!MarsRover methodsFor: 'observing' stamp: 'MP 10/26/2024 16:14:24'!
addObserverForPosition: anObserver
	positionProxy addObserver: anObserver
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-Solucion'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 13:30:13'!
startingAt: aPoint heading: aCardinalPoint 
	
	^self new initializeStartingAt: aPoint heading: aCardinalPoint ! !


!classDefinition: #MarsRoverHead category: #'MarsRover-Solucion'!
Object subclass: #MarsRoverHead
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHead methodsFor: 'heading' stamp: 'LL 6/30/2021 19:46:16'!
isHeading: aCardinalPoint

	^self class whenFacing: aCardinalPoint

	! !


!MarsRoverHead methodsFor: 'orientation' stamp: 'MP 10/29/2024 00:07:57'!
orientation
	self subclassResponsibility ! !


!MarsRoverHead methodsFor: 'initialization' stamp: 'LL 6/30/2021 16:17:57'!
initializeOf: aMarsRover

	marsRover := aMarsRover! !


!MarsRoverHead methodsFor: 'rotating' stamp: 'LL 6/30/2021 16:36:46'!
rotateLeft

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'rotating' stamp: 'LL 6/30/2021 16:36:43'!
rotateRight

	self subclassResponsibility! !


!MarsRoverHead methodsFor: 'moving' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	self subclassResponsibility! !

!MarsRoverHead methodsFor: 'moving' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHead class' category: #'MarsRover-Solucion'!
MarsRoverHead class
	instanceVariableNames: ''!

!MarsRoverHead class methodsFor: 'testing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	self subclassResponsibility.! !


!MarsRoverHead class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 16:16:27'!
of: aMarsRover

	^self new initializeOf: aMarsRover! !

!MarsRoverHead class methodsFor: 'instance creation' stamp: 'LL 6/30/2021 19:46:37'!
of: aMarsRover facing: aCardinalPoint
	
	| headingSubclass |
	headingSubclass := self subclasses detect: [ :aHeadingSubclass | aHeadingSubclass whenFacing: aCardinalPoint ].
	
	^headingSubclass of: aMarsRover.! !


!classDefinition: #MarsRoverHeadFacingEast category: #'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingEast methodsFor: 'rotating' stamp: 'LL 6/30/2021 17:06:22'!
rotateLeft

	^marsRover headNorth.

	! !

!MarsRoverHeadFacingEast methodsFor: 'rotating' stamp: 'LL 6/30/2021 17:10:14'!
rotateRight

	^marsRover headSouth.

	! !


!MarsRoverHeadFacingEast methodsFor: 'moving' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveLeft.

	! !

!MarsRoverHeadFacingEast methodsFor: 'moving' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveRight.

	! !


!MarsRoverHeadFacingEast methodsFor: 'orientation' stamp: 'MP 10/29/2024 00:07:57'!
orientation
	^#East! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingEast class' category: #'MarsRover-Solucion'!
MarsRoverHeadFacingEast class
	instanceVariableNames: ''!

!MarsRoverHeadFacingEast class methodsFor: 'testing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #East! !


!classDefinition: #MarsRoverHeadFacingNorth category: #'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingNorth methodsFor: 'orientation' stamp: 'MP 10/29/2024 00:07:57'!
orientation
	^#North! !


!MarsRoverHeadFacingNorth methodsFor: 'moving' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveDown.! !

!MarsRoverHeadFacingNorth methodsFor: 'moving' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveUp.! !


!MarsRoverHeadFacingNorth methodsFor: 'rotating' stamp: 'LL 6/30/2021 17:06:33'!
rotateLeft

	^marsRover headWest.! !

!MarsRoverHeadFacingNorth methodsFor: 'rotating' stamp: 'LL 6/30/2021 17:10:58'!
rotateRight

	^marsRover headEast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingNorth class' category: #'MarsRover-Solucion'!
MarsRoverHeadFacingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingNorth class methodsFor: 'testing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #North! !


!classDefinition: #MarsRoverHeadFacingSouth category: #'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingSouth methodsFor: 'orientation' stamp: 'MP 10/29/2024 00:07:58'!
orientation
	^#South! !


!MarsRoverHeadFacingSouth methodsFor: 'moving' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveUp.! !

!MarsRoverHeadFacingSouth methodsFor: 'moving' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveDown! !


!MarsRoverHeadFacingSouth methodsFor: 'rotating' stamp: 'LL 6/30/2021 17:06:43'!
rotateLeft

	^marsRover headEast.! !

!MarsRoverHeadFacingSouth methodsFor: 'rotating' stamp: 'LL 6/30/2021 17:12:30'!
rotateRight

	^marsRover headWest.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingSouth class' category: #'MarsRover-Solucion'!
MarsRoverHeadFacingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadFacingSouth class methodsFor: 'testing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #South! !


!classDefinition: #MarsRoverHeadFacingWest category: #'MarsRover-Solucion'!
MarsRoverHead subclass: #MarsRoverHeadFacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverHeadFacingWest methodsFor: 'moving' stamp: 'LL 6/30/2021 19:48:36'!
movingBackwards

	^marsRover moveRight.! !

!MarsRoverHeadFacingWest methodsFor: 'moving' stamp: 'LL 6/30/2021 19:48:47'!
movingForward

	^marsRover moveLeft.! !


!MarsRoverHeadFacingWest methodsFor: 'rotating' stamp: 'LL 6/30/2021 17:06:52'!
rotateLeft

	^marsRover headSouth.! !

!MarsRoverHeadFacingWest methodsFor: 'rotating' stamp: 'LL 6/30/2021 17:12:44'!
rotateRight

	^marsRover headNorth.! !


!MarsRoverHeadFacingWest methodsFor: 'orientation' stamp: 'MP 10/29/2024 00:07:58'!
orientation
	^#West! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadFacingWest class' category: #'MarsRover-Solucion'!
MarsRoverHeadFacingWest class
	instanceVariableNames: ''!

!MarsRoverHeadFacingWest class methodsFor: 'testing' stamp: 'LL 6/30/2021 19:46:16'!
whenFacing: aCardinalPoint

	^aCardinalPoint = #West! !


!classDefinition: #MarsRoverObserver category: #'MarsRover-Solucion'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverObserver methodsFor: 'updating' stamp: 'MP 10/26/2024 18:58:53'!
updateHeading: aHeading
	self subclassResponsibility ! !

!MarsRoverObserver methodsFor: 'updating' stamp: 'MP 10/26/2024 18:59:04'!
updatePosition: aPosition
	self subclassResponsibility ! !


!classDefinition: #MarsRoverLogger category: #'MarsRover-Solucion'!
MarsRoverObserver subclass: #MarsRoverLogger
	instanceVariableNames: 'logs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverLogger methodsFor: 'initialization' stamp: 'MP 10/26/2024 15:56:07'!
initialize
	logs := OrderedCollection new.! !


!MarsRoverLogger methodsFor: 'logging' stamp: 'MP 10/18/2024 19:10:33'!
logs
	^logs! !


!MarsRoverLogger methodsFor: 'updating' stamp: 'MP 10/26/2024 17:54:40'!
updateHeading: aHeading
	logs add: aHeading
	
	
	! !

!MarsRoverLogger methodsFor: 'updating' stamp: 'MP 10/26/2024 17:54:27'!
updatePosition: aPosition
	logs add: aPosition
	
	
	! !


!classDefinition: #MarsRoverWindow category: #'MarsRover-Solucion'!
MarsRoverObserver subclass: #MarsRoverWindow
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverWindow methodsFor: 'initialization' stamp: 'MP 10/26/2024 18:38:05'!
initialize
	state := Dictionary new.! !


!MarsRoverWindow methodsFor: 'state' stamp: 'MP 10/26/2024 18:37:53'!
state
	^state! !


!MarsRoverWindow methodsFor: 'updating' stamp: 'MP 10/26/2024 17:56:35'!
updateHeading: aHeading
	state add: #Heading->aHeading.
	
	
	! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'MP 10/26/2024 17:59:04'!
updatePosition: aPosition
	state add: #Position->aPosition.
	
	
	! !


!classDefinition: #MarsRoverProxy category: #'MarsRover-Solucion'!
Object subclass: #MarsRoverProxy
	instanceVariableNames: 'observers proxee'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!MarsRoverProxy methodsFor: 'updating' stamp: 'MP 10/26/2024 17:51:49'!
update: anEntry

	self subclassResponsibility! !


!MarsRoverProxy methodsFor: 'initialization' stamp: 'MP 10/28/2024 22:29:24'!
initializeWith: aValue
	proxee := aValue.
	observers := OrderedCollection new.! !


!MarsRoverProxy methodsFor: 'observing' stamp: 'MP 10/26/2024 18:18:06'!
addObserver: anObserver

	self subclassResponsibility! !


!MarsRoverProxy methodsFor: 'accessing' stamp: 'MP 10/29/2024 00:14:05'!
proxee
	^proxee! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverProxy class' category: #'MarsRover-Solucion'!
MarsRoverProxy class
	instanceVariableNames: ''!

!MarsRoverProxy class methodsFor: 'instance creation' stamp: 'MP 10/26/2024 23:53:52'!
initializeFor: aValue
	^self new initializeWith: aValue.! !


!classDefinition: #HeadProxy category: #'MarsRover-Solucion'!
MarsRoverProxy subclass: #HeadProxy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!HeadProxy methodsFor: 'updating' stamp: 'MP 10/29/2024 00:07:58'!
update: aHeading
	| headingText |
	
	proxee := aHeading.
	headingText := proxee orientation.
	
	observers do: [ :observer | observer updateHeading: headingText ]! !


!HeadProxy methodsFor: 'observing' stamp: 'MP 10/26/2024 18:49:46'!
addObserver: anObserver
	
	observers add: anObserver.! !


!classDefinition: #PositionProxy category: #'MarsRover-Solucion'!
MarsRoverProxy subclass: #PositionProxy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Solucion'!

!PositionProxy methodsFor: 'updating' stamp: 'MP 10/28/2024 22:29:25'!
update: aPosition
	proxee := proxee + aPosition.
	
	observers do: [ :observer | observer updatePosition: proxee ]! !


!PositionProxy methodsFor: 'observing' stamp: 'MP 10/26/2024 18:49:52'!
addObserver: anObserver
	
	observers add: anObserver.! !
