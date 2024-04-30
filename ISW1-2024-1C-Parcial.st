!classDefinition: #FloorTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #FloorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!FloorTest methodsFor: 'testing' stamp: 'ap 4/29/2024 20:44:31'!
creatingFloorWithRooms: roomAmount andPrices: aPriceList shouldFailWith: errorMessage

	^ self
		should: [Floor floorWithRoomAmount: roomAmount andPrices: aPriceList ]
		raise: Error - MessageNotUnderstood 
		withMessageText: errorMessage! !

!FloorTest methodsFor: 'testing' stamp: 'ap 4/29/2024 20:45:01'!
creatingFloorWithRooms: roomAmount shouldFailWith: errorMessage
	^self creatingFloorWithRooms: roomAmount andPrices: self defaultPriceList shouldFailWith: errorMessage
	! !

!FloorTest methodsFor: 'testing' stamp: 'ap 4/29/2024 20:41:04'!
test01CannotCreateFloorWithoutRooms

	self creatingFloorWithRooms: 0 shouldFailWith: Floor numberOfRoomsMustBePositiveErrorDescription.! !

!FloorTest methodsFor: 'testing' stamp: 'ap 4/29/2024 20:41:45'!
test02CannotCreateFloorWithNoIntergerNumberOfRooms
	self creatingFloorWithRooms: 1.5 shouldFailWith: Floor numberOfRoomsMustBeIntegerErrorDescription .
	! !

!FloorTest methodsFor: 'testing' stamp: 'ap 4/29/2024 20:43:06'!
test03CannotCreateFloorWithoutPrices

	self creatingFloorWithRooms: 10 andPrices: Dictionary new shouldFailWith: Floor pricesListCannotBeEmptyErrorDescription.! !

!FloorTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:21:40'!
test04WhenAFloorIsCreatedAllTheRoomsAreAvailable

	| floor |
	
	floor :=  Floor floorWithRoomAmount: 10 andPrices: self defaultPriceList.
	
	self assert: floor allRoomsAvailable.
	self assert: 0 equals: floor totalRoomsOccupied.
	self assert: 0 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:19:48'!
test05WhenAFloorReceivesAGuestInARoomReducesTheAvailableRoomsByOneAndIncreaseOccupiedByOne

	| floor |
	
	floor := Floor floorWithRoomAmount: 10 andPrices: self defaultPriceList.
	
	"Tech Debt"
	floor receive: self guestTypeVacation at: 1.
	
	self assert: 9 equals: floor totalRoomsAvailable. 
	self assert: 1 equals: floor totalRoomsOccupied.
	self assert: 0 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:19:55'!
test06WhenAFloorReceivesOnReservationAGuestInARoomKeepsTheAvailableRoomsIncreasesOccupiedAndReducesTheReservedByOne

	| floor roomsAvailable roomsOccupied roomsReserved |
	
	
	floor := Floor floorWithRoomAmount: 10 andPrices: self defaultPriceList.
	
	"Tech Debt"
	floor reserveAt: 1.

	roomsAvailable := floor totalRoomsAvailable.
	roomsOccupied := floor totalRoomsOccupied.
	roomsReserved := floor totalRoomsReserved.

	"Tech Debt"
	floor receiveWithReservation: self guestTypeVacation at: 1.
	
	self assert: roomsAvailable equals: floor totalRoomsAvailable. 
	self assert: roomsOccupied  + 1 equals: floor totalRoomsOccupied.
	self assert: roomsReserved - 1 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'ap 4/29/2024 20:46:59'!
test07WhenARoomIsReservedTheFloorAvailableRoomsReducesByOneAndIncreaseReservedByOne

	| floor  |
	
	
	floor := Floor floorWithRoomAmount: 10 andPrices: self defaultPriceList.
	
	"Tech Debt"
	floor reserveAt: 1.
	
	self assert: 9 equals: floor totalRoomsAvailable. 
	self assert: 1 equals: floor totalRoomsUnavailable. "Occupied here meant Unavailable, it was ambiguous"
	self assert: 1 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:20:04'!
test08TotalProfitShouldBeTheSumOfOccupiedRoomsProfits

	| floor |
	
	
	floor := Floor floorWithRoomAmount: 10 andPrices: self defaultPriceList.
	
	"Tech Debt"
	floor receive: self guestTypeVacation at: 1.
	floor receive: self guestTypeConference at: 2 .
	floor reserveAt: 3.
		
	self assert: (100*peso) + (200*peso) + (50*peso) equals: floor totalProfits
! !

!FloorTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:20:11'!
test09TotalLossesShouldBeTheSumOfAvailableRoomsLosses

	| floor |
	
	
	floor := Floor floorWithRoomAmount: 10 andPrices: self defaultPriceList.
	
	"Tech Debt"
	floor receive: self guestTypeVacation at: 1.
	floor receive: self guestTypeConference at: 2 .
	floor reserveAt: 3.
		
	self assert: (200*peso) * 7 equals: floor totalLosses
! !


!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 17:01:23'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: 100*peso;
		at: self guestTypeConference put: 200*peso;
		yourself ! !

!FloorTest methodsFor: 'create' stamp: 'ap 4/29/2024 21:14:16'!
guestTypeConference
	
	^ #ConferenceGuest ! !

!FloorTest methodsFor: 'create' stamp: 'ap 4/29/2024 21:14:21'!
guestTypeVacation
	
	^ #VacationGuest ! !


!classDefinition: #HotelTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #HotelTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:00:08'!
should: aBlock with: aHotel failPreserveRoomsAndRaise: anErrorText

	^ self 
	should: aBlock
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: anErrorText equals: error messageText.
		
		self assert: aHotel	 totalRooms equals: aHotel totalRoomsAvailable.
		self assert: 0 equals: aHotel totalRoomsReserved.
		self assert: 0 equals: aHotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:19:32'!
shouldNotReceiveWithReservationAtNonExistentRoomAndShouldPreserveReservation: hotel

	^ self 
	should: [ 	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel roomNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
		self assert: 1 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 17:41:08'!
test01CannotCreateHotelWithoutFloors

	self
		should: [ Hotel withFloors: OrderedCollection new. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Hotel noFloorsErrorDescription.! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 17:42:19'!
test02NewHotelsAreEmpty

	| hotel |
	
	hotel := Hotel withFloors: self defaultFloors .
	
	self assert: hotel isEmpty.! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 17:42:32'!
test03HotelCanReceiveATypeOfGuestInRoomAtFloor

	| hotel |
	
	hotel := Hotel withFloors: self defaultFloors .
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 2.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 0 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsOccupied.
! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 20:48:51'!
test04HotelCanTakeAReservationForARoomAtFloor

	| hotel |
	
	hotel := Hotel withFloors: self defaultFloors .

	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel reserveRoom: 2 atFloor: 1.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 1 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsUnavailable. "Occupied here meant Unavailable, it was ambiguous"! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 17:42:43'!
test05HotelCanReceiveWithReservationATypeOfGuestInRoomAtFloor

	| hotel |
	
	hotel := Hotel withFloors: self defaultFloors .
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel reserveRoom: 2 atFloor: 1.
	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 2.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 0 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsOccupied.
! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 17:42:49'!
test06HotelCannotReceiveWithReservationWithoutPreviousReservation
	
	| hotel |
	
	hotel := Hotel withFloors: self defaultFloors .
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	self 
		should: [ 	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [		:error |	
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.
			
			self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
			self assert: 0 equals: hotel totalRoomsReserved.
			self assert: 0 equals: hotel totalRoomsOccupied.
		]


! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:19:14'!
test07HotelProfitsAreTheSumOfEachFloorProfits
	
	| hotel floor1 floor2 floors |
	
	
	floor1 := self defaultlyPricedTenRoomFloor.
	floor2 := self defaultlyPricedTenRoomFloor.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel withFloors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	self assert: floor1 totalProfits + floor2 totalProfits equals:		hotel totalProfits.! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 17:59:30'!
test08HotelLossesAreTheSumOfEachFloorLosses
	
	| hotel floor1 floor2 floors |
	
	
	floor1 := self defaultlyPricedTenRoomFloor.
	floor2 := self defaultlyPricedTenRoomFloor.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel new setFloors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	hotel reserveRoom: 4 atFloor: 1.
	hotel reserveRoom: 2 atFloor: 2.

	self assert: floor1 totalLosses + floor2 totalLosses equals:		hotel totalLosses.! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:01:53'!
test09HotelCannotReserveANonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self defaultlyPricedTenRoomFloor.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
	self should: [ 	hotel reserveRoom: 42 atFloor: 1. ] with: hotel failPreserveRoomsAndRaise: Hotel roomNumberDoesNotExistErrorDescription.
	
! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:03:09'!
test10HotelCannotReserveANonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := self defaultlyPricedTenRoomFloor.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
		self should: [ 	hotel reserveRoom: 1 atFloor: 42. ] with: hotel failPreserveRoomsAndRaise: Hotel floorNumberDoesNotExistErrorDescription.
	! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:03:54'!
test11HotelCannotReceiveAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self defaultlyPricedTenRoomFloor.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
	self should: [ 	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 42. ] with: hotel failPreserveRoomsAndRaise: Hotel roomNumberDoesNotExistErrorDescription.
	
	! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:04:37'!
test12HotelCannotReceiveAtNonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := self defaultlyPricedTenRoomFloor.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
	self should: [ 	hotel receive: self guestTypeVacation atFloor: 42 atRoom: 1. ] with: hotel failPreserveRoomsAndRaise: Hotel floorNumberDoesNotExistErrorDescription.
	
	! !

!HotelTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:06:33'!
test13HotelCannotReceiveWithReservationAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self defaultlyPricedTenRoomFloor.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.

	hotel reserveRoom: 1 atFloor: 1. 
	
	self shouldNotReceiveWithReservationAtNonExistentRoomAndShouldPreserveReservation: hotel! !


!HotelTest methodsFor: 'create' stamp: 'ap 4/29/2024 19:30:08'!
defaultFloors

	^ OrderedCollection with: (self defaultlyPricedTenRoomFloor )
					     with: (Floor floorWithRoomAmount: 1 andPrices: self defaultPriceList )! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:22'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: self minPriceInList;
		at: self guestTypeConference put: self maxPriceInList;
		yourself ! !

!HotelTest methodsFor: 'create' stamp: 'ap 4/29/2024 17:59:30'!
defaultlyPricedTenRoomFloor

	^ Floor floorWithRoomAmount: 10 andPrices: self defaultPriceList! !

!HotelTest methodsFor: 'create' stamp: 'ap 4/29/2024 21:14:25'!
guestTypeConference
	
	^ #ConferenceGuest ! !

!HotelTest methodsFor: 'create' stamp: 'ap 4/29/2024 21:14:29'!
guestTypeVacation
	
	^ #VacationGuest ! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:48'!
maxPriceInList
	
	^ 200*peso ! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:53'!
minPriceInList
	
	^ 100*peso ! !


!classDefinition: #RoomTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #RoomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 20:55:24'!
room: aRoom shouldProfit: aProfit

	^ self assert: aProfit 
		equals: (aRoom  profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ])! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:21:40'!
test01NewRoomsAreAvailable

	| room |
	
	room := Room empty.

	self assert: room allRoomsAvailable.
	
	self deny: room isOccupied.
	self deny: room isReserved.! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:21:40'!
test02ReceivingAGuestMakesTheRoomOccupied

	| room |
	
	room := Room empty.

	room receive: #VacationGuest.

	self assert: room isOccupied.

	self deny: room allRoomsAvailable.
	self deny: room isReserved.! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:21:40'!
test03ReservingARoomMakesTheRoomUnavailable

	| room |
	
	room := Room empty.

	room reserve.

	self assert: room isUnavailable. "Occupied here meant Unavailable, it was ambiguous"

	self deny: room allRoomsAvailable.
! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:21:40'!
test04CannotReceiveAGuestInAOccupiedRoom

	| room |
	
	room := Room empty.

	room receive: #VacationGuest.
	
	self 
		should: [ room receive: self guestTypeVacation] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotEmptyErrorDescription equals: error messageText.

			self assert: room isOccupied.
			
			self deny: room allRoomsAvailable.
			self deny: room isReserved.
		]
	
! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:21:40'!
test05CannotReceiveAGuestInAReservedRoom

	| room |
	
	room := Room empty.

	room reserve.
	
	self 
		should: [ room receive: #VacationGuest ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotEmptyErrorDescription equals: error messageText.
			
			self assert: room isUnavailable.
			
			self deny: room allRoomsAvailable.
		]

	

	
! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:21:40'!
test06ReceivingOnReservationMakesTheRoomUnavailable

	| room |
	
	room := Room empty.

	room reserve.
	
	room receiveWithReservation: #VacationGuest.
	
	self assert: room isUnavailable. "Occupied here meant Unavailable, it was ambiguous!!"
	
	self deny: room isReserved.
	self deny: room allRoomsAvailable.
! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:21:40'!
test07CannotReceiveOnReservationAnAvailableRoom

	| room |
	
	room := Room empty.

	self 
		should: [ room receiveWithReservation: #VacationGuest] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.

			self assert: room allRoomsAvailable.

			self deny: room isReserved.
			self deny: room isOccupied.
		]

	
! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:21:40'!
test08CannotReceiveOnReservationAnOccupiedRoom

	| room |
	
	room := Room empty.

	room receive: #VacationGuest.

	self 
		should: [ room receiveWithReservation: #VacationGuest] 
		raise: Error - MessageNotUnderstood 	
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.
			
			self assert: room isOccupied.

			self deny: room isReserved.
			self deny: room allRoomsAvailable.
		]

	
! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 18:06:55'!
test09ProfitOfAvailableRoomIsCeroPesos

	| room |
	
	room := Room empty.

	self assert: 0*peso equals: (room profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
	
! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 18:06:57'!
test10ProfitOfReservedRoomIsHalfTheMinPriceInList

	| room |
	
	room := Room empty.

	room reserve.

	self assert: self minPriceInList / 2 equals: (room profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 21:15:36'!
test11ProfitOfOccupiedRoomDependsOnGuestType

	| roomWithConferenceGuest roomWithVacationGuest |
	
	roomWithConferenceGuest := Room empty receive: #ConferenceGuest.
	roomWithVacationGuest := Room empty receive: #VacationGuest.


	self room: roomWithConferenceGuest shouldProfit: (self defaultPriceList at: self guestTypeConference).
	self room: roomWithVacationGuest shouldProfit: (self defaultPriceList at: self guestTypeVacation).
	
! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 18:34:16'!
test12NoProfitOnOccupiedRoomByUnknownGuestType

	| room |
	
	room := Room empty.
	room receive: #unknownGuest.
	
	room profitUsing: self defaultPriceList ifAbsentGuestType: [ ^self ].
	
	self failWith: 'should not calculate profit on room occupied by unknown guest type'.
! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 20:26:43'!
test13LossesOfAvailableRoomIsTheMaxPriceInList
		| room |
	
		room := Room empty.

		self assert: self maxPriceInList equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
	! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 20:24:26'!
test14LossesOfReservedRoomIsCeroPesos

		| room |
	
		room := Room empty.

		room reserve.

		self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).

! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 20:24:54'!
test15LossesOfOccupiedRoomIsCeroPesos

		| room |
		
		room := Room empty.

		room receive: self guestTypeVacation.

		self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 18:07:21'!
test16CannotReserveWhenReserved

	| room |
	
	room := Room empty.

	room reserve.

	self 
		should: [ room reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room roomIsNotEmptyErrorDescription equals: anError messageText.
			self assert: room isReserved ].! !

!RoomTest methodsFor: 'testing' stamp: 'ap 4/29/2024 18:07:26'!
test17CannotReserveWhenOccupied

	| room |
	
	room := Room empty.

	room receive: self guestTypeVacation.

	self 
		should: [ room reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room roomIsNotEmptyErrorDescription equals: anError messageText.
			self assert: room isOccupied ].! !


!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:16:28'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: self minPriceInList;
		at: self guestTypeConference put: self maxPriceInList;
		yourself ! !

!RoomTest methodsFor: 'create' stamp: 'ap 4/29/2024 21:13:54'!
guestTypeConference
	
	^ #ConferenceGuest.! !

!RoomTest methodsFor: 'create' stamp: 'ap 4/29/2024 21:13:58'!
guestTypeVacation
	
	^ #VacationGuest! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:16:13'!
maxPriceInList
	
	^ 200*peso ! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:40:38'!
minPriceInList
	
	^ 100*peso ! !


!classDefinition: #Floor category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Floor
	instanceVariableNames: 'rooms prices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Floor methodsFor: 'testing' stamp: 'ap 4/29/2024 21:21:40'!
allRoomsAvailable
	
	^ self totalRooms = self totalRoomsAvailable

		
! !


!Floor methodsFor: 'accessing' stamp: 'ap 4/29/2024 21:21:40'!
isEmpty
	rooms collect: [:aRoom | aRoom allRoomsAvailable ifFalse: [^false]].
	^true! !

!Floor methodsFor: 'accessing' stamp: 'ap 4/29/2024 20:00:48'!
size
	^ rooms size! !


!Floor methodsFor: 'accounting' stamp: 'ap 4/29/2024 21:21:40'!
totalLosses
	
	| total |
	
	total := 0*peso.
	rooms do: [ :room | room allRoomsAvailable ifTrue: [ total := total + prices values max ] ].

	^ total

		
! !

!Floor methodsFor: 'accounting' stamp: 'ap 4/29/2024 19:39:00'!
totalProfits

	^rooms sum: [	:room | room profitUsing: prices ifAbsentGuestType: [ self class signalUnknownGuestType ]]

	
! !


!Floor methodsFor: 'totals' stamp: 'FRT 4/21/2024 14:49:55'!
totalRooms
	
	^ rooms size
		
! !

!Floor methodsFor: 'totals' stamp: 'ap 4/29/2024 21:21:40'!
totalRoomsAvailable
	
	^rooms count: [ :room | room allRoomsAvailable ]
		
! !

!Floor methodsFor: 'totals' stamp: 'ap 4/29/2024 20:18:49'!
totalRoomsOccupied
	
	^rooms count: [ :room | room isOccupied ]
		
! !

!Floor methodsFor: 'totals' stamp: 'ap 4/29/2024 20:18:39'!
totalRoomsReserved
	
	^rooms count: [ :room | room isReserved ]
		
! !

!Floor methodsFor: 'totals' stamp: 'ap 4/29/2024 20:04:25'!
totalRoomsUnavailable
	^ rooms count: [:room | room isUnavailable]! !


!Floor methodsFor: 'initialization' stamp: 'ap 4/29/2024 19:30:58'!
initializeRoomsWith: aNumberOfRooms

	rooms := OrderedCollection new.
	aNumberOfRooms timesRepeat: [rooms add: Room empty.]
	
! !

!Floor methodsFor: 'initialization' stamp: 'ap 4/29/2024 17:17:26'!
initializeWithRooms: aNumberOfRooms andPrice: aPriceList
	self initializeRoomsWith: aNumberOfRooms .
	prices := aPriceList.! !


!Floor methodsFor: 'operate' stamp: 'ap 4/29/2024 20:10:59'!
atRoom: aRoomNumber ifAbsent: aBlock
	^rooms at: aRoomNumber ifAbsent: aBlock.! !

!Floor methodsFor: 'operate' stamp: 'ap 4/29/2024 20:14:24'!
receive: aGuest at: aRoomNumber
	(rooms at: aRoomNumber) receive: aGuest.! !

!Floor methodsFor: 'operate' stamp: 'ap 4/29/2024 20:15:45'!
receiveWithReservation: aGuest at: aRoomNumber
	(rooms at: aRoomNumber) receiveWithReservation: aGuest.! !

!Floor methodsFor: 'operate' stamp: 'ap 4/29/2024 20:07:12'!
reserveAt: aRoomNumber
	(rooms at: aRoomNumber) reserve.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Floor class' category: #'ISW1-2024-1C-Parcial'!
Floor class
	instanceVariableNames: ''!

!Floor class methodsFor: 'assertions' stamp: 'FRT 4/20/2024 19:39:26'!
assertIsInteger: aNumber ifFalse: signalsBlock

	aNumber isInteger ifFalse: signalsBlock! !

!Floor class methodsFor: 'assertions' stamp: 'FRT 4/20/2024 19:40:06'!
assertIsPositive: aNumber ifFalse: signalsBlock

	aNumber strictlyPositive ifFalse: signalsBlock! !

!Floor class methodsFor: 'assertions' stamp: 'ap 4/29/2024 17:43:50'!
assertValidPrices: aPriceList andRooms: aNumberOfRooms

	self assertIsPositive: aNumberOfRooms ifFalse: [self error: self numberOfRoomsMustBePositiveErrorDescription].
	
	self assertIsInteger: aNumberOfRooms ifFalse: [self error: self numberOfRoomsMustBeIntegerErrorDescription ].
	
	aPriceList size > 0  ifFalse: [self error: self pricesListCannotBeEmptyErrorDescription ]! !


!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:02:53'!
numberOfRoomsMustBeIntegerErrorDescription
	
	^ 'Number of rooms must be integer'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:35:54'!
numberOfRoomsMustBePositiveErrorDescription
	
	^'The number of rooms must be positive'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:42:12'!
priceMustBeIntegerErrorDescription
	
	^ 'Price must be integer'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:42:25'!
priceMustBePositiveErrorDescription
	
	^'Price must be positive'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/21/2024 14:43:01'!
pricesListCannotBeEmptyErrorDescription 
	
	^ 'Prices List must not be empty'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/21/2024 14:47:30'!
unknownGuestTypeErrorDescription
	
	^ 'The guest type is unknown'! !


!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/21/2024 14:42:33'!
signalNoPrices
	
	self error: self pricesListCannotBeEmptyErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:02:35'!
signalNumberOfRoomsMustBeInteger
	
	self error: self numberOfRoomsMustBeIntegerErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:35:54'!
signalNumberOfRoomsMustBePositive

	self error: self numberOfRoomsMustBePositiveErrorDescription! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:41:37'!
signalPriceMustBeInteger
	
	self error: self priceMustBeIntegerErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:41:58'!
signalPriceMustBePositive

	self error: self priceMustBePositiveErrorDescription! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/21/2024 14:48:09'!
signalUnknownGuestType

	self error: self class unknownGuestTypeErrorDescription
! !


!Floor class methodsFor: 'creation' stamp: 'ap 4/29/2024 17:40:05'!
floorWithRoomAmount: aNumberOfRooms andPrices: aPriceList

	self assertValidPrices: aPriceList andRooms: aNumberOfRooms.
	
	^self new initializeWithRooms: aNumberOfRooms andPrice: aPriceList.! !


!classDefinition: #Hotel category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Hotel
	instanceVariableNames: 'floors availableRoomsCount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Hotel methodsFor: 'accounting' stamp: 'ap 4/29/2024 20:36:36'!
totalLosses

	^floors sum: [:aFloor | aFloor totalLosses]. 

! !

!Hotel methodsFor: 'accounting' stamp: 'ap 4/29/2024 20:36:54'!
totalProfits

	^floors sum: [:aFloor | aFloor totalProfits]. 
! !


!Hotel methodsFor: 'initialization' stamp: 'ap 4/29/2024 17:51:40'!
initializeWithFloors: aFloorList.

	floors := aFloorList.

	availableRoomsCount := self totalRooms .
! !


!Hotel methodsFor: 'setters' stamp: 'FRT 4/22/2024 11:50:40'!
setFloors: aFloorsCollection

	self class assertHaveFloors: aFloorsCollection.

	floors := aFloorsCollection.
	
	availableRoomsCount := self totalRooms.! !


!Hotel methodsFor: 'totals' stamp: 'ap 4/29/2024 20:00:54'!
totalRooms

	^ floors sum: [:aFloor | aFloor size].

! !

!Hotel methodsFor: 'totals' stamp: 'FRT 4/22/2024 11:43:00'!
totalRoomsAvailable

	^ availableRoomsCount.
! !

!Hotel methodsFor: 'totals' stamp: 'ap 4/29/2024 20:03:24'!
totalRoomsOccupied
	^floors sum: [:thisFloor |
		thisFloor totalRoomsOccupied.
		].


! !

!Hotel methodsFor: 'totals' stamp: 'ap 4/29/2024 20:20:39'!
totalRoomsReserved

	^floors sum: [:thisFloor | 
		thisFloor totalRoomsReserved.
		].

! !

!Hotel methodsFor: 'totals' stamp: 'ap 4/29/2024 20:20:47'!
totalRoomsUnavailable

	^floors sum: [:thisFloor | 
		thisFloor totalRoomsUnavailable.
		].

! !


!Hotel methodsFor: 'testing' stamp: 'ap 4/29/2024 19:26:32'!
isEmpty

	floors collect: [:aFloor | aFloor isEmpty ifFalse: [^false]].
	^true.! !


!Hotel methodsFor: 'guests' stamp: 'ap 4/29/2024 20:34:29'!
receive: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	(self roomAt: aRoomNumber atFloor: aFloorNumber)  receive: aGuestType.
	
	availableRoomsCount := availableRoomsCount - 1.
! !

!Hotel methodsFor: 'guests' stamp: 'ap 4/29/2024 20:34:52'!
receiveWithReservation: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	(self roomAt: aRoomNumber atFloor: aFloorNumber) receiveWithReservation: aGuestType.

! !

!Hotel methodsFor: 'guests' stamp: 'ap 4/29/2024 20:35:05'!
reserveRoom: aRoomNumber atFloor: aFloorNumber

	(self roomAt: aRoomNumber atFloor: aFloorNumber) reserve.
	
	availableRoomsCount := availableRoomsCount - 1.
! !


!Hotel methodsFor: 'rooms' stamp: 'ap 4/29/2024 20:33:57'!
roomAt: aRoomNumber atFloor: aFloorNumber 

	| floor |
	
	floor := floors at: aFloorNumber ifAbsent:  [ self class signalFloorNumberDoesNotExist ].
	^ floor atRoom: aRoomNumber ifAbsent: [ self class signalRoomNumberDoesNotExist ].

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Hotel class' category: #'ISW1-2024-1C-Parcial'!
Hotel class
	instanceVariableNames: ''!

!Hotel class methodsFor: 'assertions' stamp: 'HAW 4/29/2024 08:48:39'!
assertHaveFloors: aFloorsCollection

	aFloorsCollection isEmpty ifTrue: [ self signalNoFloors ].! !


!Hotel class methodsFor: 'error description' stamp: 'FRT 4/25/2024 21:42:02'!
floorNumberDoesNotExistErrorDescription

	^ 'Floor number does not exist'.! !

!Hotel class methodsFor: 'error description' stamp: 'FRT 4/20/2024 21:42:02'!
noFloorsErrorDescription

	^ 'Cannot have a Hotel without floors'! !

!Hotel class methodsFor: 'error description' stamp: 'FRT 4/25/2024 21:41:41'!
roomNumberDoesNotExistErrorDescription

	^ 'Room number does not exist'.! !


!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/25/2024 21:42:24'!
signalFloorNumberDoesNotExist

	self error: self floorNumberDoesNotExistErrorDescription.! !

!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 21:41:30'!
signalNoFloors

	self error: self noFloorsErrorDescription.! !

!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/25/2024 21:42:39'!
signalRoomNumberDoesNotExist

	self error: self roomNumberDoesNotExistErrorDescription.! !


!Hotel class methodsFor: 'instance creation' stamp: 'ap 4/29/2024 17:40:59'!
withFloors: aFloorList
	self assertHaveFloors: aFloorList .
	^self new initializeWithFloors: aFloorList.
	! !


!classDefinition: #Room category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Room
	instanceVariableNames: 'guest reserved occupationState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Room methodsFor: 'guests' stamp: 'ap 4/29/2024 21:12:12'!
guestType

	^ guest ! !

!Room methodsFor: 'guests' stamp: 'ap 4/29/2024 19:14:41'!
receive: aGuest

	occupationState receive: aGuest ! !

!Room methodsFor: 'guests' stamp: 'ap 4/29/2024 19:12:39'!
receiveWithReservation: aGuest
	
	occupationState canReceiveWithReservation: aGuest ! !

!Room methodsFor: 'guests' stamp: 'ap 4/29/2024 18:55:32'!
reserve

	occupationState reserve.! !


!Room methodsFor: 'testing' stamp: 'ap 4/29/2024 21:21:40'!
allRoomsAvailable

	^ occupationState allRoomsAvailable! !

!Room methodsFor: 'testing' stamp: 'ap 4/29/2024 18:55:32'!
isOccupied

	^ occupationState isOccupied 
! !

!Room methodsFor: 'testing' stamp: 'ap 4/29/2024 18:55:32'!
isReserved

	^ occupationState isReserved ! !

!Room methodsFor: 'testing' stamp: 'ap 4/29/2024 19:05:02'!
isUnavailable

	^ occupationState isUnavailable.! !


!Room methodsFor: 'accounting' stamp: 'ap 4/29/2024 20:23:21'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock


	^occupationState lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock
	! !

!Room methodsFor: 'accounting' stamp: 'ap 4/29/2024 19:53:54'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock


	^occupationState profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock
	! !


!Room methodsFor: 'instance creation' stamp: 'ap 4/29/2024 21:12:03'!
initializeWithGuest: aGuest
	guest := aGuest.
	occupationState := OccupiedRoomStatus of: self! !

!Room methodsFor: 'instance creation' stamp: 'ap 4/29/2024 21:13:06'!
initializeWithoutGuest
	guest := #noGuest.
	occupationState := AvailableRoomStatus of: self! !


!Room methodsFor: 'private' stamp: 'ap 4/29/2024 20:30:04'!
lossWhenAvailable: aPriceList

	^ aPriceList max.! !

!Room methodsFor: 'private' stamp: 'ap 4/29/2024 20:30:47'!
lossWhenUnavailable

	^ 0 * peso.! !

!Room methodsFor: 'private' stamp: 'ap 4/29/2024 19:17:55'!
profitWhenAvailable

	^ 0*peso! !

!Room methodsFor: 'private' stamp: 'ap 4/29/2024 21:18:53'!
profitWhenOccupiedUsing: aPriceList ifAbsentGuessType: unknownGuestTypeBlock

	^ aPriceList at: guest ifAbsent: unknownGuestTypeBlock! !

!Room methodsFor: 'private' stamp: 'ap 4/29/2024 19:18:28'!
profitWhenReservedWith: aPriceList

	^ aPriceList values min / 2! !

!Room methodsFor: 'private' stamp: 'ap 4/29/2024 19:14:22'!
receiveWhenAvailable: aGuest
	guest := aGuest.
	occupationState := OccupiedRoomStatus of: self! !

!Room methodsFor: 'private' stamp: 'ap 4/29/2024 19:14:00'!
receiveWhenUnavailable
	 self error: self class roomIsNotEmptyErrorDescription ! !

!Room methodsFor: 'private' stamp: 'ap 4/29/2024 19:10:52'!
receiveWithReservationWhenNotReserved
	self error: self class roomIsNotReservedErrorDescription.
	! !

!Room methodsFor: 'private' stamp: 'ap 4/29/2024 19:11:47'!
receiveWithReservationWhenReserved: aGuest
	guest := aGuest. 
	occupationState := OccupiedRoomStatus of: self
	! !

!Room methodsFor: 'private' stamp: 'ap 4/29/2024 18:55:32'!
reserveWhenAvailable

	occupationState := ReservedRoomStatus of: self.! !

!Room methodsFor: 'private' stamp: 'ap 4/29/2024 18:42:09'!
reserveWhenUnavailable

	self error: self class roomIsNotEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: #'ISW1-2024-1C-Parcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'error messages' stamp: 'FRT 4/22/2024 09:01:14'!
roomIsNotEmptyErrorDescription

	^ 'Room is not empty.'! !

!Room class methodsFor: 'error messages' stamp: 'FRT 4/22/2024 09:01:43'!
roomIsNotReservedErrorDescription

	^ 'Room is not reserved.'! !


!Room class methodsFor: 'instance creation' stamp: 'ap 4/29/2024 18:45:16'!
empty
	^self new initializeWithoutGuest ! !


!classDefinition: #RoomStatus category: #'ISW1-2024-1C-Parcial'!
Object subclass: #RoomStatus
	instanceVariableNames: 'room'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!RoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 21:21:40'!
allRoomsAvailable
	^false! !

!RoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:12:22'!
canReceiveWithReservation: aGuest
	self subclassResponsibility ! !

!RoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:50:56'!
isOccupied
	^false! !

!RoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:50:44'!
isReserved
	^false! !

!RoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:04:35'!
isUnavailable
	^false! !

!RoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 20:27:36'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock
	self subclassResponsibility ! !

!RoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:17:18'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock
	self subclassResponsibility ! !

!RoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:15:18'!
receive: aGuest

	self subclassResponsibility! !

!RoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:47:11'!
reserve

	self subclassResponsibility! !

!RoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:46:57'!
with: aRoom
	room := aRoom.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoomStatus class' category: #'ISW1-2024-1C-Parcial'!
RoomStatus class
	instanceVariableNames: ''!

!RoomStatus class methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:58:44'!
of: aRoom
	self subclassResponsibility ! !


!classDefinition: #AvailableRoomStatus category: #'ISW1-2024-1C-Parcial'!
RoomStatus subclass: #AvailableRoomStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!AvailableRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 21:21:40'!
allRoomsAvailable
	^true! !

!AvailableRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:12:22'!
canReceiveWithReservation: aGuest
	room receiveWithReservationWhenNotReserved.! !

!AvailableRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 20:29:06'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock
	^room lossWhenAvailable: aPriceList.! !

!AvailableRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:19:36'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock
	^room profitWhenAvailable ! !

!AvailableRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:15:13'!
receive: aGuest
	room receiveWhenAvailable: aGuest . ! !

!AvailableRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:41:07'!
reserve 
	room reserveWhenAvailable.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AvailableRoomStatus class' category: #'ISW1-2024-1C-Parcial'!
AvailableRoomStatus class
	instanceVariableNames: ''!

!AvailableRoomStatus class methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:58:48'!
of: aRoom
	^self new with: aRoom! !


!classDefinition: #UnavailableRoomStatus category: #'ISW1-2024-1C-Parcial'!
RoomStatus subclass: #UnavailableRoomStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!UnavailableRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:04:47'!
isUnavailable
	^true! !

!UnavailableRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 20:28:43'!
lossUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock
	^room lossWhenUnavailable.! !

!UnavailableRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:13:37'!
receive: aGuest
	room receiveWhenUnavailable. ! !


!classDefinition: #OccupiedRoomStatus category: #'ISW1-2024-1C-Parcial'!
UnavailableRoomStatus subclass: #OccupiedRoomStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!OccupiedRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:12:22'!
canReceiveWithReservation: aGuest
	room receiveWithReservationWhenNotReserved.! !

!OccupiedRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:49:50'!
isOccupied
	^true! !

!OccupiedRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:20:01'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock
	^room profitWhenOccupiedUsing: aPriceList ifAbsentGuessType: unknownGuestTypeBlock.! !

!OccupiedRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:42:14'!
reserve 
	room reserveWhenUnavailable.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OccupiedRoomStatus class' category: #'ISW1-2024-1C-Parcial'!
OccupiedRoomStatus class
	instanceVariableNames: ''!

!OccupiedRoomStatus class methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:58:52'!
of: aRoom
	^self new with: aRoom! !


!classDefinition: #ReservedRoomStatus category: #'ISW1-2024-1C-Parcial'!
UnavailableRoomStatus subclass: #ReservedRoomStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!ReservedRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:12:22'!
canReceiveWithReservation: aGuest
	room receiveWithReservationWhenReserved: aGuest.! !

!ReservedRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:50:35'!
isReserved
	^true! !

!ReservedRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 19:20:34'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock
	^room profitWhenReservedWith: aPriceList! !

!ReservedRoomStatus methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:42:21'!
reserve 
	room reserveWhenUnavailable.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReservedRoomStatus class' category: #'ISW1-2024-1C-Parcial'!
ReservedRoomStatus class
	instanceVariableNames: ''!

!ReservedRoomStatus class methodsFor: 'as yet unclassified' stamp: 'ap 4/29/2024 18:58:55'!
of: aRoom
	^self new with: aRoom! !
