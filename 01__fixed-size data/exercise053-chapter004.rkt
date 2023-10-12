;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise053-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise053-chapter004

; Q.:
; Draw some world for the LR definition, including at least HEIGHT and 0 as examples.

(define WIDTH  100)
(define HEIGHT 300) 
(define BACKGROUND  (empty-scene WIDTH HEIGHT))

(define ROCKET (polygon (list (make-posn 0 0)
                              (make-posn (-(/ WIDTH 10)) (/ WIDTH 5))
                              (make-posn 0 (/ WIDTH 8) )
                              (make-posn (/ WIDTH 10) (/ WIDTH 5))) "solid" "black"))

(define ROCKET-HEIGHT (image-height ROCKET))

; An LR (short for launching rocket) is one of:
; – "resting"
; – NonnegativeNumber
; interpretation "resting" represents a grounded rocket
; a number denotes the height of a rocket in flight



; we use LR represents a grounded rocket
; LR -> Image
; produse image with rocket flying in the background world
; consume LR data

(define (render lr)
  (cond
    [(string? lr)
     (if (string=? lr "resting")
         (place-image ROCKET (/ WIDTH 2) (- HEIGHT (/ ROCKET-HEIGHT 2)) BACKGROUND)
         #false)]
    [(number? lr)
     (place-image ROCKET (/ WIDTH 2) lr BACKGROUND)]))


; scene with an unlaunched rocket
;(render "resting")

; scene with HEIGHT as LR definition
(render HEIGHT)

; scene with 0 as LR definition
;(render 0)

; scene with (/ HEIGHT 2) as LR definition
;(render (/ HEIGHT 2))
