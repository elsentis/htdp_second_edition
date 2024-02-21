;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise174-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

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


; String (name of file) -> String (name of file)
; encodes text files numerically.
; Each letter in a word should be encoded as a numeric three-letter string
; with a value between 0 and 256.
;
(define (encode f)
  (if (file-exists? f)
      (write-file
       (string-append "encode-" f)
       (aux-encode-file (read-words/line f)))))


; LN -> String
; aux func for encode
; convert a list of lines into a string with encoding letters
;
(check-expect (aux-encode-file lls0)
              "a w\n\n"
              (string-append (code1 "a")
                             (code1 " ")
                             (code1 "w")
                             (code1 "\n")
                             (code1 "\n")))
;
(define (aux-encode-file lls)
  (cond
    [(empty? lls) ""]
    [else
     (string-append (aux-encode-string (first lls))
                    (aux-encode-file (rest lls)))]))


; Los -> String
; aux func for encode
; for processing a single line
; convert a  line into a string with encoding letters
;
(check-expect (aux-encode-string line0) (string-append (code1 "a")
                                                       (code1 " ")
                                                       (code1 "w")
                                                       (code1 "\n")))
                                                       
                             
(check-expect (aux-encode-string line1) "\n")
(check-expect (aux-encode-string line2) "world big hope\n")
;
(define (aux-remove-articles-string los)
  (cond
    [(empty? los) "\n"]
    [else
     (string-append (if (member? (first los)articles-keeper) "" (first los))
                    (if (or (empty? (rest los)) (member? (first los)articles-keeper)) "" " ")
                    (aux-remove-articles-string (rest los)))]))

https://habr.com/ru/articles/794963/
