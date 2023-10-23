;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise138-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise138-chapter009

; Q.:
; Here is a data definition for representing sequences of amounts of money
; Create some examples to make sure you understand the data definition. Also add an arrow for the self-reference
; Design the sum function, which consumes a List-of-amounts and computes the sum of the amounts.
; Use DrRacket’s stepper to see how (sum l) works for a short list l in List-of-amounts.



; A List-of-amounts is one of: 
; – '()
; – (cons PositiveNumber List-of-amounts)

(define test-loa-1 (cons 15 (cons 25 (cons 10 '()))))
(define test-loa-2 (cons 1 (cons 1 '())))


; List-of-amounts -> PositiveNumber
; computes the sum of the amounts

; (how-many.v2 test-loa-1) == 50
; (how-many.v2 test-loa-2) == 2
; (how-many.v2 '()) == 0

(check-expect (how-many.v2 test-loa-1) 50)
(check-expect (how-many.v2 test-loa-2) 2)
(check-expect (how-many.v2 '()) 0)

(define (how-many.v2 aloa)
  (cond
    [(empty? aloa) 0]
    [(cons? aloa) (+
                   (first aloa)
                   (how-many.v2 (rest aloa)))]))