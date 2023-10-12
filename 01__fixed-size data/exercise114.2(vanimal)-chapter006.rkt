;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise114.2(vanimal)-chapter006|) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise114.2(vanimal)-chapter006

; Q.:
; Use the predicates from exercise 113 to check the virtual pet program (exercise 106).

; Q.:
; Design the cat-cham world program. Given both a location and an animal, it walks the latter across the canvas, starting from the given location.
; Here is the chosen data representation for animals:
; A VAnimal is either
; – a VCat
; – a VCham

(define WIDTH  1000)
(define ANIMAL-SCENE-HEIGHT 200)
(define H-GAUGE-HEIGHT 20)

(define ANIMAL-SCENE-BACKGROUND (empty-scene WIDTH ANIMAL-SCENE-HEIGHT))
(define H-GAUGE-BACKGROUND (empty-scene WIDTH H-GAUGE-HEIGHT))

(define cat1 (bitmap/file "./images/cat1.png"))
(define cat2 (bitmap/file "./images/cat2.png"))
(define CAT-IMAGE-WIDTH (image-width cat1))
(define CAT-IMAGE-HEIGHT (image-height cat1))
(define cham1 (bitmap/file "./images/cham1.png"))
(define CHAM-IMAGE-WIDTH (image-width cham1))
(define CHAM-IMAGE-HEIGHT (image-height cham1))

(define CAT-Y-LEVEL (- ANIMAL-SCENE-HEIGHT (/ CAT-IMAGE-HEIGHT 2) 1))
(define CHAM-Y-LEVEL (- ANIMAL-SCENE-HEIGHT (/ CHAM-IMAGE-HEIGHT 2) 1))
(define ANIMAL-X-INCREASE-PER-TOCK (round (/ WIDTH 300)))
(define ANIMAL-PATH-DIRECTION-RIGHT "right")
(define ANIMAL-PATH-DIRECTION-LEFT "left")

(define H-LOW-LIMIT 0)
(define H-MAX-LIMIT WIDTH)
(define H-DECREASE-PER-TOCK (/ H-MAX-LIMIT 10000))
(define H-COEFFICIENT-FOR-PET-UP-KEY 1.2)
(define H-ADDENDUM-FOR-FEEDING-DOWN-KEY 2)

(define CHAM-COLOR-RED-NAME "red")
(define CHAM-COLOR-GREEN-NAME "green")
(define CHAM-COLOR-BLUE-NAME "blue")

(define CHAM-COLOR-RED-KEY "r")
(define CHAM-COLOR-GREEN-KEY "g")
(define CHAM-COLOR-BLUE-KEY "b")

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

(define VASKYA-CAT (make-vcat 500 500 "right"))
(define VASKYA-CHAM (make-vcham 500 500 "right" "red"))

(define (cat-cham animal)
  (big-bang animal
    [check-with vanimal?]
    [to-draw render]
    [on-tick tock]
    [on-key on-pad?]
    [stop-when end?]))

; (cat-cham "lol") ;check-with: the initial expression evaluated to "lol", which fails to pass check-with's vanimal? test
; (cat-cham 1) ;check-with: the initial expression evaluated to 1, which fails to pass check-with's vanimal? test
; (cat-cham (make-vcat 500 500 "right"));successful program execution

; Functions:


; func for BB for render a complete picture
; of the scene with the animal and the scale of the level of happiness
; VAnimal -> Image
; helper functions are used to draw each type of animal and happiness level separately

(define (render animal)
    (above
   (aux-render-animal animal)
   (aux-render-gauge (aux-animal-hap-extract animal))))


; aux func for render for animal scene rendering
; VAnimal -> Image
; helper functions are used for animal rendering
; for extracting x y coord from Vanimal

(define (aux-render-animal animal)
  (place-image
   (aux-render-animal-image animal)
   (aux-animal-x-extract animal)
   (aux-animal-y-extract animal)
   ANIMAL-SCENE-BACKGROUND))



; aux func for render gauge of hap for render func 
; H -> Image
; consume a ws (hap as number) and produce an image
; with happiness gauge

(define (aux-render-gauge hap)
  (overlay/align "left"
                 "middle"
                 (rectangle hap H-GAUGE-HEIGHT "solid" "red")
                 H-GAUGE-BACKGROUND))



; aux func for animal render for render animal image
; Vanimal -> Image
; helper functions are used for each of the cases
; if VAnimal is VCat and if VAnimal is VCham

(define (aux-render-animal-image animal)
  (cond [(vcat? animal) (aux-render-animal-image-vcat (vcat-x animal))]
        [(vcham? animal) (aux-render-animal-image-vcham (vcham-color animal))]))



; X-coord -> Img
; determines the image of the cat depending on the coordinate

;(check-expect (aux-render-animal-image-vcat 31.5) IMAGE-CAT2)
;(check-expect (aux-render-animal-image-vcat 31.6) IMAGE-CAT1)
;(check-expect (aux-render-animal-image-vcat 31) IMAGE-CAT1)

(define (aux-render-animal-image-vcat ws)
  (if (even? (round ws))
      cat1
      cat2))



; Color -> Img
; creates the image of the cham depending on the color

(define (aux-render-animal-image-vcham color)
  (overlay
   cham1
   (rectangle CHAM-IMAGE-WIDTH CHAM-IMAGE-HEIGHT "solid" color)))



; VAnimal -> X-coord
; retrieves the current X-coord from the Vanimal instance

;(check-expect (aux-animal-x-extract CAT1) 50)
;(check-expect (aux-animal-x-extract CAT2) 35.1)
;(check-expect (aux-animal-x-extract CAT3) 35.2)
;(check-expect (aux-animal-x-extract CHAM1) 50)

(define (aux-animal-x-extract animal)
  (cond [(vcat? animal) (vcat-x animal)]
        [(vcham? animal) (vcham-x animal)]))



; VAnimal -> Number
; resume the current Y-coord for the Vanimal instance
; - CAT-Y-LEVEL for vcat
; - CHAM-Y-LEVEL for vcham

;(check-expect (aux-animal-y-extract CAT1) Y-LEVEL-IMAGE-CAT)
;(check-expect (aux-animal-y-extract CAT2) Y-LEVEL-IMAGE-CAT)
;(check-expect (aux-animal-y-extract CAT3) Y-LEVEL-IMAGE-CAT)
;(check-expect (aux-animal-y-extract CHAM1) Y-LEVEL-IMAGE-CHAM)

(define (aux-animal-y-extract animal)
  (cond [(vcat? animal) CAT-Y-LEVEL]
        [(vcham? animal) CHAM-Y-LEVEL]))



; VAnimal -> H
; retrieves the current H from the Vanimal instance

;(check-expect (aux-animal-hap-extract CAT1) 50)
;(check-expect (aux-animal-hap-extract CAT2) 50)
;(check-expect (aux-animal-hap-extract CAT3) 50)
;(check-expect (aux-animal-hap-extract CHAM1) 50)

(define (aux-animal-hap-extract animal)
  (cond [(vcat? animal) (vcat-hap animal)]
        [(vcham? animal) (vcham-hap animal)]))



; Vanimal -> Vanimal
; tock func for BB
; uses additional functions for each of the parameters that change over time

(define (tock animal)
  (cond [(vcat? animal) (make-vcat
                         (aux-tock-x (vcat-x animal) (vcat-dir animal) CAT-IMAGE-WIDTH)
                         (aux-tock-h (vcat-hap animal))
                         (aux-tock-dir (vcat-x animal) (aux-tock-x (vcat-x animal) (vcat-dir animal) CAT-IMAGE-WIDTH) (vcat-dir animal)))]
        [(vcham? animal) (make-vcham
                         (aux-tock-x (vcham-x animal) (vcham-dir animal) CHAM-IMAGE-WIDTH)
                         (aux-tock-h (vcham-hap animal))
                         (aux-tock-dir (vcham-x animal) (aux-tock-x (vcham-x animal) (vcham-dir animal) CHAM-IMAGE-WIDTH) (vcham-dir animal))
                         (vcham-color animal))]))




; Vanimal -> X-coord
; aux func for tock for compute x

(define (aux-tock-x x dir image-size)
  (cond [(string=? dir ANIMAL-PATH-DIRECTION-RIGHT)
         (cond
           [(>= (+ x ANIMAL-X-INCREASE-PER-TOCK)  (- WIDTH (/ image-size 2))) x]
           [else (+ x ANIMAL-X-INCREASE-PER-TOCK)])]
        [(string=? dir ANIMAL-PATH-DIRECTION-LEFT)
         (cond
           [(<= (- x ANIMAL-X-INCREASE-PER-TOCK) (/ image-size 2)) x]
           [else (- x ANIMAL-X-INCREASE-PER-TOCK)])]))

; we use H to represent a scale with gauge happiness 
; H -> H
; func for tock for change hap

(define (aux-tock-h hap)
  (cond [(< (- hap H-DECREASE-PER-TOCK) H-LOW-LIMIT) H-LOW-LIMIT]
        [else (- hap H-DECREASE-PER-TOCK)]))



; we use Dir to represent a path direction
; X-coord, X-coord, Dir -> Dir
; aux func for tock for change Dir

;(check-expect (aux-tock-dir 959.5 (aux-tock-x-cat 959.5 "right") "right") "left")
;(check-expect (aux-tock-dir 950 (aux-tock-x-cat 950 "right") "right") "right")
;(check-expect (aux-tock-dir 35 (aux-tock-x-cham 35 "left") "left") "left")
;(check-expect (aux-tock-dir 34.5 (aux-tock-x-cham 34.5 "left") "left") "right")

(define (aux-tock-dir x-current x-next dir-current)
  (cond [( and (string=? dir-current ANIMAL-PATH-DIRECTION-RIGHT) (= x-current x-next)) ANIMAL-PATH-DIRECTION-LEFT]
        [( and (string=? dir-current ANIMAL-PATH-DIRECTION-LEFT) (= x-current x-next)) ANIMAL-PATH-DIRECTION-RIGHT]
        [else dir-current]))



; Vanimal -> Vanimal
; on-pad? func for BB
; uses additional functions for key processing for changing hap and dir

(define (on-pad? animal ke)
  (cond [(and (vcat? animal)
             (or (string=? ke "up")
                 (string=? ke "down")
                 (string=? ke ANIMAL-PATH-DIRECTION-RIGHT)
                 (string=? ke ANIMAL-PATH-DIRECTION-LEFT)))
         (make-vcat (vcat-x animal)
                    (aux-on-pad-hap (vcat-hap animal) ke)
                    (aux-on-pad-dir (vcat-dir animal) ke))]
        [(and (vcham? animal)
              (or (string=? ke "down")
                  (string=? ke ANIMAL-PATH-DIRECTION-RIGHT)
                  (string=? ke ANIMAL-PATH-DIRECTION-LEFT)
                  (string=? ke CHAM-COLOR-RED-KEY)
                  (string=? ke CHAM-COLOR-GREEN-KEY)
                  (string=? ke CHAM-COLOR-BLUE-KEY)))
         (make-vcham (vcham-x animal)
                     (aux-on-pad-hap (vcham-hap animal) ke)
                     (aux-on-pad-dir (vcham-dir animal) ke)
                     (aux-on-pad-color (vcham-color animal) ke))]
        [else animal]))




; Hap, String  -> Hap
; aux func for on-pad for compute hap depending on keystrokes
; "up" - pet, hap up two points 
; down arrow - feed, hap up two points

;(check-expect (aux-on-pad-hap 20 "up") (* 20 1.2))
;(check-expect (aux-on-pad-hap 20 "down") 22)
;(check-expect (aux-on-pad-hap 900 "up") H-MAX-LIMIT)
;(check-expect (aux-on-pad-hap 999 "down") H-MAX-LIMIT)

(define (aux-on-pad-hap hap ke)
  (cond [(string=? ke "up")
         (cond [(> (* hap H-COEFFICIENT-FOR-PET-UP-KEY) H-MAX-LIMIT) H-MAX-LIMIT]
               [else (* hap H-COEFFICIENT-FOR-PET-UP-KEY)])]
        [(string=? ke "down")
         (cond [(> (+ hap H-ADDENDUM-FOR-FEEDING-DOWN-KEY) H-MAX-LIMIT) H-MAX-LIMIT]
               [else (+ hap H-ADDENDUM-FOR-FEEDING-DOWN-KEY)])]
        [else hap]))



; aux func for on-pad for handling direction change events
; Dir, KeyEvent -> Dir

;(check-expect (aux-on-pad-dir "left" ANIMAL-PATH-DIRECTION-RIGHT) ANIMAL-PATH-DIRECTION-RIGHT)
;(check-expect (aux-on-pad-dir "left" "r") "left")
;(check-expect (aux-on-pad-dir ANIMAL-PATH-DIRECTION-RIGHT ANIMAL-PATH-DIRECTION-LEFT) ANIMAL-PATH-DIRECTION-LEFT)

(define (aux-on-pad-dir dir ke)
  (cond [(string=? ke ANIMAL-PATH-DIRECTION-RIGHT) ANIMAL-PATH-DIRECTION-RIGHT]
        [(string=? ke ANIMAL-PATH-DIRECTION-LEFT) ANIMAL-PATH-DIRECTION-LEFT]
        [else dir]))



; aux func for on-pad for handling direction change events
; Color, KeyEvent -> Color

(define (aux-on-pad-color color ke)
  (cond [(string=? ke CHAM-COLOR-RED-KEY) CHAM-COLOR-RED-NAME]
        [(string=? ke CHAM-COLOR-GREEN-KEY) CHAM-COLOR-GREEN-NAME]
        [(string=? ke CHAM-COLOR-BLUE-KEY) CHAM-COLOR-BLUE-NAME]
        [else color]))



; Vanimal -> Boolean
; end? func for BB
; return #true when animal's hap <= 0

;(check-expect (end? CAT1 ) #false)
;(check-expect (end? CHAM1 ) #false)
;(check-expect (end? (make-vcat 50 0 "right") ) #true)
;(check-expect (end? (make-vcham 50 0 "right" "red") ) #true)

(define (end? animal)
  (cond [(<= (aux-animal-hap-extract animal) H-LOW-LIMIT) #true]
        [else #false]))



; Any -> Boolean
; is a an element of the Vanimal collection

;(check-expect (vanimal? (make-vcat 120 90 "right")) #true)
;(check-expect (vanimal? (make-vcham 100 150 "right" "green")) #true)
;(check-expect (vanimal? (make-posn 10 10)) #false)
;(check-expect (vanimal? 1) #false)
;(check-expect (vanimal? "lol") #false)

(define (vanimal? v)
  (or (vcat? v) (vcham? v)))