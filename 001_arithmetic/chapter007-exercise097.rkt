;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter007-exercise097) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; chapter007-exercise097

; Q.:
; Design the functions tank-render, ufo-render, and missile-render.
; Compare expressions, when do the two expressions produce the same result?

(define WIDTH 200)
(define HEIGHT 200)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define ROCKET (polygon (list (make-posn 0 0)
                 (make-posn (-(/ WIDTH 20)) (/ WIDTH 10))
                 (make-posn 0 (/ WIDTH 15) )
                 (make-posn (/ WIDTH 20) (/ WIDTH 10)))
           "solid"
           "black"))

(define UFO (overlay (circle (/ WIDTH 30) "solid" "green") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "green")))
(define WIN_UFO (overlay (circle (/ WIDTH 30) "solid" "red") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "red")))

(define TANK-HEIGHT (/ HEIGHT 30))
(define TANK-Y-LEVEL (- (- HEIGHT (* TANK-HEIGHT 0.5 )) 1))
(define TANK (rectangle (/ WIDTH 5) TANK-HEIGHT "solid" "blue"))

(define FIRE (star 20 "outline" "orange"))

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



; Tank Image -> Image 
; adds t to the given image im

;(check-expect (tank-render (make-tank 25 -3) BACKGROUND) (place-image TANK 25  TANK-Y-LEVEL BACKGROUND))

(define (tank-render s im)
  (place-image TANK (tank-loc s) TANK-Y-LEVEL im))



; UFO Image -> Image 
; adds u to the given image im

;(check-expect (ufo-render (make-posn 25 30) BACKGROUND) (place-image UFO 25 30 BACKGROUND))

(define (ufo-render s im)
  (place-image UFO (posn-x s) (posn-y s) im))



; Missile Image -> Image 
; adds m to the given image im

;(check-expect (missile-render (make-posn 25 50) BACKGROUND) (place-image ROCKET 25 50 BACKGROUND))

(define (missile-render m im)
  (place-image ROCKET (posn-x m) (posn-y m) im))



; Compare this expression:
; (tank-render
;  (fired-tank s)
;  (ufo-render (fired-ufo s)
;              (missile-render (fired-missile s)
;                              BACKGROUND)))
; with this one:
; (ufo-render
;  (fired-ufo s)
;  (tank-render (fired-tank s)
;               (missile-render (fired-missile s)
;                               BACKGROUND)))
; When do the two expressions produce the same result?


; the same result
; when objects UFO and TANK do not intersect, do not collide with each other in space