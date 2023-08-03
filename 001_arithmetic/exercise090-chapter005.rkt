;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise090-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise090-chapter005

; Q.:
; Modify the happy-cat program from the preceding exercises so that it stops whenever the cat’s happiness falls to 0.

(define WIDTH  1000)
(define CAT-SCENE-HEIGHT 200)
(define H-GAUGE-HEIGHT 20)

(define CAT-SCENE-BACKGROUND (empty-scene WIDTH CAT-SCENE-HEIGHT))
(define H-GAUGE-BACKGROUND (empty-scene WIDTH H-GAUGE-HEIGHT))

(define cat1 (bitmap/file "./images/cat1.png"))
(define cat2 (bitmap/file "./images/cat2.png"))
(define CAT-IMAGE-WIDTH (image-width cat1))

(define CAT-Y-LEVEL (- CAT-SCENE-HEIGHT (/ (image-height cat1) 2) 1))
(define CAT-X-INCREASE-PER-TOCK (/ WIDTH 300))

(define H-LOW-LIMIT 0)
(define H-MAX-LIMIT WIDTH)
(define H-DECREASE-PER-TOCK (/ H-MAX-LIMIT 10000))
(define H-COEFFICIENT-FOR-PET-UP-KEY 1.2)
(define H-ADDENDUM-FOR-FEEDING-DOWN-KEY 2)


; H is a Number between [0..H-MAX-LIMIT].
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

(define VASKYA (make-vcat 50 H-MAX-LIMIT))



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
    [to-draw render]
    [on-key hand-pad]
    [stop-when end?]))



; we use VCat for interp. a virtual cat, including
; information about its movement and happiness 
; VCat -> VCat
; tock func for big-bang for change a X-coordand and H
; parametres of Vcat per time

(define (tock ws)
  (make-vcat
   (aux-tock-x (vcat-x ws))
   (aux-tock-h (vcat-hap ws))))


; we use X-coord to represent a location coordinate of cat image 
; X-coord, Number, Number -> X-coord
; aux func for tock for change X-cord

;(check-expect (aux-tock-x 0) (modulo (round (+ 0 CAT-X-INCREASE-PER-TOCK)) WIDTH))

(define (aux-tock-x x)
  (cond [(> (+ x CAT-X-INCREASE-PER-TOCK) (+ WIDTH CAT-IMAGE-WIDTH)) (- 0 CAT-IMAGE-WIDTH )]
        [else (round (+ x CAT-X-INCREASE-PER-TOCK))]))



; we use H to represent a scale with gauge happiness 
; Number -> Number
; func for tock for change hap

(define (aux-tock-h hap)
  (cond [(< (- hap H-DECREASE-PER-TOCK) H-LOW-LIMIT) H-LOW-LIMIT]
        [else (- hap H-DECREASE-PER-TOCK)]))



; render func for BB
; we get ws as Vcat data type, and exit a img
; Vcat -> Image
; to draw exit img
; puts the cat1 image in an even coordinate and cat2 image in an odd one
; and produce an image with happiness gauge

(define (render ws)
  (above
   (aux-render-cat (vcat-x ws))
   (aux-render-gauge (vcat-hap ws))))



; aux func render cat in back for render func
; we get ws in numbers, and exit a img
; X-coord -> Image
; to draw exit img
; puts the cat1 image in an even coordinate and cat2 image in an odd one

(define (aux-render-cat ws)
  (if (even? ws)
      (place-image cat1 ws CAT-Y-LEVEL CAT-SCENE-BACKGROUND)
      (place-image cat2 ws CAT-Y-LEVEL CAT-SCENE-BACKGROUND)))



; aux func for render gauge of hap for render func 
; H -> Image
; consume a ws (hap as number) and produce an image
; with happiness gauge

(define (aux-render-gauge hap)
  (overlay/align "left"
                 "middle"
                 (rectangle hap H-GAUGE-HEIGHT "solid" "red")
                 H-GAUGE-BACKGROUND))



; Vcat, KeyEvent  -> Vcat
; aux func for on-pad for compute hap depending on keystrokes
; func for respond to key presses
; up arrow - hap jumps by 1/5
; down arrow - hap increases by 2 points

(define (hand-pad vcat ke)
  (cond [(string=? "up" ke)
         (make-vcat
          (vcat-x vcat)
          (cond [(> (* (vcat-hap vcat) H-COEFFICIENT-FOR-PET-UP-KEY) H-MAX-LIMIT) H-MAX-LIMIT]
                [else (* (vcat-hap vcat) H-COEFFICIENT-FOR-PET-UP-KEY)]))]
        [(string=? "down" ke)
         (make-vcat
          (vcat-x vcat)
          (cond [(> (+ (vcat-hap vcat) H-ADDENDUM-FOR-FEEDING-DOWN-KEY) H-MAX-LIMIT) H-MAX-LIMIT]
               [else (+ (vcat-hap vcat) H-ADDENDUM-FOR-FEEDING-DOWN-KEY)]))]
        [else vcat]))



; we use H to represent a scale with gauge happiness 
; H -> boolean
; determine the end of animate from mane
; when the happiness drops to 0

;(check-expect (end? 1000) #false)
;(check-expect (end? 990) #false)
;(check-expect (end? 1) #false)
;(check-expect (end? 0) #true)
;(check-expect (end? -1) #true)

(define (end? vcat)
  (cond [(> (vcat-hap vcat) H-LOW-LIMIT) #false]
        [else #true]))
