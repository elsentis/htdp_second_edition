;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise089-chapter005) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise089-chapter005

; Q.:
; Design the happy-cat world program, which manages a walking cat and its happiness level.
; Let’s assume that the cat starts out with perfect happiness.

(define WIDTH  1000)
(define CAT-SCENE_HEIGHT 200)
(define H-GAUGE_HEIGHT 20)

(define CAT-SCENE-BACKGROUND (empty-scene WIDTH HEIGHT))
(define H-GAUGE-BACKGROUND (empty-scene WIDTH GAUGE_HEIGHT))

(define cat1 (bitmap/file "./images/cat1.png"))
(define cat2 (bitmap/file "./images/cat2.png"))

(define CAT-Y-LEVEL (- HEIGHT (/ (image-height cat1) 2) 1))
(define CAT-X-INCREASE-PER-TOCK (/ WIDTH 300))

(define H-LOW-LIMIT 0)
(define H-MAX-LIMIT 100)
(define H-DECREASE-PER-TOCK (/ H-MAX-LIMIT 1000))
(define H-COEFFICIENT-FOR-UP-KEY (/ 1 3))
(define H-COEFFICIENT-FOR-DOWN-KEY (/ 1 5))


; H is a Number between [0..100].
; interpretation represents a happiness value

; X-coord is a Number
; interpretation represents a object location coordinate


(define-struct vcat (x hap))
;; A VCat is a structure:
;;   (make-vcat Image Track)
;; interp. a virtual cat, including 
;;         information about its movement and happiness
;;         x is the X-coord of the cat on the screen
;;         hap is its happiness H

(define VASKYA (make-vcat  H-MAX-LIMIT



; cat-prog func
; BB World proframm
; a WorldState is a VCat
; interp. a virtual cat, including 
;         information about its movement and happiness
;         x is the X-coord of the cat on the screen
;         hap is its happiness H

(define (happy-cat ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]))

