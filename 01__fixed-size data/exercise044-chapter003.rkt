;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise044-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise044-chapter003

; Q.:
; Design a program that moves a car across the world canvas, from left to right, at the rate of three pixels per clock tick.
; If the mouse is clicked anywhere on the canvas, the car is placed at the x-coordinate of that click.
; Formulate the examples as BSL tests. Click RUN and watch them fail.


(define WIDTH  1000)
(define HEIGHT  100)
(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define TREE
  (underlay/xy (circle (/ WIDTH 30) "solid" "green")
               (/ WIDTH 35) (/ WIDTH 25)
               (rectangle (/ WIDTH 100) (/ WIDTH 15) "solid" "brown")))
(define BACKGROUND-TREE (place-image TREE (/ WIDTH 2) (/ (image-height TREE) 2) BACKGROUND))


(define WHEEL-RADIUS (/ WIDTH 50))
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define WHEELS-PAIR (overlay/offset WHEEL WHEEL-DISTANCE 0 WHEEL))

(define CAR-BODY (polygon (list (make-posn 0 0)
                                (make-posn 0 (* 2 WHEEL-RADIUS))
                                (make-posn (* 9 WHEEL-RADIUS) (* 2 WHEEL-RADIUS))
                                (make-posn (* 9 WHEEL-RADIUS) 0)
                                (make-posn (* 7 WHEEL-RADIUS) 0)
                                (make-posn (* 7 WHEEL-RADIUS) (- 0 WHEEL-RADIUS))
                                (make-posn (* 2 WHEEL-RADIUS) (- 0 WHEEL-RADIUS))
                                (make-posn (* 2 WHEEL-RADIUS) 0))
                          "solid"
                          "red"))

(define CAR (overlay/offset WHEELS-PAIR 0 (- 0 (* WHEEL-RADIUS 1.5)) CAR-BODY))
(define CAR-WIDTH (image-width CAR))
(define Y-CAR (- HEIGHT (/ (image-height CAR) 2)))



; A WorldState is a Number.
; interpretation the number of pixels between
; the left border of the scene and the center of the car

; WorldState -> WorldState
; launches the program from some initial state

(define (main ws)
   (big-bang ws
     [on-tick tock]
     [on-mouse hyper]
     [to-draw render]
     [stop-when end?]))



; tock func
; we use Number to represent the number of pixels between the left border of the scene and the car
; WorldState -> WorldState
; moves car for 3 pixels every clock tick 

;(check-expect (tock 20) 23)
;(check-expect (tock 78) 81)

(define (tock ws)
  (+ ws 3))



; image func
; we use Number to represent the number of pixels between the left border of the scene and the car
; WorldState -> Image
; places a car into a background scene according given world state

;(check-expect (render 0) (place-image CAR (+ (/ CAR-WIDTH 2) 0) Y-CAR BACKGROUND-TREE))
;(check-expect (render 10) (place-image CAR (+ (/ CAR-WIDTH 2) 10) Y-CAR BACKGROUND-TREE))

(define (render cw)
  (place-image CAR cw Y-CAR BACKGROUND-TREE))



; end? func
; we use Number to represent the number of pixels between the left border of the scene and the car
; WorldState -> Boolean
; check car coordinate and return flag for end of programm to bb when car disappeared on the right side

;given 0, expect 0
;given  WIDTH, expect 0;
;given (+ WIDTH (/ WIDTH 15)), expect 1;

;(check-expect (end? 0) #false)
;(check-expect (end? (/ WIDTH 2)) #false)
;(check-expect (end? (+ WIDTH CAR-WIDTH)) #true)

(define (end? cw)
  (if (< cw (+ WIDTH (/ CAR-WIDTH 2))) #false #true))



; testing an unfinished function
; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down"

;(check-expect (hyper 21 10 20 "enter") 21)
;(check-expect (hyper 42 10 20 "button-down") 10) ; Check failures
;(check-expect (hyper 42 10 20 "move") 42)
;
;(define (hyper x-position-of-car x-mouse y-mouse me)
;  x-position-of-car)



; WorldState Number Number String -> WorldState
; places the car at x-mouse
; if the given me is "button-down"

;(check-expect (hyper 21 10 20 "enter") 21)
;(check-expect (hyper 42 10 20 "button-down") 10)
;(check-expect (hyper 42 10 20 "move") 42)

(define (hyper x-position-of-car x-mouse y-mouse me)
  (cond
    [(string=? "button-down" me) x-mouse]
    [else x-position-of-car]))