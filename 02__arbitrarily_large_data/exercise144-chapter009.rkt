;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise144-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise144-chapter009

; Q.:
; Will sum and how-many work for NEList-of-temperatures even though they are designed for inputs from List-of-temperatures?
; If you think they don’t work, provide counter-examples. If you think they would, explain why.


; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures 
 
(define ABSOLUTE0 -272)
; A CTemperature is a Number greater than ABSOLUTE0.


; NEList-of-temperatures -> Number
; computes the average temperature 
; 
;(check-expect (average (cons 1 (cons 2 (cons 3 '()))))
;              2)
; 
(define (average ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))


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


; Q.:
; Will sum and how-many work for NEList-of-temperatures even though they are designed for inputs from List-of-temperatures?
; If you think they don’t work, provide counter-examples. If you think they would, explain why.
;
; A.:
; Yes, sum and how-many work for NEList-of-temperatures because all elements of the NEList-of-temperatures
; are also non-empty elements of List-of-temperatures (subset) and this functions defined to process a wider range of data
; than NEList-of-temperatures
