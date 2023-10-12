;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise110-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise110-chapter006

; Q.:
; A checked version of area-of-disk can also enforce that the arguments to the function are positive numbers, not just arbitrary numbers.
; Modify checked-area-of-disk in this way


(define MESSAGE "area-of-disk: positive number expected")

; Number -> Number
; computes the area of a disk with radius r
(define (area-of-disk r)
  (* 3.14 (* r r)))

; Any -> Number
; computes the area of a disk with radius v, 
; if v is a number

(check-expect (checked-area-of-disk "lol") MESSAGE)
(check-expect (checked-area-of-disk -1) MESSAGE)
(check-expect (checked-area-of-disk 0) MESSAGE)
(check-expect (checked-area-of-disk 1) (* 3.14 (* 1 1)))

(define (checked-area-of-disk v)
  (cond
    [(number? v)
     (cond [(positive? v)(area-of-disk v)]
           [else (error  MESSAGE)])]
    [else (error  MESSAGE)]))
     
    
