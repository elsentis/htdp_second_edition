;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise092-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise092-chapter005

; Q.:
; Design the cham program, which has the chameleon continuously walking across the canvas from left to right.
; When it reaches the right end of the canvas, it disappears and immediately reappears on the left
; For managing the chameleon’s happiness gauge, you may reuse the happiness gauge from the virtual cat



(define WIDTH  1000)
(define CHAM-SCENE-HEIGHT 200)
(define H-GAUGE-HEIGHT 20)

(define CHAM-SCENE-BACKGROUND (empty-scene WIDTH CHAM-SCENE-HEIGHT))
(define H-GAUGE-BACKGROUND (empty-scene WIDTH H-GAUGE-HEIGHT))

(define cham1 (bitmap/file "./images/cham1.png"))
(define CHAM-IMAGE-WIDTH (image-width cham1))
(define CHAM-IMAGE-HEIGHT (image-height cham1))

(define CHAM-Y-LEVEL (- CHAM-SCENE-HEIGHT (/ CHAM-IMAGE-HEIGHT 2) 1))
(define CHAM-X-INCREASE-PER-TOCK (/ WIDTH 300))
(define CHAM-PATH-DIRECTION-RIGHT "right")
(define CHAM-PATH-DIRECTION-LEFT "left")

(define CHAM-COLOR-RED-NAME "red")
(define CHAM-COLOR-GREEN-NAME "green")
(define CHAM-COLOR-BLUE-NAME "blue")

(define CHAM-COLOR-RED-KEY "r")
(define CHAM-COLOR-GREEN-KEY "g")
(define CHAM-COLOR-BLUE-KEY "b")

(define H-LOW-LIMIT 0)
(define H-MAX-LIMIT WIDTH)
(define H-DECREASE-PER-TOCK (/ H-MAX-LIMIT 10000))
(define H-COEFFICIENT-FOR-PET-UP-KEY 1.2)
(define H-ADDENDUM-FOR-FEEDING-DOWN-KEY 2)


; H is a Number between [0..H-MAX-LIMIT].
; interpretation represents a happiness value

; X-coord is a Number
; interpretation represents a object location coordinate

; Dir is a Strings as two values
; "left", "right"
; interpretation represents a path direction

; Color is a Strings as three values
; "red", "green", "blue"
; interpretation represents a color

(define-struct vcham (x hap dir color))
;; A VCham is a structure:
;;   (make-track X-coord H Dir)
; interp. a virtual cham
;; interp. keeps track of a cham's changing variables
;;         x is the x-coordinate of the cham on the screen
;;         hap is its happiness
;;         dir is a path direction
;;         color is a current color of cham


(define VASKYA-CHAM (make-vcham 50 150 "right" "red"))



(define (happy-cham ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]
    [on-key hand-pad]
    [stop-when end?]))



; we use Vcham for interp. a virtual cham, including its image and
; information about its movement and happiness and path direction 
; Vcham -> Vcham
; tock func for big-bang for change a X-coordand  H
; parametres of Vcham per time

(define (tock ws)
  (make-vcham
   (aux-tock-x (vcham-x ws) (vcham-dir ws))
   (aux-tock-h (vcham-hap ws))
   (aux-tock-dir (vcham-x ws) (aux-tock-x (vcham-x ws) (vcham-dir ws)) (vcham-dir ws))
   (vcham-color ws)))



; we use X-coord to represent a location coordinate of cham image 
; X-coord, Dir -> X-coord
; aux func for tock for change X-cord, depending on the path direction

(define (aux-tock-x x dir)
  (cond [(string=? dir CHAM-PATH-DIRECTION-RIGHT)
         (cond
           [(>= (+ x CHAM-X-INCREASE-PER-TOCK)  (-  WIDTH (/ CHAM-IMAGE-WIDTH 2))) x]
           [else (+ x CHAM-X-INCREASE-PER-TOCK)])]
        [(string=? dir CHAM-PATH-DIRECTION-LEFT)
         (cond
           [(<= (- x CHAM-X-INCREASE-PER-TOCK) (/ CHAM-IMAGE-WIDTH 2)) x]
           [else (- x CHAM-X-INCREASE-PER-TOCK)])]))



; we use H to represent a scale with gauge happiness 
; Number -> Number
; func for tock for change hap

(define (aux-tock-h hap)
  (cond [(< (- hap H-DECREASE-PER-TOCK) H-LOW-LIMIT) H-LOW-LIMIT]
        [else (- hap H-DECREASE-PER-TOCK)]))



; we use Dir to represent a path direction
; X-Coord, X-Coord, Dir -> Dir
; aux func for tock for change Dir

(define (aux-tock-dir x-current x-next dir-current)
  (cond [( and (string=? dir-current CHAM-PATH-DIRECTION-RIGHT) (= x-current x-next)) CHAM-PATH-DIRECTION-LEFT]
        [( and (string=? dir-current CHAM-PATH-DIRECTION-LEFT) (= x-current x-next)) CHAM-PATH-DIRECTION-RIGHT]
        [else dir-current]))



; we use Vcham for interp. a virtual cham, including its image and
; information about its movement and happiness and color
; Vcham -> Img
; func for big-vang for drawing a cham in the space
; in the x-track coord, with a current color and draw
; gauge of its happines as hap

(define (render ws)
  (above
   (aux-render-cham (vcham-x ws) (vcham-color ws))
   (aux-render-gauge (vcham-hap ws))))



; aux func render cham in back for render func
; we get ws in numbers, and exit a img
; X-coord -> Image
; to draw exit img


(define (aux-render-cham x color)
  (place-image
   (overlay
    cham1
   (rectangle CHAM-IMAGE-WIDTH CHAM-IMAGE-HEIGHT "solid" color))
   x
   CHAM-Y-LEVEL
   CHAM-SCENE-BACKGROUND))



; aux func for render gauge of hap for render func 
; H -> Image
; consume a ws (hap as number) and produce an image
; with happiness gauge

(define (aux-render-gauge hap)
  (overlay/align "left"
                 "middle"
                 (rectangle hap H-GAUGE-HEIGHT "solid" "red")
                 H-GAUGE-BACKGROUND))



; we use Vcham for interp. a virtual cham, including its image and
; information about its movement and happiness and color
; Vcham -> Vcham
; func for big-bang for change a cham parametres
; if corresponding keys were pressed
; up, and down arrays for change hap
; r, g, b letters for change color

(define (hand-pad vcham ke)
  (cond [(string=? "down" ke)
         (make-vcham
          (vcham-x vcham)
          (cond [(> (+ (vcham-hap vcham) H-ADDENDUM-FOR-FEEDING-DOWN-KEY) H-MAX-LIMIT) H-MAX-LIMIT]
                [else (+ (vcham-hap vcham) H-ADDENDUM-FOR-FEEDING-DOWN-KEY)])
          (vcham-dir vcham)
          (vcham-color vcham))]
        [(or (string=? ke CHAM-PATH-DIRECTION-RIGHT) (string=? ke CHAM-PATH-DIRECTION-LEFT))
          (make-vcham
           (vcham-x vcham)
           (vcham-hap vcham)
           (cond [(string=? ke CHAM-PATH-DIRECTION-RIGHT) CHAM-PATH-DIRECTION-RIGHT]
                 [(string=? ke CHAM-PATH-DIRECTION-LEFT) CHAM-PATH-DIRECTION-LEFT])
           (vcham-color vcham))]
        [(or (string=? ke CHAM-COLOR-RED-KEY) (string=? ke CHAM-COLOR-GREEN-KEY) (string=? ke CHAM-COLOR-BLUE-KEY))
         (make-vcham
           (vcham-x vcham)
           (vcham-hap vcham)
           (vcham-dir vcham)
           (cond [(string=? ke CHAM-COLOR-RED-KEY) CHAM-COLOR-RED-NAME]
                 [(string=? ke CHAM-COLOR-GREEN-KEY) CHAM-COLOR-GREEN-NAME]
                 [(string=? ke CHAM-COLOR-BLUE-KEY) CHAM-COLOR-BLUE-NAME]))]
        [else vcham]))



; we use Vcham for interp. a virtual cham, including its image and
; information about its movement and happiness and color
; H is a Number between [0..100].
; interpretation represents a happiness value
; Vcham -> boolean
; func for big bang for resume
; a definition for exit cicle if definition -
; a hap = 0

(define (end? vcham)
  (cond [(<= (vcham-hap vcham) H-LOW-LIMIT) #true]
        [else #false]))
           