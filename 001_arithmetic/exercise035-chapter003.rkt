;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise035-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise035-chapter003

; Q.:
; Design the function string-last, which extracts the last character from a non-empty string.

; string-last func
; we use string to represent string
; String -> String
; function return last symbol as string from input string

;given "hello world", expect "d"
;given "test", expect "t"

(define (last-string str)
  (substring str (- (string-length str) 1)))

(last-string "hello world")
(last-string "test")