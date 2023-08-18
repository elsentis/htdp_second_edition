;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise058-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise058-chapter004

; Q.:
; The state of Tax Land has created a three-stage sales tax to cope with its budget deficit.
; Inexpensive items, those costing less than $1,000, are not taxed. Luxury items, with a price of more than $10,000, are taxed at the rate of eight percent (8.00%).
; Everything in between comes with a five percent (5.00%) markup.
; Introduce constant definitions that separate the intervals for low prices and luxury prices from the others so that the legislators in Tax Land can easily raise the taxes even more.


(define LIMIT-LOW-TAX 1000)
(define LIMIT-HIGH-TAX 10000)

(define TAX-RATE-LOW 0)
(define TAX-RATE-MIDDLE 0.05)
(define TAX-RATE-HIGH 0.08)


; ; A Price falls into one of three intervals: 
; — 0 through 999
; — 1000 through 9999
; — 10000 and above.
; interpretation the price of an item



; Price -> Number
; computes the amount of tax charged for p

(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 999) 0)
(check-expect (sales-tax 1000) (* 0.05 1000))
(check-expect (sales-tax 5537) (* 0.05 5537))
(check-expect (sales-tax 9999) (* 0.05 9999))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 55537) (* 0.08 55537))

(define (sales-tax p)
  (cond
    [(and (<= 0 p) (< p LIMIT-LOW-TAX)) 0]
    [(and (<= LIMIT-LOW-TAX p) (< p LIMIT-HIGH-TAX)) (* TAX-RATE-MIDDLE p)]
    [(>= p LIMIT-HIGH-TAX) (* TAX-RATE-HIGH p)]))