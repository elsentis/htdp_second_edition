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

(define-struct file-info-struct [symbol-c words-c lines-c])
; A file-info-struct is a structure
; (make-file-info-struct Number Number Number)
; interpretation a set of values describing the contents of a some file:
; count the number of 1Strings (with line engings and spaces), words, and lines

(define line0 (cons "a" (cons "w" '())))
(define line1 '())
(define line2 (cons "t" (cons "w" (cons "a" (cons "b" (cons "h" '()))))))
(define line3 (cons "an" (cons "wht" '())))

(define lls0 (cons line0 (cons line1 '())))
(define lls1 (cons line1 (cons line2 '())))
(define lls3 (cons line2 (cons line0 '())))
(define lls4 (cons line3 (cons line0 '())))


; String (name of file) -> file-info
; The purpose of the function consumes the name of a file and produces a value
; that consists of three numbers
; count the number of 1Strings, words, and lines in a given file
;
(define (file-info f)
  (aux-file-info (read-words/line f)))


; LN -> file-info-struct
; consume a data from input file processed by the function read-words/line
; and produce a file-info-struct with data about file
;
;(check-expect (aux-file-info lls0) (make-file-info-struct 4 2 2))
;
(define (aux-file-info lls)
  (make-file-info-struct (aux-file-info-1string-count lls)
                         (aux-file-info-word-count lls)
                         (aux-file-info-line-count lls)))


; LN -> Number
; func for counting the number of 1Strings
; in inputuing LN
;
;(check-expect (aux-file-info-1string-count lls0) 5)
;(check-expect (aux-file-info-1string-count lls1) 11)
;
(define (aux-file-info-1string-count lls)
  (cond
    [(empty? lls) 0]
    [else
     (+ (aux-file-info-1string-count-line (first lls) 0)
        (if (empty? (rest lls)) 0 1)
        (aux-file-info-1string-count (rest lls)))]))


; Los, Number -> Number
; consume list of strings with a number to count
; produce the sum of the number and the number of list items
;(check-expect (aux-file-info-1string-count-line line3 0) 6)
;(check-expect (aux-file-info-1string-count-line line2 0) 9)
;
(define (aux-file-info-1string-count-line los n)
  (cond
    [(empty? los) n]
    [else (+ (aux-file-info-1string-count-word (explode (first los)) 0)
             (if (empty? (rest los)) 0 1)
             (aux-file-info-1string-count-line (rest los) 0))]))



; Los, Number -> Number
; consume list of strings with a number to count
; produce the sum of the number and the number of list items
;(check-expect (aux-file-info-1string-count-word line0 0) 2)
;(check-expect (aux-file-info-1string-count-word line0 0) 2)
;
(define (aux-file-info-1string-count-word los n)
  (cond
    [(empty? los) n]
    [else (aux-file-info-1string-count-word (rest los) (+ n 1))]))


; LN -> Number
;  aux func for file-info for counting words in a input file
;
;(check-expect (aux-file-info-word-count lls0) 2)
;(check-expect (aux-file-info-word-count lls1) 5)
;(check-expect (aux-file-info-word-count lls3) 7)
;
(define (aux-file-info-word-count lls)
  (cond
    [(empty? lls) 0]
    [else (+ (aux-file-info-word-count-line (first lls))
             (aux-file-info-word-count (rest lls)))]))


; Los -> Number
; aux func for file-info for counting words in a separate text line
;
;(check-expect (aux-file-info-word-count-line line0) 2)
;(check-expect (aux-file-info-word-count-line line1) 0)
;(check-expect (aux-file-info-word-count-line line2) 5)
;(check-expect (aux-file-info-word-count-line line3) 2)
;
(define (aux-file-info-word-count-line los)
  (cond
    [(empty? los) 0]
    [else (+ 1
        (aux-file-info-word-count-line (rest los)))]))


; LN -> Number
; aux func for file-info for counting line in a input file
;
;(check-expect (aux-file-info-line-count lls0) 2)
;
(define (aux-file-info-line-count lls)
  (cond
    [(empty? lls) 0]
    [else (+ 1
             (aux-file-info-line-count (rest lls)))]))




