!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/16/2024 21:09:03'!
test08PortfolioCalculatesBalanceWIthOneAccount

	| account1 portfolio1 |
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 
	
	portfolio1 add: account1.
		
	self assert: (portfolio1 balance = 50).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/16/2024 21:09:15'!
test09PortfolioCalculatesBalanceWIthTwoAccounts

	| account1 account2 portfolio1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account1.
	Deposit register: 60 on: account2.
	
	portfolio1:= Portfolio new. 
	
	portfolio1 add: account1.
	portfolio1 add: account2.
		
	self assert: (portfolio1 balance = 110).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/16/2024 21:09:33'!
test10PortfolioCalculatesBalanceWIthPortfolio

	| account1 portfolio1 portfolio2|
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 
	portfolio2 := Portfolio  new.
	
	portfolio1 add: account1.
	
	portfolio2 add: portfolio1.
		
	self assert: (portfolio2 balance = 50).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/16/2024 21:09:41'!
test11CannotAddSameAccountTwice

	| account1 portfolio1|
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 

	
	portfolio1 add: account1.
	
	self should: [portfolio1 add: account1]
	raise: Error - MessageNotUnderstood 
	withMessageText: 'Cannot add account twice'
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/16/2024 21:09:53'!
test12CannotAddPortfolioWithAlreadyAddedAccount

	| account1 portfolio1 portfolio2|
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 
	portfolio2:= Portfolio new. 

	portfolio2 add: account1.	
	portfolio1 add: account1.
	
	self should: [portfolio2 add: portfolio1]
	raise: Error - MessageNotUnderstood 
	withMessageText: 'Cannot add account twice'
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/16/2024 21:10:09'!
test13CannotAddAccountThatIsInSubPortfolios

	| account1 portfolio1 portfolio2|
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 
	portfolio2:= Portfolio new. 

	portfolio2 add: account1.	
	portfolio1 add: portfolio2. 
	
	self should: [portfolio1 add: account1]
	raise: Error - MessageNotUnderstood 
	withMessageText: 'Cannot add account twice'
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/16/2024 21:30:22'!
test14CannotAddPortfolioWithRepeatedAccountsInTheSuperPortfolio

	| account1 portfolio1 portfolio2|
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 
	portfolio2:= Portfolio new. 
	
	portfolio1 add: portfolio2. 
	portfolio1 add: account1.
	
	self should: [portfolio2 add: account1]
	raise: Error - MessageNotUnderstood 
	withMessageText: 'Cannot add account twice'
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/16/2024 21:34:37'!
test15hasRegisteredReturnsTrueWhenItShould

	| account1 portfolio1 aDeposit|
	
	account1 := ReceptiveAccount new.
	
	aDeposit := Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 
	
	portfolio1 add: account1.
		
	self assert: (portfolio1 hasRegistered: aDeposit).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'ap 5/16/2024 21:40:02'!
test16canAskForAllTransactions

	| account1 portfolio1 aDepositCollection|
	
	account1 := ReceptiveAccount new.
	aDepositCollection := OrderedCollection new.
	aDepositCollection add:( Deposit register: 50 on: account1).
	aDepositCollection add:( Deposit register: 50 on: account1).
	aDepositCollection add:( Deposit register: 50 on: account1).
	
	portfolio1:= Portfolio new. 
	
	portfolio1 add: account1.
		
	self assert: (portfolio1 transactions = aDepositCollection).
! !


!classDefinition: #Account category: #'Portfolio-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: 'parentAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Account methodsFor: 'init' stamp: 'ap 5/16/2024 21:14:48'!
addParent: aPortfolio
	parentAccounts add: aPortfolio! !

!Account methodsFor: 'init' stamp: 'ap 5/16/2024 21:25:58'!
allReceptiveAccountsBelow

	self subclassResponsibility! !

!Account methodsFor: 'init' stamp: 'ap 5/16/2024 21:25:35'!
allReceptiveAccountsConnected
	parentAccounts isEmpty ifTrue: [^self allReceptiveAccountsBelow].
	^self superParents inject: OrderedCollection new into: [:allAccounts :aSuperParent | allAccounts addAll: aSuperParent allReceptiveAccountsConnected; yourself].
	
	
	! !

!Account methodsFor: 'init' stamp: 'ap 5/16/2024 21:12:21'!
balance

	self subclassResponsibility! !

!Account methodsFor: 'init' stamp: 'ap 5/16/2024 21:26:10'!
superParents
	parentAccounts isEmpty ifTrue: [^OrderedCollection with: self].
	^parentAccounts inject: OrderedCollection new into: [:accumulatedParents :currentParent| accumulatedParents addAll: currentParent superParents; yourself].
	! !


!Account methodsFor: 'testing' stamp: 'ap 5/16/2024 21:31:45'!
hasRegistered: aTransaction

	self subclassResponsibility! !


!Account methodsFor: 'transactions' stamp: 'ap 5/16/2024 21:37:26'!
transactions

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'Accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'init' stamp: 'ap 5/16/2024 21:19:19'!
allReceptiveAccountsBelow
	^ Accounts inject: OrderedCollection new into: [:accumulatedAccounts :currentPortfolio |
			accumulatedAccounts addAll: currentPortfolio allReceptiveAccountsBelow;yourself.
		]! !

!Portfolio methodsFor: 'init' stamp: 'ap 5/16/2024 21:20:21'!
balance
	^Accounts sum: [:account | account balance].! !

!Portfolio methodsFor: 'init' stamp: 'ap 5/16/2024 21:33:28'!
hasRegistered: aTransaction

	^Accounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction]! !

!Portfolio methodsFor: 'init' stamp: 'ap 5/16/2024 21:21:21'!
initialize
	Accounts := OrderedCollection  new.
	parentAccounts := OrderedCollection  new.
	! !

!Portfolio methodsFor: 'init' stamp: 'ap 5/16/2024 21:39:32'!
transactions

	^Accounts inject: OrderedCollection new into: [:aTransactionCollection :currentAccount | aTransactionCollection addAll: currentAccount transactions; yourself].! !


!Portfolio methodsFor: 'events-registering' stamp: 'ap 5/16/2024 21:17:41'!
add: aPortfolio
	|allAccountsInAPortfolio|
	allAccountsInAPortfolio := aPortfolio allReceptiveAccountsConnected.
	self allReceptiveAccountsConnected do:
		[:anAccount |
			(allAccountsInAPortfolio includes: anAccount) ifTrue:[self error: self class cannotAddAccountTwiceErrorDescription]
			].
	Accounts add: aPortfolio.
	aPortfolio addParent: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AP 5/16/2024 11:18:46'!
cannotAddAccountTwiceErrorDescription
	^'Cannot add account twice'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'ap 5/16/2024 21:21:45'!
initialize

	transactions := OrderedCollection new.
	parentAccounts := OrderedCollection  new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'AP 5/16/2024 10:03:36'!
balance

	^transactions inject: 0 into: [:currentBalance : currentTransaction | currentTransaction executeOver: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'ap 5/16/2024 21:18:40'!
allReceptiveAccountsBelow
	^OrderedCollection with: self.! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'AP 5/16/2024 10:04:00'!
executeOver: aBalance
	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'AP 5/16/2024 10:04:30'!
executeOver: aBalance
	^aBalance  + self value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'AP 5/16/2024 10:04:41'!
executeOver: aBalance
	^aBalance  - self value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !
