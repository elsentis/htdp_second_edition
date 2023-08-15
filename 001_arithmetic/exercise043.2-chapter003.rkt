;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise043.2-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise043.2-chapter003

; Q.:
; Use the data definition to design a program that moves the car according to a sine wave. (Don’t try to drive like that.)

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
(define CAR-HEIGHT (image-height CAR))
(define Y-CAR (- HEIGHT (/ (image-height CAR) 2)))



; An AnimationState is a Number.
; interpretation the number of clock ticks 
; since the animation started

; AnimationState -> AnimationState
; launches the program from some initial state

(define (main ws)
   (big-bang ws
     [on-tick tock]
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
  (place-image CAR (as-x cw) (as-y cw) BACKGROUND-TREE))



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
  (if (< (as-x cw) (+ WIDTH (/ CAR-WIDTH 2))) #false #true))



; func for convert a AnimateState to distance in pixels
; AnimateState -> Number
; convert as AnimateState in Number
; Number to represent the number of pixels between the left border of the scene and the center of car

(define (as-x t)
  t)


; func for convert a AnimateState to distance in pixels
; AnimateState -> Number
; convert as AnimateState in Number
; Number to represent the number of pixels between the ground level and the center of car

(define (as-y ws)
  (if (even? (quotient ws (round (/ CAR-HEIGHT 2))))
      (- (- HEIGHT (round (/ CAR-HEIGHT 2))) (modulo ws (round (/ CAR-HEIGHT 2))))
      (+ (round (/ CAR-HEIGHT 2)) (modulo ws (round (/ CAR-HEIGHT 2))))))