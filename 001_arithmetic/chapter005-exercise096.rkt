;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter005-exercise096) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
;chapter005-exercise096

; Q.:
; Sketch how each of the three game states could be rendered assuming a 200*200 canvas.

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


(define GAME-STATE-1 (make-aim (make-posn 20 10) (make-tank 28 -3)))
; Here is an instance that describes
; the tank maneuvering into position to fire the missile
; since the missile has not been fired yet
; we don't need to use data definitions for designation missile
; here structure type defining only visible objects -
; ufo and tank

(define GAME-STATE-2 (make-fired (make-posn 20 10) (make-tank 28 -3) (make-posn 28 (- HEIGHT TANK-HEIGHT))))
; Here is an instance that describes the tank maneuvering,
; descending ufo, and the missile that has been fired
; since the missile is fired we must use structure type
; to indicate its position
; structure types which designate a ufo and a tank
; are also involved

(define GAME-STATE-3 (make-fired (make-posn 20 100) (make-tank 100 3) (make-posn 22 103)))
; an instance that describes the missile
; is about to collide with the UFO
; structure types which designate three visible objects
; a tank, ufo and missile
; according to the coordinates of ufo anf missile,
; you can understand that they are close to a collision



; scene that describes the tank maneuvering into position to fire the missile
(define SCENE-GAME-STATE-1
  (place-image TANK (tank-loc (aim-tank GAME-STATE-1)) TANK-Y-LEVEL
               (place-image UFO (posn-x (aim-ufo GAME-STATE-1)) (posn-y (aim-ufo GAME-STATE-1)) BACKGROUND)))


; scene that describes the missile has been fired
(define SCENE-GAME-STATE-2
  (place-image TANK (tank-loc (fired-tank GAME-STATE-2)) TANK-Y-LEVEL
               (place-image UFO (posn-x (fired-ufo GAME-STATE-2)) (posn-y (fired-ufo GAME-STATE-2))
                            (place-image ROCKET (posn-x (fired-missile GAME-STATE-2)) (posn-y (fired-missile GAME-STATE-2)) BACKGROUND))))


; scene that describes the missile has been fired
(define SCENE-GAME-STATE-3
  (place-image (text "you win" (/ WIDTH 10) "red") (- (/ WIDTH 1) (image-width (text "you win" (/ WIDTH 10) "red"))) (/ (image-height (text "you win" (/ WIDTH 10) "red")) 2)
                (place-image FIRE (/ (+ (posn-x (fired-ufo GAME-STATE-3)) (posn-x (fired-missile GAME-STATE-3))) 2) (/ (+ (posn-y (fired-ufo GAME-STATE-3)) (posn-y (fired-missile GAME-STATE-3))) 2)
                             (place-image TANK (tank-loc (fired-tank GAME-STATE-3)) TANK-Y-LEVEL
                                          (place-image UFO (posn-x (fired-ufo GAME-STATE-3)) (posn-y (fired-ufo GAME-STATE-3))
                                                       (place-image ROCKET (posn-x (fired-missile GAME-STATE-3)) (posn-y (fired-missile GAME-STATE-3)) BACKGROUND))))))
               
               