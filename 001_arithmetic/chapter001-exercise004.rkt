;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter001-exercise004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; chapter001-exercise004

; Q:
; create an expression using string primitives that deletes the ith position from str
; Which values for i are legitimate?


(define str "helloworld")
(define i 1)

(string-append (substring str 0 (- i 1)) (substring str i))

; Which values for i are legitimate?
; from 1 to (string-length str) 