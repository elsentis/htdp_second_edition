;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercies073-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercies073-chapter005

; Q.:
; Design the function posn-up-x, which consumes a Posn p and a Number n. It produces a Posn like p with n in the x field
; Functions such as posn-up-x are often called updaters or functional setters. They are extremely useful when you write large programs.


; Posn -> Posn
; increases the x-coordinate of p by 3

(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))

(define (x+ p)
  (posn-up-x p (+ (posn-x p) 3)))



; Posn -> Posn
; substitute the x-coordinate of p by n

(check-expect (posn-up-x (make-posn 10 0) 14) (make-posn 14 0))

(define (posn-up-x p n)
  (make-posn n (posn-y p)))