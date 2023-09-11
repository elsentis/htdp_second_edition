;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise060-chapter004) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise060-chapter004

; Q.:
; An alternative data representation for a traffic light program may use numbers instead of strings
; Reformulate tl-next’s tests for tl-next-numeric
; Does the tl-next function convey its intention more clearly than the tl-next-numeric function? If so, why? If not, why not?

(define WIDTH 90)
(define HEIGHT 30)
(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define BULB-RADIUS (/ WIDTH 10))

; An N-TrafficLight is one of:
; – 0 interpretation the traffic light shows red
; – 1 interpretation the traffic light shows gold (yellow before green)
; – 2 interpretation the traffic light shows green
; - 3 interpretation the traffic light shows yellow (yellow before red)
; interpretation the three numbers represent the three 
; possible states that a traffic light may assume 
; (me add in traffic light second yellow (gold) signal, to warn of a change from red to green)


; N-TrafficLight -> N-TrafficLight
; simulates a clock-based American traffic light
; (traffic-light-simulation-numeric 0)

(define (traffic-light-simulation-numeric initial-state)
  (big-bang initial-state
    [to-draw tl-render-numeric]
    [on-tick tl-next-numeric 1]))


; N-TrafficLight -> N-TrafficLight
; yields the next state, given current state cs

;(check-expect (tl-next-numeric 0) 1)
;(check-expect (tl-next-numeric 1) 2)
;(check-expect (tl-next-numeric 2) 3)
;(check-expect (tl-next-numeric 3) 0)

(define (tl-next-numeric cs) (modulo (+ cs 1) 4))


; N-TrafficLight -> Image
; renders the current state cs as an image

;(check-expect (tl-render-numeric 0) (place-image (circle BULB-RADIUS "solid" "red") (/ WIDTH 8) (/ HEIGHT 2)
;                                             (place-image (circle BULB-RADIUS "outline" "gold") (* (/ WIDTH 8) 3) (/ HEIGHT 2)
;                                                          (place-image (circle BULB-RADIUS "outline" "yellow") (* (/ WIDTH 8) 5) (/ HEIGHT 2)
;                                                                       (place-image (circle BULB-RADIUS "outline" "green") (* (/ WIDTH 8) 7) (/ HEIGHT 2) BACKGROUND)))))

;(check-expect (tl-render-numeric 3) (place-image (circle BULB-RADIUS "outline" "red") (/ WIDTH 8) (/ HEIGHT 2)
;                                             (place-image (circle BULB-RADIUS "outline" "gold") (* (/ WIDTH 8) 3) (/ HEIGHT 2)
;                                                          (place-image (circle BULB-RADIUS "solid" "yellow") (* (/ WIDTH 8) 5) (/ HEIGHT 2)
;                                                                       (place-image (circle BULB-RADIUS "outline" "green") (* (/ WIDTH 8) 7) (/ HEIGHT 2) BACKGROUND)))))

(define (tl-render-numeric current-state)
  (place-image (circle BULB-RADIUS (if (= current-state 0) "solid" "outline") "red") (/ WIDTH 8) (/ HEIGHT 2)
               (place-image (circle BULB-RADIUS (if (= current-state 1) "solid" "outline") "gold") (* (/ WIDTH 8) 3) (/ HEIGHT 2)
                            (place-image (circle BULB-RADIUS (if (= current-state 3) "solid" "outline") "yellow") (* (/ WIDTH 8) 5) (/ HEIGHT 2)
                                         (place-image (circle BULB-RADIUS (if (= current-state 2) "solid" "outline") "green") (* (/ WIDTH 8) 7) (/ HEIGHT 2) BACKGROUND)))))




; Q.:
; Does the tl-next function convey its intention more clearly than the tl-next-numeric function? If so, why? If not, why not?

; it may seem that string representation more more suitable
; but this is only convenient for reading the program a person unfamiliar with the program
; numeric representation more suitable for increased order, data control and versatility
; also according to the recipe from this book nessesary to use constants as a single point of program control 