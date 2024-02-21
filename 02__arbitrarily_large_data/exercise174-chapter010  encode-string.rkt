;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise174-chapter010  encode-string|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise174-chapter010

; Q.:
; Design a program that encodes text files numerically.
; Each letter in a word should be encoded as a numeric three-letter string
; with a value between 0 and 256.
; Figure 69 shows our encoding function for single letters.
; Before you start, explain these functions.

; An Los (List-of-String) 
; is one of: 
; – '() 
; – (cons String Los)

; An LN is one of: 
; – '()
; – (cons Los LN)
; interpretation a list of lines, each is a list of Strings

(define line0 (cons "a" (cons "w" '())))
(define line1 '())
(define line2 (cons "t" (cons "wd" (cons "a" (cons "b" (cons "h" '()))))))

(define lls0 (cons line0 (cons line1 '())))
(define lls1 (cons line1 (cons line2 '())))
(define lls3 (cons line2 (cons line0 '())))

; Los -> String
; aux func for encode
; for processing a single line
; convert a  line into a string with encoding letters
;
(check-expect (aux-encode-string line0) (string-append (code1 "a")
                                                       (code1 " ")
                                                       (code1 "w")
                                                       (code1 "\n")))
                                                       
                             
(check-expect (aux-encode-string line1) (code1 "\n"))
(check-expect (aux-encode-string line2) (string-append (code1 "t")
                                                       (code1 " ")
                                                       (code1 "w")
                                                       (code1 "d")
                                                       (code1 " ")
                                                       (code1 "a")
                                                       (code1 " ")
                                                       (code1 "b")
                                                       (code1 " ")
                                                       (code1 "h")
                                                       (code1 "\n")))
;
(define (aux-encode-string los)
  (cond
    [(empty? los) (code1 "\n")]
    [else
     (string-append (aux-encode-word (explode (first los)))
                    (if (empty? (rest los)) "" (code1 " "))
                    (aux-encode-string (rest los)))]))


; LoS -> String
; aux func for encode
; for processing a single word (presented as list of 1-letter strings)
; convert a  word into a string with encoding letters
;
;(check-expect (aux-encode-word (cons "a" '())) (code1 "a"))
;(check-expect (aux-encode-word (cons "w"
;                                     (cons "o"
;                                           (cons "r"
;                                                 (cons "d" '())))))
;              (string-append (code1 "w") (code1 "o") (code1 "r") (code1 "d")))
;
(define (aux-encode-word los)
  (cond
    [(empty? los) ""]
    [else
     (string-append (code1 (first los)) (aux-encode-word (rest los)))]))


; 1String -> String
; converts the given 1String into a String
 
;(check-expect (code1 "z") "122")
 
(define (code1 c)
  (number->string (string->int c)))


