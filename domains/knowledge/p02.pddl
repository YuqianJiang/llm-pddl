(define (problem bring-back-spoon)
    (:domain robot)
    (:objects
        robot - robot
        joshua_bedroom - room
        joshua_bedroom_table - location
        joshua_bedroom_shelf - location
        joshua_bedroom_shelf_4 - surface
        spoon - kitchenware
    )
    (:init
        (is_in robot joshua_bedroom)
        (is_near robot joshua_bedroom_table)
        (hand_empty robot)
        (is_placed_at spoon joshua_bedroom_shelf)
        (on_shelf spoon joshua_bedroom_shelf_4)
    )
    (:goal
        (and
            (is_placed_at spoon joshua_bedroom_table)
            (hand_empty robot)
        )
    )
)