!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'MP 9/10/2024 21:47:53'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook action |
	
	customerBook := CustomerBook new.
	action := [customerBook addCustomerNamed: 'John Lennon'.].
	
	self assertDoesThisAction: action takeLessThan: 50 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MP 9/10/2024 21:48:17'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney action |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.

	customerBook addCustomerNamed: paulMcCartney.
	action := [customerBook removeCustomerNamed: paulMcCartney.].
	
	self assertDoesThisAction: action takeLessThan: 100 * millisecond
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MP 9/12/2024 23:06:07'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook action actionOnError |
			
	customerBook := CustomerBook new.
	
	action := [ customerBook addCustomerNamed: ''].
	actionOnError := [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ].

	self should: action raise: Error withExceptionDo: actionOnError.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MP 9/12/2024 23:45:21'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon action actionOnError |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	action := [ customerBook removeCustomerNamed: 'Paul McCartney'.].
	actionOnError := [ :anError | 
			self assertCustomerBook: customerBook hasOneCustomerNamed: johnLennon ].
		
	self should: action raise: NotFound withExceptionDo: actionOnError.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MP 9/13/2024 00:08:33'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertCustomerBookWithZeroActiveCustomers: customerBook hasSuspendedAndTotalCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MP 9/13/2024 00:08:40'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertCustomerBookWithZeroActiveCustomers: customerBook hasSuspendedAndTotalCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MP 9/12/2024 23:45:21'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon action actionOnError |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	
	action := [ customerBook suspendCustomerNamed: 'Ringo Starr'].
	actionOnError := [ :anError | 
			self assertCustomerBook: customerBook hasOneCustomerNamed: johnLennon ].
		
	self should: action raise: CantSuspend withExceptionDo: actionOnError.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MP 9/12/2024 23:45:21'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon action actionOnError |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	action := [ customerBook suspendCustomerNamed: johnLennon].
	actionOnError := [ :anError | 
			self assertCustomerBook: customerBook hasOneCustomerNamed: johnLennon ].
		
	self should: action raise: CantSuspend withExceptionDo: actionOnError.
	! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'MP 9/12/2024 23:57:46'!
assertCustomerBook: customerBook hasNumberOfCustomers: number

	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: number equals: customerBook numberOfSuspendedCustomers.
	self assert: number equals: customerBook numberOfCustomers! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'MP 9/12/2024 23:45:42'!
assertCustomerBook: customerBook hasOneCustomerNamed: customerName

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: customerName).! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'MP 9/13/2024 00:07:08'!
assertCustomerBookWithZeroActiveCustomers: customerBook hasSuspendedAndTotalCustomers: number

	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: number equals: customerBook numberOfSuspendedCustomers.
	self assert: number equals: customerBook numberOfCustomers! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'MP 9/13/2024 00:10:11'!
assertDoesThisAction: anAction takeLessThan: timeExpected
	| time |
	time := self howLongDoesThisActionTakes: anAction.
	
	self assert: time < timeExpected! !


!CustomerBookTest methodsFor: 'auxiliary' stamp: 'MP 9/13/2024 00:10:38'!
howLongDoesThisActionTakes: anAction 
	| millisecondsBeforeRunning millisecondsAfterRunning |
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	anAction value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^millisecondsAfterRunning - millisecondsBeforeRunning! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'MP 9/13/2024 01:21:45'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MP 9/13/2024 14:31:58'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MP 9/13/2024 14:23:17'!
remove: aName inThisCollection: collection
 
	1 to: collection size do: 
	[ :index |
		aName = (collection at: index)
			ifTrue: [
				collection removeAt: index.
				^ aName 
			] 
	].

	^ nil
! !

!CustomerBook methodsFor: 'customer management' stamp: 'MP 9/13/2024 14:34:10'!
removeCustomerNamed: aName 
 
	| name |
	
	name := self remove: aName inThisCollection: active.
	name ifNotNil: [ ^ name ].
	
	name := self remove: aName inThisCollection: suspended.
	name ifNotNil: [ ^ name ].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'MP 9/13/2024 14:53:12'!
signalCustomerAlreadyExists 

	self throwErrorWithMessage: #customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'MP 9/13/2024 14:53:25'!
signalCustomerNameCannotBeEmpty 
	
	self throwErrorWithMessage: #customerCanNotBeEmptyErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

!CustomerBook methodsFor: 'customer management' stamp: 'MP 9/13/2024 15:03:14'!
throwErrorWithMessage: classMethodThatReturnsAMessage
	
	self error:  (self class perform: classMethodThatReturnsAMessage)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
