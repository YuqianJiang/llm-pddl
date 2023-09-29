(define (problem robot-task)
    (:domain robot)
    (:objects
        robot - robot
        joshua_bedroom - room
        living_room - room
        joshua_bedroom_table - location
        living_room_table - location
        beige_pen - object
    )
    (:init
        (is_in robot joshua_bedroom)
        (is_near robot joshua_bedroom_table)
        (hand_empty robot)
        (is_placed_at beige_pen joshua_bedroom_table)
    )
    (:goal
        (and
            (is_placed_at beige_pen living_room_table)
            (hand_empty robot)
        )
    )
)