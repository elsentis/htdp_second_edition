;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise128-intermezzo01) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise128-intermezzo01

; Q.:
; Copy the following tests into DrRacket’s definitions area
; Validate that all of them fail and explain why



; (check-member-of "green" "red" "yellow" "grey")
; Check failures
; check-member-of
; checks that the value of the first expression is that of one of the following expressions
; value of the expression "green" - is a same string
; there are no this value among following expressions


; (check-within (make-posn #i1.0 #i1.1)
;               (make-posn #i0.9 #i1.2)  0.01)
; Check failures
; check-within
; the value of the expression expression is structurally equal to the value produced by the expected-expression expression;
; every number in the first expression must be within delta of the corresponding number in the second expression
; in our case difference between numbers in the first and second expressions more than delta

; (check-range #i0.9 #i0.6 #i0.8)
; Check failures
; check-range
; Checks that the value of the first expression is a number in between the value of the low-expression and the high-expression, inclusive
; in our case value of the first expression out of range whose boundaries are values of second and third expressions

; (check-random (make-posn (random 3) (random 9))
;               (make-posn (random 9) (random 3)))
; Check failures
; check-random
; Checks that the first expression evaluates to the same value as the expected-expression
; The form supplies the same random-number generator to both parts
; if both parts request random numbers from the same interval in the same order, they receive the same random numbers.
; in our case experssions requests random numbers from the same intervals, but in the different order

; (check-satisfied 4 odd?)
; Check failures
; check-satisfied
; Checks that the first expression satisfies the named predicate (function of one argument).
; Recall that “satisfies” means “the function produces #true for the given value.”
; in our case value of expression is number 4, that is not a odd number 