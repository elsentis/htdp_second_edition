;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise150-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise150-chapter009

; Q.:
; Design the function add-to-pi.
; It consumes a natural number n and adds it to pi without using the primitive + operation.
; Once you have a complete definition, generalize the function to add
; which adds a natural number n to some arbitrary number x without using +



; N -> Number
; computes (+ n pi) without using +
 
;(check-within (add-to-pi 3) (+ 3 pi) 0.001)
 
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [else (add1 (add-to-pi (sub1 n)))]))

; Q.:
; Why does the skeleton use check-within?
;
; A.:
; because pi inaccurate number and when checking the results , which include pi
; to be safe, it is better to use a check with a range
; (and check-expect don't work with expr or expected-expr to produce an inexact number)



; Q.:
; Once you have a complete definition, generalize the function to add
; which adds a natural number n to some arbitrary number x without using +

; N Number  -> Number
; adds a natural number n to some arbitrary number x without using +
 
(check-within (add 3 pi) (+ 3 pi) 0.001)
(check-expect (add 3 10) 13)
 
(define (add n x)
  (cond
    [(zero? n) x]
    [else (add1 (add (sub1 n) x))]))