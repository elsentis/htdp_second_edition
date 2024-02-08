;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise145-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise145-chapter009

; Q.:
; Design the sorted>? predicate, which consumes a NEList-of-temperatures
; and produces #true if the temperatures are sorted in descending order.
; That is, if the second is smaller than the first, the third smaller than the second, and so on.
; Otherwise it produces #false.



; An NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of Celsius temperatures

(define ABSOLUTE0 -272)

; A CTemperature is a Number greater than ABSOLUTE0.



; NEList-of-temperatures -> Boolean
; consumes a NEList-of-temperatures
; and produces #true if the temperatures are sorted in descending order
; #false otherwise
;
;        l        (first l)        (rest l)        (sorted>? (rest l))        (sorted>? l)
;
;   (cons 1
;     (cons 2        1               (cons 2               #true                  #false
;        '()))                           '())) 
;
;   (cons 3
;     (cons 2        3              (cons 2                #true                   #true
;      '()))                            '()))
;
;   (cons 0
;     (cons 3        0              (cons 3
;       (cons 2                        (cons 2             #true                   #false
;         '())))                          '()))
;
;
;

(check-expect (sorted>? (cons 0 (cons 3 (cons 2 '())))) #false)
(check-expect (sorted>? (cons 3 (cons 2  '()))) #true)
(check-expect (sorted>? (cons 1 (cons 2  '()))) #false)

(define (sorted>? l)
  (cond
    [(empty? (rest l)) #true]
    [else (cond
            [(> (first l) (first (rest l))) (sorted>? (rest l))]
            [else #false])]))
              