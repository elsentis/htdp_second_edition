;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise051-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise051-chapter004

; Q.:
; Design a big-bang program that simulates a traffic light for a given duration.
; The program renders the state of a traffic light as a solid circle of the appropriate color, and it changes state on every clock tick. 

; A TrafficLight is one of the following Strings:
; – "red"
; – "green"
; – "yellow"
; - "gold"
; interpretation the three strings represent the three 
; possible states that a traffic light may assume 
; (me add in traffic light second yellow (gold) signal, to warn of a change from red to green)


(define TIME-SWITCH-STATE 10)



; BB fucntion for traffic light state switching programm

(define (main ws)
  (big-bang ws
    [on-tick tock TIME-SWITCH-STATE]
    [to-draw render]))



; tock func for BB func
; for switch traffic light state per time
; TrafficLight -> TrafficLight

(check-expect (tock "red") "gold")
(check-expect (tock "gold") "green")
(check-expect (tock "green") "yellow")
(check-expect (tock "green") "yellow")
(check-expect (tock "yellow") "red")
(check-expect (tock "orange") "red")
(check-expect (tock "lol") "red")

(define (tock ws)
  (cond [(string=? ws "red") "gold"]
        [(string=? ws "gold") "green"]
        [(string=? ws "green") "yellow"]
        [(string=? ws "yellow") "red"]
        [else "red"]))



; render func for BB func
; for switch traffic light state per time
; TrafficLight -> Image

(define (render ws)
  (circle 10 "solid" ws))


; Q.:
; What is the most appropriate initial state? Ask your engineering friends.

; the most appropriate initial state is "red", for road safety