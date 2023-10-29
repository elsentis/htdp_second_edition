;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise157-chapter009) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise157-chapter009

; Q.:
; Experiment to determine whether the arbitrary decisions concerning constants are easy to change.
; For example, determine whether changing a single constant definition achieves the desired outcome
; change the height of the canvas to 220 pixels
; change the width of the canvas to 30 pixels
; change the x location of the line of shots to “somewhere to the left of the middle”
; change the background to a green rectangle
; change the rendering of shots to a red elongated rectangle
; Also check whether it is possible to double the size of the shot without changing anything else
; or to change its color to black


; change the height of the canvas to 220 pixels
;
(define HEIGHT 220) ; distances in terms of pixels
; ...


; change the width of the canvas to 30 pixels
;
; ...
(define WIDTH 30)
; ...


; change the x location of the line of shots to “somewhere to the left of the middle”
;
; ...
(define XSHOTS (/ WIDTH 4))
; ...


; change the background to a green rectangle
;
; ...
(define BACKGROUND (empty-scene WIDTH HEIGHT "green"))
; ...


; change the rendering of shots to a red elongated rectangle
;
; ...
(define SHOT (rectangle 3 10 "solid" "red"))
; ...


; Q.:
; Also check whether it is possible to double the size of the shot without changing anything else
; or to change its color to black
;
; A.:
; Yes, it is possible by changing the parameters of the SHOT constant
; previous definition of SHOT
; (define SHOT (triangle 3 "solid" "red"))
; to double the size of the SHOT and change its color to black
; (define SHOT (triangle 6 "solid" "black"))

