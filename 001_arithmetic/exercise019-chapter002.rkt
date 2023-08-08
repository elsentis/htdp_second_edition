;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise019-chapter002) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise019-chapter002

; Q.:
; Define the function string-insert, which consumes a string str plus a number i and inserts "_" at the ith position of str.
; Assume i is a number between 0 and the length of the given string (inclusive).
; See exercise 3 for ideas. Ponder how string-insert copes with "".

(define (string-insert str i)
  (string-append (substring str 0 i) "_" (substring str i)))


; Q.: Ponder how string-insert copes with "".

; > (string-insert "" 0)
; "_"
; string-insert inserts a "_" character before end of line character