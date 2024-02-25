;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise176-chapter010) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise176-chapter010

; Q.:
; Mathematics teachers may have introduced you to matrix calculations by now.
; In principle, matrix just means rectangle of numbers.
; Here is one possible data representation for matrices
; Note the constraints on matrices.
; Study the data definition and translate the two-by-two matrix consisting of the numbers
; 11, 12, 21, and 22 into this data representation.
; Stop, don’t read on until you have figured out the data examples.


; A Matrix is one of: 
;  – (cons Row '())
;  – (cons Row Matrix)
; constraint all rows in matrix are of the same length
 
; A Row is one of: 
;  – '() 
;  – (cons Number Row)

(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '())))

(define row1 (cons 11 (cons 12 '())))
(define row2 (cons 21 (cons 22 '())))
(define mat1 (cons row1 (cons row2 '())))

(define mat2
(cons (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))
(cons (cons 6 (cons 7 (cons 8 (cons 9 (cons 10 '())))))
(cons (cons 11 (cons 12 (cons 13 (cons 14 (cons 15 '()))))) '()))))


(define tam2
  (cons (cons 1 (cons 6 (cons 11 '())))
        (cons (cons 2 (cons 7 (cons 12 '())))
              (cons (cons 3 (cons 8 (cons 13 '())))
                    (cons (cons 4 (cons 9 (cons 14 '())))
                          (cons (cons 5 (cons 10 (cons 15 '()))) '()))))))

; Matrix -> Matrix
; transposes the given matrix along the diagonal 
;
(check-expect (transpose mat1) tam1)
(check-expect (transpose mat2) tam2)
(check-expect (transpose tam2) mat2)
;
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))


; Matrix -> Row
; func for transposes separate column of the input matrix into row
;
;(check-expect (first* mat1) wor1)
;
(define (first*  m)
  (cond
    [(empty? m) '()]
    [else (cons (first (first m)) (first* (rest m)))]))


; Matrix -> Row
; aux func for transponse for
; formation of a residual matrix for a recursive call of transponse 
;
(check-expect (rest* mat1) (cons (cons 12 '()) (cons (cons 22 '()) '())))
;
(define (rest* m)
  (cond
    [(empty? m) '()]
    (else (cons (rest (first m)) (rest* (rest m))))))
