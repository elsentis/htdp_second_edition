;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ecercise039-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; ecercise039-chapter003

; Q.:
; Develop your favorite image of an automobile so that WHEEL-RADIUS remains the single point of control.

(define WHEEL-RADIUS 10)

(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))


(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define CAR-BODY (polygon (list (make-posn 0 0)
                                (make-posn 0 (* 2 WHEEL-RADIUS))
                                (make-posn (* 9 WHEEL-RADIUS) (* 2 WHEEL-RADIUS))
                                (make-posn (* 9 WHEEL-RADIUS) 0)
                                (make-posn (* 7 WHEEL-RADIUS) 0)
                                (make-posn (* 7 WHEEL-RADIUS) (- 0 WHEEL-RADIUS))
                                (make-posn (* 2 WHEEL-RADIUS) (- 0 WHEEL-RADIUS))
                                (make-posn (* 2 WHEEL-RADIUS) 0))
                          "solid"
                          "red")
  )

(define WHEELS-PAIR (overlay/offset WHEEL WHEEL-DISTANCE 0 WHEEL))

(define CAR (overlay/offset WHEELS-PAIR 0 (- 0 (* WHEEL-RADIUS 1.5)) CAR-BODY))
