;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise131-chapter008) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise131-chapter008

; Q.:
; Provide a data definition for representing lists of Boolean values
; The class contains all arbitrarily long lists of Booleans



; A List-of-booleans is one of: 
; – '()
; – (cons Boolean List-of-booleans)
; interpretation a list of booleans for data recording

(cons #true (cons #true (cons #false (cons #true (cons #false '())))))