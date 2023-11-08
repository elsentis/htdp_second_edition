;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise161-chapter010) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise161-chapter010

; Q.:
; Translate the examples into tests and make sure they all succeed.
; Then change the function in figure 64 so that everyone gets $14 per hour.
; Now revise the entire program so that changing the wage for everyone
; is a single change to the entire program and not several.

(define WAGE-PER-HOUR 14)

; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
;
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons 392 '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons 56 (cons 28 '())))
;
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))
 
; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* WAGE-PER-HOUR h))