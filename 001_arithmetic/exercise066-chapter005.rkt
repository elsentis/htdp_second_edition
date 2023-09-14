;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise066-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise066-chapter005

; Q.:
; Revisit the structure type definitions of exercise 65. Make sensible guesses as to what kind of values go with which fields.
; Then create at least one instance per structure type definition.


(define-struct movie [title producer year])

(define m-1 (make-movie "revolver" "guy ritchie" 2005))
(define m-2 (make-movie "cloud-paradise" "nikolai dostal" 1990))



(define-struct person [name hair eyes phone])

(define person1 (make-person "ivan" "black" "brown" 222))
(define person2 (make-person "denis" "white" "blue" 420))



(define-struct pet [name number])

(define dog (make-pet "flo" 1))
(define cat (make-pet "jiu" 2))



(define-struct CD [artist title price])

(define karate-smo (make-CD "smo" "karate" "2.99"))
(define defolt-various (make-CD "various" "defolt" "5.00"))



(define-struct sweater [material size producer])

(define sweater-for-winter (make-sweater  "wool" "l" "z"))
(define sweater-for-autumn (make-sweater "cotton" "l" "b"))
