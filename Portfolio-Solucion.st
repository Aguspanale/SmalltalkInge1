!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AP 5/20/2024 20:05:17'!
test08TransferAffectBalancesCorrectly

	| account1 account2 transfer1|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer1 := Transfer amount: 100 from: account1 to: account2.
		
	self assert: ((account1 balance = -100) and: (account2 balance = 100)).
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AP 5/20/2024 20:03:34'!
test09TransferKnowsBothSides

	| account1 account2 transfer1|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer1 := Transfer amount: 100 from: account1 to: account2.
		
	self assert: ((transfer1 receiverIs: account2) and: (transfer1 senderIs: account1)).
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AP 5/20/2024 20:22:36'!
test10TransferAppearsBothSides

	| account1 account2 transfer1|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer1 := Transfer amount: 100 from: account1 to: account2.
		
	self assert: ((account2 hasRegistered: transfer1 deposit) and: (account1 hasRegistered: transfer1 withdrawal)).
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AP 5/20/2024 20:50:01'!
test11TransferLegsKnowFather

	| account1 account2 transfer1|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer1 := Transfer amount: 100 from: account1 to: account2.
		
	self assert: (transfer1 deposit transfer = transfer1 withdrawal transfer).
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/21/2024 13:58:48'!
test12AccountSummarySummarizesDeposit

	| account1 |
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1 .
		
	self assert: (AccountSummaryMaker summarizeWith: account1) includes: 'Depósito por 100'.
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/21/2024 13:58:52'!
test13AccountSummarySummarizesWithdrawal

	| account1 |
	
	account1 := ReceptiveAccount new.
	
	Withdraw register: 100 on: account1 .
		
	self assert: (AccountSummaryMaker summarizeWith: account1) includes: 'Extracción por 100'.
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/21/2024 13:58:58'!
test14AccountSummarySummarizesMultipleDeposits

	| account1 |
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1 .
	Deposit register: 120 on: account1 .
		
	self assert: (AccountSummaryMaker summarizeWith: account1) includes: 'Depósito por 100'.
	self assert: (AccountSummaryMaker summarizeWith: account1) includes: 'Depósito por 120'.
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/21/2024 13:59:05'!
test15AccountSummarySummarizesTransfer

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer amount: 100 from: account1 to: account2.
		
	self assert: (AccountSummaryMaker summarizeWith: account1) includes: 'Salida por transferencia de 100'.
	self assert: (AccountSummaryMaker summarizeWith: account2) includes: 'Entrada por transferencia de 100'.
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/21/2024 13:59:08'!
test16AccountSummarySummarizesBalance

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer amount: 100 from: account1 to: account2.
		
	self assert: (AccountSummaryMaker summarizeWith: account1) includes: 'Balance -100'.
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/21/2024 14:00:08'!
test17TransferNetAddsReceptions

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer amount: 100 from: account1 to: account2.
		
	self assert: ((TransferNetSummaryMaker summarizeWith: account1) = -100 and: account2 transferNet = 100)
	
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/21/2024 14:00:22'!
test18TransferNetDoesNotCountDepositsOrWithdrawals

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer amount: 100 from: account1 to: account2.
	Deposit register: 10 on: account1. 
	Withdraw register: 10 on: account2. 
		
	self assert: ((TransferNetSummaryMaker summarizeWith: account1) = -100 and: account2 transferNet = 100)
	
	
! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AP 5/20/2024 20:17:02'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'inspecting' stamp: 'ap 5/21/2024 13:25:37'!
accountSummary
	|summary|
	
	summary := transactions inject: OrderedCollection new into: [:currentSummary :currentTransaction |
		(currentTransaction isKindOf: Deposit) ifTrue:[currentSummary add: 'Depósito por ',currentTransaction value asString.].
		(currentTransaction isKindOf: Withdraw) ifTrue:[currentSummary add: 'Extracción por ',currentTransaction value asString.].
		(currentTransaction isKindOf: CashDispatch) ifTrue:[currentSummary add: 'Salida por transferencia de ',currentTransaction value asString.].
		(currentTransaction isKindOf: CashReception) ifTrue:[currentSummary add: 'Entrada por transferencia de ',currentTransaction value asString.].
		currentSummary
		].
	summary add: 'Balance ',self balance asString.
	^summary ! !

!ReceptiveAccount methodsFor: 'inspecting' stamp: 'ap 5/21/2024 13:48:13'!
summarizeWith: aSummarizer
	^aSummarizer summarizeWithTransactionsAndBalance value:transactions value: self balance.! !

!ReceptiveAccount methodsFor: 'inspecting' stamp: 'ap 5/21/2024 13:34:39'!
transferNet
	
	
	^transactions sum: [:aTransaction | 
		|aValue|
		aValue := 0.
		(aTransaction isKindOf: CashDispatch) ifTrue:[aValue := aValue - aTransaction value].
		(aTransaction isKindOf: CashReception) ifTrue:[aValue := aValue + aTransaction value].
		aValue
		].! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'AP 5/20/2024 20:16:33'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'AP 5/20/2024 20:16:15'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'value transferRepresented'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'AP 5/20/2024 20:50:34'!
initializeFrom: aTransfer
	transferRepresented := aTransfer .
	! !

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'AP 5/20/2024 20:43:45'!
transfer
	^transferRepresented! !

!TransferLeg methodsFor: 'as yet unclassified' stamp: 'AP 5/20/2024 20:44:08'!
value

	^ self transfer value! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'AP 5/20/2024 20:56:45'!
registerFrom: aTransfer for: anAccount
	|transaction|
	
	transaction := self new initializeFrom: aTransfer.
	anAccount register: transaction.
	^transaction! !


!classDefinition: #CashDispatch category: #'Portfolio-Solucion'!
TransferLeg subclass: #CashDispatch
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!CashDispatch methodsFor: 'as yet unclassified' stamp: 'AP 5/20/2024 20:57:46'!
affectBalance: aBalance

	^aBalance - self value.! !


!classDefinition: #CashReception category: #'Portfolio-Solucion'!
TransferLeg subclass: #CashReception
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!CashReception methodsFor: 'as yet unclassified' stamp: 'AP 5/20/2024 20:51:34'!
affectBalance: aBalance

	^aBalance + self value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CashReception class' category: #'Portfolio-Solucion'!
CashReception class
	instanceVariableNames: ''!

!CashReception class methodsFor: 'as yet unclassified' stamp: 'AP 5/20/2024 20:41:04'!
register: aValue on: account from: aTransfer

	| transaction |
	
	transaction := self new initializeFor: aValue from: aTransfer .
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'AP 5/20/2024 20:16:25'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Summarizer category: #'Portfolio-Solucion'!
Object subclass: #Summarizer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Summarizer methodsFor: 'as yet unclassified' stamp: 'ap 5/21/2024 13:44:02'!
accountSummary: anAccount
	^anAccount summarizeWith: self.
	

	! !

!Summarizer methodsFor: 'as yet unclassified' stamp: 'ap 5/21/2024 13:57:04'!
summarizeWithTransactionsAndBalance

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Summarizer class' category: #'Portfolio-Solucion'!
Summarizer class
	instanceVariableNames: ''!

!Summarizer class methodsFor: 'as yet unclassified' stamp: 'ap 5/21/2024 13:50:30'!
summarizeWith: anAccount
	^self new accountSummary: anAccount.! !


!classDefinition: #AccountSummaryMaker category: #'Portfolio-Solucion'!
Summarizer subclass: #AccountSummaryMaker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryMaker methodsFor: 'as yet unclassified' stamp: 'ap 5/21/2024 13:56:59'!
summarizeWithTransactionsAndBalance
	
	^[:transactions :balance | |summary|
		summary := transactions inject: OrderedCollection new into: [:currentSummary :currentTransaction |
		(currentTransaction isKindOf: Deposit) ifTrue:[currentSummary add: 'Depósito por ',currentTransaction value asString.].
		(currentTransaction isKindOf: Withdraw) ifTrue:[currentSummary add: 'Extracción por ',currentTransaction value asString.].
		(currentTransaction isKindOf: CashDispatch) ifTrue:[currentSummary add: 'Salida por transferencia de ',currentTransaction value asString.].
		(currentTransaction isKindOf: CashReception) ifTrue:[currentSummary add: 'Entrada por transferencia de ',currentTransaction value asString.].
		currentSummary
		].
	summary add: 'Balance ',balance asString.
	summary]! !


!classDefinition: #TransferNetSummaryMaker category: #'Portfolio-Solucion'!
Summarizer subclass: #TransferNetSummaryMaker
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetSummaryMaker methodsFor: 'as yet unclassified' stamp: 'ap 5/21/2024 13:58:19'!
summarizeWithTransactionsAndBalance

	^[:transactions :balance | transactions sum: [:aTransaction | 
		|aValue|
		aValue := 0.
		(aTransaction isKindOf: CashDispatch) ifTrue:[aValue := aValue - aTransaction value].
		(aTransaction isKindOf: CashReception) ifTrue:[aValue := aValue + aTransaction value].
		aValue
		].].! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'senderAccount receiverAccount amount deposit withdrawal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'AP 5/20/2024 20:55:25'!
initializeTransferOf: anAmount from: aSenderAccount to: aReceiverAccount 
	amount := anAmount.
	senderAccount := aSenderAccount.
	receiverAccount := aReceiverAccount.
	withdrawal := CashDispatch registerFrom: self for: aSenderAccount .
	deposit := CashReception registerFrom: self for: aReceiverAccount . ! !

!Transfer methodsFor: 'initialization' stamp: 'AP 5/20/2024 19:50:55'!
receiverIs: anAccount 
	^receiverAccount = anAccount! !

!Transfer methodsFor: 'initialization' stamp: 'AP 5/20/2024 19:51:03'!
senderIs: anAccount 
	
	^senderAccount = anAccount! !


!Transfer methodsFor: 'accessing' stamp: 'AP 5/20/2024 20:20:21'!
deposit
	^deposit! !

!Transfer methodsFor: 'accessing' stamp: 'AP 5/20/2024 20:52:07'!
value
	^amount! !

!Transfer methodsFor: 'accessing' stamp: 'AP 5/20/2024 20:20:44'!
withdrawal
	^withdrawal! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'AP 5/20/2024 19:49:14'!
amount: anAmount from: aSenderAccount to: aReceiverAccount 
	^self new initializeTransferOf: anAmount from: aSenderAccount to: aReceiverAccount.! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'AP 5/20/2024 19:48:22'!
receiverIs: account2 
	self shouldBeImplemented.! !
