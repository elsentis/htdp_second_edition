;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter010-exercise162) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise162-chapter010

; Q.:
; No employee could possibly work more than 100 hours per week.
; To protect the company against fraud, the function should check
; that no item of the input list of wage* exceeds 100.
; If one of them does, the function should immediately signal an error.
; How do we have to change the function in figure 64 if we want to perform this basic reality check?


(define WAGE-PER-HOUR 14)

; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
;
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons 392 '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons 56 (cons 28 '())))
(check-error (wage* (cons 4 (cons 101 (cons 1 '())))) "incorrect input, exceeding the allowed value")
;
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [(> (first whrs) 100) (error "incorrect input, exceeding the allowed value")]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))
 
; Number -> Number
; computes the wage for h hours of work
(define (wage h)
  (* WAGE-PER-HOUR h))