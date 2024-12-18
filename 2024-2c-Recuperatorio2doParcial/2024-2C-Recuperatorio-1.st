!classDefinition: #MarsRoverTest category: #'2024-2C-Recuperatorio-1'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'nextIntegers'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio-1'!

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:14:12'!
test23OverDirtMovesAndRotatesNormally

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@3->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'fr'.
	
	self assert: (marsRover isAt: 1@3 heading: #East).! !

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:14:25'!
test24OverRockCanNotRotateToRight

	| marsRover map |
	
	map := Dictionary with: 1@2->(Rock new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	self 
		should: [ marsRover process: 'r' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover canNotMoveErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ].! !

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:14:34'!
test25OverRockCanNotRotateToLeft

	| marsRover map |
	
	map := Dictionary with: 1@2->(Rock new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	self 
		should: [ marsRover process: 'l' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover canNotMoveErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ].! !

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:16:07'!
test26CanNotMoveForwardWithARockInFrontWhenHeadingNorth

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@3->(Rock new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	self 
		should: [ marsRover process: 'f' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover canNotMoveErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ].! !

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:16:01'!
test27CanNotMoveBackwardsWithARockBehindWhenHeadingNorth

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@1->(Rock new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	self 
		should: [ marsRover process: 'b' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover canNotMoveErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ].! !

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:16:11'!
test28CanNotMoveForwardWithARockInFrontWhenHeadingWest

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 0@2->(Rock new).
	marsRover := MarsRover at: 1@2 heading: #West on: map withRandomMovement: [Random nextInteger: 10].
	
	self 
		should: [ marsRover process: 'f' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover canNotMoveErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #West) ].! !

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:16:36'!
test29CanNotMoveBackwardsWithARockBehindWhenHeadingWest

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 2@2->(Rock new).
	marsRover := MarsRover at: 1@2 heading: #West on: map withRandomMovement: [Random nextInteger: 10].
	
	self 
		should: [ marsRover process: 'b' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover canNotMoveErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #West) ].! !

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:17:40'!
test30MovingForwardOverIceMovesRandomWith5PositionsHeadingNorth

	| marsRover map |
	
	nextIntegers := ReadStream on: #(5).
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@3->(Ice new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: self.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@7 heading: #North).! !

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:17:36'!
test31MovingBackwardsOverIceMovesRandomWith7PositionsHeadingNorth

	| marsRover map |
	
	nextIntegers := ReadStream on: #(7).
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@1->(Ice new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: self.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@-5 heading: #North).! !

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:17:59'!
test32MovingForwardOverIceMovesRandomWith2PositionsHeadingWest

	| marsRover map |
	
	nextIntegers := ReadStream on: #(2).
	
	map := Dictionary with: 1@2->(Dirt new) with: 0@2->(Ice new).
	marsRover := MarsRover at: 1@2 heading: #West on: map withRandomMovement: self.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: -1@2 heading: #West).! !

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:18:15'!
test33MovingBackwardsOverIceMovesRandomWith3PositionsHeadingWest

	| marsRover map |
	
	nextIntegers := ReadStream on: #(3).
	
	map := Dictionary with: 1@2->(Dirt new) with: 2@2->(Ice new).
	marsRover := MarsRover at: 1@2 heading: #West on: map withRandomMovement: self.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 4@2 heading: #West).! !

!MarsRoverTest methodsFor: 'tests sensor' stamp: 'LD 12/10/2024 21:18:26'!
test34OverIceRotatesNormally

	| marsRover map |
	
	map := Dictionary with: 1@2->(Ice new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'rrl'.
	
	self assert: (marsRover isAt: 1@2 heading: #East).! !


!MarsRoverTest methodsFor: 'tests repetition' stamp: 'LD 12/10/2024 21:12:35'!
test17f0MovesForwardThreeTimes

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@3->(Dirt new) with: 1@4->(Dirt new) with: 1@5->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'f0'.
	
	self assert: (marsRover isAt: 1@5 heading: #North).! !

!MarsRoverTest methodsFor: 'tests repetition' stamp: 'LD 12/10/2024 21:12:30'!
test18b0MovesBackwardsThreeTimes

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@1->(Dirt new) with: 1@0->(Dirt new) with: 1@-1->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'b0'.
	
	self assert: (marsRover isAt: 1@-1 heading: #North).! !

!MarsRoverTest methodsFor: 'tests repetition' stamp: 'LD 12/10/2024 21:12:58'!
test19r0WhenHeadingNorthHeadsWest

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'r0'.
	
	self assert: (marsRover isAt: 1@2 heading: #West).! !

!MarsRoverTest methodsFor: 'tests repetition' stamp: 'LD 12/10/2024 21:13:15'!
test20l0WhenHeadingNorthHeadsEast

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'l0'.
	
	self assert: (marsRover isAt: 1@2 heading: #East).! !

!MarsRoverTest methodsFor: 'tests repetition' stamp: 'LD 12/10/2024 21:13:26'!
test21f00RaisesAnError

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@3->(Dirt new) with: 1@4->(Dirt new) with: 1@5->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	self 
		should: [ marsRover process: 'f00' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover repeatTwiceDigitErrorDescription.
			self assert: (marsRover isAt: 1@5 heading: #North) ].
! !

!MarsRoverTest methodsFor: 'tests repetition' stamp: 'LD 12/10/2024 21:13:38'!
test22f1MovesForwardFourTimes

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@3->(Dirt new) with: 1@4->(Dirt new) with: 1@5->(Dirt new) with: 1@6->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'f1'.
	
	self assert: (marsRover isAt: 1@6 heading: #North).! !


!MarsRoverTest methodsFor: 'random' stamp: 'LD 12/10/2024 19:42:32'!
nextInteger: aLimit

	self assert: 10 equals: aLimit.
	self deny: nextIntegers atEnd.
	
	^nextIntegers next.! !


!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:03:15'!
test01EmptyCommandStringDoesNothing

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:03:20'!
test02fWhenHeadingNorthIncrementsY

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@3->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:03:24'!
test03bWhenHeadingNorthDecrementsY

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@1->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:03:26'!
test04rWhenHeadingNorthMakesMarsRoverPointToEast

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:03:29'!
test05lWhenHeadingNorthMakesMarsRovePointToWest

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:03:32'!
test06InvalidCommandsAreNotProcessed

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:03:38'!
test07MoreThanOneCommandAreProcessedCorrectly

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@3->(Dirt new) with: 1@4->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #North on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:03:43'!
test08fWhenHeadingEastIncrementsX

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 2@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #East on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:03:50'!
test09bWhenHeadingEastDecrementsX

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 0@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #East on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:03:52'!
test10rWhenHeadingEastMakesMarsRoverPointToSouth

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #East on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:03:55'!
test11lWhenHeadingEastMakesMarsRoverPointToNorth

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #East on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:04:01'!
test12fbrAreProcessedCorrectlyWhenHeadingSouth

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 1@1->(Dirt new) with: 1@0->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #South on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 1@1 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:04:04'!
test13lWhenHeadingSouthMakesMarsRoverPointToEast

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #South on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:04:13'!
test14fbrAreProcessedCorrectlyWhenHeadingWest

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new) with: 0@2->(Dirt new) with: -1@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #West on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 0@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:04:15'!
test15lWhenHeadingWestMakesMarsRoverPointToSouth

	| marsRover map |
	
	map := Dictionary with: 1@2->(Dirt new).
	marsRover := MarsRover at: 1@2 heading: #West on: map withRandomMovement: [Random nextInteger: 10].
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'LD 12/10/2024 21:04:18'!
test16CanNotCreateAMarsRoverWithAnInvalidHeading

	| map |
	
	map := Dictionary with: 1@2->(Dirt new).

	self 
		should: [MarsRover at: 1@2 heading: #X on: map withRandomMovement: [Random nextInteger: 10] ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: MarsRover invalidCardinalPointErrorDescription equals: anError messageText ]! !


!classDefinition: #MarsRover category: #'2024-2C-Recuperatorio-1'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head map random'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio-1'!

!MarsRover methodsFor: 'exceptions' stamp: 'LD 12/10/2024 18:28:00'!
canNotMoveErrorDescription
	
	^'Can not move to position.'! !

!MarsRover methodsFor: 'exceptions' stamp: 'LD 12/10/2024 20:32:15'!
invalidCommandErrorDescription
	
	^'Invalid command'.! !

!MarsRover methodsFor: 'exceptions' stamp: 'LD 12/10/2024 20:24:20'!
repeatTwiceDigitErrorDescription

	^'Can not repeat digit command twice or more in a row.'! !

!MarsRover methodsFor: 'exceptions' stamp: 'LD 12/10/2024 18:06:46'!
signalCanNotMove
	
	self error: self canNotMoveErrorDescription.! !

!MarsRover methodsFor: 'exceptions' stamp: 'LD 12/10/2024 20:32:12'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription.! !

!MarsRover methodsFor: 'exceptions' stamp: 'LD 12/10/2024 20:24:20'!
signalRepeatTwiceDigit
	
	self error: self repeatTwiceDigitErrorDescription.! !


!MarsRover methodsFor: 'initialization' stamp: 'LD 12/10/2024 20:54:25'!
initializeAt: aPosition heading: aHeading on: aMap withRandomMovement: aRandom

	position := aPosition.
	head := aHeading.
	map := aMap.
	random := aRandom.! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:20'!
headEast
	
	head := MarsRoverHeadingEast new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:16:30'!
headNorth
	
	head := MarsRoverHeadingNorth new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:16:05'!
headSouth
	
	head := MarsRoverHeadingSouth new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:38'!
headWest
	
	head := MarsRoverHeadingWest new! !

!MarsRover methodsFor: 'heading' stamp: 'LD 12/10/2024 21:53:15'!
rotateLeft
	
	self validateSoilAtPositionIsNotARock.
	
	head rotateLeft: self.! !

!MarsRover methodsFor: 'heading' stamp: 'LD 12/10/2024 21:53:01'!
rotateRight
	
	self validateSoilAtPositionIsNotARock.
	
	head rotateRight: self.! !

!MarsRover methodsFor: 'heading' stamp: 'LD 12/10/2024 21:53:36'!
validateSoilAtPositionIsNotARock

	| soil |
	
	soil := map at: position.
	soil validateSoilIsNotARockOn: self.! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 8/22/2019 12:00:30'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ head isHeading: aCardinalPoint ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving soil' stamp: 'LD 12/10/2024 20:50:11'!
moveOnDirtWithDirection: aDirection

	position := position + aDirection.! !

!MarsRover methodsFor: 'moving soil' stamp: 'LD 12/10/2024 20:50:26'!
moveOnIceWithDirection: aDirection

	position := position + (aDirection * (random nextInteger: 10))! !

!MarsRover methodsFor: 'moving soil' stamp: 'LD 12/10/2024 21:30:03'!
moveOnRock

	self signalCanNotMove.! !


!MarsRover methodsFor: 'private' stamp: 'LD 12/10/2024 21:37:51'!
moveWithDirection: aDirection

	| positionToMove soil |
	
	positionToMove := position + aDirection.
	soil := map at: positionToMove.
	
	soil establishFormToMove: self withDirection: aDirection.! !

!MarsRover methodsFor: 'private' stamp: 'LD 12/10/2024 21:43:19'!
repeatManyTimesAs: aNumberOfTimesToBeRepeated LastCommand: aLastCommand

	(aLastCommand isDigit) ifTrue: [ self signalRepeatTwiceDigit ].
		
	^aNumberOfTimesToBeRepeated timesRepeat: [ self processCommand: aLastCommand ].! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward
	
	head moveBackward: self! !

!MarsRover methodsFor: 'moving' stamp: 'LD 12/10/2024 21:31:35'!
moveEast
	
	self moveWithDirection: 1@0.! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:55'!
moveForward
	
	head moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'LD 12/10/2024 21:31:04'!
moveNorth
	
	self moveWithDirection: 0@1.! !

!MarsRover methodsFor: 'moving' stamp: 'LD 12/10/2024 21:31:30'!
moveSouth
	
	self moveWithDirection: 0@-1.! !

!MarsRover methodsFor: 'moving' stamp: 'LD 12/10/2024 21:31:43'!
moveWest
	
	self moveWithDirection: -1@0.! !


!MarsRover methodsFor: 'command processing' stamp: 'LD 12/10/2024 20:06:37'!
process: aSequenceOfCommands
	
	| lastCommand |
	
	lastCommand := $0.

	aSequenceOfCommands do: [:aCommand | 
		self processCommand: aCommand withLastCommand: lastCommand.
		lastCommand := aCommand ].
! !

!MarsRover methodsFor: 'command processing' stamp: 'LD 12/10/2024 18:18:00'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !

!MarsRover methodsFor: 'command processing' stamp: 'LD 12/10/2024 21:43:19'!
processCommand: aCommand withLastCommand: aLastCommand
	
	(aCommand isDigit) ifTrue: [
		^self repeatManyTimesAs: (aCommand digitValue + 2) LastCommand: aLastCommand.
	].

	^self processCommand: aCommand.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'2024-2C-Recuperatorio-1'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'LD 12/10/2024 19:31:20'!
at: aPosition heading: aCardinalPoint on: aMap withRandomMovement: aRandom.
	
	^self new initializeAt: aPosition heading: (MarsRoverHeading heading: aCardinalPoint) on: aMap withRandomMovement: aRandom.! !

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #MarsRoverHeading category: #'2024-2C-Recuperatorio-1'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio-1'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:06:17'!
rotateLeft: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:08:23'!
rotateRight: aMarsRover

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 7/2/2018 19:07:42'!
isHeading: aCardinalPoint

	^self class isFor: aCardinalPoint! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:54'!
moveForward: aMarsRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: #'2024-2C-Recuperatorio-1'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'cardinal point' stamp: 'HAW 7/2/2018 19:07:01'!
cardinalPoint

	self subclassResponsibility ! !


!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:02:00'!
heading: aCardinalPoint

	^self subclasses 
		detect: [ :aMarsRoverPositionClass | aMarsRoverPositionClass isFor: aCardinalPoint ]
		ifFound: [ :aMarsRoverPositionClass | aMarsRoverPositionClass new ]
		ifNone: [ self error: MarsRover invalidCardinalPointErrorDescription ]! !


!MarsRoverHeading class methodsFor: 'testing' stamp: 'HAW 7/2/2018 17:01:33'!
isFor: aCardinalPoint

	^self cardinalPoint = aCardinalPoint ! !


!classDefinition: #MarsRoverHeadingEast category: #'2024-2C-Recuperatorio-1'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio-1'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:19'!
moveBackward: aMarsRover
	
	^aMarsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:28'!
moveForward: aMarsRover
	
	^aMarsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:42'!
rotateLeft: aMarsRover
	
	^aMarsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:54'!
rotateRight: aMarsRover
	
	^aMarsRover headSouth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingEast class' category: #'2024-2C-Recuperatorio-1'!
MarsRoverHeadingEast class
	instanceVariableNames: ''!

!MarsRoverHeadingEast class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:01:53'!
cardinalPoint

	^#East! !


!classDefinition: #MarsRoverHeadingNorth category: #'2024-2C-Recuperatorio-1'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio-1'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:12'!
moveBackward: aMarsRover
	
	^aMarsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:23'!
moveForward: aMarsRover
	
	^aMarsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:40'!
rotateLeft: aMarsRover
	
	^aMarsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:51'!
rotateRight: aMarsRover
	
	^aMarsRover headEast! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingNorth class' category: #'2024-2C-Recuperatorio-1'!
MarsRoverHeadingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadingNorth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:11'!
cardinalPoint

	^#North! !


!classDefinition: #MarsRoverHeadingSouth category: #'2024-2C-Recuperatorio-1'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio-1'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:15'!
moveBackward: aMarsRover
	
	^aMarsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:25'!
moveForward: aMarsRover
	
	^aMarsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:55'!
rotateLeft: aMarsRover
	
	^aMarsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:50'!
rotateRight: aMarsRover
	
	^aMarsRover headWest! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingSouth class' category: #'2024-2C-Recuperatorio-1'!
MarsRoverHeadingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadingSouth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:17'!
cardinalPoint

	^#South! !


!classDefinition: #MarsRoverHeadingWest category: #'2024-2C-Recuperatorio-1'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio-1'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:07'!
moveBackward: aMarsRover

	^aMarsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:15'!
moveForward: aMarsRover
	
	^aMarsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:26'!
rotateLeft: aMarsRover
	
	^aMarsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:41'!
rotateRight: aMarsRover
	
	^aMarsRover headNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: #'2024-2C-Recuperatorio-1'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #Soil category: #'2024-2C-Recuperatorio-1'!
Object subclass: #Soil
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio-1'!

!Soil methodsFor: 'validation' stamp: 'LD 12/10/2024 21:53:36'!
validateSoilIsNotARockOn: aMarsRover

	self subclassResponsibility.! !


!Soil methodsFor: 'moving' stamp: 'LD 12/10/2024 21:06:52'!
establishFormToMove: aMarsRover withDirection: aDirection

	self subclassResponsibility.! !


!classDefinition: #Dirt category: #'2024-2C-Recuperatorio-1'!
Soil subclass: #Dirt
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio-1'!

!Dirt methodsFor: 'validation' stamp: 'LD 12/10/2024 21:53:36'!
validateSoilIsNotARockOn: aMarsRover

	^self.	! !


!Dirt methodsFor: 'moving' stamp: 'LD 12/10/2024 20:49:21'!
establishFormToMove: aMarsRover withDirection: aDirection

	aMarsRover moveOnDirtWithDirection: aDirection.! !


!classDefinition: #Ice category: #'2024-2C-Recuperatorio-1'!
Soil subclass: #Ice
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio-1'!

!Ice methodsFor: 'validation' stamp: 'LD 12/10/2024 21:53:36'!
validateSoilIsNotARockOn: aMarsRover

	^self.	! !


!Ice methodsFor: 'moving' stamp: 'LD 12/10/2024 20:49:05'!
establishFormToMove: aMarsRover withDirection: aDirection

	aMarsRover moveOnIceWithDirection: aDirection.! !


!classDefinition: #Rock category: #'2024-2C-Recuperatorio-1'!
Soil subclass: #Rock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio-1'!

!Rock methodsFor: 'moving' stamp: 'LD 12/10/2024 21:30:03'!
establishFormToMove: aMarsRover withDirection: aDirection

	aMarsRover moveOnRock.! !


!Rock methodsFor: 'validation' stamp: 'LD 12/10/2024 21:53:36'!
validateSoilIsNotARockOn: aMarsRover

	aMarsRover moveOnRock.! !
