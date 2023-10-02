(define (problem robot_task)
    (:domain robot)
    (:objects 
        joshua_bedroom - room
        living_room - room
        kitchen - room
        stephanie_bedroom - room
        joshua_bedroom_tv - tv
        joshua_bedroom_shelf - shelf
        joshua_bedroom_window - window
        joshua_bedroom_overhead - light
        joshua_bedroom_table - table
        robot - robot
        living_room_tv - tv
        living_room_shelf - shelf
        living_room_window - window
        living_room_overhead - light
        living_room_table - table
        kitchen_fridge - fridge
        kitchen_overhead - light
        kitchen_sink - sink
        stephanie_bedroom_tv - tv
        stephanie_bedroom_shelf - shelf
        stephanie_bedroom_window - window
        stephanie_br_overhead - light
        stephanie_bedroom_table - table
        the_prince_book - book
        beige_pen - pen
        black_pen - pen
        pineapple - food
        knife - kitchenware
        spoon - kitchenware
        dennis_phone - phone
        espn - channel
    )
    (:init 
        (is_in robot joshua_bedroom)
        (is_near robot joshua_bedroom_table)
        (hand_empty robot)
        (is_placed_at beige_pen joshua_bedroom_table)
        (is_placed_at the_prince_book joshua_bedroom_table)
        (is_placed_at black_pen living_room_table)
        (is_placed_at pineapple living_room_table)
        (is_placed_at knife kitchen_sink)
        (is_placed_at spoon joshua_bedroom_shelf)
        (is_placed_at dennis_phone joshua_bedroom_shelf)
        (is_light_on joshua_bedroom_overhead)
        (is_light_on stephanie_br_overhead)
        (is_tv_on joshua_bedroom_tv)
        (is_tv_on living_room_tv)
        (is_tv_on stephanie_bedroom_tv)
        (is_faucet_on kitchen_sink)
        (is_window_open joshua_bedroom_window)
        (channel_playing joshua_bedroom_tv espn)
        (channel_playing living_room_tv espn)
        (channel_playing stephanie_bedroom_tv espn)
    )
    (:goal (and 
        (is_placed_at beige_pen living_room_table)
    ))
)