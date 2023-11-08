;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise160-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; chapter009-exercise160

; Q.:
; Design the functions set+.L and set+.R,
; which create a set by adding a number x to some given set s
; for the left-hand and right-hand data definition, respectively.



; A Son.L is one of: 
; – empty 
; – (cons Number Son.L)
; 
; Son is used when it 
; applies to Son.L and Son.R
(define s1.L (cons 1 (cons 1 '()))) 

; A Son.R is one of: 
; – empty 
; – (cons Number Son.R)
; 
; Constraint If s is a Son.R, 
; no number occurs twice in s


; Number Son.L -> Son.L
; add x to s 
;
(check-expect (set+.L 1 s1.L) es)
;
(define (set+.L x s)
  (append (cons x '()) s))

; check contain x in s
(define (contain? x s)
  (
