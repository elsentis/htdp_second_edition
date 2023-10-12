;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise111-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise111-chapter006

; Q.:
; Develop the function checked-make-vec, which is to be understood as a checked version of the primitive operation make-vec.
; It ensures that the arguments to make-vec are positive numbers. In other words, checked-make-vec enforces our informal data definition.

(define MESSAGE "make-vec: positive number expected")

(define-struct vec [x y])
; A vec is
;   (make-vec PositiveNumber PositiveNumber)
; interpretation represents a velocity vector


; Number, Number -> vec
; to create vec with additional check for accepted objects

(check-expect (checked-make-vec 10 10) (make-vec 10 10))
(check-expect (checked-make-vec 0 10) MESSAGE)
(check-expect (checked-make-vec 10 0) MESSAGE)
(check-expect (checked-make-vec -1 1) MESSAGE)
(check-expect (checked-make-vec "lol" "lol") MESSAGE)

(define (checked-make-vec x y)
  (cond [(and (number? x) (number? y))
         (cond [(and (positive? x) (positive? y)) (make-vec x y)]
               [else MESSAGE])]
        [else MESSAGE]))
