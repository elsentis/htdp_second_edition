;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise165-chapter010) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

; exercise165-chapter010

; Q.:
; Design the function subst-robot, which consumes a list of toy descriptions (one-word strings)
; and replaces all occurrences of "robot" with "r2d2"; all other descriptions remain the same.
; 
; Generalize subst-robot to substitute.
; The latter consumes two strings, called new and old, and a list of strings.
; It produces a new list of strings by substituting all occurrences of old with new.



; a Toy is a String
; interpretation represents the toy descriptions (one-word strings)

