(define (problem robot-task)
    (:domain robot)
    (:objects
        robot - robot
        joshua_bedroom - room
        joshua_bedroom_table - table
        stephanie_bedroom_shelf - shelf
        kitchen_sink - sink
        bowl - kitchenware
    )
    (:init
        (is_in robot joshua_bedroom)
        (is_near robot joshua_bedroom_table)
        (hand_empty robot)
        (is_placed_at bowl stephanie_bedroom_shelf)
    )
    (:goal
        (and
            (is_placed_at bowl kitchen_sink)
        )
    )
)