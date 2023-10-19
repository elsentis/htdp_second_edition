;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise129-chapter008) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise129-chapter008

; Q.:
; Create BSL lists that represent
; Sketch some box representations of these lists, similar to those in figures 44 and 45. Which of the sketches do you like better?



; 1. a list of celestial bodies, say, at least all the planets in our solar system

(cons "Neptune"
      (cons "Uranus"
            (cons "Saturn"
                  (cons "Jupiter"
                        (cons "Mars"
                              (cons "Earth"
                                    (cons "Venus"
                                          (cons "Mercury"
                                                '()))))))))


; 2. a list of items for a meal, for example, steak, french fries, beans, bread, water, Brie cheese, and ice cream

(cons "steak"
      (cons "french fries"
            (cons "beans"
                  (cons "bread"
                        (cons "water"
                              (cons "Brie cheese"
                                    (cons "ice cream"
                                          '())))))))


; 3. a list of colors

(cons "red"
      (cons "green"
            (cons "blue"
                  '())))

; Q.:
; Sketch some box representations of these lists, similar to those in figures 44 and 45. Which of the sketches do you like better?
; A.:
; preferred for visulisation of list is form where in each cons structure becomes a separate box and boxes located in the order in which they are consed together
                  