;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise056-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise056-chapter004

; Q.:
; Define main2 so that you can launch the rocket and watch it lift off.
; If you watch the entire launch, you will notice that once the rocket reaches the top something curious happens. Explain.
; Add a stop-when clause to main2 so that the simulation of the liftoff stops gracefully when the rocket is out of sight.


(define WIDTH  100)
(define HEIGHT 300) 
(define BACKG  (empty-scene WIDTH HEIGHT))

(define ROCKET (polygon (list (make-posn 0 0)
                              (make-posn (-(/ WIDTH 10)) (/ WIDTH 5))
                              (make-posn 0 (/ WIDTH 8) )
                              (make-posn (/ WIDTH 10) (/ WIDTH 5))) "solid" "black"))

(define ROCKET-HEIGHT (image-height ROCKET))
(define CENTER (/ (image-height ROCKET) 2))

(define YDELTA 3)

; An LRCD (for launching rocket countdown) is one of:
; – "resting"
; – a Number between -3 and -1
; – a NonnegativeNumber 
; interpretation a grounded rocket, in countdown mode,
; a number denotes the number of pixels between the
; top of the canvas and the rocket (its height)



; LRCD -> LRCD
; launches the program from initial state

(define (main2 s)
  (big-bang s
    [on-tick fly 0.7]
    [to-draw show]
    [on-key launch]
    [stop-when reach]))



; we use LRCD represents a grounded rocket
; LRCD -> Image
; produse image with rocket flying in the background world
; consume LR data

(define (show x)
  (cond
    [(string? x) (rocket-show HEIGHT)]
    [(<= -3 x -1) (place-image (text (number->string x) 20 "red") 10 (* 3/4 WIDTH) (rocket-show HEIGHT))]
    [(>= x 0) (rocket-show x)]))



; aux fucn for produce img of only rocket with place-image func
; we use numbers to represent distance in pixels
; numb -> img

;(check-expect (rocket-show 0) (place-image ROCKET (/ WIDTH 2) (- 0 CENTER) BACKG))
;(check-expect (rocket-show 100) (place-image ROCKET (/ WIDTH 2) (- 100 CENTER) BACKG))

(define (rocket-show x)
  (place-image ROCKET (/ WIDTH 2) (- x CENTER) BACKG))



; LRCD -> LRCD
; launch the countdown state from "resting" when user pressed space bar

;(check-expect (launch "resting" " ") -3)
;(check-expect (launch "resting" "a") "resting")
;(check-expect (launch -3 " ") -3)
;(check-expect (launch -1 " ") -1)
;(check-expect (launch 33 " ") 33)
;(check-expect (launch 33 "a") 33)

(define (launch x ke)
  (cond
    [(string? x) (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0) x]))



; LRCD -> LRCD
; raises the rocket by YDELTA if it is moving already 
 
;(check-expect (fly "resting") "resting")
;(check-expect (fly -3) -2)
;(check-expect (fly -2) -1)
;(check-expect (fly -1) HEIGHT)
;(check-expect (fly 10) (- 10 YDELTA))
;(check-expect (fly 22) (- 22 YDELTA))
 
(define (fly x)
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))




; LCRD -> Boolean
; func for produce true boolean, when rocket reach on top
; we use LCRD numb state to represent distance in pixels

(define (reach x)
  (and (number? x) (<= (- x YDELTA) 0)))



; Q.:
; If you watch the entire launch, you will notice that once the rocket reaches the top something curious happens. Explain.

; fly func increase decrease LCRD if it is a positive number state while LRCD will not reach value less than 0
; after this launch func reads this like LRCD countdown state and there is a process of countdown and the start of the flight again
; to avoid this need to create checking function for stop-when big-bang clause for determine the end of flight (reach func in this exercise)