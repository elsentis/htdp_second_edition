;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise167-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise167-chapter010

; Q.:
; Design the function sum,
; which consumes a list of Posns and produces the sum of all of its x-coordinates.


; Lop (short for list of Posns) is one of:
; - '()
; - (cons Posn Lop)
; interpretation an instance of Lop represents the
; a list of some Posns

; Lop -> Number
; consumes a list of Posns and produces the sum of all of its x-coordinates
;
(check-expect (sum (cons (make-posn 3 4) (cons (make-posn 5 6) '()))) (+ 3 5))
;
(define (sum lop)
  (cond
    [(empty? lop) 0]
    [(cons? lop)
     (+ (posn-x (first lop)) (sum (rest lop)))]))