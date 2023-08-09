;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise113-chapter006) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise113-chapter006

; Q.:
; Design predicates for the following data definitions from the preceding section: SIGS, Coordinate (exercise 105), and VAnimal.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; predicate for the SIGS data definition


; A UFO is a Posn. 
; interpretation (make-posn x y) is the UFO's location 
; (using the top-down, left-to-right convention)
 
(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number). 
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick 
 
; A Missile is a Posn. 
; interpretation (make-posn x y) is the missile's place

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a 
; space invader game
(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])



; Any -> Boolean
; is a an element of the SIGS collection

;(check-expect (sigs? "lol") #false)
;(check-expect (sigs? "1") #false)
;(check-expect (sigs? (make-aim (make-posn 10 10) (make-tank 10 -3))) #true)
;(check-expect (sigs? (make-fired (make-posn 10 10) (make-tank 10 -3) (make-posn 30 30))) #true)

(define (sigs? v)
  (or (aim? v) (fired? v)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; predicate for the Coordinate data definition

; ; A Coordinate is one of: 
; – a NegativeNumber 
; interpretation on the y axis, distance from top
; – a PositiveNumber 
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

;(check-expect (coordinate? "lol") #false)
;(check-expect (coordinate? 1) #true)
;(check-expect (coordinate? (make-posn 1 1)) #true)
;(check-expect (coordinate? (make-aim (make-posn 10 10) (make-tank 10 -3))) #false)

(define (coordinate? v)
  (or (number? v) (posn? v)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; predicate for the VAnimal data defenition

; H is a Number between [0..1000].
; interpretation represents a happiness value

; X-coord is a Number
; interpretation represents a object location coordinate

; Dir is a Strings as two values
; "left", "right"
; interpretation represents a path direction

; Color is a Strings as three values
; "red", "green", "blue"
; interpretation represents a color

(define-struct vcat (x hap dir))
;; A VCat is a structure:
;;   (make-vcat Image Track)
;; interp. a virtual cat, including 
;;         information about its movement and happiness and path direction
;;         x is the X-coord of the cat on the screen
;;         hap is its happiness H
;;         dir is a path direction


(define-struct vcham (x hap dir color))
;; A VCham is a structure:
;;   (make-track X-coord H Dir)
; interp. a virtual cham
;; interp. keeps track of a cham's changing variables
;;         x is the x-coordinate of the cham on the screen
;;         hap is its happiness
;;         dir is a path direction
;;         color is a current color of cham

; A VAnimal is either
; – a VCat
; – a VCham

;(check-expect (vanimal? (make-vcat 120 90 "right")) #true)
;(check-expect (vanimal? (make-vcham 100 150 "right" "green")) #true)
;(check-expect (vanimal? (make-posn 10 10)) #false)
;(check-expect (vanimal? 1) #false)
;(check-expect (vanimal? "lol") #false)

(define (vanimal? v)
  (or (vcat? v) (vcham? v)))
