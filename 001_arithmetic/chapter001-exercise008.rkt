;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter001-exercise008) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; chapter001-exercise008

; Q.: 
; Create a conditional expression that computes whether the image is tall or wide.
; Create an expression that computes whether a picture is "tall", "wide", or "square".

(define cat (bitmap "./cat.png"))

(define image-test (rectangle 30 30 "outline" "grey"))

(if (< (image-width cat) (image-height cat)) "tall" "wide")

(if (< (image-width image-test) (image-height image-test))
    "tall"
    (if (> (image-width image-test)(image-height image-test)) "wide" "square"))

