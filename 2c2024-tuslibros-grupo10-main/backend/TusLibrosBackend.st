!classDefinition: #CartTest category: #'TusLibrosBackend-Test'!
TestCase subclass: #CartTest
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Test'!

!CartTest methodsFor: 'setUp' stamp: 'LD 11/15/2024 19:59:45'!
setUp
	
	| catalog |
	
	catalog := Dictionary with: 'XP'->50 with: 'TDD'->5.
	cart := Cart createWithCatalog: catalog.! !


!CartTest methodsFor: 'assertions' stamp: 'LD 11/8/2024 14:08:38'!
assertAddingToCartTheBook: aBook withAQuantityOf: aBookQuantity containsAQuantiyOfCopiesEqualsTo: aBookQuantityOfCopies
	
	cart add: aBook quantity: aBookQuantity.
	
	self assert: (cart has: aBook withAQuantityOf: aBookQuantityOfCopies).! !


!CartTest methodsFor: 'tests' stamp: 'LD 11/6/2024 12:57:58'!
test01NewCartStartsEmpty
	
	self assert: (cart isEmpty).! !

!CartTest methodsFor: 'tests' stamp: 'LD 11/8/2024 14:09:22'!
test02CartContainsABookAfterAddingIt
	
	self assertAddingToCartTheBook: 'XP' withAQuantityOf: 1 containsAQuantiyOfCopiesEqualsTo: 1.
	self deny: (cart isEmpty).! !

!CartTest methodsFor: 'tests' stamp: 'LD 11/8/2024 14:09:27'!
test03CartContainsTwoBooksAfterAddingThem
	
	self assertAddingToCartTheBook: 'XP' withAQuantityOf: 1 containsAQuantiyOfCopiesEqualsTo: 1.
	self assertAddingToCartTheBook: 'TDD' withAQuantityOf: 1 containsAQuantiyOfCopiesEqualsTo: 1.! !

!CartTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:08:10'!
test04AddingABookThatIsNotInTheCatalogShouldRaiseAnError
	
	self should: [cart add: 'Design Patterns' quantity: 1]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = Cart bookNotInTheCatalogErrorMessage ].! !

!CartTest methodsFor: 'tests' stamp: 'LD 11/8/2024 14:09:38'!
test05CartContainsTwoCopiesOfTheSameBookAfterAddingThem
	
	self assertAddingToCartTheBook: 'XP' withAQuantityOf: 2 containsAQuantiyOfCopiesEqualsTo: 2.! !

!CartTest methodsFor: 'tests' stamp: 'LD 11/8/2024 14:09:44'!
test06CartWithTwoCopiesOfTheSameBookContainsThreeCopiesAfterAddingTheSameOne
	
	cart add: 'XP' quantity: 2.

	self assertAddingToCartTheBook: 'XP' withAQuantityOf: 1 containsAQuantiyOfCopiesEqualsTo: 3.! !

!CartTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:08:15'!
test07AddingAnInvalidQuantityOfBooksShouldRaiseError
	
	self should: [cart add: 'XP' quantity: 0]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = Cart bookQuantityInvalidErrorMessage ].
	
	self should: [cart add: 'XP' quantity: -1]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = Cart bookQuantityInvalidErrorMessage ].! !


!classDefinition: #InnerRestInterfaceTest category: #'TusLibrosBackend-Test'!
TestCase subclass: #InnerRestInterfaceTest
	instanceVariableNames: 'interface authSystem paymentSystem catalog systemTime system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Test'!

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/12/2024 16:29:34'!
test01InterfaceRequestForCreatingACartReturnsStatus201AndBodyOk
	
	| response requestFields |
	
	requestFields := Dictionary with: 'userId'->'1' with: 'password'->'alumno'.
	response := interface createCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 201 andBody: '0|OK' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/12/2024 16:29:41'!
test02InterfaceRequestForAddingABookToACartReturnsStatus200AndBodyOk
	
	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	
	requestFields := Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1'.
	response := interface addToCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 200 andBody: '0|OK' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 11:29:43'!
test03InterfaceRequestForAddingABookToACartNotCreatedReturnsStatus422AndBodyErrorMessage
	
	| response requestFields |
	
	requestFields := Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1'.
	response := interface addToCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 422 andBody: ('1|', System addBookToNonExistingCartErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/12/2024 16:29:50'!
test04InterfaceRequestForListingAnEmptyCartReturnsStatus200AndBody0
	
	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	
	requestFields := Dictionary with: 'userId' -> '1'.
	response := interface listCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 200 andBody: '0' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/12/2024 16:29:59'!
test05InterfaceRequestForListingACartThatHasOneBookReturnsStatus200AndBodyWithBookAndQuantity
	
	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	
	requestFields := Dictionary with: 'userId' -> '1'.
	response := interface listCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 200 andBody: '0|XP|1' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/12/2024 16:30:05'!
test06InterfaceRequestForListingACartThatHasTwoBooksReturnsStatus200AndBodyWithBooksAndQuantity
	
	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'TDD' with: 'bookQuantity' -> '1').
	
	requestFields := Dictionary with: 'userId' -> '1'.
	response := interface listCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 200 andBody: '0|TDD|1|XP|1' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 11:31:57'!
test07InterfaceRequestForListingACartNotCreatedReturnsStatus422AndBodyErrorMessage
	
	| response requestFields |
	
	requestFields := Dictionary with: 'userId' -> '1'.
	response := interface listCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 422 andBody: ('1|', System listNonExistingCartErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 11:32:17'!
test08InterfaceRequestForAddingABookThatIsNotInTheCatalogReturnsStatus422AndBodyErrorMessage
	
	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	
	requestFields := Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'Design Patterns' with: 'bookQuantity' -> '1'.
	response := interface addToCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 422 andBody: ('1|', Cart bookNotInTheCatalogErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'MP 11/12/2024 18:56:40'!
test09InterfaceRequestForListingACartThatHasTwoCopiesOfTheSameBookReturnsStatus200AndBodyWithBooksAndQuantity
	
	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '2').
	
	requestFields := Dictionary with: 'userId' -> '1'.
	response := interface listCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 200 andBody: '0|XP|2' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/12/2024 16:30:29'!
test10InterfaceRequestForAddingTwoCopiesOfTheSameBookReturnsStatus200AndBodyOk
	
	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	
	requestFields := Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '2'.
	response := interface addToCart: requestFields.

	self assertInnerInterface: interface hasStatusCode: 200 andBody: '0|OK' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 11:31:52'!
test11InterfaceRequestForAddingABookWithAnInvalidQuantityReturnsStatus422AndBodyErrorMessage
	
	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	
	requestFields := Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '0'.
	response := interface addToCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 422 andBody: ('1|', Cart bookQuantityInvalidErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 13:03:27'!
test12InterfaceRequestForCreatingACartForAnInvalidUserIdAndPasswordShouldReturnStatus422AndBodyErrorMessage

	| response requestFields invalidAuthSystem |
	
	invalidAuthSystem := AuthSystemStub createWithBehaviour: [ :aUser :aPassword | self error: 'Error al validar el usuario y la contrasenia.' ].
	system := System createWithCatalog: catalog andAuthSystem: invalidAuthSystem andPaymentSystem: paymentSystem andSystemTime: systemTime.
	interface := InnerRestInterface createWithSystem: system.
	
	requestFields := Dictionary with: 'userId'->'1' with: 'password'->'alumno'.
	response := interface createCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 422 andBody: '1|Error al validar el usuario y la contrasenia.' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:03:25'!
test13InterfaceRequestForAddingABookWithEmptyParametersReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	
	requestFields := Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> ''.
	response := interface addToCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface emptyParametersErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:04:12'!
test14InterfaceRequestForAddingABookWithAnInvalidBookQuantityReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	
	requestFields := Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> 'X'.
	response := interface addToCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface bookQuantityErrorMessage ) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:03:29'!
test15InterfaceRequestForListingACartWithEmptyParametersReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	requestFields := Dictionary with: 'userId' -> ''.
	response := interface listCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface emptyParametersErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:03:33'!
test16InterfaceRequestForCreatingACartWithEmptyParametersReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	requestFields := Dictionary with: 'userId'->'' with: 'password'->''.
	response := interface createCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface emptyParametersErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:04:31'!
test17InterfaceIncompleteRequestForAddingABookWithMissingParametersReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	requestFields := Dictionary with: 'userId'->'pepe' with: 'bookIsbn'->'XP'.
	response := interface addToCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface missingParametersErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:04:41'!
test18InterfaceIncompleteRequestForCreatingACartWithMissingParametersReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	requestFields := Dictionary with: 'userId'->'pepe'.
	response := interface createCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface missingParametersErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:04:45'!
test19InterfaceIncompleteRequestForListingACartWithMissingParametersReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	requestFields := Dictionary new.
	response := interface listCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface missingParametersErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:05:25'!
test20InterfaceRequestCheckingOutForAnEmptyCartReturnsStatus422AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	
	requestFields := Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cced'->'122024' with: 'cco'->'pepe gomez'.
	response := interface checkOutCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 422 andBody: ('1|', Cashier cartIsEmptyErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:05:52'!
test21InterfaceRequestCheckingOutForACartWithACardThatHasAnInvalidMonthForExpirationDateReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	
	requestFields := Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cced'->'132025' with: 'cco'->'pepe gomez'.
	response := interface checkOutCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface invalidExpirationDateOfCardErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:06:47'!
test22InterfaceRequestCheckingOutForACartWithACardThatHasAnInvalidExpirationDateReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	
	requestFields := Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cced'->'x' with: 'cco'->'pepe gomez'.
	response := interface checkOutCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface invalidExpirationDateOfCardErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:06:56'!
test23InterfaceRequestCheckingOutForACartWithACardThatHasAnInvalidExpirationDateLengthReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	
	requestFields := Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cced'->'1220251' with: 'cco'->'pepe gomez'.
	response := interface checkOutCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface invalidExpirationDateOfCardErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:04:58'!
test24InterfaceIncompleteRequestForCheckingOutACartWithMissingParametersReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	
	requestFields := Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cco'->'pepe gomez'.
	response := interface checkOutCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface missingParametersErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/28/2024 11:59:19'!
test25InterfaceRequestCheckingOutForACartWithABookReturnsStatus200

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	
	requestFields := Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cced'->'122025' with: 'cco'->'pepe gomez'.
	response := interface checkOutCart: requestFields.
	
	self assert: (interface response: response hasStatus: 200).! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:06:12'!
test26InterfaceRequestForCheckingOutACartWithAnExpiredCardReturnsStatus422AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	
	requestFields := Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cced'->'122023' with: 'cco'->'pepe gomez'.
	response := interface checkOutCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 422 andBody: ('1|', Cashier cardIsExpiredErrorMessage ) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:03:44'!
test27InterfaceRequestForCheckingOutACartWithEmptyParametersReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	
	requestFields := Dictionary with: 'userId'->'' with: 'ccn'->'' with: 'cced'->'' with: 'cco'->'pepe gomez'.
	response := interface checkOutCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface emptyParametersErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 11:32:04'!
test28InterfaceRequestForCheckingOutForACartWithACardThatHasAnInvalidCardNumberReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	
	requestFields := Dictionary with: 'userId'->'1' with: 'ccn'->'x' with: 'cced'->'122025' with: 'cco'->'pepe gomez'.
	response := interface checkOutCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface invalidCardNumberErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 13:09:30'!
test29InterfaceRequestForListingCartAfterThirtyMinutesOfInnactivityReturnsStatus419AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	systemTime setAdditionalTime: 30 * minute.
	
	requestFields := Dictionary with: 'userId' -> '1'.
	response := interface listCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 422 andBody: ('1|', System sessionIsExpiredErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 13:09:32'!
test30InterfaceRequestForAddingABookToACartAfterThirtyMinutesOfInnactivityReturnsStatus419AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	systemTime setAdditionalTime: 30 * minute.
	
	requestFields := (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	response := interface addToCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 422 andBody: ('1|', System sessionIsExpiredErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/25/2024 13:09:34'!
test31InterfaceRequestForCheckingOutACartAfterThirtyMinutesOfInnactivityReturnsStatus419AndBodyErrorMessage

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	systemTime setAdditionalTime: 30 * minute.
	
	requestFields := Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cced'->'122024' with: 'cco'->'pepe gomez'.
	response := interface checkOutCart: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 422 andBody: ('1|', System sessionIsExpiredErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'MP 11/28/2024 22:58:02'!
test32InterfaceRequestForListingPurchasesReturnsStatus200AndBodyWithBooksTheirQuantityAndTotal

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	interface checkOutCart: (Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cced'->'122025' with: 'cco'->'pepe gomez').
	
	requestFields := Dictionary with: 'userId' -> '1' with: 'password'->'alumno'.
	response := interface listPurchases: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 200 andBody: '0|XP|1|50' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/29/2024 09:50:07'!
test33InterfaceRequestForListingPurchasesOfAUserThatHasDoneMultiplePurchasesReturnsStatus200AndBodyWithBooksTheirQuantityAndTotal

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'TDD' with: 'bookQuantity' -> '3').
	interface checkOutCart: (Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cced'->'122025' with: 'cco'->'pepe gomez').
	
	requestFields := Dictionary with: 'userId' -> '1' with: 'password'->'alumno'.
	response := interface listPurchases: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 200 andBody: '0|TDD|3|XP|1|65' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'LD 11/29/2024 09:51:16'!
test34InterfaceRequestForListingPurchasesOfAUserThatHasDoneMultiplePurchasesAtDifferentMomentsReturnsStatus200AndBodyWithBooksTheirQuantityAndTotal

	| response requestFields |
	
	interface createCart: (Dictionary with: 'userId' -> '1' with: 'password' -> 'alumno').
	
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1').
	interface checkOutCart: (Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cced'->'122025' with: 'cco'->'pepe gomez').
	
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'XP' with: 'bookQuantity' -> '1'). 
	interface addToCart: (Dictionary with: 'userId' -> '1' with: 'bookIsbn' -> 'TDD' with: 'bookQuantity' -> '3').
	interface checkOutCart: (Dictionary with: 'userId'->'1' with: 'ccn'->'1' with: 'cced'->'122025' with: 'cco'->'pepe gomez').
	
	requestFields := Dictionary with: 'userId' -> '1' with: 'password'->'alumno'.
	response := interface listPurchases: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 200 andBody: '0|TDD|3|XP|2|115' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'MP 11/29/2024 00:09:02'!
test35InterfaceRequestForListingPurchasesOfAUserWithInvalidCredetentialsReturnsStatus422AndBodyErrorMessage

	| response requestFields invalidAuthSystem |
	
	invalidAuthSystem := AuthSystemStub createWithBehaviour: [ :aUser :aPassword | self error: 'Error al validar el usuario y la contrasenia.' ].
	system := System createWithCatalog: catalog andAuthSystem: invalidAuthSystem andPaymentSystem: paymentSystem andSystemTime: systemTime.
	interface := InnerRestInterface createWithSystem: system.
	
	requestFields := Dictionary with: 'userId'->'1' with: 'password'->'alumno'.
	response := interface listPurchases: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 422 andBody: '1|Error al validar el usuario y la contrasenia.' for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'MP 11/29/2024 14:24:02'!
test36InterfaceRequestForListingPurchasesOfAUserWithMissingParametersReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	requestFields := Dictionary with: 'userId'->'1'.
	response := interface listPurchases: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface missingParametersErrorMessage) for: response.! !

!InnerRestInterfaceTest methodsFor: 'tests' stamp: 'MP 11/29/2024 14:26:23'!
test37InterfaceRequestForListingPurchasesOfAUserWithEmptyParametersReturnsStatus400AndBodyErrorMessage

	| response requestFields |
	
	requestFields := Dictionary with: 'userId'->'1' with: 'password'->''.
	response := interface listPurchases: requestFields.
	
	self assertInnerInterface: interface hasStatusCode: 400 andBody: ('1|', InnerRestInterface emptyParametersErrorMessage) for: response.! !


!InnerRestInterfaceTest methodsFor: 'setUp' stamp: 'MP 11/24/2024 21:01:46'!
setUp

	authSystem := AuthSystemStub createWithBehaviour: [ :aUser :aPassword | true ].
	paymentSystem := PaymentSystemStub createWithBehaviour: [ :anAmount :aCardNumber :anExpirationDate :aCardOwner | true ].
	catalog := Dictionary with: 'XP'->50 with: 'TDD'->5.
	systemTime := SystemTime withExpiratonTime: 30 * minute.
	
	system := System createWithCatalog: catalog andAuthSystem: authSystem andPaymentSystem: paymentSystem andSystemTime: systemTime.
	
	interface := InnerRestInterface createWithSystem: system.
! !


!InnerRestInterfaceTest methodsFor: 'assertions' stamp: 'LD 11/8/2024 14:13:49'!
assertInnerInterface:  aInnerInterface hasStatusCode: aStatusCode andBody: aBody for: aResponse

	self assert: (aInnerInterface response: aResponse hasStatus: aStatusCode andBody: aBody).! !


!classDefinition: #SystemTest category: #'TusLibrosBackend-Test'!
TestCase subclass: #SystemTest
	instanceVariableNames: 'system catalog paymentSystem authSystem systemTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Test'!

!SystemTest methodsFor: 'setUp' stamp: 'MP 11/24/2024 21:01:46'!
setUp

	authSystem := AuthSystemStub createWithBehaviour: [ :aUser :aPassword | true ].
	paymentSystem := PaymentSystemStub createWithBehaviour: [ :anAmount :aCardNumber :anExpirationDate :aCardOwner | true ].
	
	catalog := Dictionary with: 'XP'->50 with: 'TDD'->5.
	
	systemTime := SystemTime withExpiratonTime: 30 * minute.
	system := System createWithCatalog: catalog andAuthSystem: authSystem andPaymentSystem: paymentSystem andSystemTime: systemTime.
	! !


!SystemTest methodsFor: 'tests' stamp: 'LD 11/9/2024 20:09:13'!
test01SystemCreatesAnEmptyCartForUserWithAPassword

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	
	self assert: (system cartOfUserIsEmpty: 'pepe').! !

!SystemTest methodsFor: 'tests' stamp: 'MP 11/8/2024 19:40:09'!
test02SystemAddsABookToAUserCart
	
	system createCartForUser: 'pepe' withPassword: 'alumno'.
	
	self assertAddingToUserCart: 'pepe' theBook: 'XP' withAQuantityOf: 1 containsAQuantiyOfCopiesEqualsTo: 1.
	self deny: (system cartOfUserIsEmpty: 'pepe').! !

!SystemTest methodsFor: 'tests' stamp: 'MP 11/8/2024 19:40:09'!
test03SystemAddsTwoBooksToAUserCart

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	
	self assertAddingToUserCart: 'pepe' theBook: 'XP' withAQuantityOf: 1 containsAQuantiyOfCopiesEqualsTo: 1.
	self assertAddingToUserCart: 'pepe' theBook: 'TDD' withAQuantityOf: 1 containsAQuantiyOfCopiesEqualsTo: 1.! !

!SystemTest methodsFor: 'tests' stamp: 'MP 11/8/2024 19:40:09'!
test04SystemHandlesMultipleUsers

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	system createCartForUser: 'fito' withPassword: 'alumno'.
	
	self assertAddingToUserCart: 'pepe' theBook: 'XP' withAQuantityOf: 1 containsAQuantiyOfCopiesEqualsTo: 1.
	self assertAddingToUserCart: 'pepe' theBook: 'TDD' withAQuantityOf: 1 containsAQuantiyOfCopiesEqualsTo: 1.
	self assertAddingToUserCart: 'fito' theBook: 'XP' withAQuantityOf: 1 containsAQuantiyOfCopiesEqualsTo: 1.! !

!SystemTest methodsFor: 'tests' stamp: 'MP 11/8/2024 19:40:09'!
test05SystemAddsTwoCopiesOfTheSameBookToAUserCart

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	
	self assertAddingToUserCart: 'pepe' theBook: 'XP' withAQuantityOf: 2 containsAQuantiyOfCopiesEqualsTo: 2.! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:08:29'!
test06SystemAddingABookNotInTheCatalogToAUserCartShouldRaiseError

	system createCartForUser: 'pepe' withPassword: 'alumno'.

	self should: [system addBook: 'Design Patterns' quantity: 1 toCartOfUser: 'pepe'.]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = Cart bookNotInTheCatalogErrorMessage ].! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:08:32'!
test07SystemAddingAnInvalidQuantityOfCopiesOfABookToAUserCartShouldRaiseError

	system createCartForUser: 'pepe' withPassword: 'alumno'.

	self should: [system addBook: 'XP' quantity: 0 toCartOfUser: 'pepe'.]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = Cart bookQuantityInvalidErrorMessage ].! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/25/2024 12:08:34'!
test08SystemAddingABookToANonExistingUserCartShouldRaiseError

	self should: [system addBook: 'XP' quantity: 1 toCartOfUser: 'pepe'.]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = System addBookToNonExistingCartErrorMessage ].! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:26:27'!
test09SystemListingACartToANonExistingUserCartShouldRaiseError

	self should: [system listCartOfUser: 'pepe']
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = System listNonExistingCartErrorMessage ].! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:32:45'!
test10SystemListingACartShouldReturnSaidContentOfCart

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	system addBook: 'XP' quantity: 1 toCartOfUser: 'pepe'.
		
	self assert: (system listCartOfUser: 'pepe') 
		equals: (Bag with: 'XP').! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:27:01'!
test11SystemCreatingACartForAnInvalidUserWithPasswordShouldRaiseError

	| invalidAuthSystem |
	
	invalidAuthSystem := AuthSystemStub createWithBehaviour: [ :aUser :aPassword | self error: 'Error al validar el usuario y la contrasenia.' ].
	system := System createWithCatalog: catalog andAuthSystem: invalidAuthSystem andPaymentSystem: paymentSystem andSystemTime: systemTime.

	self should: [system createCartForUser: 'pepe' withPassword: 'erroneo' ]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = 'Error al validar el usuario y la contrasenia.' ].
		
	self should: [system createCartForUser: 'erroneo' withPassword: 'alumno' ]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = 'Error al validar el usuario y la contrasenia.' ].! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:26:52'!
test12SystemCheckingOutAnEmptyCartShouldRaiseError

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	
	self should: [ system checkOutCartOfUser: 'pepe' withCardNumber: '1' andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez' ]
		raise: Error-MessageNotUnderstood
		withExceptionDo: [ :exception | self assert: exception messageText = Cashier cartIsEmptyErrorMessage ].! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:26:48'!
test13SystemCheckingOutACartWithAnExpiredCardShouldRaiseError

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	system addBook: 'XP' quantity: 1 toCartOfUser: 'pepe'.
	
	self should: [ system checkOutCartOfUser: 'pepe' withCardNumber: '1' andExpirationDate: (GregorianMonthOfYear octoberOf: 2024) ofOwner: 'pepe gomez' ] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = Cashier cardIsExpiredErrorMessage ].
! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:26:43'!
test14SystemCheckingOutACartWithACardThatDoesNotHaveAvailableShouldRaiseError

	| invalidPaymentSystem | 

	invalidPaymentSystem := PaymentSystemStub createWithBehaviour: [ :aUserId :aCcn :aCced :aCco | self error: 'Error. No hay suficiente monto disponible en la tarjeta.' ].
	system := System createWithCatalog: catalog andAuthSystem: authSystem andPaymentSystem: invalidPaymentSystem andSystemTime: systemTime.
	
	system createCartForUser: 'pepe' withPassword: 'alumno'.
	system addBook: 'XP' quantity: 1 toCartOfUser: 'pepe'.
	
	self should: [ system checkOutCartOfUser: 'pepe' withCardNumber: '1' andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez' ]
		raise: Error-MessageNotUnderstood
		withExceptionDo: [ :exception | self assert: exception messageText = 'Error. No hay suficiente monto disponible en la tarjeta.' ].
! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:26:36'!
test15SystemCheckingOutACartAfterTransactionReturnsATransactionId

	| transactionId |
	system createCartForUser: 'pepe' withPassword: 'alumno'.
	system addBook: 'XP' quantity: 1 toCartOfUser: 'pepe'.
	
	transactionId := system checkOutCartOfUser: 'pepe' withCardNumber: '1' andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez'.
	
	self assert: transactionId notNil.! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:30:05'!
test16SystemCheckingOutACartAfterTransactionReturnsATransactionIdThatIsDifferentFromAnotherTransactionId

	| transactionId1 transactionId2 |
	
	system createCartForUser: 'pepe' withPassword: 'alumno'.
	system addBook: 'XP' quantity: 1 toCartOfUser: 'pepe'.
	transactionId1 := system checkOutCartOfUser: 'pepe' withCardNumber: '1' andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez'.
	
	system createCartForUser: 'fito' withPassword: 'alumno'.
	system addBook: 'TDD' quantity: 1 toCartOfUser: 'fito'.
	transactionId2 := system checkOutCartOfUser: 'fito' withCardNumber: '1' andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'fito gomez'.
	
	self deny: (transactionId1 = transactionId2).! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:32:51'!
test17SystemListingACartAfterThirtyMinutesOfInnactivityShouldRaiseError

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	systemTime setAdditionalTime: 30 * minute.
	
	self should: [ system listCartOfUser: 'pepe' ]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = System sessionIsExpiredErrorMessage ].! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:32:59'!
test18SystemAddingABookToACartAfterThirtyMinutesOfInnactivityShouldRaiseError

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	systemTime setAdditionalTime: 30 * minute.
	
	self should: [ system addBook: 'XP' quantity: 1 toCartOfUser: 'pepe' ]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = System sessionIsExpiredErrorMessage ].
! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:33:03'!
test19SystemCheckingOutACartAfterThirtyMinutesOfInnactivityShouldRaiseError

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	system addBook: 'TDD' quantity: 1 toCartOfUser: 'pepe'.
	
	systemTime setAdditionalTime: 30 * minute.
	
	self should: [ system checkOutCartOfUser: 'pepe' withCardNumber: 123 andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez' ]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = System sessionIsExpiredErrorMessage ].
! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:33:34'!
test20SystemAddingABookResetsLastActivityTimeAndAfterThirtyMinutesOfInnactivityShouldRaiseError

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	systemTime setAdditionalTime: 20 * minute.
	system addBook: 'TDD' quantity: 1 toCartOfUser: 'pepe'.
	
	systemTime setAdditionalTime: 30 * minute.
	
	self should: [ system checkOutCartOfUser: 'pepe' withCardNumber: 123 andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez' ]
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = System sessionIsExpiredErrorMessage ].
! !

!SystemTest methodsFor: 'tests' stamp: 'MP 11/28/2024 22:44:47'!
test21SystemListingPurchasesForAUserWithoutPreviousPurchasesShouldHaveTotalAmountZero

	self assert: (system listPurchasesOfUser: 'pepe' withPassword: 'alumno') 
		equals: (Dictionary with: 'totalAmount'->0).
! !

!SystemTest methodsFor: 'tests' stamp: 'MP 11/28/2024 23:53:58'!
test22SystemListingPurchasesForAUserWithOnePurchaseShouldHaveThatPurchaseAndTotal

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	system addBook: 'TDD' quantity: 1 toCartOfUser: 'pepe'.
	system checkOutCartOfUser: 'pepe' withCardNumber: 123 andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez'.
	
	self assert: (system listPurchasesOfUser: 'pepe' withPassword: 'alumno') 
		equals: (Dictionary with: 'TDD'->1 with: 'totalAmount'->5).! !

!SystemTest methodsFor: 'tests' stamp: 'MP 11/28/2024 23:53:39'!
test23SystemListingPurchasesForAUserWithTwoPurchasesOfTheSameBookShouldHaveThosePurchasesAndTotal

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	
	system addBook: 'TDD' quantity: 1 toCartOfUser: 'pepe'.
	system addBook: 'TDD' quantity: 1 toCartOfUser: 'pepe'.
	
	system checkOutCartOfUser: 'pepe' withCardNumber: 123 andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez'.
	
	self assert: (system listPurchasesOfUser: 'pepe' withPassword: 'alumno') 
		equals: (Dictionary with: 'TDD'->2 with: 'totalAmount'->10).! !

!SystemTest methodsFor: 'tests' stamp: 'MP 11/28/2024 23:53:33'!
test24SystemListingPurchasesForAUserWithTwoPurchasesOfDifferentBooksShouldHaveThosePurchasesAndTotal

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	
	system addBook: 'TDD' quantity: 1 toCartOfUser: 'pepe'.
	system addBook: 'XP' quantity: 1 toCartOfUser: 'pepe'.
	
	system checkOutCartOfUser: 'pepe' withCardNumber: 123 andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez'.
	
	self assert: (system listPurchasesOfUser: 'pepe' withPassword: 'alumno') 
		equals: (Dictionary with: 'XP'->1 with: 'TDD'->1 with: 'totalAmount'->55).! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/29/2024 09:51:50'!
test25SystemListingPurchasesForAUserWithTwoPurchasesAtDifferentMomentsShouldHaveThosePurchasesAndTotal

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	system addBook: 'TDD' quantity: 1 toCartOfUser: 'pepe'.
	system addBook: 'XP' quantity: 2 toCartOfUser: 'pepe'.
	system checkOutCartOfUser: 'pepe' withCardNumber: 123 andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez'.
	
	system addBook: 'TDD' quantity: 3 toCartOfUser: 'pepe'.
	system addBook: 'XP' quantity: 4 toCartOfUser: 'pepe'.
	system checkOutCartOfUser: 'pepe' withCardNumber: 123 andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez'.
	
	self assert: (system listPurchasesOfUser: 'pepe' withPassword: 'alumno') 
		equals: (Dictionary with: 'XP'->6 with: 'TDD'->4 with: 'totalAmount'->320).! !

!SystemTest methodsFor: 'tests' stamp: 'MP 11/28/2024 23:41:19'!
test26SystemListingPurchasesForTwoDifferentUsersShoudHaveTheirRespectivePurchaseHistoryAndTotal

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	system createCartForUser: 'fito' withPassword: 'alumno'.
	
	system addBook: 'TDD' quantity: 1 toCartOfUser: 'pepe'.
	system addBook: 'XP' quantity: 2 toCartOfUser: 'pepe'.
	system checkOutCartOfUser: 'pepe' withCardNumber: 123 andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez'.
	
	system addBook: 'TDD' quantity: 5 toCartOfUser: 'fito'.
	system checkOutCartOfUser: 'fito' withCardNumber: 123 andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'fito gomez'.
	
	self assert: (system listPurchasesOfUser: 'pepe' withPassword: 'alumno') 
		equals: (Dictionary with: 'XP'->2 with: 'TDD'->1 with: 'totalAmount'->105).
		
	self assert: (system listPurchasesOfUser: 'fito' withPassword: 'alumno') 
		equals: (Dictionary with: 'TDD'->5 with: 'totalAmount'->25).! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/28/2024 12:34:10'!
test27SystemCannotListPurchasesWhenCredentialsAreInvalid

	| invalidAuthSystem |
	
	invalidAuthSystem := AuthSystemStub createWithBehaviour: [ :aUser :aPassword | self error: 'Error al validar el usuario y la contrasenia.' ].
	system := System createWithCatalog: catalog andAuthSystem: invalidAuthSystem andPaymentSystem: paymentSystem andSystemTime: systemTime.

	self should: [ system listPurchasesOfUser: 'fito' withPassword: 'wrong']
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :exception | self assert: exception messageText = 'Error al validar el usuario y la contrasenia.' ].! !

!SystemTest methodsFor: 'tests' stamp: 'LD 11/29/2024 09:44:13'!
test28SystemCartOfUserAfterCheckingOutIsEmpty

	system createCartForUser: 'pepe' withPassword: 'alumno'.
	
	system addBook: 'TDD' quantity: 1 toCartOfUser: 'pepe'.
	system addBook: 'XP' quantity: 2 toCartOfUser: 'pepe'.
	system checkOutCartOfUser: 'pepe' withCardNumber: 123 andExpirationDate: (GregorianMonthOfYear decemberOf: 2025) ofOwner: 'pepe gomez'.
	
	self assert: (system cartOfUserIsEmpty: 'pepe').! !


!SystemTest methodsFor: 'assertions' stamp: 'LD 11/8/2024 14:11:08'!
assertAddingToUserCart: aUser theBook: aBook withAQuantityOf: aBookQuantity containsAQuantiyOfCopiesEqualsTo: aBookQuantityOfCopies
	
	system addBook: aBook quantity: aBookQuantity toCartOfUser: aUser.
	
	self assert: (system cartOfUser: aUser has: aBook withAQuantityOf: aBookQuantityOfCopies ).! !
!classDefinition: #Cart category: #'TusLibrosBackend-Business'!
Object subclass: #Cart
	instanceVariableNames: 'content catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Business'!

!Cart methodsFor: 'initialization' stamp: 'MP 11/8/2024 20:02:32'!
initializeWith: aCatalog

	content := Bag new.
	catalog := aCatalog.! !


!Cart methodsFor: 'listing' stamp: 'MP 11/8/2024 20:22:34'!
content

	^content.! !


!Cart methodsFor: 'adding' stamp: 'LD 11/25/2024 12:37:46'!
add: aBook quantity: aBookQuantity

	(catalog includesKey: aBook) ifFalse: [ self error: self class bookNotInTheCatalogErrorMessage ].
	(aBookQuantity <= 0) ifTrue: [ self error: self class bookQuantityInvalidErrorMessage ].
	
	content add: aBook withOccurrences: aBookQuantity.! !


!Cart methodsFor: 'pricing' stamp: 'LD 11/29/2024 14:05:05'!
priceOfContent

	| priceOfContent |
	
	priceOfContent := content sum: [ :item | catalog at: item ] ifEmpty: 0.

	^priceOfContent.! !


!Cart methodsFor: 'emptying' stamp: 'LD 11/29/2024 13:50:41'!
clear

	content := Bag new.! !

!Cart methodsFor: 'emptying' stamp: 'LD 11/6/2024 12:54:00'!
isEmpty

	^content isEmpty.! !


!Cart methodsFor: 'testing' stamp: 'LD 11/6/2024 13:37:45'!
has: aBook withAQuantityOf: aBookQuantity

	^(content includes: aBook) and: [(content occurrencesOf: aBook) = aBookQuantity].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibrosBackend-Business'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'LD 11/14/2024 10:05:06'!
createWithCatalog: aCatalog

	^self new initializeWith: aCatalog.! !


!Cart class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:53:48'!
bookNotInTheCatalogErrorMessage

	^'Error al agregar el libro. El libro no está en el catálogo.'.! !

!Cart class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:54:12'!
bookQuantityInvalidErrorMessage

	^'Error al agregar el libro. La cantidad de copias no puede ser menor o igual a 0.'.! !


!classDefinition: #Cashier category: #'TusLibrosBackend-Business'!
Object subclass: #Cashier
	instanceVariableNames: 'paymentSystem salesBook catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Business'!

!Cashier methodsFor: 'initialization' stamp: 'LD 11/18/2024 10:54:23'!
initializeWithPaymentSystem: aPaymentSystem andSalesBook: aSalesBook andCatalog: aCatalog

	paymentSystem := aPaymentSystem.
	salesBook := aSalesBook.
	catalog := aCatalog.! !


!Cashier methodsFor: 'checking out' stamp: 'LD 11/29/2024 14:05:05'!
checkOutCart: aCart ofUser: aUser withCardNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner

	| total transactionId cartContent |
	
	self validateCartIsNotEmpty: aCart.
	self validateCardIsNotExpiredWithNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner.

	cartContent := aCart content.
	total := aCart priceOfContent.
	
	paymentSystem processPaymentOf: total withCardNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner.
	
	self updateSalesBookForUser: aUser withCartContent: cartContent addingATotalOf: total.
	aCart clear.
	transactionId := UUID new asString.
	
	^transactionId.! !


!Cashier methodsFor: 'private' stamp: 'LD 11/29/2024 13:56:01'!
updateSalesBookForUser: aUser withCartContent: aCartContent addingATotalOf: aTotal
	
	| previousTotalAmount userPurchaseHistory |
	
	salesBook at: aUser ifAbsent: [ 
		salesBook at: aUser put: Dictionary new.
		(salesBook at: aUser) at: 'totalAmount' put: 0.
	].
	
	userPurchaseHistory := salesBook at: aUser.

	aCartContent asSet do: [ :item | 
		| previouslyPurchased | 
		
		userPurchaseHistory at: item ifAbsent: [ userPurchaseHistory at: item put: 0. ].
		previouslyPurchased := userPurchaseHistory at: item.
		userPurchaseHistory at: item put: ((aCartContent occurrencesOf: item) + previouslyPurchased).
	].
	
	previousTotalAmount := userPurchaseHistory at: 'totalAmount'.
	userPurchaseHistory at: 'totalAmount' put: (aTotal + previousTotalAmount).! !


!Cashier methodsFor: 'validations - private' stamp: 'LD 11/29/2024 10:04:25'!
validateCardIsNotExpiredWithNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner

	| aCard |
	
	aCard := CreditCard withNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner.
	aCard isExpired ifTrue: [ self error: self class cardIsExpiredErrorMessage ].! !

!Cashier methodsFor: 'validations - private' stamp: 'LD 11/29/2024 09:57:42'!
validateCartIsNotEmpty: aCart

	aCart isEmpty ifTrue: [ self error: self class cartIsEmptyErrorMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibrosBackend-Business'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'LD 11/16/2024 17:21:35'!
createWithPaymentSystem: aPaymentSystem andSalesBook: aSalesBook andCatalog: aCatalog

	^self new initializeWithPaymentSystem: aPaymentSystem andSalesBook: aSalesBook andCatalog: aCatalog.! !


!Cashier class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:55:06'!
cardIsExpiredErrorMessage

	^'Error al hacer el checkout. La tarjeta esta expirada.'.! !

!Cashier class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:55:35'!
cartIsEmptyErrorMessage

	^'Error al hacer el checkout. El carrito esta vacio.'.! !


!classDefinition: #CreditCard category: #'TusLibrosBackend-Business'!
Object subclass: #CreditCard
	instanceVariableNames: 'cardNumber expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Business'!

!CreditCard methodsFor: 'initialization' stamp: 'LD 11/14/2024 09:40:37'!
initializeWith: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner

	cardNumber := aCardNumber.
	expirationDate := anExpirationDate.
	owner := aCardOwner.! !


!CreditCard methodsFor: 'validation' stamp: 'LD 11/18/2024 10:58:29'!
isExpired

	| date |
	
	date := Date newDay: (expirationDate lastDayNumber) month: (expirationDate monthNumber) year: (expirationDate year).

	^date < (Date today).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibrosBackend-Business'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'MP 11/14/2024 22:39:58'!
withNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner

	^self new initializeWith: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner.! !


!classDefinition: #System category: #'TusLibrosBackend-Business'!
Object subclass: #System
	instanceVariableNames: 'users catalog authSystem cashier salesBook lastTimeOfActivity systemTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Business'!

!System methodsFor: 'initialization' stamp: 'LD 11/28/2024 11:11:06'!
initializeWithCatalog: aCatalog andAuthSystem: anAuthSystem andPaymentSystem: aPaymentSystem andSystemTime: aSystemTime

	users := Dictionary new.
	catalog := aCatalog.
	authSystem := anAuthSystem.
	salesBook := Dictionary new.
	
	lastTimeOfActivity := Dictionary new.
	systemTime := aSystemTime.
	
	cashier := Cashier createWithPaymentSystem: aPaymentSystem andSalesBook: salesBook andCatalog: aCatalog.! !


!System methodsFor: 'testing' stamp: 'LD 11/6/2024 13:37:39'!
cartOfUser: aUser has: aBook withAQuantityOf: aBookQuantity

	| cart |
	
	cart := users at: aUser.
	
	^cart has: aBook withAQuantityOf: aBookQuantity.! !

!System methodsFor: 'testing' stamp: 'LD 11/6/2024 13:06:16'!
cartOfUserIsEmpty: aUser

	| cart |
	
	cart := users at: aUser.
	
	^cart isEmpty.! !


!System methodsFor: 'session times' stamp: 'MP 11/24/2024 20:19:22'!
updateLastTimeOfActivity: aUser

	lastTimeOfActivity at: aUser put: GregorianDateTime now.
! !

!System methodsFor: 'session times' stamp: 'MP 11/29/2024 14:32:41'!
validateSessionAndUpdateTimes: aUser

	systemTime updateActualTime.
	self validateSessionIsNotExpired: aUser.
	self updateLastTimeOfActivity: aUser.
	! !

!System methodsFor: 'session times' stamp: 'LD 11/25/2024 12:37:00'!
validateSessionIsNotExpired: aUser

	| lastTimeOfUser |
	
	lastTimeOfUser := lastTimeOfActivity at: aUser.
	
	(systemTime hasExpirationTimeBeenSurpassedBy: lastTimeOfUser) ifTrue: [ self error: self class sessionIsExpiredErrorMessage ].! !


!System methodsFor: 'operations' stamp: 'MP 11/29/2024 14:33:58'!
addBook: aBook quantity: aBookQuantity toCartOfUser: aUser

	| cart |
	
	cart := users at: aUser ifAbsent: [ self error: self class addBookToNonExistingCartErrorMessage ].
	
	self validateSessionAndUpdateTimes: aUser.
	
	cart add: aBook quantity: aBookQuantity. ! !

!System methodsFor: 'operations' stamp: 'MP 11/29/2024 14:33:37'!
checkOutCartOfUser: aUser withCardNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner

	| cart transactionId |
	
	cart := users at: aUser.

	transactionId := cashier checkOutCart: cart ofUser: aUser withCardNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner.
	
	self validateSessionAndUpdateTimes: aUser.

	^transactionId.! !

!System methodsFor: 'operations' stamp: 'MP 11/24/2024 22:00:35'!
createCartForUser: aUser withPassword: aPassword 
	
	authSystem authenticate: aUser withPassword: aPassword.
	users at: aUser put: (Cart createWithCatalog: catalog).
	
	systemTime updateActualTime.
	self updateLastTimeOfActivity: aUser.! !

!System methodsFor: 'operations' stamp: 'MP 11/29/2024 14:33:13'!
listCartOfUser: aUser

	| cart |
	
	cart := users at: aUser ifAbsent: [ self error: self class listNonExistingCartErrorMessage ].
	
	self validateSessionAndUpdateTimes: aUser.
	
	^cart content.! !

!System methodsFor: 'operations' stamp: 'LD 11/28/2024 12:18:46'!
listPurchasesOfUser: aUser withPassword: aPassword
	
	authSystem authenticate: aUser withPassword: aPassword.
	
	^salesBook at: aUser ifAbsent: [ ^Dictionary with: 'totalAmount'->0 ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'System class' category: #'TusLibrosBackend-Business'!
System class
	instanceVariableNames: ''!

!System class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:56:25'!
addBookToNonExistingCartErrorMessage

	^'Error al agregar el libro al carrito. Se requiere iniciar un pedido antes.'.! !

!System class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:56:30'!
listNonExistingCartErrorMessage

	^'Error al listar el carrito. Se requiere iniciar un pedido antes.'.! !

!System class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:56:35'!
sessionIsExpiredErrorMessage

	^'Error. La sesion expiro.'.! !


!System class methodsFor: 'instance creation' stamp: 'MP 11/24/2024 21:03:34'!
createWithCatalog: aCatalog andAuthSystem: anAuthSystem andPaymentSystem: aPaymentSystem andSystemTime: aSystemTime

	^self new initializeWithCatalog: aCatalog andAuthSystem: anAuthSystem andPaymentSystem: aPaymentSystem andSystemTime: aSystemTime.! !


!classDefinition: #SystemTime category: #'TusLibrosBackend-Business'!
Object subclass: #SystemTime
	instanceVariableNames: 'expirationTime actualTime additionalTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Business'!

!SystemTime methodsFor: 'testing' stamp: 'LD 11/25/2024 13:08:15'!
setAdditionalTime: aTimeToBeAdded
	
	additionalTime := aTimeToBeAdded.! !


!SystemTime methodsFor: 'initialization' stamp: 'MP 11/24/2024 22:17:46'!
initializeWithExpirationTime: anExpirationTime

	actualTime := GregorianDateTime now.
	expirationTime := anExpirationTime.
	additionalTime := 0 * second.! !


!SystemTime methodsFor: 'update' stamp: 'MP 11/24/2024 22:34:47'!
updateActualTime

	actualTime := (GregorianDateTime now) next: additionalTime.! !


!SystemTime methodsFor: 'calculation' stamp: 'LD 11/19/2024 21:49:32'!
hasExpirationTimeBeenSurpassedBy: aTime

	^(aTime distanceTo: actualTime) >= expirationTime.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SystemTime class' category: #'TusLibrosBackend-Business'!
SystemTime class
	instanceVariableNames: ''!

!SystemTime class methodsFor: 'instance creation' stamp: 'LD 11/19/2024 21:21:12'!
withExpiratonTime: anExpirationTime

	^self new initializeWithExpirationTime: anExpirationTime.! !
!classDefinition: #AuthSystem category: #'TusLibrosBackend-Services'!
Object subclass: #AuthSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Services'!

!AuthSystem methodsFor: 'validation' stamp: 'MP 11/10/2024 20:26:47'!
authenticate: aUserId withPassword: aPassword 
	self subclassResponsibility ! !


!classDefinition: #AuthSystemService category: #'TusLibrosBackend-Services'!
AuthSystem subclass: #AuthSystemService
	instanceVariableNames: 'users'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Services'!

!AuthSystemService methodsFor: 'initialization' stamp: 'LD 11/16/2024 17:27:28'!
initialize

	users := Dictionary with: 'pepe'->'alumno' with: 'fito'->'alumno' with: 'messi'->'1234' with: 'dimaria'->'123456'.! !


!AuthSystemService methodsFor: 'validation' stamp: 'LD 11/25/2024 12:48:55'!
authenticate: aUserId withPassword: aPassword

	| password |
	
	password := users at: aUserId ifAbsent: [ self error: self class invalidUserOrPasswordErrorMessage ].
	password = aPassword ifFalse: [ self error: self class invalidUserOrPasswordErrorMessage ].

	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuthSystemService class' category: #'TusLibrosBackend-Services'!
AuthSystemService class
	instanceVariableNames: ''!

!AuthSystemService class methodsFor: 'error messages' stamp: 'LD 11/25/2024 11:18:14'!
invalidUserOrPasswordErrorMessage
	
	^'Error al validar el usuario y la contrasenia.'.! !


!classDefinition: #AuthSystemStub category: #'TusLibrosBackend-Services'!
AuthSystem subclass: #AuthSystemStub
	instanceVariableNames: 'authenticatorBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Services'!

!AuthSystemStub methodsFor: 'initialization' stamp: 'MP 11/10/2024 20:05:18'!
initializeWith: aBehaviour

	authenticatorBehaviour := aBehaviour.! !


!AuthSystemStub methodsFor: 'validation' stamp: 'LD 11/11/2024 17:41:50'!
authenticate: aUserId withPassword: aPassword 

	^authenticatorBehaviour value: aUserId value: aPassword.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AuthSystemStub class' category: #'TusLibrosBackend-Services'!
AuthSystemStub class
	instanceVariableNames: ''!

!AuthSystemStub class methodsFor: 'instance creation' stamp: 'MP 11/10/2024 20:05:43'!
createWithBehaviour: aBehaviour

	^self new initializeWith: aBehaviour.! !


!classDefinition: #PaymentSystem category: #'TusLibrosBackend-Services'!
Object subclass: #PaymentSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Services'!

!PaymentSystem methodsFor: 'payment' stamp: 'LD 11/18/2024 11:06:03'!
processPaymentOf: anAmount withCardNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner

	self subclassResponsibility.! !


!classDefinition: #PaymentSystemService category: #'TusLibrosBackend-Services'!
PaymentSystem subclass: #PaymentSystemService
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Services'!

!PaymentSystemService methodsFor: 'payment' stamp: 'LD 11/29/2024 13:25:00'!
processPaymentOf: anAmount withCardNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner
	
	"Se realiza la operacion"! !


!classDefinition: #PaymentSystemStub category: #'TusLibrosBackend-Services'!
PaymentSystem subclass: #PaymentSystemStub
	instanceVariableNames: 'checkoutBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Services'!

!PaymentSystemStub methodsFor: 'initialization' stamp: 'MP 11/12/2024 19:31:25'!
initializeWith: aBehaviour

	checkoutBehaviour := aBehaviour.! !


!PaymentSystemStub methodsFor: 'payment' stamp: 'LD 11/18/2024 11:05:51'!
processPaymentOf: anAmount withCardNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner
	
	^checkoutBehaviour value: anAmount value: aCardNumber value: anExpirationDate value: aCardOwner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PaymentSystemStub class' category: #'TusLibrosBackend-Services'!
PaymentSystemStub class
	instanceVariableNames: ''!

!PaymentSystemStub class methodsFor: 'instance creation' stamp: 'MP 11/12/2024 19:31:40'!
createWithBehaviour: aBehaviour

	^self new initializeWith: aBehaviour.! !
!classDefinition: #ExternalRestInterface category: #'TusLibrosBackend-Interface'!
Object subclass: #ExternalRestInterface
	instanceVariableNames: 'innerRestInterface server'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Interface'!

!ExternalRestInterface methodsFor: 'initialization' stamp: 'MP 11/29/2024 14:56:35'!
initialize
	
	| catalog |
	
	catalog := self getCatalog.
	innerRestInterface := self createInnerRestInterfaceWithCatalog: catalog andExpirationTime: 30 * minute.
	server := self createAndStartWebServerOnPort: 9000. 
	
	self enableEndpoints.! !


!ExternalRestInterface methodsFor: 'endpoints - private' stamp: 'LD 11/29/2024 13:47:02'!
addEndpoint: anEndpoint andOperation: anOperation

	server addService: anEndpoint action: [ :request | 
		| output | 

		output := anOperation value: (request fields).
		
		request sendResponseCode: (output at: 'statusCode') 
		content: (output at: 'responseBody') 
		
		type: 'text/plain; charset=utf-8' 
		do: [ :aResponse | ] ].! !

!ExternalRestInterface methodsFor: 'endpoints - private' stamp: 'MP 11/29/2024 00:27:06'!
enableEndpoints

	self endpointCreateCart.
	self endpointAddToCart.
	self endpointListCart.
	self endpointCheckOutCart.
	self endpointListPurchases.! !

!ExternalRestInterface methodsFor: 'endpoints - private' stamp: 'MP 11/29/2024 14:51:16'!
endpointAddToCart

	self addEndpoint: '/addToCart' andOperation: [ :request | innerRestInterface addToCart: request ].! !

!ExternalRestInterface methodsFor: 'endpoints - private' stamp: 'MP 11/29/2024 14:51:12'!
endpointCheckOutCart

	self addEndpoint: '/checkOutCart' andOperation: [ :request | innerRestInterface checkOutCart: request ].! !

!ExternalRestInterface methodsFor: 'endpoints - private' stamp: 'MP 11/29/2024 14:51:07'!
endpointCreateCart

	self addEndpoint: '/createCart' andOperation: [ :request | innerRestInterface createCart: request ].! !

!ExternalRestInterface methodsFor: 'endpoints - private' stamp: 'MP 11/29/2024 14:51:03'!
endpointListCart

	self addEndpoint: '/listCart' andOperation: [ :request | innerRestInterface listCart: request ].! !

!ExternalRestInterface methodsFor: 'endpoints - private' stamp: 'MP 11/29/2024 14:50:58'!
endpointListPurchases

	self addEndpoint: '/listPurchases' andOperation: [ :request | innerRestInterface listPurchases: request ].! !


!ExternalRestInterface methodsFor: 'server destroy' stamp: 'LD 11/6/2024 11:07:39'!
endServerConnection

	server destroy.! !


!ExternalRestInterface methodsFor: 'private' stamp: 'MP 11/26/2024 15:45:36'!
createAndStartWebServerOnPort: aPort
	
	| webServer |
	
	webServer := WebServer reset default.
	webServer listenOn: 9000.
	webServer useDebugErrorHandler.
	
	^webServer ! !

!ExternalRestInterface methodsFor: 'private' stamp: 'MP 11/26/2024 15:46:01'!
createInnerRestInterfaceWithCatalog: aCatalog andExpirationTime: aExpirationTime
	
	| authSystem paymentSystem system systemTime |
	
	authSystem := AuthSystemService new.
	paymentSystem := PaymentSystemService new.
	systemTime := SystemTime withExpiratonTime: aExpirationTime.
	system := System createWithCatalog: aCatalog andAuthSystem: authSystem andPaymentSystem: paymentSystem andSystemTime: systemTime.
	
	^InnerRestInterface createWithSystem: system.! !

!ExternalRestInterface methodsFor: 'private' stamp: 'MP 11/26/2024 15:40:35'!
getCatalog
	
	| catalog |
	
	catalog := Dictionary with: '9780137314942'->31505 with: '9780321278654'->45305 with: '9780201710915'->45180 with: '9780321125217'->41000 with: '9780735619654'->34900 with: '9780321146533'->29100.

	^catalog! !


!classDefinition: #InnerRestInterface category: #'TusLibrosBackend-Interface'!
Object subclass: #InnerRestInterface
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosBackend-Interface'!

!InnerRestInterface methodsFor: 'initialization' stamp: 'MP 11/8/2024 20:03:16'!
initializeWith: aSystem

	system := aSystem.! !


!InnerRestInterface methodsFor: 'validations - private' stamp: 'LD 11/25/2024 10:58:42'!
validateBookQuantity: aBookQuantity

	self validateParameterIsANumber: aBookQuantity withError: (self class bookQuantityErrorMessage).! !

!InnerRestInterface methodsFor: 'validations - private' stamp: 'LD 11/25/2024 10:58:25'!
validateCardNumber: aCardNumber
	
	self validateParameterIsANumber: aCardNumber withError: (self class invalidCardNumberErrorMessage).! !

!InnerRestInterface methodsFor: 'validations - private' stamp: 'LD 11/25/2024 12:45:27'!
validateEmptyParameters: parameters

	parameters do: [ :param | param isEmpty ifTrue: [ self error: self class emptyParametersErrorMessage ] ].! !

!InnerRestInterface methodsFor: 'validations - private' stamp: 'LD 11/25/2024 12:46:33'!
validateExpirationDate: anExpirationDate
	
	self validateParameterIsANumber: anExpirationDate withError: (self class invalidExpirationDateOfCardErrorMessage).
	
	(anExpirationDate size = 6) ifFalse: [ self error: self class invalidExpirationDateOfCardErrorMessage ].! !

!InnerRestInterface methodsFor: 'validations - private' stamp: 'LD 11/25/2024 12:46:54'!
validateParameterIsANumber: aParameter withError: anError

	[ aParameter asNumber ]
	on: Error
	do: [ self error: anError ].! !


!InnerRestInterface methodsFor: 'testing' stamp: 'LD 11/16/2024 17:32:26'!
response: aResponse hasStatus: aStatusCode

	^aStatusCode = (aResponse at: 'statusCode').! !

!InnerRestInterface methodsFor: 'testing' stamp: 'LD 11/8/2024 14:07:13'!
response: aResponse hasStatus: aStatusCode andBody: aBody

	^aStatusCode = (aResponse at: 'statusCode') and: [aBody = (aResponse at: 'responseBody')].! !


!InnerRestInterface methodsFor: 'response' stamp: 'MP 11/12/2024 12:17:59'!
responseWithStatus: aStatusCode andBody: aBody

	^Dictionary with: 'statusCode' -> aStatusCode with: 'responseBody' -> aBody.! !


!InnerRestInterface methodsFor: 'operations - private' stamp: 'LD 11/25/2024 12:47:46'!
addBook: aBookIsbn quantity: aBookQuantity toCartOfUser: aUserId

	[ self validateEmptyParameters: { aBookIsbn. aBookQuantity. aUserId }.
	self validateBookQuantity: aBookQuantity ]
	on: Error
	do: [ :exception | ^self responseWithStatus: 400 andBody: ('1|', exception messageText) ].
	
	[ system addBook: aBookIsbn quantity: (aBookQuantity asNumber) toCartOfUser: aUserId ]
	on: Error
	do: [ :exception | ^self responseWithStatus: 422 andBody: ('1|', exception messageText) ].
	
	^self responseWithStatus: 200 andBody: '0|OK'.! !

!InnerRestInterface methodsFor: 'operations - private' stamp: 'MP 11/26/2024 19:21:02'!
checkOutCartOfUser: aUserId withCardNumber: aCardNumber andExpirationDate: anExpirationDate ofOwner: aCardOwner
	
	| transactionId parsedExpirationDate|
	
	[ self validateEmptyParameters: { aUserId. aCardNumber. anExpirationDate. aCardOwner }.
	self validateCardNumber: aCardNumber.
	self validateExpirationDate: anExpirationDate.
	parsedExpirationDate := self parseDate: anExpirationDate ]
	on: Error-MessageNotUnderstood
	do: [ :exception | ^self responseWithStatus: 400 andBody: ('1|', exception messageText) ].
	
	[ transactionId := system checkOutCartOfUser: aUserId withCardNumber: aCardNumber andExpirationDate: parsedExpirationDate ofOwner: aCardOwner ]
	on: Error-MessageNotUnderstood
	do: [ :exception | ^self responseWithStatus: 422 andBody: ('1|', exception messageText) ].
	
	^self responseWithStatus: 200 andBody: '0|', transactionId asString.! !

!InnerRestInterface methodsFor: 'operations - private' stamp: 'MP 11/29/2024 00:16:40'!
createCartForUser: aUserId withPassword: aPassword 

	[ self validateEmptyParameters: { aUserId. aPassword } ]
	on: Error
	do: [ :exception | ^self responseWithStatus: 400 andBody: ('1|', exception messageText) ].
	
	[ system createCartForUser: aUserId withPassword: aPassword ]
	on: Error
	do: [ :exception | ^self responseWithStatus: 422 andBody: ('1|', exception messageText) ].
	
	^self responseWithStatus: 201 andBody: '0|OK'.! !

!InnerRestInterface methodsFor: 'operations - private' stamp: 'LD 11/25/2024 12:47:51'!
listCartOfUser: aUserId

	| items body |
	
	[ self validateEmptyParameters: { aUserId } ]
	on: Error
	do: [ :exception | ^self responseWithStatus: 400 andBody: ('1|', exception messageText) ].
	
	[ items := system listCartOfUser: aUserId ]
	on: Error
	do: [ :exception | ^self responseWithStatus: 422 andBody: ('1|', exception messageText) ].
			
	body := '0'.
	items asSet do: [ :item | body := body, '|', item, '|', (items occurrencesOf: item) asString].
	
	^self responseWithStatus: 200 andBody: body.! !

!InnerRestInterface methodsFor: 'operations - private' stamp: 'LD 11/29/2024 09:37:12'!
listPurchasesOfUser: aUser withPassword: aPassword

	| userPurchaseHistory body total |
	
	[ self validateEmptyParameters: { aUser. aPassword } ]
	on: Error
	do: [ :exception | ^self responseWithStatus: 400 andBody: ('1|', exception messageText) ].
	
	[ userPurchaseHistory := system listPurchasesOfUser: aUser withPassword: aPassword ]
	on: Error
	do: [ :exception | ^self responseWithStatus: 422 andBody: '1|', exception messageText ].
	
	body := '0'.
	userPurchaseHistory keysAndValuesDo: [		 :key :value |
		key = 'totalAmount' ifFalse: [ body := body, '|', key asString, '|', value asString ] ]. "TODO: Quiza pensar de hacerlo de otra manera"
	
	total := (userPurchaseHistory at: 'totalAmount') asString.
	body := body, '|', total.
	
	^self responseWithStatus: 200 andBody: body.
! !


!InnerRestInterface methodsFor: 'operations' stamp: 'LD 11/25/2024 12:47:14'!
addToCart: requestFields
	
	| userId bookIsbn bookQuantity|
	
	[ userId := requestFields at: 'userId'.
	bookIsbn := requestFields at: 'bookIsbn'.
	bookQuantity := requestFields at: 'bookQuantity' ]
	on: Error
	do: [ ^self responseWithStatus: 400 andBody: ('1|', self class missingParametersErrorMessage) ].
	
	^self addBook: bookIsbn quantity: bookQuantity toCartOfUser: userId.! !

!InnerRestInterface methodsFor: 'operations' stamp: 'LD 11/25/2024 12:47:19'!
checkOutCart: requestFields 
	
	| userId cardNumber expirationDate cardOwner |
	
	[ userId := requestFields at: 'userId'.
	cardNumber := requestFields at: 'ccn'.
	expirationDate := requestFields at: 'cced'.
	cardOwner := requestFields at: 'cco' ]
	on: Error
	do: [ ^self responseWithStatus: 400 andBody: ('1|', self class missingParametersErrorMessage) ].

	^self checkOutCartOfUser: userId withCardNumber: cardNumber andExpirationDate: expirationDate ofOwner: cardOwner.! !

!InnerRestInterface methodsFor: 'operations' stamp: 'LD 11/28/2024 12:04:39'!
createCart: requestFields
	
	| userId password |
	
	[ userId := requestFields at: 'userId'.
	password := requestFields at: 'password' ]
	on: Error
	do: [ ^self responseWithStatus: 400 andBody: ('1|', self class missingParametersErrorMessage) ].
	
	^self createCartForUser: userId withPassword: password.! !

!InnerRestInterface methodsFor: 'operations' stamp: 'LD 11/25/2024 12:47:24'!
listCart: requestFields
	
	| userId |
	
	[ userId := requestFields at: 'userId' ]
	on: Error
	do: [ ^self responseWithStatus: 400 andBody: ('1|', self class missingParametersErrorMessage) ].
	
	^self listCartOfUser: userId.! !

!InnerRestInterface methodsFor: 'operations' stamp: 'LD 11/29/2024 09:36:50'!
listPurchases: requestFields
	
	| userId password |
	
	[ userId := requestFields at: 'userId'.
	password := requestFields at: 'password' ]
	on: Error
	do: [ ^self responseWithStatus: 400 andBody: ('1|', self class missingParametersErrorMessage) ].
	
	^self listPurchasesOfUser: userId withPassword: password.! !


!InnerRestInterface methodsFor: 'parsing' stamp: 'LD 11/25/2024 12:44:00'!
parseDate: anExpirationDate

	| year month |

	month := (anExpirationDate copyFrom: 1 to: 2) asNumber.
	year := (anExpirationDate copyFrom: 3 to: 6) asNumber.
	
	[ ^GregorianMonthOfYear year: year monthNumber: month ]
	on: Error
	do: [ self error: self class invalidExpirationDateOfCardErrorMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InnerRestInterface class' category: #'TusLibrosBackend-Interface'!
InnerRestInterface class
	instanceVariableNames: ''!

!InnerRestInterface class methodsFor: 'instance creation' stamp: 'LD 11/16/2024 17:17:58'!
createWithSystem: aSystem

	^self new initializeWith: aSystem.! !


!InnerRestInterface class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:57:35'!
bookQuantityErrorMessage

	^'La cantidad de libros debe ser un numero.'! !

!InnerRestInterface class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:58:01'!
emptyParametersErrorMessage

	^'Los parametros no pueden estar vacios.'.! !

!InnerRestInterface class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:58:08'!
invalidCardNumberErrorMessage

	^'Error. El numero de la tarjeta es invalido.'.! !

!InnerRestInterface class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:58:14'!
invalidExpirationDateOfCardErrorMessage

	^'Error. La fecha de expiracion de la tarjeta es invalida.'.! !

!InnerRestInterface class methodsFor: 'error messages' stamp: 'LD 11/25/2024 10:58:18'!
missingParametersErrorMessage

	^'Error. Faltan algunos campos.'.! !
