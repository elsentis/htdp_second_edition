;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise028-chapter002) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise028-chapter002

; Q.:
; Determine the potential profit for these ticket prices: $1, $2, $3, $4, and $5.
; Which price maximizes the profit of the movie theater? Determine the best ticket price to a dime.


(define PRICE-BASE 5.00)
(define ATTENDEES-WITH-PRICE-BASE 120)
(define ATTENDEES-CHANGE-BY-BASE-PRICE-CHANGE-PER-DOLLAR (/ 15 0.10))
(define COST-BASE 180)
(define COST-CHANGE-ADDITIONAL-PER-ATTENDEE 0.04)


(define (attendees ticket-price)
  (- ATTENDEES-WITH-PRICE-BASE (* (- ticket-price PRICE-BASE) ATTENDEES-CHANGE-BY-BASE-PRICE-CHANGE-PER-DOLLAR)))


(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))


(define (cost ticket-price)
  (+ COST-BASE (* COST-CHANGE-ADDITIONAL-PER-ATTENDEE (attendees ticket-price))))


(define (profit ticket-price)
  (- (revenue ticket-price) (cost ticket-price)))

; Q.:
; Determine the potential profit for these ticket prices: $1, $2, $3, $4, and $5. Which price maximizes the profit of the movie theater?

;(profit 1) 511.2
;(profit 2) 937.2
;(profit 3) 1063.2
;(profit 4) 889.2
;(profit 5) 415.2
; a ticket price of $3 will bring the maximum profit

; Q.:
; Determine the best ticket price to a dime.

;(profit 2.5) 1037.7
;(profit 3) 1063.2
;(profit 3.5) 1013.7

;(profit 2.6) 1048.8
;(profit 2.7) 1056.9
;(profit 2.8) 1062
;(profit 2.9) 1064.1
;(profit 3.0) 1063.2
;(profit 3.1) 1059.3

;(profit 2.80) 1062
;(profit 2.85) 1063.425
;(profit 2.9) 1064.1
;(profit 2.95) 1064.025

;(profit 2.85) 1063.425
;(profit 2.86) 1063.62
;(profit 2.87) 1063.785
;(profit 2.88) 1063.92
;(profit 2.89) 1064.025
;(profit 2.90) 1064.1
;(profit 2.91) 1064.145
;(profit 2.92) 1064.16
;(profit 2.93) 1064.145
;(profit 2.94) 1064.1
;(profit 2.95) 1064.025
;(profit 2.96) 1063.92
;(profit 2.97) 1063.785

;(profit 2.92) 1064.16
; a ticket price of $2.92 will bring the maximum profit to be exact to a dime.