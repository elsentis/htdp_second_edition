;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise037-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise037-chapter003

; Q.:
; Design the function string-rest, which produces a string like the given one with the first character removed.

; string-rest func
; we use string to represent string
; String -> String
; func take a string str and return a string str without first symbol

; given "hello world", expect "ello world"
; given "test", expect "est"

(define (string-rest str)
  (substring str 1))


(string-rest "hello world") 
(string-rest "test")