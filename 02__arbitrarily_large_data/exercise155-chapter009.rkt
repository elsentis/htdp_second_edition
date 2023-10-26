;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise155-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise155-chapter009

; Q.:
; Design the function inner, which consumes an RD and produces the (color of the) innermost doll.
; Use DrRacket’s stepper to evaluate (inner rd) for your favorite rd.



(define-struct layer [color doll])
; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)


; RD -> String
; consumes an RD and produces the (color of the) innermost doll
;
(check-expect (inner "red") "red")
(check-expect (inner (make-layer "yellow" (make-layer "green" "red"))) "red")
;
(define (inner an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (inner (layer-doll an-rd))]))