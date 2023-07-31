;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter001-exercise009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; chapter001-exercise009

; Q.:
; create an expression that converts the value of in to a non-negative number.
; For a String, it determines how long the String is; for an Image, it uses the area; for a Number, it uses the absolute value; for #true it uses 10 and for #false 20

(define in -1)

(cond
  [(number? in) (if (>= in 0) in (* in -1))]
  [(string? in) (string-length in)]
  [(image? in) (* (image-width in) (image-height in))]
  [(boolean? in) (if in 10 20)]
  [else "wtf is it\n"])
  
