;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter006-exercise095) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
;chapter006-exercise095

; Q.:
; Explain why the three instances are generated according to the first or second clause of the data definition.

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])


(make-aim (make-posn 20 10) (make-tank 28 -3))
; Here is an instance that describes
; the tank maneuvering into position to fire the missile
; since the missile has not been fired yet
; we don't need to use data definitions for designation missile
; here structure type defining only visible objects -
; ufo and tank

(make-fired (make-posn 20 10)
            (make-tank 28 -3)
            (make-posn 28 (- HEIGHT TANK-HEIGHT)))
; Here is an instance that describes the tank maneuvering,
; descending ufo, and the missile that has been fired
; since the missile is fired we must use structure type
; to indicate its position
; structure types which designate a ufo and a tank
; are also involved

(make-fired (make-posn 20 100)
            (make-tank 100 3)
            (make-posn 22 103))
; an instance that describes the missile
; is about to collide with the UFO
; structure types which designate three visible objects
; a tank, ufo and missile
; according to the coordinates of ufo anf missile,
; you can understand that they are close to a collision

