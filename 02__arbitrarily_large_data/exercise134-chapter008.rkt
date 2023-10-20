;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise134-chapter008) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise134-chapter008

; Q.:
; Develop the contains? function, which determines whether some given string occurs on a given list of strings
; Don’t use member? to define the contains? function



;; A List-of-strings is one of: 
; – '()
; – (cons String List-of-strings)
;
; interpretation a list of some stings


; String, List-of-strings -> Boolean
; determines whether given String s is on a given List-of-string alos
;
(check-expect (contains? "anton" (cons "boris" (cons "ivan" (cons "anton" '())))) #true)
(check-expect (contains? "anton" (cons "boris" (cons "ivan" (cons "rebecca" '())))) #false)
(check-expect (contains? "anton" '()) #false)
;
(define (contains? s alos)
  (cond
    [(empty? alos) #false]
    [(cons? alos) (cond
                    [(string=? (first alos) s) #true]
                    [else (contains? s (rest alos))])]))


