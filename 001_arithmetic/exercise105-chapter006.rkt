;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise105-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise105-chapter006

; Q.:
; Make up at least two data examples per clause in the data definition.
; For each of the examples, explain its meaning with a sketch of a canvas


; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

(define COORDINATE-POINT-1 10)
(define COORDINATE-POINT-2 100)

(define COORDINATE-POINT-3 -10)
(define COORDINATE-POINT-4 -100)

(define COORDINATE-POINT-5 (make-posn 100 100))
(define COORDINATE-POINT-6 (make-posn -100 -100))



(define WIDTH 500)
(define HEIGHT 500)

(define BACKGROUND (center-pinhole (empty-scene WIDTH HEIGHT)))

(define POINT (circle (/ WIDTH 100) "solid" "red"))

(define X-CENTER-POINT (/ WIDTH 2))
(define Y-CENTER-POINT (/ WIDTH 2))



; Coordinate -> Img
; consume a Coordinate and
; and places a point at these coordinates
; if  Coordinate is a number - on one of the axes
; if  Coordinate is a Posn - in cartesian space
; produce a Image with it

(define (coordinate-to-image coordinate)
  (cond [(posn? coordinate) (place-image POINT (+ X-CENTER-POINT (posn-x coordinate)) (- Y-CENTER-POINT (posn-y coordinate)) BACKGROUND)]
        [(number? coordinate) (cond [(>= coordinate 0) (place-image POINT (- X-CENTER-POINT coordinate) Y-CENTER-POINT BACKGROUND)]
                                    [else (place-image POINT X-CENTER-POINT (+ Y-CENTER-POINT coordinate)  BACKGROUND)])]
        [else "error"]))



(define SCETCH-POINT-1 (coordinate-to-image COORDINATE-POINT-1))
(define SCETCH-POINT-2 (coordinate-to-image COORDINATE-POINT-2))
(define SCETCH-POINT-3 (coordinate-to-image COORDINATE-POINT-3))
(define SCETCH-POINT-4 (coordinate-to-image COORDINATE-POINT-4))
(define SCETCH-POINT-5 (coordinate-to-image COORDINATE-POINT-5))
(define SCETCH-POINT-6 (coordinate-to-image COORDINATE-POINT-6))

SCETCH-POINT-1