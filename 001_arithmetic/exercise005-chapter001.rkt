;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname chapter001-exercise005) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise005-chapter001

; Q:
; create the image of a simple boat or tree, you can easily change the scale of the entire image

(define SIZE-BOAT 1)

(define BOAT (polygon (list (make-posn 0 0)
                            (make-posn (* 20 SIZE-BOAT) (* 60 SIZE-BOAT))
                            (make-posn (* 160 SIZE-BOAT)  (* 60 SIZE-BOAT))
                            (make-posn (* 300 SIZE-BOAT) 0))
                      "solid"
                      "burlywood"))
                      

(define SIZE-TREE 1)

(define TREE (above
              (circle (* 40 SIZE-TREE) "solid" "green")
              (rectangle (* 20 SIZE-TREE) (* 75 SIZE-TREE) "solid" "saddle brown")))
              
                            


