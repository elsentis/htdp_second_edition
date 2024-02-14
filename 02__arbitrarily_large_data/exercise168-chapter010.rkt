;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise168-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise168-chapter010

; Q.:
; Design the function translate.
; It consumes and produces lists of Posns.
; For each (make-posn x y) in the former, the latter contains (make-posn x (+ y 1)).
; We borrow the word “translate” from geometry,
; where the movement of a point by a constant distance along a straight line is called a translation.


; Lop (short for list of Posns) is one of:
; - '()
; - (cons Posn Lop)
; interpretation an instance of Lop represents the
; a list of some Posns


; Lop -> Lop
; It consumes and produces lists of Posns.
; For each (make-posn x y) in the former, the latter contains (make-posn x (+ y 1))
;
(check-expect (translate (cons (make-posn 3 4) (cons (make-posn 5 6) '())))
              (cons (make-posn 3 5) (cons (make-posn 5 7) '())))
;
(define (translate lop)
  (cond
    [(empty? lop) '()]
    [(cons? lop) (cons (aux-translate (first lop)) (translate (rest lop)))]))


; Posn -> Posn
; aux func for 'translate' func
; for separate instance of 'posn'
;
(check-expect (aux-translate (make-posn 3 4)) (make-posn 3 5))
;
(define (aux-translate p)
  (make-posn (posn-x p) (+ 1 (posn-y p))))