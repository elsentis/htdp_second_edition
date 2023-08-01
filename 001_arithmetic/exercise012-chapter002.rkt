;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter002-exercise012) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise012-chapter002

; Q.:
; Define the function cvolume, which accepts the length of a side of an equilateral cube and computes its volume.
; If you have time, consider defining csurface, too.

(define (cvolume length-of-side)
  (if (number? length-of-side)
      (if (>= length-of-side  0)
          (expt length-of-side 3)
          "error, expect a lenght")
      "error, expect a lenght")
  )

(define (csurface length-of-side)
  (if (number? length-of-side)
      (if (>= length-of-side  0)
          (* (expt length-of-side 2) 6)
          "error, expect a lenght")
      "error, expect a lenght")
  )
