;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise158-chapter009) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise158-chapter009

; Q.:
; If you run main, press the space bar (fire a shot), and wait for a goodly amount of time,
; the shot disappears from the canvas. When you shut down the world canvas, however,
; the result is a world that still contains this invisible shot.
; Design an alternative tock function that doesn’t just move shots one pixel per clock tick
; but also eliminates those whose coordinates place them above the canvas.
; Hint You may wish to consider the design of an auxiliary function for the recursive cond clause.



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


; ShotWorld -> ShotWorld
; launches the program from some initial state 
(define (main w0)
  (big-bang w0
    [on-tick tock]
    [on-key keyh]
    [to-draw to-image]))


; ShotWorld -> ShotWorld 
; moves each shot up by one pixel
; eliminates those shots whose coordinates place them above the canvas
;
;(check-expect (tock '()) '())
;(check-expect (tock (cons 25 '())) (cons 24 '()))
;(check-expect (tock (cons 25 (cons 24 '()))) (cons 24 (cons 23 '())))
;(check-expect (tock (cons -1 '())) '())
; 
(define (tock w)
  (cond
    [(empty? w) '()]
    [(< (sub1 (first w)) (- 0 (/ (image-height SHOT) 2))) '()]
    [else (cons (sub1 (first w)) (tock (rest w)))]))
; did not come up with the application of a possible auxiliary function
; for the recursive cond clause


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




; (main '())


