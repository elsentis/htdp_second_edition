;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise116-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise116-chapter003

; Q.:
; Take a look at the following sentences:
; Explain why they are syntactically legal expressions 

; x
; this is variable (refers to expression)

; (= y z)
; this is primitive operation called grammatically correct
; with parenthesis and two arguments

; (= (= y z) 0)
; primitive operation nested in primitive operation
; primitive operations are called syntactically correct