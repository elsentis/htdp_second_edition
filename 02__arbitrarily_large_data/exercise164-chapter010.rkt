;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise164-chapter010) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

; exercise164-chapter010

; Q.:
; Design the function convert-euro, which converts a list of US$ amounts into a list of € amounts.
; Look up the current exchange rate on the web.
; Generalize convert-euro to the function convert-euro*,
; which consumes an exchange rate and a list of US$ amounts
; and converts the latter into a list of € amounts.



; A Dollar-Amount is a NonnegativeNumber
; interpretation the amount of something in a dollars

; A Euro-Amount is a NonnegativeNumber
; interpretation the amount of something in a euro

; A LoDA is one of:
; -- empty
; -- (cons Dollar-Amount LoDA)
; interpretation the list of Dollar-Amount


; A LoEA is one of:
; -- empty
; -- (cons Euro-Amount LoEA)
; interpretation the list of Euro-Amount

(define D-E-EX-RATE 0.92)

; LoDA -> LoEA
; converts a list of US$ amounts into a list of € amounts
;
(check-expect (convert-euro '()) '())
(check-expect
(convert-euro (cons 1 (cons 4.2 (cons 10 '()))))
(cons 0.92 (cons 3.864 (cons 9.2 '()))))
(check-error
 (convert-euro (cons 1 (cons 0 (cons 10 '()))))
 "incorrect input")
;
(define (convert-euro lod)
  (cond
     [(empty? lod) '()]
     [(and
       (positive? (first lod))
       (cons? lod))
      (cons (* D-E-EX-RATE (first lod)) (convert-euro (rest lod)))]
     [else (error "incorrect input")]))


; NonnegativeNumber. LoDA -> LoEA
; consumes an exchange rate and a list of US$ amounts
; and converts the latter into a list of € amounts.
;
(check-expect (convert-euro* D-E-EX-RATE '()) '())
;
(check-expect
 (convert-euro* D-E-EX-RATE (cons 1 (cons 4.2 (cons 10 '()))))
 (cons 0.92 (cons 3.864 (cons 9.2 '()))))
;
(check-error
 (convert-euro* D-E-EX-RATE (cons 1 (cons 0 (cons 10 '()))))
 "incorrect input")
;
(define (convert-euro* ex-rating lod)
  (cond
    [(empty? lod) '()]
    [(and
      (positive? (first lod))
      (cons? lod)
      (positive? ex-rating))
     (cons (* ex-rating (first lod)) (convert-euro* ex-rating (rest lod)))]
    [else (error "incorrect input")]))
  


