;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise099-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise099-chapter006

; Q.:
; Design si-move. This function is called for every clock tick to determine to which position the objects move now.
; Accordingly, it consumes an element of SIGS and produces another one.

(define WIDTH 200)
(define HEIGHT 200)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define ROCKET (polygon (list (make-posn 0 0)
                 (make-posn (-(/ WIDTH 20)) (/ WIDTH 10))
                 (make-posn 0 (/ WIDTH 15) )
                 (make-posn (/ WIDTH 20) (/ WIDTH 10)))
           "solid"
           "black"))
(define MISSILE-OBJECT-DETECTION-ZONE 1)
(define MISSILE-FLIGHT-VELOCITY 3)

(define UFO (overlay (circle (/ WIDTH 30) "solid" "green") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "green")))
(define WIN-UFO (overlay (circle (/ WIDTH 30) "solid" "red") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "red")))
(define UFO-LAND-LEVEL (- (- HEIGHT (* (image-height UFO) 0.5 )) 1))
(define UFO-X-VELOCITY 2)
(define UFO-DESCENT-VELOCITY 3)
(define RANDOM-LIMIT 2)

(define TANK-HEIGHT (/ HEIGHT 30))
(define TANK-Y-LEVEL (- (- HEIGHT (* TANK-HEIGHT 0.5 )) 1))
(define TANK (rectangle (/ WIDTH 5) TANK-HEIGHT "solid" "blue"))

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


;; func for SIGS parameter changes over time
;; SIGS -> SIGS
;; this function is called for every clock tick to
;; determine to which position the objects move now
;; consumes an element of SIGS and produces another one
;; Moving the tank and the missile (if any)
;; in straight lines at a constant speed
;; Moving the UFO calls for small random jumps
;; to the left or the right

(check-expect (si-move (make-aim (make-posn 10 20) (make-tank 28 -3))) (make-aim (si-move-ufo (aim-ufo (make-aim (make-posn 10 20) (make-tank 28 -3)))) (si-move-tank (aim-tank (make-aim (make-posn 10 20) (make-tank 28 -3))))))
(check-expect (si-move (make-fired (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3) (make-posn 10 40)))
              (make-fired
               (si-move-ufo (fired-ufo (make-fired (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3) (make-posn 10 40))))
               (si-move-tank (fired-tank (make-fired (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3) (make-posn 10 40))))
               (si-move-missile (fired-missile (make-fired (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3) (make-posn 10 40))))))

(define (si-move s)
  (cond
  [(aim? s)
   (make-aim
    (si-move-ufo (aim-ufo s))
    (si-move-tank (aim-tank s)))]
  [(fired? s)
   (make-fired
    (si-move-ufo (fired-ufo s))
    (si-move-tank (fired-tank s))
    (si-move-missile (fired-missile s)))]))



; si-move-proper
; func for determine in process of time
; new coord for the space-invader objects 
; Number (Coord), Number -> Number (Coord)
; (define (si-move-random w delta) w)
; adds delta to the given w coord

;(check-random (si-move-proper 100 3) 103)

(define (si-move-proper w delta)
  (+ w delta))



; si-move-ufo
; func for change ufo-type coord parametres per time
; UFO -> UFO
; change ufo x, y position of the vel per time
; x - to the constant change, y - random

;(check-random (si-move-ufo (make-posn 100 100)) (make-posn  (cond [(even? (random RANDOM-LIMIT)) (+ 100 2)] [else (- 100 2)]) 97))
;(check-random (si-move-ufo (make-posn 178 100)) (make-posn   176 97))
;(check-random (si-move-ufo (make-posn 22 100)) (make-posn   24 97))
;(check-expect (si-move-tank (make-tank 173 4)) (make-tank 177 4))
;(check-expect (si-move-tank (make-tank 178 -4)) (make-tank 174 -4))
;(check-expect (si-move-tank (make-tank 25 -4)) (make-tank 21 -4))
;(check-expect (si-move-tank (make-tank 24 -4)) (make-tank 24 -4))

(define (si-move-ufo s-ufo)
  (make-posn
   (cond
     [(<= (si-move-proper (posn-x s-ufo) (- UFO-X-VELOCITY)) (image-width UFO))
      (si-move-proper (posn-x s-ufo) UFO-X-VELOCITY)]
     [(<= (si-move-proper (posn-x s-ufo) UFO-X-VELOCITY) (- WIDTH (image-width UFO)))
      (si-move-proper (posn-x s-ufo) (- UFO-X-VELOCITY))]
     [else (si-move-random (posn-x s-ufo) UFO-X-VELOCITY)])
   (cond
     [(>= (si-move-proper (posn-y s-ufo) UFO-DESCENT-VELOCITY) (- HEIGHT (image-width UFO)))
      (- HEIGHT (image-width UFO))]
     [else (si-move-proper (posn-y s-ufo) (- UFO-DESCENT-VELOCITY))])))



; si-move-random
; func for creates a random coordinate for the
; space-invader objects 
; Number -> Number
; (define (si-move-random w) w)
; adds rand number (limits of WIDTH/100) to the given w coord

;(check-random (si-move-random 185 2) (cond [(even? (random RANDOM-LIMIT)) (+ 185 UFO-X-VELOCITY)]
;               [else (- 185 UFO-X-VELOCITY)]))
;(check-random (si-move-random 176 2) (cond [(even? (random RANDOM-LIMIT)) (+ 176 UFO-X-VELOCITY)]
;               [else (- 176 UFO-X-VELOCITY)]))
;(check-random (si-move-random 100 2) (cond [(even? (random RANDOM-LIMIT)) (+ 100 UFO-X-VELOCITY)]
;               [else (- 100 UFO-X-VELOCITY)]))
;(check-random (si-move-random 18 2) (cond [(even? (random RANDOM-LIMIT)) (+ 18 UFO-X-VELOCITY)]
;               [else (- 18 UFO-X-VELOCITY)]))


(define (si-move-random w delta)
  (cond [(even? (random RANDOM-LIMIT)) (+ w delta)]
               [else (- w delta)]))



; si-move-tank
; func for change tank-type coord parametres per time
; Tank -> Tank
; change Tank loc position of the vel per time

;(check-expect (si-move-tank (make-tank 178 4)) (make-tank 178 4))
;(check-expect (si-move-tank (make-tank 173 4)) (make-tank 177 4))
;(check-expect (si-move-tank (make-tank 178 -4)) (make-tank 174 -4))
;(check-expect (si-move-tank (make-tank 25 -4)) (make-tank 21 -4))
;(check-expect (si-move-tank (make-tank 24 -4)) (make-tank 24 -4))

(define (si-move-tank s-tank)
  (make-tank
   (cond
    [(or (>= (si-move-proper (tank-loc s-tank) (tank-vel s-tank)) (- WIDTH (/ (image-width TANK) 2)))
         (<= (si-move-proper (tank-loc s-tank) (tank-vel s-tank)) (/ (image-width TANK) 2)))
     (tank-loc s-tank)]
    [else
     (si-move-proper (tank-loc s-tank) (tank-vel s-tank))])
    (tank-vel s-tank)))



;; si-move-missile
; func for change missile-type coord parametres per time
; MISSILE -> MISSILE
; change y position of the MISSILE per time
; to the constant change

;(check-expect (si-move-missile (make-posn 100 100)) (make-posn  100 103))


(define (si-move-missile s-missile)
  (make-posn
   (posn-x s-missile)
   (si-move-proper (posn-y s-missile) MISSILE-FLIGHT-VELOCITY)))