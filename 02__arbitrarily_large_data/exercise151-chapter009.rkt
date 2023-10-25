;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise151-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise151-chapter009

; Q.:
; Design the function multiply.
; It consumes a natural number n and multiplies it with a number x without using *.



; N Number  -> Number
; consumes a natural number n and multiplies it with a number x without using *
 
(check-within (multiply 3 pi) (* 3 pi) 0.001)
(check-expect (multiply 3 10) 30)
 
(define (multiply n x)
  (cond
    [(zero? n) 0]
    [else (+ x (multiply (sub1 n) x))]))


; Q.:
; How does multiply relate to what you know from grade school?
;
; A.:
; when defining multiply funciton we used the fact that for natural numbers
; the product is the multiple addition of the first multiplier by the number of times of the second