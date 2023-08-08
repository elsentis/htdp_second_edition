;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise021-chapter002) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise021-chapter002

; Q.:
; Use DrRacket’s stepper to evaluate (ff (ff 1)) step-by-step. Also try (+ (ff 1) (ff 1)).
; Does DrRacket’s stepper reuse the results of computations?

(define (ff a)
  (* 10 a))

; (ff (ff 1))
(+ (ff 1) (ff 1))


; Q.:
; Does DrRacket’s stepper reuse the results of computations?

; No, DrRacket inserts the argument into the function's body each time the function is called, even for the same arguments