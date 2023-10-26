;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise154-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise154-chapter009

; Q.:
; Design the function colors.
; It consumes a Russian doll and produces a string of all colors, separated by a comma and a space.
; Thus our example should produce
; "yellow, green, red"



(define-struct layer [color doll])
; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)


; RD -> String
; consumes a Russian doll and produces a string of all colors, separated by a comma and a space
;
(check-expect (colors "red") "red")
(check-expect (colors (make-layer "yellow" (make-layer "green" "red"))) "yellow, green, red")
;
(define (colors an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (string-append (layer-color an-rd)
                         ", "
                         (colors (layer-doll an-rd)))]))