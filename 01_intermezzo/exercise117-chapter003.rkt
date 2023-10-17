;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise117-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise117-intermezzo01

; Q.:
; Consider the following sentences
; Explain why they are syntactically illegal

; (3 + 4)
; 3, 4 is a value
; + is a primitive addition operation
; (3 + 4) grammatically incorrect operation call
; according to the rule:
; expr = (primitive expr expr ...)
; right version operation call
; (+ 3 4)

; number?
; number? is a primitive operation
; according to the rule right primitive using
; (primitive expr expr ...)
; number? - using without parenthesis and argument like expression
; right version operation call
; (number? 1)

; (x)
; x is a variable
; according to the rule:
; expr = variable
; without parenthesis
; right version variable call
; x

j%=h6KYiNrgS
