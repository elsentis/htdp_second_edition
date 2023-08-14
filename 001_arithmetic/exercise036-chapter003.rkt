;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise036-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise036-chapter003

; Q.:
; Design the function image-area, which counts the number of pixels in a given image.

; image-area func
; we use image to represent image
; we use numbers to represent quantity of pixels
; Image -> Number
; compute the area of input image img

; given (rectangle 30 30 "outline" "grey"), expected 900 
; given (circle 20 "solid" "grey"), expected 1600

(define (image-area img)
  (* (image-width img) (image-height img)))

(image-area (rectangle 30 30 "outline" "grey"))
(image-area (circle 20 "solid" "grey"))