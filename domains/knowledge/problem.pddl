(define (problem simulation-a)
	(:domain simulation)
	(:objects
		me - person
		living-room - livingroom
		living-room-shelf - shelf
		living-room-window - window
		living-room-table - table
		living-room-tv - tv
		living-room-overhead-light - light
		kitchen - kitchen
		kitchen-sink - sink
		kitchen-fridge - fridge
		kitchen-overhead-light - light
		stephanie-bedroom - bedroom
		stephanie-bedroom-overhead-light - light
		stephanie-bedroom-shelf - shelf
		stephanie-bedroom-tv - tv
		stephanie-bedroom-table - table
		stephanie-bedroom-window - window
		joshua-bedroom - bedroom
		joshua-bedroom-overhead-light - light
		joshua-bedroom-tv - tv
		joshua-bedroom-window - window
		joshua-bedroom-table - table
		joshua-bedroom-shelf - shelf
		pineapple - food
		knife - kitchenware
		the-prince-book - book
		the-road-book - book
		lemon - food
		bowl - kitchenware
		fork - kitchenware
		artichoke - food
		egg - food
		nicholas-phone - phone
		spoon - kitchenware
		dennis-phone - phone
		black-pen - pen
		emily-phone - phone
		beige-pen - pen
		the-discovery-channel - channel
		cartoon-network - channel
		nbc - channel
		cnn - channel
		fox-news - channel
		espn - channel
		level-1 - level
		level-2 - level
		level-3 - level
		level-4 - level
		level-5 - level
		level-6 - level
		level-7 - level
		level-8 - level
		level-9 - level
		level-10 - level
	)
	(:init
		(hand-empty me)
		(in-livingroom living-room living-room-shelf)
		(shelf-has-level living-room-shelf level-1)
		(shelf-has-level living-room-shelf level-2)
		(shelf-has-level living-room-shelf level-3)
		(shelf-has-level living-room-shelf level-4)
		(shelf-has-level living-room-shelf level-5)
		(shelf-has-level living-room-shelf level-6)
		(shelf-has-level living-room-shelf level-7)
		(shelf-has-level living-room-shelf level-8)
		(shelf-has-level living-room-shelf level-9)
		(shelf-has-level living-room-shelf level-10)
		(in-livingroom living-room living-room-window)
		(in-livingroom living-room living-room-table)
		(in-livingroom living-room living-room-tv)
		(tv-on living-room-tv)
		(tv-playing-channel living-room-tv fox-news)
		(in-livingroom living-room living-room-overhead-light)
		(in-kitchen kitchen kitchen-sink)
		(faucet-on kitchen-sink)
		(in-kitchen kitchen kitchen-fridge)
		(in-kitchen kitchen kitchen-overhead-light)
		(in-bedroom stephanie-bedroom stephanie-bedroom-overhead-light)
		(light-on stephanie-bedroom-overhead-light)
		(in-bedroom stephanie-bedroom stephanie-bedroom-shelf)
		(shelf-has-level stephanie-bedroom-shelf level-1)
		(shelf-has-level stephanie-bedroom-shelf level-2)
		(shelf-has-level stephanie-bedroom-shelf level-3)
		(shelf-has-level stephanie-bedroom-shelf level-4)
		(in-bedroom stephanie-bedroom stephanie-bedroom-tv)
		(tv-on stephanie-bedroom-tv)
		(tv-playing-channel stephanie-bedroom-tv the-discovery-channel)
		(in-bedroom stephanie-bedroom stephanie-bedroom-table)
		(in-bedroom stephanie-bedroom stephanie-bedroom-window)
		(in-bedroom joshua-bedroom joshua-bedroom-overhead-light)
		(light-on joshua-bedroom-overhead-light)
		(in-bedroom joshua-bedroom joshua-bedroom-tv)
		(tv-on joshua-bedroom-tv)
		(tv-playing-channel joshua-bedroom-tv cartoon-network)
		(in-bedroom joshua-bedroom joshua-bedroom-window)
		(window-open joshua-bedroom-window)
		(in-bedroom joshua-bedroom joshua-bedroom-table)
		(in-bedroom joshua-bedroom joshua-bedroom-shelf)
		(shelf-has-level joshua-bedroom-shelf level-1)
		(shelf-has-level joshua-bedroom-shelf level-2)
		(shelf-has-level joshua-bedroom-shelf level-3)
		(shelf-has-level joshua-bedroom-shelf level-4)
		(shelf-has-level joshua-bedroom-shelf level-5)
		(table-contains living-room-table pineapple)
		(sink-contains kitchen-sink knife)
		(table-contains joshua-bedroom-table the-prince-book)
		(shelf-contains living-room-shelf the-road-book level-8)
		(shelf-contains stephanie-bedroom-shelf lemon level-1)
		(shelf-contains stephanie-bedroom-shelf bowl level-1)
		(table-contains stephanie-bedroom-table fork)
		(fridge-contains kitchen-fridge artichoke)
		(fridge-contains kitchen-fridge egg)
		(shelf-contains living-room-shelf nicholas-phone level-6)
		(shelf-contains joshua-bedroom-shelf spoon level-4)
		(shelf-contains joshua-bedroom-shelf dennis-phone level-3)
		(table-contains living-room-table black-pen)
		(table-contains stephanie-bedroom-table emily-phone)
		(table-contains joshua-bedroom-table beige-pen)
	)
)
