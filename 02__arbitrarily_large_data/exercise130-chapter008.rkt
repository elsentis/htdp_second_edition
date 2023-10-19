;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise130-chapter008) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise130-chapter008

; Q.:
; Create an element of List-of-names that contains five Strings
; Explain why
; (cons "1" (cons "2" '()))
; is an element of List-of-names and why (cons 2 '()) isn’t



; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name

(cons "Anton" (cons "Ivan" (cons "Boris" (cons "Rebecca" (cons "Paula" '())))))

; Q.:
; Explain why
; (cons "1" (cons "2" '()))
; is an element of List-of-names and why (cons 2 '()) isn’t
; A.:
;
; (cons "1" (cons "2" '()))
; consist from String "1" and (cons "2" '())
; if (cons "2" '()) is an instance of List-of-names
; all piece of data (cons "1" (cons "2" '())) is an instance of List-of-names
; corresponds to first clause in the itemization List-of-names
; (cons "2" '())
; is an instance of List-of-names according second clause in the itemization List-of-names
; therefore
; (cons "1" (cons "2" '())) - is an element of List-of-names
;
; (cons 2 '())
; consist from Number 2 and '()
; while '() is an element of List-of-names according first clause in the itemization List-of-names
; Number or combination of Number and '() is not instance of List-of-names
; ; therefore
; (cons 2 '()) - is not element of List-of-names