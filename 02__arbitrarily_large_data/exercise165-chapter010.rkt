;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise165-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise165-chapter010

; Q.:
; Design the function subst-robot, which consumes a list of toy descriptions (one-word strings)
; and replaces all occurrences of "robot" with "r2d2"; all other descriptions remain the same.
; 
; Generalize subst-robot to substitute.
; The latter consumes two strings, called new and old, and a list of strings.
; It produces a new list of strings by substituting all occurrences of old with new.



; a Toy is a String
; interpretation represents the toy descriptions (one-word strings)

; a LoT is one of:
; -- empty
; -- (cons Toy LoT)
; interpretation the list of Toy

; LoT -> LoT
; consumes a list of toy descriptions (one-word strings)
; and replaces all occurrences of "robot" with "r2d2"
; all other descriptions remain the same
;
(check-expect (subst-robot '()) '())
(check-expect
 (subst-robot (cons "elephant" (cons "ball" (cons "robot" '()))))
 (cons "elephant" (cons "ball" (cons "r2d2" '()))))
(check-expect
 (subst-robot (cons "elephant" (cons "ball" (cons "robot" (cons "matryoshka" (cons "robot" '()))))))
 (cons "elephant" (cons "ball" (cons "r2d2" (cons "matryoshka" (cons "r2d2" '()))))))
;
(define (subst-robot lot)
  (cond
    [(empty? lot) '()]
    [(cons? lot)
     (cons
      (if (string=? "robot" (first lot))
          "r2d2"
          (first lot))
      (subst-robot (rest lot)))]))



; String, String, List of Strings -> List of Strings
; consumes two strings, called new and old, and a list of strings
; it produces a new list of strings by substituting all occurrences of old with new.
;
(check-expect
 (substitute "one" "two" (cons "one" (cons "two" (cons "three" (cons "four" (cons "five" '()))))))
 (cons "two" (cons "two" (cons "three" (cons "four" (cons "five" '()))))))
(check-expect
 (substitute "one" "two" (cons "one" (cons "two" (cons "one" (cons "four" (cons "one" '()))))))
 (cons "two" (cons "two" (cons "two" (cons "four" (cons "two" '()))))))
;
(define (substitute old new los)
  (cond
    [(empty? los) '()]
    [(cons? los)
     (cons
      (if (string=? (first los) old)
          new
          (first los))
     (substitute old new (rest los)))]))
