;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise030-chapter002) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise030-chapter002

; Q.:
; Define constants for the price optimization program at the movie theater so that the price sensitivity of attendance
; (15 people for every 10 cents) becomes a computed constant.

(define PRICE-BASE 5.00)
(define ATTENDEES-WITH-PRICE-BASE 120)
(define ATTENDEES-CHANGE-BY-BASE-PRICE-CHANGE-PER-DOLLAR (/ 15 0.10)) ;constant for the price sensitivity of attendance (15 people for every 10 cents)
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
