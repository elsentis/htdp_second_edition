;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise174-chapter010  encode-file|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

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
(define line2 (cons "t" (cons "w" (cons "a" (cons "b" (cons "h" '()))))))
(define line3 (cons "an" (cons "wht" '())))

(define lls0 (cons line0 (cons line1 '())))
(define lls1 (cons line1 (cons line2 '())))
(define lls3 (cons line2 (cons line0 '())))
(define lls4 (cons line3 (cons line0 '())))

; LN -> String
; aux func for encode
; for procissing a hole text from file
; encoding each letter in a word  as a numeric three-letter string
;
(check-expect (aux-encode-file lls4) (string-append (encode-letter "a")
                                                    (encode-letter "n")
                                                    (encode-letter " ")
                                                    (encode-letter "w")
                                                    (encode-letter "h")
                                                    (encode-letter "t")
                                                    (encode-letter "\n")
                                                    (encode-letter "a")
                                                    (encode-letter " ")
                                                    (encode-letter "w")
                                                    (encode-letter "\n")))
(check-expect (aux-encode-file lls1) (string-append (encode-letter "\n")
                                                   (encode-letter "t")
                                                   (encode-letter " ")
                                                   (encode-letter "w")
                                                   (encode-letter " ")
                                                   (encode-letter "a")
                                                   (encode-letter " ")
                                                   (encode-letter "b")
                                                   (encode-letter " ")
                                                   (encode-letter "h")
                                                   (encode-letter "\n")))
;
(define (aux-encode-file lls)
  (cond
    [(empty? lls) ""]
    [else
     (string-append (aux-encode-string (first lls)) (aux-encode-file (rest lls)))]))


; Los -> String
; aux func for encode
; for processing a single line
; convert a  line into a string with encoding letters
;
;(check-expect (aux-encode-string line0) (string-append (encode-letter "a")
;                                                       (encode-letter " ")
;                                                       (encode-letter "w")
;                                                       (encode-letter "\n")))
;                                                       
;                             
;(check-expect (aux-encode-string line1) (encode-letter "\n"))
;(check-expect (aux-encode-string line2) (string-append (encode-letter "t")
;                                                       (encode-letter " ")
;                                                       (encode-letter "w")
;                                                       (encode-letter "d")
;                                                       (encode-letter " ")
;                                                       (encode-letter "a")
;                                                       (encode-letter " ")
;                                                       (encode-letter "b")
;                                                       (encode-letter " ")
;                                                       (encode-letter "h")
;                                                       (encode-letter "\n")))
;
(define (aux-encode-string los)
  (cond
    [(empty? los) (encode-letter "\n")]
    [else
     (string-append (aux-encode-word (explode (first los)))
                    (if (empty? (rest los)) "" (encode-letter " "))
                    (aux-encode-string (rest los)))]))


; LoS -> String
; aux func for encode
; for processing a single word (presented as list of 1-letter strings)
; convert a  word into a string with encoding letters
;
;(check-expect (aux-encode-word (cons "a" '())) (encode-letter "a"))
;(check-expect (aux-encode-word (cons "w"
;                                     (cons "o"
;                                           (cons "r"
;                                                 (cons "d" '())))))
;              (string-append (encode-letter "w") (encode-letter "o")
;                              (encode-letter "r") (encode-letter "d")))
;
(define (aux-encode-word los)
  (cond
    [(empty? los) ""]
    [else
     (string-append (encode-letter (first los)) (aux-encode-word (rest los)))]))

; 1String -> String
; converts the given 1String to a 3-letter numeric String
; 
;(check-expect (encode-letter "z") (code1 "z"))
;(check-expect (encode-letter "\t")
;              (string-append "00" (code1 "\t")))
;(check-expect (encode-letter "a")
;              (string-append "0" (code1 "a")))
; 
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))


; 1String -> String
; converts the given 1String into a String
; 
;(check-expect (code1 "z") "122")
; 
(define (code1 c)
  (number->string (string->int c)))

