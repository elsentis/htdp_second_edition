;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise153-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise153-chapter009

; Q.:
; Use the two functions from exercise 152 to create a rectangle of COLUMNS by ROWS squares
; each of which has size 10 by 10.
; Place it in an empty-scene of the same size.
; Design add-balloons.
; The function consumes a list of Posn whose coordinates fit into the dimensions of the lecture hall.
; It produces an image of the lecture hall with red dots added as specified by the Posns.



(define SQUARE-SIDE 10)
(define SQUARE (square SQUARE-SIDE "outline" "black"))
(define SQUARE-HALL-X 10) ; the size of the hall in squares on the x scale
(define SQUARE-HALL-Y 10) ; the size of the hall in squares on the y scale
(define RED-DOT (circle 3 "solid" "red"))
;(define BACKGROUND (empty-scene (* SQUARE-HALL-X SQUARE-SIDE) (* SQUARE-HALL-Y SQUARE-SIDE)))


; An N is one of:
; – 0
; – (add1 N)
; Represents the counting numbers.

; A Lext-X fall in interval:
; - 0 to SQUARE-HALL-X
; interpretation the 

; A Lext-Y fall in interval:
; - 0 to SQUARE-HALL-Y

; A Lect-Posn is a structure:
;  (make-posn Lect-x 10 Lect-y)
; interpretation the range of points available for throwing the ball is within Lecture-hall

;; An List-of-Lect-Posns is one of:
;; -  '()
;; - (cons Boolean List-of-Lect-Posns)
(define list-of-dots-1 (cons (make-posn 6 4)
                             (cons (make-posn 3 6)
                                   (cons (make-posn 6 8) '()))))

; List-of-Lect-Posns -> Image
; consumes a list of Posn whose coordinates fit into the dimensions of the lecture hall
; produces an image of the lecture hall with red dots added as specified by the Lect-Posns
;
;(add-balloons list-of-dots-1)
;
(define (add-balloons list)
  (cond
    [(empty? list) (lecture-hall
                    SQUARE-HALL-X
                    SQUARE-HALL-Y)]
    [(cons? list) (place-image
                   RED-DOT
                   (* (posn-x (first list)) SQUARE-SIDE)
                   (* (posn-y (first list)) SQUARE-SIDE)
                   (add-balloons (rest list)))]))
                   

; N, N -> Image
; create a rectangle of y COLUMNS by x ROWS squares
; and place it in an empty-scene of the same size
;
(define (lecture-hall x y)
  (place-image
   (col y (row x SQUARE))
   (/ (* SQUARE-SIDE x) 2)
   (/ (* SQUARE-SIDE y) 2)
   (empty-scene (* x SQUARE-SIDE) (* y SQUARE-SIDE))))


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