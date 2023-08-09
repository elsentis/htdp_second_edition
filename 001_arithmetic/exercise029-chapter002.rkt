;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise029-chapter002) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise029-chapter002

; Q.:
; After studying the costs of a show, the owner discovered several ways of lowering the cost.
; As a result of these improvements, there is no longer a fixed cost; a variable cost of $1.50 per attendee remains.
; Modify both programs to reflect this change.
; When the programs are modified, test them again with ticket prices of $3, $4, and $5 and compare the results.


(define PRICE-BASE 5.00)
(define ATTENDEES-WITH-PRICE-BASE 120)
(define ATTENDEES-CHANGE-BY-BASE-PRICE-CHANGE-PER-DOLLAR (/ 15 0.10))
(define COST-BASE-PER-ATENDEE 1.5)

(define (attendees ticket-price)
  (- ATTENDEES-WITH-PRICE-BASE (* (- ticket-price PRICE-BASE) ATTENDEES-CHANGE-BY-BASE-PRICE-CHANGE-PER-DOLLAR)))


(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))


(define (cost ticket-price)
  (* COST-BASE-PER-ATENDEE (attendees ticket-price)))


(define (profit.v1 ticket-price)
  (- (revenue ticket-price) (cost ticket-price)))


;(profit.v1 3) 630
;(profit.v1 4) 675
;(profit.v1 5) 420
; a ticket price of $3 will bring the maximum profit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (profit.v2 price)
  (- (* (+ 120
           (* (/ 15 0.1)
              (- 5.0 price)))
        price)
     (* 1.50
        (+ 120
           (* (/ 15 0.1)
              (- 5.0 price))))))

;(profit.v2 3) 630 
;(profit.v2 4) 675
;(profit.v2 5) 420
; a ticket price of $3 will bring the maximum profit

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Resume
; editing a program that is divided into a main and several auxiliary functions is much easier
; than a program in which all calculations are carried out in one main function