;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise126-intermezzo01) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise126-intermezzo01

; Q.:
; Identify the values among the following expressions, assuming the definitions area contains these structure type definitions
; (define-struct point [x y z])
; (define-struct none  [])
; Explain why the expressions are values or not



; (define-struct point [x y z])
; (define-struct none  [])


; 1.
; (make-point 1 2 3)
; value of this expression is that instance
; of point structure (make-point 1 2 3)

; 2.
; (make-point (make-point 1 2 3) 4 5)
; value of this expression is that instance
; of point structure (make-point (make-point 1 2 3) 4 5)
; value of the first variable is another one point structure instance (make-point 1 2 3)

; 3.
; (make-point (+ 1 2) 3 4)
;
; ==
;
; (make-point 3 3 4)
;
; value of this expression is instance
; of point structure (make-point 3 4 5)
; value of the first component is value of expression in parentheses (+ 1 2)

; 4.
; (make-none)
; value of this expression is instance
; of none structure (make-none)
; legal, because none structure type definition does not contain variables components

; 5.
; (make-point (point-x (make-point 1 2 3)) 4 5)
;
; ==
;
; (make-point 1 4 5)
;
; value of this expression is instance
; of point structure (make-point 1 4 5)
; value of the first component is value of selector's expression (point-x (make-point 1 2 3))