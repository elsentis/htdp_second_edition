;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise040-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise040-chapter003

; Q.:
; Formulate the examples as BSL tests, that is, using the check-expect form. Introduce a mistake. Re-run the tests.




; WorldState -> WorldState 
; moves the car by 3 pixels for every clock tick
; examples: 

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)
(check-expect (tock 20) 20) ; intoduce a mistake in expected value


(define (tock cw)
  (+ cw 3))