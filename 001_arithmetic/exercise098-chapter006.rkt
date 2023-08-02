;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter006-exercise098) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise098-chapter006

; Q.:
; Design the function si-game-over? for use as the stop-when handler.
; Design si-render-final and use it as the second part for your stop-when clause in the main function of exercise 100.

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

(define UFO (overlay (circle (/ WIDTH 30) "solid" "green") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "green")))
(define WIN-UFO (overlay (circle (/ WIDTH 30) "solid" "red") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "red")))
(define UFO-LAND-LEVEL (- (- HEIGHT (* (image-height UFO) 0.5 )) 1))

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


; func for stop-when
; end? func
; SIGS -> Boolean
; check ws checks for a condition
; ufo landing or missile hit and
; return #true if one at condition are met

(check-expect (si-game-over? (make-aim
                          (make-posn 10 20) (make-tank 28 -3))) #false)

(check-expect (si-game-over? (make-aim
                          (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3))) #true)

(check-expect (si-game-over? (make-fired
                          (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3) (make-posn 10 40))) #true)

(check-expect (si-game-over? (make-fired
                          (make-posn 10 50) (make-tank 28 -3) (make-posn 10 40))) #false)

(check-expect (si-game-over? (make-fired
                          (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49))) #true)

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

(check-expect (si-render-final (make-aim (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3))) (lose-text-render (tank-render (aim-tank (make-aim (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3)))
                                                                                                                          (red-ufo-render (aim-ufo (make-aim (make-posn 10 UFO-LAND-LEVEL) (make-tank 28 -3)))
                                                                                                                                          BACKGROUND))))

(check-expect (si-render-final (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49)))
              (win-text-render (star-fire-render (fired-ufo (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49)))
                                                 (fired-missile (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49)))
                                                 (missile-render (fired-missile (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49)))
                                                                 (tank-render (fired-tank (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49)))
                                                                              (ufo-render (fired-ufo (make-fired (make-posn 10 50) (make-tank 28 -3) (make-posn 10 49))) BACKGROUND))))))
                                                                                                                                                    
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

; Tank Image -> Image 
; adds t to the given image im

;(check-expect (tank-render (make-tank 25 -3) BACKGROUND) (place-image TANK 25  TANK-Y-LEVEL BACKGROUND))

(define (tank-render s im)
  (place-image TANK (tank-loc s) TANK-Y-LEVEL im))



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



; Missile Image -> Image 
; adds m to the given image im

;(check-expect (missile-render (make-posn 25 50) BACKGROUND) (place-image ROCKET 25 50 BACKGROUND))

(define (missile-render m im)
  (place-image ROCKET (posn-x m) (posn-y m) im))



; UFO Image -> Image 
; adds u to the given image im

;(check-expect (ufo-render (make-posn 25 30) BACKGROUND) (place-image UFO 25 30 BACKGROUND))

(define (ufo-render s im)
  (place-image UFO (posn-x s) (posn-y s) im))
