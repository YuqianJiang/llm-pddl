(define (domain robot)
    (:requirements :strips :typing)
    (:types location object room robot surface channel- entity
            phone food kitchenware pen - object
            table shelf window light fridge light sink rv - location)
    (:predicates
          (has ?e1 - entity ?e2 - entity)
          (is_near ?r - robot ?l - location)
          (is_in ?r - robot ?l - room)
          (is_placed_at ?o - object ?l - location)
          (hand_empty ?r - robot)
          (holding ?r - robot ?o - object)
          (on_shelf ?o - object ?s - surface)
          (is_phone_ringing ?o - phone)
          (is_light_on ?l - light)
          (is_tv_on ?l - tv)
          (is_faucet_on ?l - sink)
          (is_window_open ?l - window)
          (channel_playing ?l - tv ?c - channel)
    )

    (:action go-to
    :parameters  (?r - robot ?from ?to - location)
    :precondition (and  (is_near ?r ?from))
    :effect (and  (is_near ?r ?to)
         (not (is_near ?r ?from))))

    (:action pick
    :parameters (?r - robot ?obj - object ?l - location)
    :precondition  (and  (is_placed_at ?obj ?l) (is_near ?r ?l) (hand_empty ?r))
    :effect (and (holding ?r ?obj)
        (not (is_placed_at ?obj ?l))
        (not (hand_empty ?r))))

    (:action place
    :parameters (?r - robot ?obj - object ?l - location)
    :precondition  (and  (holding ?r ?obj) (is_near ?r ?l))
    :effect (and (is_placed_at ?obj ?l)
        (hand_empty ?r)
        (not (holding ?r ?obj))))
)
