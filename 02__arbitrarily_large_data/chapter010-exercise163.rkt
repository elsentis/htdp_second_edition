;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter010-exercise163) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; chapter010-exercise163

; Q.:
; Design convertFC.
; The function converts a list of measurements in Fahrenheit to a list of Celsius measurements.


; A Fahrenheit fall into interval:
; -- 32 to 212
; interpretation the value of temperatures on the Fahrenheit scale
(define FAHRENHEIT-LOW-LIMIT 32)
(define FAHRENHEIT-UPPER-LIMIT 212)

; A Celcius is a Number
; interpretation the value of temperatures on the Celsius scale

; A LoF is one of:
; -- empty
; -- (cons Fahrenheit LoF)
; interpretation the list of values of temperatures on the Fahrenheit scale

; A LoC is one of:
; -- empty
; -- (cons Celcius LoC)
; interpretation the list of values of temperatures on the Celcius scale


; Lof -> LoC
; convert all values of temperatures on the Fahrenheit scale from input list
; to values of temperatures on the Celsius scale
;
(check-expect (convertFC '()) '())
(check-expect (convertFC (cons 50 (cons 34 (cons 190 '()))))
              (cons (C 50) (cons (C 34) (cons (C 190) '()))))
;
(define (convertFC f)
  (cond
   [(empty? f) '()]
   [(or (< (first f) FAHRENHEIT-LOW-LIMIT)
        (> (first f) FAHRENHEIT-UPPER-LIMIT)) (error "incorrect input, exceeding the allowed value")]
   [else (cons (C (first f)) (convertFC (rest f)))]))


; converts a temperature measured on a Fahrenheit thermometer into a Celsius temperature
(define (C f)
  (* 5/9 (- f 32)))
