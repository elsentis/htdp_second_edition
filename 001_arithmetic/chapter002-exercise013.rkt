;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter002-exercise013) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; chapter002-exercise013

; Q.:
; Define the function string-first, which extracts the first 1String from a non-empty string.

(define (string-first str)
  (if (string? str)
     (if (> (string-length str) 0)
         (substring str 0 1)
         ("error, expect a string"))
     ("error, expect a string")))
