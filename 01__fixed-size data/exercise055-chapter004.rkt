;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise055-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise055-chapter004

; Q.:
; Define an auxiliary function that performs with the approximate shape
; (place-image ROCKET 10 (- ... CENTER) BACKG)

(define WIDTH  100)
(define HEIGHT 300) 
(define BACKG  (empty-scene WIDTH HEIGHT))

(define ROCKET (polygon (list (make-posn 0 0)
                              (make-posn (-(/ WIDTH 10)) (/ WIDTH 5))
                              (make-posn 0 (/ WIDTH 8) )
                              (make-posn (/ WIDTH 10) (/ WIDTH 5))) "solid" "black"))

(define ROCKET-HEIGHT (image-height ROCKET))
(define CENTER (/ (image-height ROCKET) 2))

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)



; we use LR represents a grounded rocket
; LR -> Image
; produse image with rocket flying in the background world
; consume LR data

(define (show x)
  (cond
    [(string? x) (rocket-show HEIGHT)]
    [(<= -3 x -1) (place-image (text (number->string x) 20 "red") 10 (* 3/4 WIDTH) (rocket-show HEIGHT))]
    [(>= x 0) (rocket-show x)]))



; aux fucn for produce img of only rocket with place-image func
; we use numbers to represent distance in pixels
; numb -> img

;(check-expect (rocket-show 0) (place-image ROCKET (/ WIDTH 2) (- 0 CENTER) BACKG))
;(check-expect (rocket-show 100) (place-image ROCKET (/ WIDTH 2) (- 100 CENTER) BACKG))

(define (rocket-show x)
  (place-image ROCKET (/ WIDTH 2) (- x CENTER) BACKG))