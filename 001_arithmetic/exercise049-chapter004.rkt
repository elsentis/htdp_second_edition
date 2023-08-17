;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise049-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise049-chapter004

; Q.:
; A cond expression is really just an expression and may therefore show up in the middle of another expression
; (- 200 (cond [(> y 200) 0] [else y]))
; Use the stepper to evaluate the expression for y as 100 and 210.
; Reformulate create-rocket-scene.v5 to use a nested expression; the resulting function mentions place-image only once.

;(define (test y)
;  (- 200 (cond [(> y 200) 0] [else y])))

;(test 100)
;(test 210)



(define WIDTH  100)
(define HEIGHT  60)
(define MTSCN  (empty-scene WIDTH HEIGHT)) ; short for empty scene 
(define ROCKET (rectangle 10 10 "solid" "grey"))
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))
 
(define (create-rocket-scene.v5 h)
  (place-image
   ROCKET
   50
   (cond
     [(<= h ROCKET-CENTER-TO-TOP) h]
     [(> h ROCKET-CENTER-TO-TOP) ROCKET-CENTER-TO-TOP])
   MTSCN))