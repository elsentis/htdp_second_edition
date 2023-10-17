;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise118-intermezzo01) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise118-intermezzo01

; Q.:
; Take a look at the following sentences:
; Explain why they are syntactically legal definitions


; (define (f x) x)
; 'define' is a keyword
; f, x is a variable
; expr = variable
; def = (define (variable variable variable ...) expr)



; (define (f x) y)
; 'define' is a keyword
; f, x, y is a variable
; expr = variable
; def = (define (variable variable variable ...) expr)



; (define (f x y) 3)
; 'define' is a keyword
; f, x, y is a variable
; expr = variable
; 3 is a number
; number is a value
; def = (define (variable variable variable ...) expr)
