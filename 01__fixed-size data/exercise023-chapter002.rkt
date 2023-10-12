;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise023-chapter002) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise023-chapter002

; Q.:
; The first 1String in "hello world" is "h". How does the following function compute this result?
; Use the stepper to confirm your ideas.

(define (string-first s)
  (substring s 0 1))


(string-first "hello world")

; Q.:
; How does the following function compute this result?

; string-first uses a helper function substring to calculate the result
; if you pass the arguments: input string and 0 and 1 to the substring function, it will return the first character of the input string