;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise140-chapter009) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise140-chapter009

; Q.:
; Design the function all-true, which consumes a list of Boolean values and determines whether all of them are #true.
; In other words, if there is any #false on the list, the function produces #false.
; Design one-true, a function that consumes a list of Boolean values and determines whether at least one item on the list is #true.



; Q.:
; Design the function all-true, which consumes a list of Boolean values and determines whether all of them are #true.


; A List-of-booleans is one of:
; -- '()
; -- (cons Boolean '())
; interpretation a list of some booleans

; List-of-Booleans -> Boolean
; which consumes a list of Boolean values and producing #true if whether all of them are #true
; #false if if there is any #false on the list
;
; (check-expect (all-true '()) #true)
; (check-expect (all-true (cons #true (cons #true (cons #true'())))) #true)
; (check-expect (all-true (cons #true (cons #false (cons #true'())))) #false)

(define (all-true alob)
  (cond
    [(empty? alob) #true]
    [(cons? alob) (cond
                    [(first alob) (all-true (rest alob))]
                    [else #false])]))


; Q.:
; Now design one-true, a function that consumes a list of Boolean values
; and determines whether at least one item on the list is #true.

; List-of-Booleans -> Boolean
; consumes a list of Boolean values and producing #true if at least one item on the list is #true
; #false if there are none #true in the list
;
(check-expect (one-true '()) #false)
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #false '())) #false)
(check-expect (one-true (cons #true (cons #false '()))) #true)
;
(define (one-true alob)
  (cond
    [(empty? alob) #false]
    [(cons? alob) (cond
                    [(first alob) #true]
                    [else (one-true (rest alob))])]))

