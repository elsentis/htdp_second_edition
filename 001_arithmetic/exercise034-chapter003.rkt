;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise034-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise034-chapter003

; Q.:
; Design the function string-first, which extracts the first character from a non-empty string. Don’t worry about empty strings.

; sring-first func
; we use string to represent string
; String -> String 
; function return first symbol as string from input string

; given: "hello world", expect "h"
; given: "test", expect "t"

(define (string-first str)
  (substring str 0 1))

(string-first "hello world")
(string-first "test")