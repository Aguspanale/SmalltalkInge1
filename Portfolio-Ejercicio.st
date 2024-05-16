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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AP 5/16/2024 10:17:35'!
test08PortfolioCalculatesBalanceWIthOneAccount

	| account1 portfolio1 |
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 
	
	portfolio1 addAccount: account1.
		
	self assert: (portfolio1 balance = 50).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AP 5/16/2024 10:14:23'!
test09PortfolioCalculatesBalanceWIthTwoAccounts

	| account1 account2 portfolio1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account1.
	Deposit register: 60 on: account2.
	
	portfolio1:= Portfolio new. 
	
	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.
		
	self assert: (portfolio1 balance = 110).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AP 5/16/2024 10:23:34'!
test10PortfolioCalculatesBalanceWIthPortfolio

	| account1 portfolio1 portfolio2|
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 
	portfolio2 := Portfolio  new.
	
	portfolio1 addAccount: account1.
	
	portfolio2 addPortfolio: portfolio1.
		
	self assert: (portfolio2 balance = 50).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AP 5/16/2024 11:14:35'!
test11CannotAddSameAccountTwice

	| account1 portfolio1|
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 

	
	portfolio1 addAccount: account1.
	
	self should: [portfolio1 addAccount: account1]
	raise: Error - MessageNotUnderstood 
	withMessageText: 'Cannot add account twice'
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AP 5/16/2024 11:21:30'!
test12CannotAddPortfolioWithAlreadyAddedAccount

	| account1 portfolio1 portfolio2|
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 
	portfolio2:= Portfolio new. 

	portfolio2 addAccount: account1.	
	portfolio1 addAccount: account1.
	
	self should: [portfolio2 addPortfolio: portfolio1]
	raise: Error - MessageNotUnderstood 
	withMessageText: 'Cannot add account twice'
	
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'AP 5/16/2024 11:53:06'!
test13CannotAddAccountThatIsInSubPortfolios

	| account1 portfolio1 portfolio2|
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 50 on: account1.
	
	portfolio1:= Portfolio new. 
	portfolio2:= Portfolio new. 

	portfolio2 addAccount: account1.	
	portfolio1 addPortfolio: portfolio2. 
	
	self should: [portfolio1 addAccount: account1]
	raise: Error - MessageNotUnderstood 
	withMessageText: 'Cannot add account twice'
	
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


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'account accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'init' stamp: 'AP 5/16/2024 11:53:43'!
addAccount: anAccount
	(self allAccounts includes: anAccount) ifTrue: [self error: self class cannotAddAccountTwiceErrorDescription]. 
	accounts add: anAccount.
	! !

!Portfolio methodsFor: 'init' stamp: 'AP 5/16/2024 11:41:57'!
allAccounts
	|anAllAccounts|
	anAllAccounts := accounts.
	portfolios do: [:aPortFolio| anAllAccounts := anAllAccounts addAll: aPortFolio allAccounts; yourself].
	^anAllAccounts ! !

!Portfolio methodsFor: 'init' stamp: 'AP 5/16/2024 10:23:56'!
balance
	^(accounts sum: [:anAccount| anAccount balance] ifEmpty: 0) + (portfolios sum: [:aPortFolio | aPortFolio balance] ifEmpty: 0).! !

!Portfolio methodsFor: 'init' stamp: 'AP 5/16/2024 10:21:17'!
initialize
	accounts := OrderedCollection  new.
	portfolios  := OrderedCollection  new.! !


!Portfolio methodsFor: 'events-registering' stamp: 'AP 5/16/2024 11:34:34'!
addPortfolio: aPortfolio
	self allAccounts do:
		[:anAccount |
			(aPortfolio allAccounts includes: anAccount) ifTrue:[self error: self class cannotAddAccountTwiceErrorDescription]
			].
	portfolios add: aPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!


!Portfolio class methodsFor: 'as yet unclassified' stamp: 'AP 5/16/2024 11:18:46'!
cannotAddAccountTwiceErrorDescription
	^'Cannot add account twice'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


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


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
