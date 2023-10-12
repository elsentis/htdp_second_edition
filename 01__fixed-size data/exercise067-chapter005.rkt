;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise067-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise067-chapter005

; Q.:
; Here is another way to represent bouncing balls
; Interpret this code fragment and create other instances of balld.


(define SPEED 3)

(define-struct balld [location direction])
; interp. a balld is interpretation of ball, with
; location is distance from top of the canvas
; and direсtion of the ball movement relative to the top of the canvas


(define bal-1 (make-balld 10 "up"))
(define bal-2 (make-balld 0 "down"))
(define bal-3 (make-balld 50 "up"))

