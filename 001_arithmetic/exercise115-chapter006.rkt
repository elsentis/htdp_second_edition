;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise115-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise115-chapter006


; Q.:
; Revise light=? so that the error message specifies which of the two arguments isn’t an element of TrafficLight.


(define MESSAGE-1
  "light=?:expects a trafficlight as 1st argument, given ")

(define MESSAGE-2
  "light=?:expects a trafficlight as 2nd argument, given ")
 
; Any Any -> Boolean
; are the two values elements of TrafficLight and, 
; if so, are they equal

;(check-expect (light=? "red" "red") #true)
;(check-expect (light=? "red" "green") #false)
;(check-expect (light=? "green" "green") #true)
;(check-expect (light=? "yellow" "yellow") #true)
;(check-expect (light=? "blue" "yellow") (error "light=?:expects a trafficlight as 1st argument, given blue"))
;(check-expect (light=? 1 "yellow") (error "light=?:expects a trafficlight as 1st argument, given 1"))
;(check-expect (light=? "yellow" "blue") (error "light=?:expects a trafficlight as 2nd argument, given blue"))
;(check-expect (light=? "blue" "blue") (error "light=?:expects a trafficlight as 1st argument, given blue"))
 
(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (cond [(not (light? a-value)) (error MESSAGE-1 a-value)]
            [(not (light? another-value)) (error MESSAGE-2 another-value)])))



; Any -> Boolean
; is the given value an element of TrafficLight

(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))