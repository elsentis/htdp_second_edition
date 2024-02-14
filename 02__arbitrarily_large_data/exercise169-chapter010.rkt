;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise169-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise169-chapter010

; Q.:
; Design the function legal.
; Like translate from exercise 168, the function consumes and produces a list of Posns.
; The result contains all those Posns
; whose x-coordinates are between 0 and 100 and whose y-coordinates are between 0 and 200.


; Lop (short for list of Posns) is one of:
; - '()
; - (cons Posn Lop)
; interpretation an instance of Lop represents the
; a list of some Posns


; Lop -> Lop
; the function consumes and produces a list of Posns
; The result contains all those Posns
; whose x-coordinates are between 0 and 100 and whose y-coordinates are between 0 and 200.
;
(check-expect (legal (cons (make-posn 3 4) (cons (make-posn 5 6) '())))
              (cons (make-posn 3 4) (cons (make-posn 5 6) '())))
(check-expect (legal (cons (make-posn 103 4) (cons (make-posn 5 6) '())))
              (cons (make-posn 5 6) '()))
(check-expect (legal (cons (make-posn 3 4) (cons (make-posn 5 201) '())))
              (cons (make-posn 3 4)  '()))
;
(define (legal lop)
  (cond
    [(empty? lop) '()]
    [(and (and (<= 0 (posn-x (first lop))) (<= (posn-x (first lop)) 100))
         (and (<= 0 (posn-y (first lop))) (<= (posn-y (first lop)) 200)))
     (cons (first lop) (legal (rest lop)))]
    [else (legal (rest lop))]))
     