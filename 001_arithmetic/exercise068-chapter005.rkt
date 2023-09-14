;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise068-chapter005) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise068-chapter005

; Q.:
; An alternative to the nested data representation of balls uses four fields to keep track of the four properties
; Programmers call this a flat representation. Create an instance of ballf that has the same interpretation as ball1


(define-struct ballf [x y deltax deltay])
; the struct interpret ball movement in space
; -- x interpret x axis position of ball
; -- y interpret y axis position of ball
; -- deltax interpret the speed and direction of the change in the position of the ball along the x-axis per time
; -- deltay interpret the speed and direction of the change in the position of the ball along the y-axis per time

(define ball-1 (make-ballf 50 25 3 -5))
