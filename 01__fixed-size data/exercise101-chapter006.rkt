;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise101-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise101-chapter006

; Q.:
; Turn the examples in figure 35 into test cases.

(define WIDTH 200)
(define HEIGHT 200)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define UFO (overlay (circle (/ WIDTH 30) "solid" "green") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "green")))
(define WIN-UFO (overlay (circle (/ WIDTH 30) "solid" "red") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "red")))
(define UFO-LAND-LEVEL (- (- HEIGHT (* (image-height UFO) 0.5 )) 1))
(define UFO-X-VELOCITY 2)
(define UFO-DESCENT-VELOCITY (/ WIDTH 200))
(define RANDOM-LIMIT 2)

(define TANK-HEIGHT (/ HEIGHT 30))
(define TANK-Y-LEVEL (- (- HEIGHT (* TANK-HEIGHT 0.5 )) 1))
(define TANK (rectangle (/ WIDTH 5) TANK-HEIGHT "solid" "blue"))

(define ROCKET (polygon (list (make-posn 0 0)
                 (make-posn (-(/ WIDTH 20)) (/ WIDTH 10))
                 (make-posn 0 (/ WIDTH 15) )
                 (make-posn (/ WIDTH 20) (/ WIDTH 10)))
           "solid"
           "black"))
(define MISSILE-OBJECT-DETECTION-ZONE (/ WIDTH 20))
(define MISSILE-FLIGHT-VELOCITY (- (/ WIDTH 100)))
(define MISSILE-START-Y-LEVEL (- HEIGHT (/ 2 (image-height ROCKET)) (image-height TANK)))

(define FIRE (star 20 "outline" "orange"))

(define TEXT-WIN (text "you win" (/ WIDTH 10) "red"))
(define TEXT-LOSE (text "you lose" (/ WIDTH 10) "red"))

; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation#false means the missile is in the tank;
; Posn says the missile is at that location

(define-struct sigs.v2 [ufo tank missile])
; A SIGS.v2 (short for SIGS version 2) is a structure:
;   (make-sigs.v2 UFO Tank MissileOrNot)
; interpretation represents the complete state of a
; space invader game



; Functions:

; SIGS -> Image
; adds TANK, UFO, and possibly MISSILE to 
; the BACKGROUND scene
   
(define (si-render.v2 s)
  (tank-render (sigs.v2-tank s)
               (ufo-render (sigs.v2-ufo s)
                           (missile-render.v2 (sigs.v2-missile s)
                                           BACKGROUND))))



;; Missile Image -> Image 
; adds m to the given image im

;(check-expect (missile-render.v2 (make-posn 25 50) BACKGROUND)
;              (place-image ROCKET 25 50 BACKGROUND))
;
;(check-expect (missile-render.v2 #false BACKGROUND)
;              BACKGROUND)

(define (missile-render.v2 s im)
  (cond
    [(boolean? s) im]
    [(posn? s)
     (place-image ROCKET (posn-x s) (posn-y s) im)]))



; UFO Image -> Image 
; adds u to the given image im

;(check-expect (ufo-render (make-posn 25 30) BACKGROUND) (place-image UFO 25 30 BACKGROUND))

(define (ufo-render s im)
  (place-image UFO (posn-x s) (posn-y s) im))



; Tank Image -> Image 
; adds t to the given image im

;(check-expect (tank-render (make-tank 25 -3) BACKGROUND) (place-image TANK 25  TANK-Y-LEVEL BACKGROUND))

(define (tank-render s im)
  (place-image TANK (tank-loc s) TANK-Y-LEVEL im))



; Exercise:

(define SI1.v2 (make-sigs.v2 (make-posn 25 100) (make-tank 32 3) #false))
(define SI2.v2 (make-sigs.v2 (make-posn 25 100) (make-tank 32 3) (make-posn 32 (- HEIGHT TANK-HEIGHT 10))))

(si-render.v2 SI1.v2)
(si-render.v2 SI2.v2)
