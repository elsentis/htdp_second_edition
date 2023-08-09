;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise114.1(si)-chapter006|) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise114.1(si)-chapter006

; Q.:
; Use the predicates from exercise 113 to check the space invader world program.

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
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

(define SI1 (make-aim (make-posn 100 0) (make-tank 100 3)))

(define (main ws)
  (big-bang ws
    [check-with sigs?]
    [to-draw si-render]
    [on-key si-control]
    [on-tick si-move]
    [stop-when si-game-over? si-render-final]))

; (main "lol") check-with: the initial expression evaluated to "lol", which fails to pass check-with's sigs? test
; (main 1) check-with: the initial expression evaluated to 1, which fails to pass check-with's sigs? test
; (main (make-aim (make-posn 100 0) (make-tank 100 3))) successful program execution



; game launch
; (main SI1)

; SIGS -> Image
; renders the given game state on top of BACKGROUND

(define (si-render s)
  (cond
  [(aim? s)
     (tank-render (aim-tank s)
                  (ufo-render (aim-ufo s) BACKGROUND))]
    [(fired? s)
     (tank-render
       (fired-tank s)
       (ufo-render (fired-ufo s)
                   (missile-render (fired-missile s)
                                   BACKGROUND)))]))



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

(define (missile-render s im)
  (place-image ROCKET (posn-x s) (posn-y s) im))



; we use A SIGS for interp.
; the complete state of a space invader game
; SIGS, KeyEvent -> SIGS
; func for big-bang for key-event handler
;  it consumes a game state and a KeyEvent
; and produces a new game state. It reacts to three different keys:
; pressing the left arrow ensures that the tank moves left;
; pressing the right arrow ensures that the tank moves right;
; pressing the space bar fires the missile if it hasn’t been launched yet

;(check-expect (si-control SI1 "right") SI1)
;(check-expect (si-control SI1 "left") (make-aim (make-posn 100 100) (make-tank 100 -3)))
;(check-expect (si-control SI1 " ") (make-fired (make-posn 100 100) (make-tank 100 3) (make-posn 100 MISSILE-START-Y-LEVEL)))

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



;; func for SIGS parameter changes over time
;; SIGS -> SIGS
;; this function is called for every clock tick to
;; determine to which position the objects move now
;; consumes an element of SIGS and produces another one
;; Moving the tank and the missile (if any)
;; in straight lines at a constant speed
;; Moving the UFO calls for small random jumps
;; to the left or the right

;(check-expect (si-move (make-aim (make-posn 10 20) (make-tank 28 -3))) (make-aim (si-move-ufo (aim-ufo (make-aim (make-posn 10 20) (make-tank 28 -3)))) (si-move-tank (aim-tank (make-aim (make-posn 10 20) (make-tank 28 -3))))))
;(check-expect (si-move (make-fired (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3) (make-posn 10 40)))
;              (make-fired
;               (si-move-ufo (fired-ufo (make-fired (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3) (make-posn 10 40))))
;               (si-move-tank (fired-tank (make-fired (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3) (make-posn 10 40))))
;               (si-move-missile (fired-missile (make-fired (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3) (make-posn 10 40))))))

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
     [(> (si-move-proper (posn-y s-ufo) UFO-DESCENT-VELOCITY) UFO-LAND-LEVEL)
      (posn-x s-ufo)]
     [(<= (si-move-proper (posn-x s-ufo) (- UFO-X-VELOCITY)) (image-width UFO))
      (si-move-proper (posn-x s-ufo) UFO-X-VELOCITY)]
     [(>= (si-move-proper (posn-x s-ufo) UFO-X-VELOCITY) UFO-LAND-LEVEL)
      (si-move-proper (posn-x s-ufo) (- UFO-X-VELOCITY))]
     [else (si-move-random (posn-x s-ufo) UFO-X-VELOCITY)])
   (cond
     [(>= (si-move-proper (posn-y s-ufo) UFO-DESCENT-VELOCITY) UFO-LAND-LEVEL)
      UFO-LAND-LEVEL]
     [else (si-move-proper (posn-y s-ufo) UFO-DESCENT-VELOCITY)])))



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



; func for stop-when
; end? func
; SIGS -> Boolean
; check ws checks for a condition
; ufo landing or missile hit and
; return #true if one at condition are met

;(check-expect (si-game-over? (make-aim
;                          (make-posn 10 20) (make-tank 28 -3))) #false)
;
;(check-expect (si-game-over? (make-aim
;                          (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3))) #true)
;
;(check-expect (si-game-over? (make-fired
;                          (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3) (make-posn 10 40))) #true)
;
;(check-expect (si-game-over? (make-fired
;                          (make-posn 10 50) (make-tank 28 -3) (make-posn 10 40))) #false)
;
;(check-expect (si-game-over? (make-fired
;                          (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49))) #true)

(define (si-game-over? s)
  (cond [(aim? s)
          (cond [(ufo-land? (aim-ufo s)) #true]
                [else #false])]
        [(fired? s)
          (cond [(ufo-land? (fired-ufo s)) #true]
                [(missile-hit? (fired-ufo s) (fired-missile s)) #true]
                [else #false])]))



;;  func for determine ufo landing
;;  UFO -> Boolean
;;  determines the UFO landing
;;  and returns #true if it happened

;(check-expect (ufo-land? (make-posn 50 0)) #false)
;(check-expect (ufo-land? (make-posn 50 200)) #true)

(define (ufo-land? s-ufo)
  (cond [(>= (posn-y s-ufo) UFO-LAND-LEVEL) #true]
        [else #false]))



;;  func for determine ufo missile hit
;; UFO, Missile -> Boolean
;; determines the UFO hit by missile
;; and returns #true if it happened

;(check-expect (missile-hit? (make-posn 10 20) (make-posn 10 20)) #true)
;(check-expect (missile-hit? (make-posn 10 20) (make-posn 10 30)) #false)
            
(define (missile-hit? s-ufo s-missile)
  (cond [(<= (sqrt (+ (sqr (- (posn-x s-ufo) (posn-x s-missile)))
                      (sqr (- (posn-y s-ufo) (posn-y s-missile)))))
             MISSILE-OBJECT-DETECTION-ZONE) #true]
        [else #false]))


; SIGS -> Image
; creates the last scene with the result of the game after the final event, with the final text and effects

;(check-expect (si-render-final (make-aim (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3))) (lose-text-render (tank-render (aim-tank (make-aim (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3)))
;                                                                                                                          (red-ufo-render (aim-ufo (make-aim (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3)))
;                                                                                                                                          BACKGROUND))))
;
;(check-expect (si-render-final (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49)))
;              (win-text-render (star-fire-render (fired-ufo (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49)))
;                                                 (fired-missile (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49)))
;                                                 (missile-render (fired-missile (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49)))
;                                                                 (tank-render (fired-tank (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49)))
;                                                                              (ufo-render (fired-ufo (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49))) BACKGROUND))))))
                                                                                                                                                    
(define (si-render-final s) 
  (cond
    [(aim? s)
     (lose-text-render (tank-render (aim-tank s)
                  (red-ufo-render (aim-ufo s) BACKGROUND)))]
    [(fired? s)
     (cond
       [(missile-hit? (fired-ufo s) (fired-missile s))
        (win-text-render (star-fire-render (fired-ufo s) (fired-missile s) (missile-render (fired-missile s) (tank-render (fired-tank s)
                  (ufo-render (fired-ufo s) BACKGROUND)))))]
       [else (lose-text-render (missile-render (fired-missile s) (tank-render (fired-tank s)
                  (red-ufo-render (fired-ufo s) BACKGROUND))))])]))



;; Image -> Image 
;  adds lose-text to the given image im

(define (lose-text-render im)
  (place-image TEXT-LOSE
               (- (/ WIDTH 1) (image-width TEXT-LOSE))
              (image-height TEXT-LOSE)
              im))


;; Image -> Image 
;  adds win-text to the given image im

(define (win-text-render im)
  (place-image TEXT-WIN
               (- WIDTH (image-width TEXT-WIN))
              (image-height TEXT-WIN)
              im))



; UFO Image -> Image 
; adds red-ufo to the given image im

(define (red-ufo-render m im)
  (place-image WIN-UFO (posn-x m) (posn-y m) im))



; UFO, MISSILE, Image -> Image
; consume ufo, missile calculates the location of the explosion
; from the contact and adds fire to the given image

(define (star-fire-render s-ufo s-missile im)
  (place-image FIRE
               (/ (+ (posn-x s-ufo) (posn-x s-missile)) 2)
               (/ (+ (posn-y s-ufo) (posn-y s-missile)) 2)
               im))



; Any -> Boolean
; is a an element of the SIGS collection

;(check-expect (sigs? "lol") #false)
;(check-expect (sigs? "1") #false)
;(check-expect (sigs? (make-aim (make-posn 10 10) (make-tank 10 -3))) #true)
;(check-expect (sigs? (make-fired (make-posn 10 10) (make-tank 10 -3) (make-posn 30 30))) #true)

(define (sigs? v)
  (or (aim? v) (fired? v)))