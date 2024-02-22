;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise175-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise175-chapter010

; Q.:
; Design a BSL program that simulates the Unix command wc.
; The purpose of the command is to count the number of 1Strings, words, and lines in a given file.
; That is, the command consumes the name of a file and produces a value
; that consists of three numbers.
; (Why might your computer’s wc give a slightly different result from your code?)


; An Los (List-of-String) 
; is one of: 
; – '() 
; – (cons String Los)

; An LN is one of: 
; – '()
; – (cons Los LN)
; interpretation a list of lines, each is a list of Strings

(define-struct file-info [symbol-c words-c lines-c])
; A file-info is a structure
; (make-file-info Number Number Number)
; interpretation a set of values describing the contents of a some file:
; count the number of 1Strings, words, and lines

(define line0 (cons "a" (cons "w" '())))
(define line1 '())
(define line2 (cons "t" (cons "w" (cons "a" (cons "b" (cons "h" '()))))))
(define line3 (cons "an" (cons "wht" '())))

(define lls0 (cons line0 (cons line1 '())))
(define lls1 (cons line1 (cons line2 '())))
(define lls3 (cons line2 (cons line0 '())))
(define lls4 (cons line3 (cons line0 '())))


; LN -> Number
; func for counting the number of 1Strings
; in inputuing LN
;
;(check-expect (aux-file-info lls0) 5)
;(check-expect (aux-file-info lls1) 11)
;
(define (aux-file-info lls)
  (cond
    [(empty? lls) 1]
    [else
     (+ (aux-line-info (first lls) 0)
        (if (empty? (rest lls)) 0 1)
        (aux-file-info (rest lls)))]))


; Los, Number -> Number
; consume list of strings with a number to count
; produce the sum of the number and the number of list items
;(check-expect (aux-line-info line3 0) 6)
;(check-expect (aux-line-info line2 0) 9)
;
(define (aux-line-info los n)
  (cond
    [(empty? los) n]
    [else (+ (aux-word-info (explode (first los)) 0)
             (if (empty? (rest los)) 0 1)
             (aux-line-info (rest los) 0))]))



; Los, Number -> Number
; consume list of strings with a number to count
; produce the sum of the number and the number of list items
;(check-expect (aux-word-info line0 0) 2)
;(check-expect (aux-word-info line0 0) 2)
;
(define (aux-word-info los n)
  (cond
    [(empty? los) n]
    [else (aux-word-info (rest los) (+ n 1))]))


