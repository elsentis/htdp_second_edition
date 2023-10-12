;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise038-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise038-chapter003

; Q.:
; Design the function string-remove-last, which produces a string like the given one with the last character removed.

; string-remove-last func
; we use string to represent string
; String -> String
; function take a string str and produce a string like input without last symbol

;given "hello world", expect "hello worl"
;given "test", expect "tes"

(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))


(string-remove-last "hello world")
(string-remove-last "test")
                             