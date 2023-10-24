;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise142-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise142-chapter009

; Q.:
; Design the ill-sized? function, which consumes a list of images loi and a positive number n.
; It produces the first image on loi that is not an n by n square; if it cannot find such an image, it produces #false.



; A List-of-images is one of: 
; – '()
; – (cons Image List-of-images)
; interpretation - a list of some images

; ImageOrFalse is one of:
; – Image
; – #false


; List-of-images, Number -> ImageOrFalse
; produces the first image on List-of-images loi that is not an Number n by Number n square
; #false if cannot find such an image

(check-expect (ill-sized? '() 5) #false)
(check-expect (ill-sized? (cons (square 5 "solid" "green")
                                     (cons (square 6 "outline" "blue")
                                           (cons (circle 3 "solid" "green") '()))) 5) (square 6 "outline" "blue"))
(check-expect (ill-sized? (cons (square 5 "solid" "green")
                                     (cons (square 5 "outline" "blue")
                                           (cons (square 5 "solid" "green") '()))) 5) #false)

(define (ill-sized? loi n)
  (cond
    [(empty? loi) #false]
    [(cons? loi) (cond
                   [(and (= (image-width (first loi)) n)
                         (= (image-height (first loi)) n)) (ill-sized? (rest loi) n)]
                   [else (first loi)])])) 

