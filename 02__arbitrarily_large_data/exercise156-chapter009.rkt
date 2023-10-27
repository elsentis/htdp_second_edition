;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise156-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise156-chapter009

; Q.:
;  Equip the program in figure 61 with tests and make sure it passes those.
; Explain what main does. Then run the program via main.



(define HEIGHT 80) ; distances in terms of pixels 
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))
 
; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))

; A Shot is a Number.
; interpretation represents the shot's y-coordinate

; A List-of-shots is one of: 
; – '()
; – (cons Shot List-of-shots)
; interpretation the collection of shots fired

; A ShotWorld is List-of-numbers. 
; interpretation each number on such a list
;   represents the y-coordinate of a shot 




; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world if the space bar is hit
;
;(check-expect (keyh '() " ") (cons 80 '()))
;(check-expect (keyh (cons 25 '()) " ") (cons 80 (cons 25 '())))
;(check-expect (keyh (cons 25 (cons 24 '())) " ") (cons 80 (cons 25 (cons 24 '()))))
;(check-expect (keyh (cons 25 (cons 24 '())) "l") (cons 25 (cons 24 '())))
;
(define (keyh w ke)
  (if (key=? ke " ") (cons HEIGHT w) w))

; ShotWorld -> ShotWorld 
; moves each shot up by one pixel
;
;(check-expect (tock '()) '())
;(check-expect (tock (cons 25 '())) (cons 24 '()))
;(check-expect (tock (cons 25 (cons 24 '()))) (cons 24 (cons 23 '())))
;
(define (tock w)
  (cond
    [(empty? w) '()]
    [else (cons (sub1 (first w)) (tock (rest w)))]))

; ShotWorld -> ShotWorld
; launches the program from some initial state 
(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))

(main '())


; ShotWorld -> Image 
; adds each shot y on w at (XSHOTS,y} to BACKGROUND
;
;(check-expect (to-image '()) (empty-scene WIDTH HEIGHT))
;(check-expect (to-image (cons 25 '())) (place-image SHOT XSHOTS 25 BACKGROUND))
;(check-expect (to-image (cons 25 (cons 24 '()))) (place-image
;                                                  SHOT XSHOTS
;                                                  25
;                                                  (place-image SHOT XSHOTS 24 BACKGROUND)))
;                                                          
;
(define (to-image w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT XSHOTS (first w)
                       (to-image (rest w)))]))





