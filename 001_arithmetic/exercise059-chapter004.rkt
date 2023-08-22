;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise059-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise059-chapter004

; Q.:
; Finish the design of a world program that simulates the traffic light FSA
; The function’s argument is the initial state for the big-bang expression, which tells DrRacket to redraw the state of the world with tl-render and to handle clock ticks with tl-next.
; Complete the design of tl-render and tl-next. Complete the design of tl-render and tl-next.
; If you decide to create images with the functions from the 2htdp/image teachpack, design an auxiliary function for creating the image of a one-color bulb.


(define WIDTH 90)
(define HEIGHT 30)
(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define BULB-RADIUS (/ (- WIDTH (/ WIDTH 5)) 2))



; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; - "gold"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume 
; (me add in traffic light second yellow (gold) signal, to warn of a change from red to green)



; TrafficLight -> TrafficLight
; yields the next state, given current state cs

;(check-expect (tl-next "red") "gold")
;(check-expect (tl-next "gold") "green")
;(check-expect (tl-next "green") "yellow")
;(check-expect (tl-next "yellow") "red")

(define (tl-next cs)
  (cond [(string=? cs "red") "gold"]
        [(string=? cs "gold") "green"]
        [(string=? cs "green") "yellow"]
        [(string=? cs "yellow") "red"]))



; TrafficLight -> Image
; renders the current state cs as an image

(check-expect (tl-render "red") (place-image (beside
                                              (circle BULB-RADIUS "solid" "red")
                                              (circle BULB-RADIUS "outline" "gold")
                                              (circle BULB-RADIUS "outline" "green")
                                              (circle BULB-RADIUS "outline" "yellow"))
                                             (/ WIDTH 2) (/ HEIGHT 2) BACKGROUND))

(check-expect (tl-render "gold") (place-image (beside
                                              (circle BULB-RADIUS "outline" "red")
                                              (circle BULB-RADIUS "solid" "gold")
                                              (circle BULB-RADIUS "outline" "green")
                                              (circle BULB-RADIUS "outline" "yellow"))
                                             (/ WIDTH 2) (/ HEIGHT 2) BACKGROUND))

(define (tl-render current-state)
  (place-image (beside
                (circle BULB-RADIUS "outline" "red")
                (circle BULB-RADIUS "solid" "gold")
                (circle BULB-RADIUS "outline" "green")
                (circle BULB-RADIUS "outline" "yellow"))
               (/ WIDTH 2) (/ HEIGHT 2)))