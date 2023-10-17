;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise119-intermezzo01) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise119-intermezzo01

; Q.: Consider the following sentences:
; Explain why they are syntactically illegal



; (define (f "x") x)
; 'define' is a keyword
; f, x is a variable
; expr = variable
; "x" is a string
; string is a value
; compound sentence (define (variable value) expr) not included in BSL core grammar


; (define (f x y z) (x))
; 'define' is a keyword
; f, x is a variable
; expr = variable
; compound sentence (define (variable variable variable variable value) (expr)) not included in BSL core grammar


