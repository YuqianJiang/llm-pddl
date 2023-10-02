(define (problem bring_back_spoon)
    (:domain robot)
    (:objects 
        robot - robot
        joshua_bedroom joshua_bedroom_table joshua_bedroom_shelf joshua_bedroom_shelf_4 - location
        spoon - object
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