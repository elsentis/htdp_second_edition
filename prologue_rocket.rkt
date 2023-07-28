;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname prologue_rocket) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/universe)

(define WEIGHT 1000)
(define HEIGHT 120)

(define ROCKET (overlay (circle 10 "solid" "green")
(rectangle 40 4 "solid" "green")))
(define LANDING_SITE (rectangle 40 25 "solid" "grey"))

(define HORIZONTAL_PLACE_IMAGE (/ WEIGHT 2))

(define BACKGROUND (empty-scene WEIGHT HEIGHT "Burlywood"))
(define SITE_LANDING_LEVEL (- HEIGHT (/ (image-height LANDING_SITE) 2 )))
(define ROCKET_LANDING_LEVEL (- HEIGHT (+ (image-height LANDING_SITE) (/ (image-height ROCKET) 2))))




(define (picture-of-rocket height)
  (cond
    [(<= height ROCKET_LANDING_LEVEL) (place-image ROCKET HORIZONTAL_PLACE_IMAGE height (place-image LANDING_SITE HORIZONTAL_PLACE_IMAGE  SITE_LANDING_LEVEL BACKGROUND)) ]
    [(> height  ROCKET_LANDING_LEVEL) (place-image ROCKET HORIZONTAL_PLACE_IMAGE ROCKET_LANDING_LEVEL (place-image LANDING_SITE HORIZONTAL_PLACE_IMAGE  SITE_LANDING_LEVEL BACKGROUND))]
    )
  )

(picture-of-rocket 95)

;overlay