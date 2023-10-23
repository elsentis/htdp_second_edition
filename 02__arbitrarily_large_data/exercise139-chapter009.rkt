;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise139-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise139-chapter009

; Q.:
; Now take a look at this data definition
;
; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)
;
; Design the function pos?, which consumes a List-of-numbers and determines whether all numbers are positive numbers.
; Also design checked-sum. The function consumes a List-of-numbers.
; It produces their sum if the input also belongs to List-of-amounts; otherwise it signals an error.
; What does sum compute for an element of List-of-numbers?



; A List-of-numbers is one of: 
; – '()
; – (cons Number List-of-numbers)

; Q.:
; Design the function pos?, which consumes a List-of-numbers and determines whether all numbers are positive numbers.
; In other words, if (pos? l) yields #true, then l is an element of List-of-amounts. Use DrRacket’s stepper to understand how pos? works for (cons 5 '()) and (cons -1 '()).

; (how-many.v2 (cons '())) == #true
; (how-many.v2 (cons 10 (cons 20 '()))) == #true
; (how-many.v2 (cons 10 (cons -20 '()))) == #false

;(check-expect (pos? '()) #true)
;(check-expect (pos? (cons 10 (cons 20 '()))) #true)
;(check-expect (pos? (cons 10 (cons -20 '()))) #false)

; List-of-numbers -> Boolean
; consumes a List-of-numbers and determines whether all numbers are positive numbers
(define (pos? alon)
  (cond
    [(empty? alon) #true]
    [(cons? alon) (cond
                    [(> (first alon) 0) (pos? (rest alon))]
                    [else #false])]))


; Q.:
; Also design checked-sum.
; The function consumes a List-of-numbers.
; It produces their sum if the input also belongs to List-of-amounts; otherwise it signals an error
; Hint Recall to use check-error.

; List-of-numbers -> PositiveNumber
; consumes a List-of-numbers, produces their sum if the input also belongs to List-of-amounts;
; otherwise it signals an error
;
; (checked-sum (cons '())) == 0
; (checked-sum (cons 10 (cons 20 '()))) == 30
; (checked-sum (cons 10 (cons -20 '()))) == error 'checked-sum "negative numbers in the list"
;
;(check-expect (checked-sum '()) 0)
;(check-expect (checked-sum (cons 10 (cons 20 '()))) 30)
;(check-error (checked-sum (cons 10 (cons -20 '()))) "checked-sum: negative numbers in the list")
;
(define (checked-sum alon)
  (cond
    [(pos? alon)
     (cond
       [(empty? alon) 0]
       [else (+ (first alon) (checked-sum (rest alon)))])]
    [else (error 'checked-sum "negative numbers in the list")]))


; Q.:
; What does sum compute for an element of List-of-numbers?
;
; the sum of all elements of the list if they are all positive numbers
; otherwise error message
