!classDefinition: #PortfolioTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 12:05:58'!
test01BalanceOfAFreshPortfolioIsZero

	| portfolio |
	portfolio := Portfolio new.
	
	self assert: portfolio balance equals: 0 * peso.! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 12:06:00'!
test02BalanceOfPortfolioWithAnAccountIsTheBalanceOfSaidAccount

	| account portfolio |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso  on: account.
	
	portfolio := Portfolio new.
	portfolio addAccount: account.
	
	self assert: portfolio balance equals: 100 * peso.
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 12:06:49'!
test03BalanceOfPortfolioWithMultipleAccountsIsTheBalanceOfThoseAccounts

	| account1 account2 portfolio |
	
	account1 := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 50 * peso on: account2.
	
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	self assert: portfolio balance equals: 150 * peso.
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 12:06:47'!
test04FreshPortfolioDoesNotHaveTheRequestedTransaction

	|  portfolio deposit account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 50 * peso on: account.
	
	self deny: (portfolio hasRegistered: deposit).
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 12:08:04'!
test05PortfolioWithAnAccountThatHasTransactionsDoesNotHaveTheRequestedOne

	|  portfolio deposit account1 account2 |

	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Deposit register: 50 * peso on: account1.
	deposit := Deposit register: 80 * peso on: account2.
	
	portfolio addAccount: account1.
	
	self deny: (portfolio hasRegistered: deposit).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/12/2024 18:00:04'!
test06PortfolioWithMultipleAccountsWithTransactionsHasTheRequestedOnes

	|  portfolio1 portfolio2 account1 account2 account3 account4 account5 deposit1 withdraw1 |

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	account5 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 * peso on: account4.
	withdraw1 := Withdraw register: 30 * peso on: account3.
	
	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.
	portfolio1 addAccount: account3.
	portfolio1 addAccount: portfolio2.
	
	portfolio2 addAccount: account4.
	portfolio2 addAccount: account5.
	
	self assert: (portfolio1 hasRegistered: deposit1).
	self assert: (portfolio1 hasRegistered: withdraw1).
	
	self assert: (portfolio2 hasRegistered: deposit1).
	self deny: (portfolio2 hasRegistered: withdraw1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'LDMT 10/8/2024 20:57:50'!
test07FreshPortfolioWhenAskedForTransactionsShouldReturnAnEmptyCollection

	|  portfolio transactions |
	portfolio := Portfolio new.
	
	transactions := portfolio transactions.
	self assert: transactions equals: OrderedCollection new.
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LDMT 10/8/2024 20:58:36'!
test08PortfolioWithAFreshAccountWhenAskedForTransactionsShouldReturnAnEmptyCollection

	|  portfolio account transactions |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio addAccount: account.
	transactions := portfolio transactions.

	self assert: transactions equals: OrderedCollection new.
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LDMT 10/8/2024 21:01:49'!
test09PortfolioWithAnAccountWhenAskedForTransactionsShouldReturnTheTransactionsOfSaidAccount

	|  portfolio account transactions deposit withdraw |
	portfolio := Portfolio new.
	account := ReceptiveAccount new.

	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
	
	portfolio addAccount: account.
	transactions := portfolio transactions.

	self assert: transactions size equals: 2.
	self assert: transactions equals: (OrderedCollection with: deposit with: withdraw).
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LDMT 10/8/2024 21:08:57'!
test10PortfolioWithMultipleAccountsWhenAskedForTransactionsShouldReturnTheTransactionsOfThoseAccounts

	|  portfolio account1 account2 transactions deposit1 deposit2 withdraw1 |
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit1 := Deposit register: 100 * peso on: account1.
	withdraw1 := Withdraw register: 50 * peso on: account1.
	deposit2 := Deposit register: 30 * peso on: account2.
	
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	
	transactions := portfolio transactions.

	self assert: transactions size equals: 3.
	self assert: transactions equals: (OrderedCollection with: deposit1 with: withdraw1 with: deposit2).
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LDMT 10/8/2024 21:25:37'!
test11PortfolioWithAnotherFreshPortfolioBalanceShouldBeZero

	|  portfolio1 portfolio2 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio1 addAccount: portfolio2 .

	self assert: portfolio1 balance equals: 0 * peso.
	
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LDMT 10/8/2024 21:34:32'!
test12PortfolioWithAnotherPortfolioThatHasAnAccountBalanceShouldBeOfSaidAccount

	|  portfolio1 portfolio2 account |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	
	
	Deposit register: 50 * peso on: account. 
	portfolio2 addAccount: account.
	portfolio1 addAccount: portfolio2.
	
	self assert: portfolio1 balance equals: 50 * peso.
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/11/2024 20:20:48'!
test13ValidatePortfolioCannotAddTheSameAccountTwice

	|  portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio addAccount: account.

	self should: [ portfolio addAccount: account ] 
		raise: Error 
		withExceptionDo: [ 
			:anException | self assert: anException messageText equals: Portfolio accountAlreadyExistsErrorMessage
		].
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 13:51:33'!
test14ValidatePortfolioCannotAddAnAccountIncludedInAChildPortfolio

	|  portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	portfolio2 addAccount: account.
	portfolio1 addAccount: portfolio2.

	self should: [ portfolio1 addAccount: account ] 
		raise: Error 
		withExceptionDo: [ 
			:anException | self assert: anException messageText equals: Portfolio accountAlreadyInAChildPortfolioErrorMessage
		].
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/11/2024 20:20:52'!
test15ValidatePortfolioCannotAddItself

	|  portfolio |
	
	portfolio := Portfolio new.
	
	self should: [ portfolio addAccount: portfolio ] 
		raise: Error 
		withExceptionDo: [ 
			:anException | self assert: anException messageText equals: Portfolio cannotAddYourselfErrorMessage
		].
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 13:51:26'!
test16ValidatePortfolioCannotAddAnAccountThatIsAlreadyAChildAccountOfTheParentPortfolio

	|  portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio1 addAccount: account.
	portfolio1 addAccount: portfolio2.

	self should: [ portfolio2 addAccount: account ] 
		raise: Error 
		withExceptionDo: [ 
			:anException | self assert: anException messageText equals: Portfolio accountCannotBeAddedAlreadyAChildAccountOfParentPortfolioErrorMessage
		].! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 13:49:28'!
test17ValidatePortfolioCannotAddAPortfolioThatHasAnAccountThatIsAlreadyIncludedInTheFirstOne

	|  portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio1 addAccount: account.
	portfolio2 addAccount: account.

	self should: [ portfolio1 addAccount: portfolio2 ] 
		raise: Error 
		withExceptionDo: [ 
			:anException | self assert: anException messageText equals: Portfolio portfolioCannotBeAddedDueToExistenceOfChildAccountAlreadyInAnotherPortfolioErrorMessage
		].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 13:50:58'!
test18ValidatePortfolioCannotAddAnAccountIncludedInAChildPortfolioOfAChildPortfolio

	|  portfolio1 portfolio2 portfolio3 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolio2 addAccount: account.
	portfolio1 addAccount: portfolio2.
	portfolio3 addAccount: portfolio1.

	self should: [ portfolio3 addAccount: account ] 
		raise: Error 
		withExceptionDo: [ 
			:anException | self assert: anException messageText equals: Portfolio accountAlreadyInAChildPortfolioErrorMessage
		].
	
	
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 13:50:49'!
test19ValidatePortfolioCannotAddAnAccountThatIsAlreadyAChildAccountOfAnotherParentPortfolio

	|  portfolio1 portfolio2 portfolio3 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio3 addAccount: portfolio1.
	portfolio3 addAccount: account.
	portfolio1 addAccount: portfolio2.

	self should: [ portfolio2 addAccount: account ] 
		raise: Error 
		withExceptionDo: [ 
			:anException | self assert: anException messageText equals: Portfolio accountCannotBeAddedAlreadyAChildAccountOfParentPortfolioErrorMessage
		].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 13:50:40'!
test20ValidatePortfolioCannotAddAPortfolioThatIsAlreadyAChildPortfolioOfTheParentPortfolio

	|  portfolio1 portfolio2 portfolio3 portfolio4 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	
	portfolio3 addAccount: portfolio1.
	portfolio3 addAccount: portfolio4 .
	portfolio1 addAccount: portfolio2.

	self should: [ portfolio2 addAccount: portfolio4 ] 
		raise: Error 
		withExceptionDo: [ 
			:anException | self assert: anException messageText equals: Portfolio accountCannotBeAddedAlreadyAChildAccountOfParentPortfolioErrorMessage
		].
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 13:50:31'!
test21ValidatePortfolioCannotAddAPortfolioThatHasAnAccountThatIsAlreadyIncludedInAParentPortfolioOfTheFirstOne

	|  portfolio1 portfolio2 portfolio3 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio1 addAccount: account.
	portfolio1 addAccount: portfolio2.
	
	portfolio3 addAccount: account.
	
	self should: [ 	portfolio2 addAccount: portfolio3 ] 
		raise: Error 
		withExceptionDo: [ 
			:anException | self assert: anException messageText equals: Portfolio portfolioCannotBeAddedDueToExistenceOfChildAccountAlreadyInAnotherPortfolioErrorMessage
		].! !

!PortfolioTest methodsFor: 'tests' stamp: 'LD 10/16/2024 13:50:25'!
test22ValidatePortfolioCannotAddAPortfolioThatHasAPorfolioWithAnAccountThatIsAlreadyIncludedInAParentPortfolioOfTheFirstOne

	|  portfolio1 portfolio2 portfolio3 portfolio4 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio1 addAccount: account.
	portfolio1 addAccount: portfolio2.
	
	portfolio4 addAccount: account.
	portfolio3 addAccount: portfolio4.
	
	self should: [ 	portfolio2 addAccount: portfolio3 ] 
		raise: Error 
		withExceptionDo: [ 
			:anException | self assert: anException messageText equals: Portfolio portfolioCannotBeAddedDueToExistenceOfChildAccountAlreadyInAnotherPortfolioErrorMessage
		].! !


!classDefinition: #ReceptiveAccountTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'JS 4/30/2024 13:50:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: account transactions includes: deposit.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MP 10/11/2024 16:56:21'!
test08TransferIncreasesValueOnAccountAndDecreasesValueOnAnotherAccount

	| accountToBeWithdrawn accountToBeDeposited |
	
	accountToBeWithdrawn := ReceptiveAccount new.
	accountToBeDeposited := ReceptiveAccount new.
	
	Deposit register:  50 * peso on: accountToBeWithdrawn.
	Transfer register: 40 * peso from: accountToBeWithdrawn to: accountToBeDeposited.
	
	self assert: accountToBeDeposited balance equals: 40 * peso.
	self assert: accountToBeWithdrawn balance equals: 10 * peso.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'MP 10/11/2024 16:58:41'!
test09TransferKnowsItsValue

	| accountToBeWithdrawn accountToBeDeposited transfer |
	
	accountToBeWithdrawn := ReceptiveAccount new.
	accountToBeDeposited := ReceptiveAccount new.
	
	transfer := Transfer register: 40 * peso from: accountToBeWithdrawn to: accountToBeDeposited.
	
	self assert: transfer value equals: 40 * peso
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LD 10/11/2024 20:21:54'!
test10CounterpartOfExtractionLegIsDepositAndViceVersa

	| accountToBeWithdrawn accountToBeDeposited transfer depositLeg withdrawLeg |
	
	accountToBeWithdrawn := ReceptiveAccount new.
	accountToBeDeposited := ReceptiveAccount new.
	
	transfer := Transfer register: 40 * peso from: accountToBeWithdrawn to: accountToBeDeposited.
	depositLeg := transfer depositLeg.
	withdrawLeg := transfer withdrawLeg.	

	self assert: (transfer counterpartOf: depositLeg) equals: withdrawLeg.
	self assert: (transfer counterpartOf: withdrawLeg) equals: depositLeg.! !


!classDefinition: #ReportTest category: #'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReportTest methodsFor: 'tests' stamp: 'MP 10/17/2024 16:50:34'!
test01SummaryOfAnEmptyAccountShouldBeZero
	| account report |
	account := ReceptiveAccount new.
	report := Report createFor: account.
	
	self assert: report summary equals: (OrderedCollection with: 'Balance = 0 * pesos').! !

!ReportTest methodsFor: 'tests' stamp: 'MP 10/17/2024 16:26:11'!
test02SummaryOfAnAccountWithADepositShouldBeTheValueOfSaidDeposit
	| account report |
	account := ReceptiveAccount new.
	Deposit register: 40 * peso on: account.
	report := Report createFor: account.
	
	self assert: report summary equals: (OrderedCollection with: 'Depósito por 40 * pesos' with: 'Balance = 40 * pesos').! !

!ReportTest methodsFor: 'tests' stamp: 'MP 10/17/2024 16:27:37'!
test03SummaryOfTwoAccountsWithTransactions
	| account1 account2 report1 report2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 40 * peso on: account1.
	Transfer register: 30 * peso from: account1 to: account2.
	Withdraw register: 10 * peso on: account2.
	
	report1 := Report createFor: account1.
	report2 := Report createFor: account2.
	
	self assert: report1 summary equals: (OrderedCollection with: 'Depósito por 40 * pesos' with: 'Salida por transferencia de 30 * pesos' with: 'Balance = 10 * pesos').
	self assert: report2 summary equals: (OrderedCollection with: 'Entrada por transferencia de 30 * pesos' with: 'Extracción por 10 * pesos' with: 'Balance = 20 * pesos')! !

!ReportTest methodsFor: 'tests' stamp: 'MP 10/17/2024 16:48:58'!
test04SummaryOfAnEmptyPortfolioShouldBeZero
	| portfolio report |
	portfolio := Portfolio new.
	report := Report createFor: portfolio.
	
	self assert: report summary equals: (OrderedCollection with: 'Balance = 0 * pesos').! !

!ReportTest methodsFor: 'tests' stamp: 'MP 10/17/2024 17:03:52'!
test05SummaryOfPortfoliosWithMultipleAccountsAndTransactions
	| portfolio1 portoflio2 portfolio3 account1 account2 account3 report1 report2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	portfolio1 := Portfolio new.
	portoflio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	Deposit register: 30 * peso on: account1.
	Deposit register: 80 * peso on: account2.
	Deposit register: 40 * peso on: account3.
	
	portfolio1 addAccount: account1.
	portoflio2 addAccount: account2.
	portfolio1 addAccount: portoflio2.
	portfolio3 addAccount: portfolio1.
	portfolio3 addAccount: account3.
	
	report1 := Report createFor: portfolio1.
	report2 := Report createFor: portfolio3.
	
	self assert: report1 summary equals: (OrderedCollection with: 'Depósito por 30 * pesos' with: 'Depósito por 80 * pesos' with: 'Balance = 110 * pesos').
	self assert: report2 summary equals: (OrderedCollection with: 'Depósito por 30 * pesos' with: 'Depósito por 80 * pesos' with: 'Depósito por 40 * pesos' with: 'Balance = 150 * pesos').! !

!ReportTest methodsFor: 'tests' stamp: 'MP 10/17/2024 17:29:11'!
test06NetTransferOfAnEmptyAccountIsZero
	| account report |
	
	account := ReceptiveAccount new.
	report := Report createFor: account.
	
	self assert: report netTransfers equals: 0 * peso.
	
! !

!ReportTest methodsFor: 'tests' stamp: 'MP 10/17/2024 18:27:01'!
test07NetTransferOfAnAccountThatHasDoneATransferIsTheNetValueOfSaidTransfer
	| account account2 report |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer register: 40 * peso from: account2 to: account.
	report := Report createFor: account.
	
	self assert: report netTransfers equals: 40 * peso.
	
! !

!ReportTest methodsFor: 'tests' stamp: 'MP 10/17/2024 18:27:06'!
test08NetTransferOfAnAccountThatHasDoneMultipleTransfers
	| account account2 report |
	
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
	Transfer register: 20 * peso from: account to: account2.
	Transfer register: 30 * peso from: account2 to: account.
	
	report := Report createFor: account.
	
	self assert: report netTransfers equals: 10 * peso.
	
! !

!ReportTest methodsFor: 'tests' stamp: 'MP 10/17/2024 18:23:14'!
test09NetTransferOfAPortfolioWithMultipleAccountsThatHasDoneMultipleTransfers
	| portfolio1 portoflio2 portfolio3 account1 account2 account3 report1 report2 report3 |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: account1.
	Withdraw register: 50 * peso on: account1.
	Transfer register: 20 * peso from: account1 to: account2.
	Transfer register: 30 * peso from: account2 to: account1.
	
	account3 := ReceptiveAccount new.
	portfolio1 := Portfolio new.
	portoflio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	Deposit register: 30 * peso on: account1.
	Deposit register: 80 * peso on: account2.
	Deposit register: 40 * peso on: account3.
	
	portfolio1 addAccount: account1.
	portoflio2 addAccount: account2.
	portfolio3 addAccount: portfolio1.
	portfolio3 addAccount: account3.
	
	report1 := Report createFor: portfolio1.
	report2 := Report createFor: portoflio2.
	report3 := Report createFor: portfolio3.
	
	self assert: report1 netTransfers equals: 10 * peso.
	self assert: report2 netTransfers equals: -10 * peso.
	self assert: report3 netTransfers equals: 10 * peso.
	
	portfolio1 addAccount: portoflio2.
	
	self assert: report1 netTransfers equals: 0 * peso.
	self assert: report2 netTransfers equals: -10 * peso.
	self assert: report3 netTransfers equals: 0 * peso.
	
	! !


!classDefinition: #Account category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: 'parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'initialization' stamp: 'MP 10/15/2024 21:06:39'!
initialize
	parents := OrderedCollection new.! !


!Account methodsFor: 'balance' stamp: 'LD 10/16/2024 11:53:47'!
balance

	self subclassResponsibility.! !


!Account methodsFor: 'add' stamp: 'LD 10/16/2024 11:52:56'!
addParent: anAccount

	parents add: anAccount.! !


!Account methodsFor: 'transactions' stamp: 'LD 10/16/2024 11:54:41'!
hasRegistered: aTransaction

	self subclassResponsibility.! !

!Account methodsFor: 'transactions' stamp: 'LD 10/16/2024 11:54:46'!
transactions

	self subclassResponsibility.! !


!classDefinition: #Portfolio category: #'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'add' stamp: 'LD 10/16/2024 11:55:18'!
addAccount: anAccount

	self validate: anAccount.
	
	accounts add: anAccount.
	
	anAccount addParent: self.! !


!Portfolio methodsFor: 'initialization' stamp: 'LD 10/16/2024 11:55:23'!
initialize

	super initialize.
	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'transactions' stamp: 'LD 10/16/2024 11:54:09'!
hasRegistered: aTransaction
	
	^accounts anySatisfy: [ :account | account hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'transactions' stamp: 'LD 10/16/2024 11:54:12'!
transactions

	| transactions |
	transactions := OrderedCollection new.

	accounts do: [ :account | transactions addAll: account transactions ].
	
	^transactions.! !


!Portfolio methodsFor: 'balance' stamp: 'LD 10/16/2024 11:53:27'!
balance

	^accounts sum: [ :account | account balance ] ifEmpty: [^0 * peso].! !


!Portfolio methodsFor: 'validations - private' stamp: 'LD 10/16/2024 13:49:50'!
validateAccountNotIncludedInAChildPortfolio: anAccount

	accounts do: [ :account | 
		(account isKindOf: Portfolio) 
			ifTrue: [ account validateAccountNotIncludedInAChildPortfolio: anAccount ] 
			ifFalse: [ (account = anAccount) ifTrue: [ self error: Portfolio accountAlreadyInAChildPortfolioErrorMessage ] ] ].! !

!Portfolio methodsFor: 'validations - private' stamp: 'LD 10/16/2024 13:48:40'!
validateAccountNotIncludedInAnyParentPortfolio: anAccount

	parents do: [ :parent | 
		(parent hasAccount: anAccount) 
			ifTrue: [ self error: Portfolio accountCannotBeAddedAlreadyAChildAccountOfParentPortfolioErrorMessage ]
			ifFalse: [ parent validateAccountNotIncludedInAnyParentPortfolio: anAccount ] ].! !

!Portfolio methodsFor: 'validations - private' stamp: 'LD 10/12/2024 16:33:16'!
validateAlreadyExists: anAccount
	
	accounts do: [ :account | (account = anAccount) 
		ifTrue: [ self error: Portfolio accountAlreadyExistsErrorMessage ] ].! !

!Portfolio methodsFor: 'validations - private' stamp: 'LD 10/12/2024 17:17:32'!
validateNotMyself: anAccount
	
	(self = anAccount) ifTrue: [ self error: Portfolio cannotAddYourselfErrorMessage ].! !

!Portfolio methodsFor: 'validations - private' stamp: 'LD 10/16/2024 13:50:08'!
validatePortfolioDoesNotHaveAnExistingAccount: aPortfolio

       | portfolioAccounts |
	portfolioAccounts := OrderedCollection new.
	aPortfolio collectAllChildAccountsIn: portfolioAccounts.

	portfolioAccounts do: [ :account | self checkAccount: account ].! !


!Portfolio methodsFor: 'validations' stamp: 'LD 10/16/2024 13:49:50'!
validate: anAccount
	
	self validateAlreadyExists: anAccount.
	
	self validateAccountNotIncludedInAChildPortfolio: anAccount.
	
	self validateNotMyself: anAccount.
	
	self validateAccountNotIncludedInAnyParentPortfolio: anAccount.
	
	(anAccount isKindOf: Portfolio) ifTrue: [ self validatePortfolioDoesNotHaveAnExistingAccount: anAccount ].! !


!Portfolio methodsFor: 'private' stamp: 'LD 10/16/2024 13:49:28'!
checkAccount: anAccount

	(self hasAccount: anAccount) ifTrue: [ self error: Portfolio portfolioCannotBeAddedDueToExistenceOfChildAccountAlreadyInAnotherPortfolioErrorMessage ].
	
	parents do: [ :parent | parent checkAccount: anAccount ].! !

!Portfolio methodsFor: 'private' stamp: 'LD 10/16/2024 13:50:08'!
collectAllChildAccountsIn: aCollectionOfAccounts
	
	accounts do: [ :account | (account isKindOf: Portfolio) ifTrue: [ account collectAllChildAccountsIn: aCollectionOfAccounts] ifFalse: [ aCollectionOfAccounts add: account] ].! !

!Portfolio methodsFor: 'private' stamp: 'LD 10/16/2024 11:39:44'!
hasAccount: anAccount

	^accounts includes: anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error' stamp: 'LD 10/16/2024 13:49:09'!
accountAlreadyExistsErrorMessage

	^'Account already exists'.! !

!Portfolio class methodsFor: 'error' stamp: 'LD 10/16/2024 13:49:07'!
accountAlreadyInAChildPortfolioErrorMessage

	^'Account already included in a child portfolio'.! !

!Portfolio class methodsFor: 'error' stamp: 'LD 10/16/2024 13:49:06'!
accountCannotBeAddedAlreadyAChildAccountOfParentPortfolioErrorMessage

	^'Cannot add an account because is already added in a parent portfolio'.! !

!Portfolio class methodsFor: 'error' stamp: 'LD 10/16/2024 13:49:04'!
cannotAddYourselfErrorMessage

	^'Cannot add yourself'.! !

!Portfolio class methodsFor: 'error' stamp: 'LD 10/16/2024 13:49:28'!
portfolioCannotBeAddedDueToExistenceOfChildAccountAlreadyInAnotherPortfolioErrorMessage

	^'Cannot add portfolio to another one because it already has an existing account'.! !


!classDefinition: #ReceptiveAccount category: #'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'LD 10/16/2024 11:55:26'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'MP 10/17/2024 16:49:51'!
balance

	| balance |
	
	balance := 0 * peso.
	
	transactions do: [ :aTransaction | balance := aTransaction addToBalance: balance ].
	
	^balance.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'MP 10/11/2024 18:19:36'!
hasRegistered: aTransaction

	^transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'LD 10/16/2024 11:54:17'!
transactions 

	^transactions copy.! !


!classDefinition: #AccountTransaction category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'MP 10/11/2024 16:30:27'!
value

	^ value! !


!AccountTransaction methodsFor: 'initialization' stamp: 'MP 10/17/2024 16:10:24'!
createFor: aValue

	value := aValue ! !


!AccountTransaction methodsFor: 'balance' stamp: 'MP 10/11/2024 15:03:05'!
addToBalance: aBalance

	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'visitor' stamp: 'LD 10/17/2024 18:32:04'!
accept: aVisitor

	self subclassResponsibility.! !


!AccountTransaction methodsFor: 'report' stamp: 'MP 10/17/2024 16:04:31'!
asString
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'MP 10/17/2024 16:10:24'!
for: aValue

	^ self new createFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'balance' stamp: 'LD 10/10/2024 15:40:27'!
addToBalance: aBalance

	^value + aBalance.! !


!Deposit methodsFor: 'visitor' stamp: 'LD 10/17/2024 18:31:54'!
accept: aVisitor

	aVisitor visitDepositOrWithdraw: self.! !


!Deposit methodsFor: 'reports' stamp: 'LD 10/17/2024 18:37:42'!
asString

	^'Depósito por ',value asString.! !


!classDefinition: #DepositLeg category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!DepositLeg methodsFor: 'balance' stamp: 'MP 10/11/2024 16:26:37'!
addToBalance: aBalance

	^value + aBalance.! !


!DepositLeg methodsFor: 'counterpart' stamp: 'MP 10/11/2024 17:26:07'!
counterpartIn: aTransfer
	^aTransfer withdrawLeg.! !


!DepositLeg methodsFor: 'reports' stamp: 'LD 10/17/2024 18:37:34'!
asString

	^'Entrada por transferencia de ',value asString.! !


!DepositLeg methodsFor: 'visitor' stamp: 'LD 10/17/2024 18:32:11'!
accept: aVisitor

	aVisitor visitTransferLeg: self.! !


!classDefinition: #Withdraw category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'visitor' stamp: 'LD 10/17/2024 18:32:15'!
accept: aVisitor

	aVisitor visitDepositOrWithdraw: self.! !


!Withdraw methodsFor: 'balance' stamp: 'MP 10/11/2024 15:02:30'!
addToBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'reports' stamp: 'LD 10/17/2024 18:37:36'!
asString

	^'Extracción por ',value asString.! !


!classDefinition: #WithdrawLeg category: #'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!WithdrawLeg methodsFor: 'counterpart' stamp: 'MP 10/11/2024 17:25:51'!
counterpartIn: aTransfer
	^aTransfer depositLeg.! !


!WithdrawLeg methodsFor: 'balance' stamp: 'MP 10/11/2024 16:27:03'!
addToBalance: aBalance

	^aBalance - value! !


!WithdrawLeg methodsFor: 'visitor' stamp: 'LD 10/17/2024 18:32:17'!
accept: aVisitor

	aVisitor visitTransferLeg: self.! !


!WithdrawLeg methodsFor: 'reports' stamp: 'LD 10/17/2024 18:37:39'!
asString

	^'Salida por transferencia de ',value asString.! !


!classDefinition: #NetTransferVisitor category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #NetTransferVisitor
	instanceVariableNames: 'net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!NetTransferVisitor methodsFor: 'visitor' stamp: 'LD 10/17/2024 18:31:06'!
visitDepositOrWithdraw: anAccount

	^self.! !

!NetTransferVisitor methodsFor: 'visitor' stamp: 'LD 10/17/2024 18:31:08'!
visitTransferLeg: aTransferLeg

	net := aTransferLeg addToBalance: net.! !


!NetTransferVisitor methodsFor: 'net' stamp: 'LD 10/17/2024 18:31:04'!
net

	^net.! !


!NetTransferVisitor methodsFor: 'initialization' stamp: 'LD 10/17/2024 18:31:01'!
initialize

	net := 0 * peso.! !


!classDefinition: #Report category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Report methodsFor: 'reports' stamp: 'LD 10/17/2024 18:31:21'!
netTransfers

	| netVisitor |

	netVisitor := NetTransferVisitor new.
	
	account transactions do: [ :transaction | transaction accept: netVisitor ].

	^netVisitor net.! !

!Report methodsFor: 'reports' stamp: 'LD 10/17/2024 18:30:47'!
summary

       | summary transactions |
	summary := OrderedCollection new.
	transactions := account transactions.	

	transactions do: [ :transaction | summary add: transaction asString].
	
	summary add: 'Balance = ',account balance asString.
	
	^summary.! !


!Report methodsFor: 'initialization' stamp: 'LD 10/17/2024 18:30:55'!
initializeWith: anAccount

	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: #'ServiciosFinancieros-Ejercicio'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'instance creation' stamp: 'MP 10/17/2024 16:10:24'!
createFor: anAccount
	^self new initializeWith: anAccount! !


!classDefinition: #Transfer category: #'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'value' stamp: 'MP 10/7/2024 16:58:03'!
value
	^value! !


!Transfer methodsFor: 'initialization' stamp: 'MP 10/11/2024 16:51:01'!
initializeWith: aValue withdrawLeg: accountToBeWithdrawn depositLeg: accountToBeDeposited
	value := aValue.
	withdrawLeg := accountToBeWithdrawn.
	depositLeg := accountToBeDeposited.! !


!Transfer methodsFor: 'accessing' stamp: 'MP 10/11/2024 17:12:01'!
depositLeg
	^depositLeg ! !

!Transfer methodsFor: 'accessing' stamp: 'MP 10/11/2024 17:12:14'!
withdrawLeg
	^withdrawLeg! !


!Transfer methodsFor: 'as yet unclassified' stamp: 'MP 10/11/2024 17:26:18'!
counterpartOf: aTransferLeg 
	^aTransferLeg counterpartIn: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'MP 10/11/2024 16:54:34'!
register: aValue from: withdrawAccount to: depositAccount

	| depositLeg withdrawLeg |
	
	withdrawLeg := WithdrawLeg register: aValue on: withdrawAccount.
	depositLeg := DepositLeg register: aValue on: depositAccount.

	^self new initializeWith: aValue withdrawLeg: withdrawLeg  depositLeg: depositLeg.! !
