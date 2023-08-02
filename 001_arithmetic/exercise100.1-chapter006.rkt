;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise100.1-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise100.1-chapter006

; Q.:
; Design the function si-control, which plays the role of the key-event handler. As such, it consumes a game state and a KeyEvent and produces a new game state.


(define WIDTH 200)
(define HEIGHT 200)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define UFO (overlay (circle (/ WIDTH 30) "solid" "green") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "green")))
(define WIN-UFO (overlay (circle (/ WIDTH 30) "solid" "red") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "red")))
(define UFO-LAND-LEVEL (- (- HEIGHT (* (image-height UFO) 0.5 )) 1))
(define UFO-X-VELOCITY 2)
(define UFO-DESCENT-VELOCITY 3)
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
(define MISSILE-OBJECT-DETECTION-ZONE 1)
(define MISSILE-FLIGHT-VELOCITY 3)
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
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

(define SI1 (make-aim (make-posn 100 100) (make-tank 100 3)))



; we use A SIGS for interp.
; the complete state of a space invader game
; SIGS, KeyEvent -> SIGS
; func for big-bang for key-event handler
;  it consumes a game state and a KeyEvent
; and produces a new game state. It reacts to three different keys:
; pressing the left arrow ensures that the tank moves left;
; pressing the right arrow ensures that the tank moves right;
; pressing the space bar fires the missile if it hasn’t been launched yet

(check-expect (si-control SI1 "right") SI1)
(check-expect (si-control SI1 "left") (make-aim (make-posn 100 100) (make-tank 100 -3)))
(check-expect (si-control SI1 " ") (make-fired (make-posn 100 100) (make-tank 100 3) (make-posn 100 MISSILE-START-Y-LEVEL)))

(define (si-control s ke)
  (cond
    [(aim? s)
     (si-handle-dir-keys-aim s ke)]
    [(fired? s)
     (si-handle-dir-keys-fired s ke)]))



; we use A SIGS for interp.
; the complete state of a space invader game
; SIGS, ke -> SIGS
; func for si-control for
; handle directional key events
; and updates SIGS-aim tank velocity

;(check-expect (si-handle-dir-keys-aim (make-aim (make-posn 100 100) (make-tank 100 -3)) "left")
;              (make-aim (make-posn 100 100) (make-tank 100 -3)))
;
;(check-expect (si-handle-dir-keys-aim (make-aim (make-posn 100 100) (make-tank 100 -3)) "right")
;              (make-aim (make-posn 100 100) (make-tank 100 3)))

(define (si-handle-dir-keys-aim s ke)
  (cond
    [(or (string=? ke "right") (string=? ke "left"))
     (make-aim
   (make-posn
    (posn-x (aim-ufo s))
    (posn-y (aim-ufo s)))
   (si-tank-update-dir-keys (aim-tank s) ke))]
    [(string=? ke " ")
     (si-missile-appear s)]
    [else s]))



; we use A SIGS for interp.
; the complete state of a space invader game
; TANK, ke -> TANK
; func for si-control (for aim and dired makers) for
; handle directional key events
; and updates TANK velocity

;(check-expect (si-tank-update-dir-keys (make-tank 100 -3) "left") (make-tank 100 -3))
;(check-expect (si-tank-update-dir-keys (make-tank 100 -3) "right") (make-tank 100 3))
;(check-expect (si-tank-update-dir-keys (make-tank 100 3) "right") (make-tank 100 3))
;(check-expect (si-tank-update-dir-keys (make-tank 100 -3) "right") (make-tank 100 3))

(define (si-tank-update-dir-keys s-tank ke)
  (make-tank
   (tank-loc s-tank)
   (cond
     [(string=? ke "right")
      (cond
        [(>= (tank-vel s-tank) 0)
         (tank-vel s-tank)]
        [else
         (- (tank-vel s-tank))])]
     [(string=? ke "left")
      (cond
        [(>= (tank-vel s-tank) 0)
         (- (tank-vel s-tank))]
        [else
         (tank-vel s-tank)])])))



; we use A SIGS for interp.
; the complete state of a space invader game
; SIGS -> SIGS
; func for si-control for
; updates SIGS when a missile appears
; from aim struct to fired struct

;(check-expect (si-missile-appear SI1) (make-fired (make-posn 100 100) (make-tank 100 -3) (make-posn 100 MISSILE-START-Y-LEVEL)))

(define (si-missile-appear s)
  (make-fired
         (make-posn
          (posn-x (aim-ufo s))
          (posn-y (aim-ufo s)))
         (make-tank
          (tank-loc (aim-tank s))
          (tank-vel (aim-tank s)))
         (make-posn
          (tank-loc (aim-tank s))
          MISSILE-START-Y-LEVEL)))



; we use A SIGS for interp.
; the complete state of a space invader game
; SIGS(fired), ke -> SIGS
; func for si-control for
; handle directional key events
; and updates SIGS-fired tank velocity

(define (si-handle-dir-keys-fired s ke)
  (cond 
    [(or (string=? ke "right") (string=? ke "left"))
     (make-fired
   (make-posn
    (posn-x (fired-ufo s))
    (posn-y (fired-ufo s)))
   (si-tank-update-dir-keys (fired-tank s) ke)
   (make-posn
    (posn-x (fired-missile s))
    (posn-y (fired-missile s))))]
    [else s]))
