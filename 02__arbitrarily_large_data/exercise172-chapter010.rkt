;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise172-chapter010) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise172-chapter010

; Q.:
; Design the function collapse, which converts a list of lines into a string.
; The strings should be separated by blank spaces (" ").
; The lines should be separated with a newline ("\n").


; An Los (List-of-String) 
; is one of: 
; – '() 
; – (cons String Los)

; An LN is one of: 
; – '()
; – (cons Los LN)
; interpretation a list of lines, each is a list of Strings


(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
 
(define ln0 '())
(define ln1 (cons line0 (cons line1 '())))

; LN -> String
; convert a list of lines into a string
; The strings should be separated by blank spaces (" ").
; The lines should be separated with a newline ("\n")
;
;(check-expect (collapse ln0) "\n") 
(check-expect (collapse ln1) "hello world\n\n")
;
(define (collapse lls)
  (cond
    [(empty? lls) ""]
    [else
     (string-append (aux-collapse-string (first lls))
                    (collapse (rest lls)))]))


; Los -> String
; aux func for collapse for processing a single line
;
;(check-expect (aux-collapse-string line0) "hello world\n")
;(check-expect (aux-collapse-string line1) "\n")
;
(define (aux-collapse-string los)
  (cond
    [(empty? los) "\n"]
    [else
     (string-append (first los)
                    (if (empty? (rest los)) "" " ")
                    (aux-collapse-string (rest los)))]))


(write-file "ttt.dat"
            (collapse (read-words/line "ttt.txt")))

