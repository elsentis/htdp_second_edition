;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise143-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise143-chapter009

; Q.:
; Determine how average behaves in DrRacket when applied to the empty list.
; Then design checked-average, a function that produces an informative error message when it is applied to '().


; A List-of-temperatures is one of: 
; – '()
; – (cons CTemperature List-of-temperatures)
 
(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.


; List-of-temperatures -> Number
; computes the average temperature
;
(check-expect
  (checked-average (cons 1 (cons 2 (cons 3 '())))) 2)
(check-error
  (checked-average  '()) "checked-average: there is an empty list in input data")
;
(define (checked-average alot)
  (cond
    [(empty? alot) (error 'checked-average "there is an empty list in input data")]
    [(cons? alot) (/ (sum alot) (how-many alot))]))


; List-of-temperatures -> Number 
; adds up the temperatures on the given list
;
;(check-expect
;  (sum (cons 1 (cons 2 (cons 3 '())))) 6)
;
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))

 
; List-of-temperatures -> Number 
; counts the temperatures on the given list
;
;(check-expect
;  (how-many (cons 1 (cons 2 (cons 3 '())))) 3)
;
(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else (+ (how-many (rest alos)) 1)]))
