;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter006-exercise094) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; chapter006-exercise094

; Q.:
; Draw some sketches of what the game scenery looks like at various stages
; Use the sketches to determine the constant and the variable pieces of the game
; Finally, create your initial scene from the constants for the tank, the UFO, and the background

(define WIDTH 500)
(define HEIGHT 500)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define ROCKET (polygon (list (make-posn 0 0)
                 (make-posn (-(/ WIDTH 20)) (/ WIDTH 10))
                 (make-posn 0 (/ WIDTH 15) )
                 (make-posn (/ WIDTH 20) (/ WIDTH 10)))
           "solid"
           "black"))

(define UFO (overlay (circle (/ WIDTH 30) "solid" "green") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "green")))
(define WIN_UFO (overlay (circle (/ WIDTH 30) "solid" "red") (rectangle (/ WIDTH 10) (/ WIDTH 100) "solid" "red")))

(define TANK-HEIGHT (/ HEIGHT 30))
(define TANK-Y-LEVEL (- (- HEIGHT (* TANK-HEIGHT 0.5 )) 1))
(define TANK (rectangle (/ WIDTH 5) TANK-HEIGHT "solid" "blue"))

(define FIRE (star 20 "outline" "orange"))

; probalble game start scene
(define SKETCH-1
  (place-image TANK (/ WIDTH 2) TANK-Y-LEVEL
               (place-image UFO (/ WIDTH 2) (image-height UFO) BACKGROUND)))
                             

; game scene after rocket launch
(define SKETCH-2
  (place-image TANK (/ WIDTH 3) TANK-Y-LEVEL
               (place-image UFO (/ WIDTH 4) (/ HEIGHT 2)
                            (place-image ROCKET (/ WIDTH 2) (+ (/ HEIGHT 2) (image-height ROCKET)) BACKGROUND))))

; game scene with player win
(define SKETCH-3
  (place-image (text "you win" (/ WIDTH 10) "red") (- (/ WIDTH 1) (image-width (text "you win" (/ WIDTH 10) "red"))) (/ (image-height (text "you win" (/ WIDTH 10) "red")) 2)
                (place-image FIRE (/ (+ (/ WIDTH 4) (+ (/ WIDTH 4) 10)) 2) (/ (+ (/ HEIGHT 2) (+ (/ HEIGHT 2) 10)) 2)
                             (place-image TANK (/ WIDTH 3) TANK-Y-LEVEL
                                          (place-image UFO (/ WIDTH 4) (/ HEIGHT 2)
                                                       (place-image ROCKET (+ (/ WIDTH 4) 10) (+ (/ HEIGHT 2) 10) BACKGROUND))))))

; game scene with player lose
(define SKETCH-4
  (place-image (text "you lose" (/ WIDTH 10) "red") (- (/ WIDTH 1) (image-width (text "you lose" (/ WIDTH 10) "red"))) (/ (image-height (text "you lose" (/ WIDTH 10) "red")) 2)
                (place-image TANK (/ WIDTH 3) TANK-Y-LEVEL
                             (place-image WIN_UFO (/ WIDTH 10) (- (- HEIGHT (* (image-height WIN_UFO) 0.5 )) 1)
                                          (place-image ROCKET (+ (/ WIDTH 4) 10) (/ (image-height (text "you lose" (/ WIDTH 10) "red")) 2) BACKGROUND)))))
                                          

                
             
       
