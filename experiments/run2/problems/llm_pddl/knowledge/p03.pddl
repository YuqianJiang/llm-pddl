(define (problem robot-task)
    (:domain robot)
    (:objects 
        robot - robot
        joshua_bedroom - room
        joshua_bedroom_table - table
        joshua_bedroom_tv - tv
        joshua_bedroom_shelf - shelf
        joshua_bedroom_window - window
        joshua_bedroom_overhead - light
        stephanie_bedroom - room
        stephanie_bedroom_tv - tv
        stephanie_br_overhead - light
        stephanie_bedroom_table - table
        stephanie_bedroom_shelf - shelf
        stephanie_br_shelf_1 - surface
        kitchen_sink - sink
        bowl - kitchenware
        espn - channel
    )
    (:init 
        (is_in robot joshua_bedroom)
        (is_near robot joshua_bedroom_table)
        (hand_empty robot)
        (has joshua_bedroom joshua_bedroom_tv)
        (has joshua_bedroom joshua_bedroom_shelf)
        (has joshua_bedroom joshua_bedroom_window)
        (has joshua_bedroom joshua_bedroom_overhead)
        (has joshua_bedroom joshua_bedroom_table)
        (is_light_on joshua_bedroom_overhead)
        (is_tv_on joshua_bedroom_tv)
        (channel_playing joshua_bedroom_tv espn)
        (is_window_open joshua_bedroom_window)
        (is_placed_at bowl stephanie_bedroom_shelf)
        (on_shelf bowl stephanie_br_shelf_1)
        (is_faucet_on kitchen_sink)
    )
    (:goal 
        (and 
            (is_placed_at bowl kitchen_sink)
        )
    )
)