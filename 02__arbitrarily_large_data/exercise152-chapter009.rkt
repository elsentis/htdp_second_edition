;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise152-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise152-chapter009

; Q.:
; Design two functions: col and row
; The function col consumes a natural number n and an image img.
; It produces a column—a vertical arrangement—of n copies of img.
; The function row consumes a natural number n and an image img.
; It produces a row—a horizontal arrangement—of n copies of img.



;; An N is one of:
;; – 0
;; – (add1 N)
;; Represents the counting numbers.


; N, Image -> Image
; consumes a natural number n and an image img.
; It produces a column—a vertical arrangement—of n copies of img
;
;(check-expect  (col 5 (circle 5 "outline" "red")) (above (circle 5 "outline" "red")
;                                                         (circle 5 "outline" "red")
;                                                         (circle 5 "outline" "red")
;                                                         (circle 5 "outline" "red")
;                                                         (circle 5 "outline" "red")))
;                                                
;
(define (col n img)
  (cond
    [(zero? n) empty-image]
    [else (above img (col (sub1 n) img))]))



; N, Image -> Image
; consumes a natural number n and an image img.
; It produces a column—a vertical arrangement—of n copies of img
;
;(check-expect  (row 5 (circle 5 "outline" "red")) (beside (circle 5 "outline" "red")
;                                                          (circle 5 "outline" "red")
;                                                          (circle 5 "outline" "red")
;                                                          (circle 5 "outline" "red")
;                                                          (circle 5 "outline" "red")))
;
(define (row n img)
  (cond
    [(zero? n) empty-image]
    [else (beside img (row (sub1 n) img))]))