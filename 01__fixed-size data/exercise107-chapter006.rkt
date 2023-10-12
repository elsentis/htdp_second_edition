;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise107-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise107-chapter006

; Q.:
; Design the cham-and-cat program, which deals with both a virtual cat and a virtual chameleon.
; You need a data definition for a “zoo” containing both animals and functions for dealing with it
; Each key event applies to only one of the two animals
; you need a data representation that specifies a focus animal



; H is a Number between [0..H-MAX-LIMIT].
; interpretation represents a happiness value

; X-coord is a Number
; interpretation represents a object location coordinat

; Dir is a Strings as two values
; "left", "right"
; interpretation represents a path direction
(define ANIMAL-PATH-DIRECTION-RIGHT "right")
(define ANIMAL-PATH-DIRECTION-LEFT "left")


; Color is a Strings as three values
; "red", "green", "blue"
; interpretation represents a color
(define CHAM-COLOR-RED-KEY "r")
(define CHAM-COLOR-GREEN-KEY "g")
(define CHAM-COLOR-BLUE-KEY "b")
(define CHAM-COLOR-RED-NAME "red")
(define CHAM-COLOR-GREEN-NAME "green")
(define CHAM-COLOR-BLUE-NAME "blue")

; FocusFlag is a string as two values
; "k" - indicates what is now in the spotlight kitty
; "l" - indicates what is now in the spotlight lizard
(define CAT-FOCUS-FLAG "k")
(define CHAM-FOCUS-FLAG "l")

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


(define-struct zoo (vcat vcham focus-flag))
; a Zoo is a structure
; (make-zoo VCat VCham FocusFlag)
; interp. a virtual zoo consisting of two animals
; cham and cat
; focus-flag indicates who is now in the spotlight


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

(define H-LOW-LIMIT 0)
(define H-MAX-LIMIT WIDTH)
(define H-DECREASE-PER-TOCK (/ H-MAX-LIMIT 10000))
(define H-COEFFICIENT-FOR-PET-UP-KEY 1.2)
(define H-ADDENDUM-FOR-FEEDING-DOWN-KEY 2)

(define TEXT-BACKGROUND-WIDTH WIDTH)
(define TEXT-BACKGROUND-HEIGHT (/ ANIMAL-SCENE-HEIGHT 2))
(define TEXT-BACKGROUND (empty-scene  TEXT-BACKGROUND-WIDTH TEXT-BACKGROUND-HEIGHT))

(define TEXT-SIZE (round (/ TEXT-BACKGROUND-HEIGHT 10)))

(define CAT1 (make-vcat 50 50 "right"))
(define CAT2 (make-vcat 35.1 50 "right"))
(define CAT3 (make-vcat 35.2 50 "right"))
(define CHAM1 (make-vcham 50 50 "right" "red"))

(define ZOO1 (make-zoo CAT1 CHAM1 CAT-FOCUS-FLAG))



(define (cham-and-cat zoo)
  (big-bang zoo
    [to-draw render]
    [on-tick tock]
    [on-key on-pad?]
    [stop-when end?]))


; Functions:

; func for BB for render a complete picture
; of the scene with the two animals scene and the scale of the level of happiness and the text with info
; Zoo -> Image
; helper functions are used to draw each type of animal and happiness level separately and the text with info

(define (render ws)
    (above
   (aux-render-animal (zoo-vcat ws))
   (aux-render-gauge (aux-animal-hap-extract (zoo-vcat ws)))
   (aux-render-animal (zoo-vcham ws))
   (aux-render-gauge (aux-animal-hap-extract (zoo-vcham ws)))
   (aux-render-text ws)))



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



; VAnimal -> Dir
; retrieves the current Dir from the Vanimal instance

;(check-expect (aux-animal-dir-extract CAT1) "right")
;(check-expect (aux-animal-dir-extract (make-vcat 35.1 50 "left")) "left")
;(check-expect (aux-animal-dir-extract CAT3) "right")
;(check-expect (aux-animal-dir-extract CHAM1) "right")

(define (aux-animal-dir-extract animal)
  (cond [(vcat? animal) (vcat-dir animal)]
        [(vcham? animal) (vcham-dir animal)]))




; aux func for render gauge of hap for render func 
; H -> Image
; consume a ws (hap as number) and produce an image
; with happiness gauge

(define (aux-render-gauge hap)
  (overlay/align "left"
                 "middle"
                 (rectangle hap H-GAUGE-HEIGHT "solid" "red")
                 H-GAUGE-BACKGROUND))



; VAnimal -> H
; retrieves the current H from the Vanimal instance

;(check-expect (aux-animal-hap-extract CAT1) 50)
;(check-expect (aux-animal-hap-extract CAT2) 50)
;(check-expect (aux-animal-hap-extract CAT3) 50)
;(check-expect (aux-animal-hap-extract CHAM1) 50)

(define (aux-animal-hap-extract animal)
  (cond [(vcat? animal) (vcat-hap animal)]
        [(vcham? animal) (vcham-hap animal)]))



; aux func for render for displaying a table with text
; informing about the progress of the program
; Zoo -> Image
; helper functions are used for display information about each of the animals

(define (aux-render-text ws)
  (overlay/align
   "middle"
   "middle"
   (above/align "left"
    (text "cham-and-cat programm is running" TEXT-SIZE "black")
    (cond [(string=? (zoo-focus-flag ws) CAT-FOCUS-FLAG)
           (text (string-append
                  "cat on focus for control (type 'l' for cham control)"
                  "\n"
                  "'up' for feed\n"
                  "'down' for pet\n"
                  "'right', 'left' for change path direction\n")
                 TEXT-SIZE "black")]
          [(string=? (zoo-focus-flag ws) CHAM-FOCUS-FLAG)
           (text (string-append
                  "cham on focus for control (type 'k' for cat control)"
                  "\n"
                  "'r', 'g', 'b' for change a color\n"
                  "'up' for feed\n"
                  "'right', 'left' for change path direction\n")
                 TEXT-SIZE "black")]
          [else (text "something wrong" TEXT-SIZE "red")])
    (aux-render-text-animal (zoo-vcat ws))
    (aux-render-text-animal (zoo-vcham ws)))
   TEXT-BACKGROUND))



; Vcat (or Vcham) -> Img
; aux func for aux-render-text for display of text with
; information about the specific instance of animal
; from zoo - cat or cham

(define (aux-render-text-animal animal)
  (text
   (string-append
    (cond [(vcat? animal) "cat"]
          [(vcham? animal) "cham"])
    " go to the "
    (aux-animal-dir-extract animal)
    ", with the "
    (number->string (quotient (round (aux-animal-hap-extract animal)) 10))
    " happy index")
   TEXT-SIZE
   "black"))



; Zoo -> Zoo
; tock func for BB
; uses additional functions for each of the parameters that change over time

(define (tock ws-zoo)
  (make-zoo
   (make-vcat
    (aux-tock-x (vcat-x (zoo-vcat ws-zoo)) (vcat-dir (zoo-vcat ws-zoo)) CAT-IMAGE-WIDTH)
    (aux-tock-hap (vcat-hap (zoo-vcat ws-zoo)))
    (aux-tock-dir (vcat-x (zoo-vcat ws-zoo)) (aux-tock-x (vcat-x (zoo-vcat ws-zoo)) (vcat-dir (zoo-vcat ws-zoo)) CAT-IMAGE-WIDTH) (vcat-dir (zoo-vcat ws-zoo))))
   (make-vcham
    (aux-tock-x (vcham-x (zoo-vcham ws-zoo)) (vcham-dir (zoo-vcham ws-zoo)) CHAM-IMAGE-WIDTH)
    (aux-tock-hap (vcham-hap (zoo-vcham ws-zoo)))
    (aux-tock-dir (vcham-x (zoo-vcham ws-zoo)) (aux-tock-x (vcham-x (zoo-vcham ws-zoo)) (vcham-dir (zoo-vcham ws-zoo)) CHAM-IMAGE-WIDTH) (vcham-dir (zoo-vcham ws-zoo)))
    (vcham-color (zoo-vcham ws-zoo)))
   (zoo-focus-flag ws-zoo)))



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

(define (aux-tock-hap hap)
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



; Zoo -> Zoo
; on-pad? func for BB
; handling the following keyboard events:
; -- for cat of focus
; "l" switch focus to lizard
; "up" pet an animal and increase its happiness level by 1.2 times
; "down" feed an animal and increase its happiness level by 2 points
; "right" change direction to the right
; "left" change direction to the left
; -- for cham on focus
; "k" switch focus to cat
; "down" feed an animal and increase its happiness level by 2 points
; "right" change direction to the right
; "left" change direction to the left
; "r" change color of cham to red
; "g" change color of cham to green
; "b" change color of cham to blue
; additional functions are used to handle keyboard events

(define (on-pad? ws-zoo ke)
  (cond [(string=? (zoo-focus-flag ws-zoo) CAT-FOCUS-FLAG)
         (cond [(string=? ke CHAM-FOCUS-FLAG) (aux-on-pad-flag ws-zoo ke)]
               [(or (string=? ke "up") (string=? ke "down")) (aux-on-pad-hap ws-zoo ke)]
               [(or (string=? ke ANIMAL-PATH-DIRECTION-RIGHT) (string=? ke ANIMAL-PATH-DIRECTION-LEFT)) (aux-on-pad-dir ws-zoo ke)]
               [else ws-zoo])]
        [(string=? (zoo-focus-flag ws-zoo) CHAM-FOCUS-FLAG)
         (cond [(string=? ke CAT-FOCUS-FLAG) (aux-on-pad-flag ws-zoo ke)]
               [(string=? ke "down") (aux-on-pad-hap ws-zoo ke)]
               [(or (string=? ke ANIMAL-PATH-DIRECTION-RIGHT) (string=? ke ANIMAL-PATH-DIRECTION-LEFT)) (aux-on-pad-dir ws-zoo ke)]
               [(or (string=? ke CHAM-COLOR-RED-KEY) (string=? ke CHAM-COLOR-GREEN-KEY) (string=? ke CHAM-COLOR-BLUE-KEY)) (make-zoo
                                                                                                                            (zoo-vcat ws-zoo)
                                                                                                                            (make-vcham
                                                                                                                             (vcham-x (zoo-vcham ws-zoo))
                                                                                                                             (vcham-hap (zoo-vcham ws-zoo))
                                                                                                                             (vcham-dir (zoo-vcham ws-zoo))
                                                                                                                             (cond [(string=? ke CHAM-COLOR-RED-KEY) CHAM-COLOR-RED-NAME]
                                                                                                                                   [(string=? ke CHAM-COLOR-GREEN-KEY) CHAM-COLOR-GREEN-NAME]
                                                                                                                                   [(string=? ke CHAM-COLOR-BLUE-KEY) CHAM-COLOR-BLUE-NAME]))
                                                                                                                            (zoo-focus-flag ws-zoo))]
               [else ws-zoo])]
        [else ws-zoo]))



; ZOO, String  -> Zoo
; aux func for on-pad for handler flag keys-control

(define (aux-on-pad-flag ws-zoo ke)
  (cond [(string=? ke CAT-FOCUS-FLAG) (make-zoo
                            (zoo-vcat ws-zoo)
                            (zoo-vcham ws-zoo)
                            CAT-FOCUS-FLAG)]
        [(string=? ke CHAM-FOCUS-FLAG) (make-zoo
                            (zoo-vcat ws-zoo)
                            (zoo-vcham ws-zoo)
                            CHAM-FOCUS-FLAG)]
        [else ws-zoo]))



; Hap, String  -> Hap
; aux func for on-pad for compute hap depending on keystrokes
; "up" - pet, hap up two points 
; down arrow - feed, hap up two points

;(check-expect (aux-on-pad-hap 20 "up") (* 20 1.2))
;(check-expect (aux-on-pad-hap 20 "down") 22)
;(check-expect (aux-on-pad-hap 900 "up") H-MAX-LIMIT)
;(check-expect (aux-on-pad-hap 999 "down") H-MAX-LIMIT)

(define (aux-on-pad-hap ws-zoo ke)
  (make-zoo
   (make-vcat
    (vcat-x (zoo-vcat ws-zoo))
    (cond [(and (string=? (zoo-focus-flag ws-zoo) CAT-FOCUS-FLAG) (string=? ke "up"))
          (cond [(> (* (vcat-hap (zoo-vcat ws-zoo)) H-COEFFICIENT-FOR-PET-UP-KEY) H-MAX-LIMIT) H-MAX-LIMIT]
                [else (* (vcat-hap (zoo-vcat ws-zoo)) H-COEFFICIENT-FOR-PET-UP-KEY)])]
          [(and (string=? (zoo-focus-flag ws-zoo) CAT-FOCUS-FLAG) (string=? ke "down"))
           (cond [(> (+ (vcat-hap (zoo-vcat ws-zoo)) H-ADDENDUM-FOR-FEEDING-DOWN-KEY) H-MAX-LIMIT) H-MAX-LIMIT]
                 [else (+ (vcat-hap (zoo-vcat ws-zoo)) H-ADDENDUM-FOR-FEEDING-DOWN-KEY)])]
          [else (vcat-hap (zoo-vcat ws-zoo))])
    (vcat-dir (zoo-vcat ws-zoo)))
   (make-vcham
    (vcham-x (zoo-vcham ws-zoo))
    (cond [(and (string=? (zoo-focus-flag ws-zoo) CHAM-FOCUS-FLAG) (string=? ke "up"))
           (cond [(> (* (vcham-hap (zoo-vcham ws-zoo)) H-COEFFICIENT-FOR-PET-UP-KEY) H-MAX-LIMIT) H-MAX-LIMIT]
                 [else (* (vcham-hap (zoo-vcham ws-zoo)) H-COEFFICIENT-FOR-PET-UP-KEY)])]
          [(and (string=? (zoo-focus-flag ws-zoo) CHAM-FOCUS-FLAG) (string=? ke "down"))
           (cond [(> (+ (vcham-hap (zoo-vcham ws-zoo)) H-ADDENDUM-FOR-FEEDING-DOWN-KEY) H-MAX-LIMIT) H-MAX-LIMIT]
                 [else (+ (vcham-hap (zoo-vcham ws-zoo)) H-ADDENDUM-FOR-FEEDING-DOWN-KEY)])]
          [else (vcham-hap (zoo-vcham ws-zoo))])
    (vcham-dir (zoo-vcham ws-zoo))
    (vcham-color (zoo-vcham ws-zoo)))
   (zoo-focus-flag ws-zoo)))



; aux func for on-pad for handling direction change events
; Dir, KeyEvent -> Dir

;(check-expect (aux-on-pad-dir "left" ANIMAL-PATH-DIRECTION-RIGHT) ANIMAL-PATH-DIRECTION-RIGHT)
;(check-expect (aux-on-pad-dir "left" "r") "left")
;(check-expect (aux-on-pad-dir ANIMAL-PATH-DIRECTION-RIGHT ANIMAL-PATH-DIRECTION-LEFT) ANIMAL-PATH-DIRECTION-LEFT)

(define (aux-on-pad-dir ws-zoo ke)
  (make-zoo
   (make-vcat
    (vcat-x (zoo-vcat ws-zoo))
    (vcat-hap (zoo-vcat ws-zoo))
    (cond [(and (string=? (zoo-focus-flag ws-zoo) CAT-FOCUS-FLAG) (string=? ke ANIMAL-PATH-DIRECTION-RIGHT)) ANIMAL-PATH-DIRECTION-RIGHT]
          [(and (string=? (zoo-focus-flag ws-zoo) CAT-FOCUS-FLAG) (string=? ke ANIMAL-PATH-DIRECTION-LEFT)) ANIMAL-PATH-DIRECTION-LEFT]
          [else (vcat-dir (zoo-vcat ws-zoo))]))
   (make-vcham
    (vcham-x (zoo-vcham ws-zoo))
    (vcham-hap (zoo-vcham ws-zoo))
    (cond [(and (string=? (zoo-focus-flag ws-zoo) CHAM-FOCUS-FLAG) (string=? ke ANIMAL-PATH-DIRECTION-RIGHT)) ANIMAL-PATH-DIRECTION-RIGHT]
          [(and (string=? (zoo-focus-flag ws-zoo) CHAM-FOCUS-FLAG) (string=? ke ANIMAL-PATH-DIRECTION-LEFT)) ANIMAL-PATH-DIRECTION-LEFT]
          [else (vcham-dir (zoo-vcham ws-zoo))])
    (vcham-color (zoo-vcham ws-zoo)))
   (zoo-focus-flag ws-zoo)))



; Zoo -> Boolean
; end? func for BB
; return #true when one of animal's hap <= 0

(define (end? ws-zoo)
  (cond [(or (<= (aux-animal-hap-extract (zoo-vcat ws-zoo)) H-LOW-LIMIT)
             (<= (aux-animal-hap-extract (zoo-vcham ws-zoo)) H-LOW-LIMIT)) #true]
        [else #false]))