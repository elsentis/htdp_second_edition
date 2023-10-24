;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise147-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise147-chapter009

; Q.:
; Develop a data definition for NEList-of-Booleans, a representation of non-empty lists of Boolean values.
; Then redesign the functions all-true and one-true from exercise 140.



; An NEList-of-Booleans is one of: 
; – (cons Boolean '())
; – (cons Boolean NEList-of-Booleans)
; interpretation non-empty lists of some Booleans


; NEList-of-Booleans -> Boolean
; which consumes a non-empty lists of Booleans values and producing #true if whether all of them are #true
; #false if if there is any #false on the list
;
; (check-expect (all-true (cons #false '())) #false)
; (check-expect (all-true (cons #true (cons #true (cons #true '())))) #true)
; (check-expect (all-true (cons #true (cons #false (cons #true '())))) #false)
;
(define (all-true ne-lob)
  (cond
    [(empty? (rest ne-lob)) (first ne-lob)]
    [else (and (first ne-lob) (all-true (rest ne-lob)))]))


; NEList-of-Booleans -> Boolean
; consumes a non-empty lists of Booleans values and producing #true if at least one item on the list is #true
; #false if there are none #true in the list
;
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #false '())) #false)
(check-expect (one-true (cons #true (cons #false '()))) #true)
;
(define (one-true ne-lob)
  (cond
    [(empty? (rest ne-lob)) (first ne-lob)]
    [else (or (first ne-lob) (one-true (rest ne-lob)))]))