;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise062-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise062-chapter004

; Q.:
; Modify door-simulation so that the clock ticks once every three seconds.



(define CLOSED "closed")
(define OPEN "open")
(define LOCKED "locked")

;a DoorState from a three state
;-- CLOSED, a door closed, but not blocked
;-- BLOCKED, a door closed and blocked
;-- OPEN, a door open



; world function for door-simulation
; DoorState -> DoorState
; (door-simulation LOCKED)

(define (door-simulation initial-state)
  (big-bang initial-state
    [on-tick door-closer 3]
    [on-key door-action]
    [to-draw door-render]))

; DoorState -> DoorState
; transfer state from OPEN to CLOSED

;(check-expect (door-closer OPEN) CLOSED)
;(check-expect (door-closer CLOSED) CLOSED)
;(check-expect (door-closer LOCKED) LOCKED)

(define (door-closer door-state)
  (if (equal? door-state OPEN) CLOSED door-state))


;DoorState -> DoorState
;switch DoorState func, depend from user action

;(check-expect (door-action OPEN " ") OPEN)
;(check-expect (door-action OPEN "l") OPEN)
;(check-expect (door-action OPEN "u") OPEN)
;(check-expect (door-action CLOSED " ") OPEN)
;(check-expect (door-action CLOSED "l") LOCKED)
;(check-expect (door-action CLOSED "u") CLOSED)
;(check-expect (door-action LOCKED "l") LOCKED)
;(check-expect (door-action LOCKED " ") LOCKED)
;(check-expect (door-action LOCKED "u") CLOSED)

(define (door-action door-state user-action)
  (cond
    [(equal? door-state CLOSED)
     (door-action-aux-for-closed door-state user-action)]
    [(equal? door-state LOCKED)
     (door-action-aux-for-locked door-state user-action)]
    [else door-state]))



; DoorState -> DoorState
; aux-action func for CLOSED door state

;(check-expect (door-action-aux-for-closed CLOSED " ") OPEN)
;(check-expect (door-action-aux-for-closed CLOSED "l") LOCKED)
;(check-expect (door-action-aux-for-closed CLOSED "u") CLOSED)

(define (door-action-aux-for-closed door-state user-action )
  (cond
    [(string=? user-action " ") OPEN]
    [(string=? user-action "l") LOCKED]
    [else door-state]))



; DoorState -> DoorState
; aux-action func for LOCKED door state

;(check-expect (door-action-aux-for-locked LOCKED " ") LOCKED)
;(check-expect (door-action-aux-for-locked LOCKED "l") LOCKED)
;(check-expect (door-action-aux-for-locked LOCKED "u") CLOSED)

(define (door-action-aux-for-locked door-state user-action)
  (cond
    [(string=? user-action "u") CLOSED]
    [else door-state]))



; DoorState -> Image
; render func, consume a DoorState and produce an image

;(check-expect (door-render CLOSED) (text CLOSED 10 "black"))

(define (door-render door-state)
  (text door-state 10 "black"))