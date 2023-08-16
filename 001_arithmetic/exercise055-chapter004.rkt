;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise055-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise055-chapter004

; Q.:
; Define an auxiliary function that performs with the approximate shape
; (place-image ROCKET 10 (- ... CENTER) BACKG)

(define WIDTH  100)
(define HEIGHT 300) 
(define BACKGROUND  (empty-scene WIDTH HEIGHT))

(define ROCKET (polygon (list (make-posn 0 0)
                              (make-posn (-(/ WIDTH 10)) (/ WIDTH 5))
                              (make-posn 0 (/ WIDTH 8) )
                              (make-posn (/ WIDTH 10) (/ WIDTH 5))) "solid" "black"))

(define ROCKET-HEIGHT (image-height ROCKET))
(define CENTER (/ (image-height ROCKET) 2))

; An LR (short for launching rocket) is one of:
; – "resting"
; – NonnegativeNumber
; interpretation "resting" represents a grounded rocket
; a number denotes the height of a rocket in flight



; we use LR represents a grounded rocket
; LR -> Image
; produse image with rocket flying in the background world
; consume LR data

(define (show x)
  (cond
    [(string? x)
     (place-image ROCKET 10 (- HEIGHT CENTER) BACKG)]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (place-image ROCKET
                               10 (- HEIGHT CENTER)
                               BACKG))]
    [(>= x 0)
     (place-image ROCKET 10 (- x CENTER) BACKG)]))



;aux fucn for produce img of only rocket with place-image func
;we use numbers to represent distance in pixels
;numb -> img

(check-expect (rocket-show 0) (place-image ROCKET (/ WIDTH 2) (- (- HEIGHT CENTER) 0) BACKG))
(check-expect (rocket-show 10) (place-image ROCKET (/ WIDTH 2) (- (- HEIGHT CENTER) 10) BACKG))

(define (rocket-show x)
  ((place-image ROCKET (/ WIDTH 2) (- x CENTER) BACKG)))