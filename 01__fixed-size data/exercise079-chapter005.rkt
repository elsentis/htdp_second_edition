;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise079-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise079-chapter005

; Q.:
; Create examples for the following data definitions



; A Color is one of: 
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black"

(define BLUE "blue")
(define ORANGE "orange")
(define GREEN "green")


; H is a Number between 0 and 100.
; interpretation represents a happiness value

(define JUST-BAD-DAY 0)
(define SIMPLE-HAPPY 80)
(define BEST-DAY 100)


(define-struct person [fstname lstname male?])
;  A Person is a structure:
;    (make-person String String Boolean)
; interpretation (make-person a b c) is a person designation
; in a database with a first-name, b last-name, and boolean gender designation:
;  #true if male, #false if female

(define ARTIST1 (make-person "Slava" "Vorontsov" #true))
(define ARTIST2 (make-person "Anna" "German" #false))

; question: Is it a good idea to use a field name that looks like the name of a predicate?
; answer: No, can get confused of this


(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)

;   (make-dog Person String PositiveInteger H)
; interpretation (make-dog a b c d) this is description of a domestic dog
; who 'a' is owner call his dog is 'b', dog is 'c' years old and feel 'd'
; points of their happines

(define pet-1 (make-dog ARTIST1 "petty" 8 SIMPLE-HAPPY))
(define pet-2 (make-dog ARTIST1 "silly" 7 SIMPLE-HAPPY))


; A Weapon is one of: 
; — #false
; — Posn
; interpretation #false means the missile hasn't 
; been fired yet; a Posn means it is in flight

(define missle-state-scene-1 #false)
(define missle-state-scene-150 (make-posn 50 50))