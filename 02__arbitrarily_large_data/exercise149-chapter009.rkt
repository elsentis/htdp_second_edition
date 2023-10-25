;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise149-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise149-chapter009

; Q.:
; Does copier function properly when you apply it to a natural number and a Boolean or an image?
; Or do you have to design another function? Read Abstraction for an answer.
; An alternative definition of copier might use else:
; (define (copier.v2 n s)
;   (cond
;     [(zero? n) '()]
;     [else (cons s (copier.v2 (sub1 n) s))]))
; How do copier and copier.v2 behave when you apply them to 0.1 and "x"? Explain.
; Use DrRacket’s stepper to confirm your explanation.


; Q.:
; Does copier function properly when you apply it to a natural number and a Boolean or an image?
; Or do you have to design another function? Read Abstraction for an answer.
;
; A.:
; yes, the function performs the task when inputing an Image or a Boolean as a second argument
; because copier function does not process or validate input data from the second argument and
; creates a list of n elements from any instance of any data type


; Q.:
; How do copier and copier.v2 behave when you apply them to 0.1 and "x"? Explain.
; Use DrRacket’s stepper to confirm your explanation.
;
; A.:
; in copier function conditions execution cond clauses set specific conditions for the second argument
; it must be zero or positive number
; if n does not meet the specified conditions
; the function terminates with a message from the cond construction
; that all question results were false 
; 
; in copier.v2 function 'else' clause of cond forces the specified action - copier.v2 to be performed
; in this clause in any case, where n is nonzero
; since n a floating point number and when applied sub1 the 0 will never be received
; this input leads to a situation with an infinite function call copier.v2 and as a consequence
; leads to out of memory


; N String -> List-of-strings 
; creates a list of n copies of s
 
;(check-expect (copier 0 "hello") '())
;(check-expect (copier 2 "hello")
;              (cons "hello" (cons "hello" '())))
 
(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))

;(copier 5 (circle 5 "solid" "red" ))
;(copier 5 #true)

(define (copier.v2 n s)
  (cond
    [(zero? n) '()]
    [else (cons s (copier.v2 (sub1 n) s))]))

;(copier 0.1 "x")
;(copier.v2 0.1 "x")
