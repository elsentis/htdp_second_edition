;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise061-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise061-chapter004

; Q.:
; As From Functions to Programs says, programs must define constants and use names instead of actual constants. In this spirit, a data definition for traffic lights must use constants, too
; Which of the two ways is properly designed using the recipe for itemization? Which of the two ways continues to work if you change the constants


(define WIDTH 90)
(define HEIGHT 30)
(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define BULB-RADIUS (/ WIDTH 10))

(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")
(define GOLD "gold")

; An C-TrafficLight is one of:
; – RED interpretation the traffic light shows red
; – GOLD interpretation the traffic light shows gold (yellow before green)
; – GREEN interpretation the traffic light shows green
; - YELLOW interpretation the traffic light shows yellow (yellow before red)
; interpretation the three constants represent the three 
; possible states that a traffic light may assume 
; (me add in traffic light second yellow (gold) signal, to warn of a change from red to green)


; C-TrafficLight -> C-TrafficLight
; simulates a clock-based American traffic light
; (traffic-light-simulation-constant RED)

(define (traffic-light-simulation-constant initial-state)
  (big-bang initial-state
    [to-draw tl-render-constant]
    [on-tick tl-next-constant 1]))


; C-TrafficLight -> C-TrafficLight
; yields the next state, given current state cs

;(check-expect (tl-next-constant RED) GOLD)
;(check-expect (tl-next-constant GOLD) GREEN)
;(check-expect (tl-next-constant GREEN) YELLOW)
;(check-expect (tl-next-constant YELLOW) RED)

(define (tl-next-constant cs)
  (cond
    [(equal? cs RED) GOLD]
    [(equal? cs GREEN) YELLOW]
    [(equal? cs YELLOW) RED]
    [(equal? cs GOLD) GREEN]))



; C-TrafficLight -> Image
; renders the current state cs as an image

;(check-expect (tl-render-constant RED) (place-image (circle BULB-RADIUS "solid" "red") (/ WIDTH 8) (/ HEIGHT 2)
;                                             (place-image (circle BULB-RADIUS "outline" "gold") (* (/ WIDTH 8) 3) (/ HEIGHT 2)
;                                                          (place-image (circle BULB-RADIUS "outline" "yellow") (* (/ WIDTH 8) 5) (/ HEIGHT 2)
;                                                                       (place-image (circle BULB-RADIUS "outline" "green") (* (/ WIDTH 8) 7) (/ HEIGHT 2) BACKGROUND)))))

;(check-expect (tl-render-constant YELLOW) (place-image (circle BULB-RADIUS "outline" "red") (/ WIDTH 8) (/ HEIGHT 2)
;                                             (place-image (circle BULB-RADIUS "outline" "gold") (* (/ WIDTH 8) 3) (/ HEIGHT 2)
;                                                          (place-image (circle BULB-RADIUS "solid" "yellow") (* (/ WIDTH 8) 5) (/ HEIGHT 2)
;                                                                       (place-image (circle BULB-RADIUS "outline" "green") (* (/ WIDTH 8) 7) (/ HEIGHT 2) BACKGROUND)))))

(define (tl-render-constant current-state)
  (place-image (circle BULB-RADIUS (if (equal? current-state RED) "solid" "outline") "red") (/ WIDTH 8) (/ HEIGHT 2)
               (place-image (circle BULB-RADIUS (if (equal? current-state GOLD) "solid" "outline") "gold") (* (/ WIDTH 8) 3) (/ HEIGHT 2)
                            (place-image (circle BULB-RADIUS (if (equal? current-state YELLOW) "solid" "outline") "yellow") (* (/ WIDTH 8) 5) (/ HEIGHT 2)
                                         (place-image (circle BULB-RADIUS (if (equal? current-state GREEN) "solid" "outline") "green") (* (/ WIDTH 8) 7) (/ HEIGHT 2) BACKGROUND)))))


; Q.:
; Which of the two ways is properly designed using the recipe for itemization? Which of the two ways continues to work if you change the constants (modulo vs equal?)

; representation of data as constants more versatile and safe
; the way with equality check using equal? function more proper because it is more straightforward and versatile
; this will work in both cases - a constant and a number and a string