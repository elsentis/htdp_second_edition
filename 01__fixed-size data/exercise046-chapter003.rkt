;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise046-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise046-chapter003

; Q.:
; Improve the cat animation with a slightly different image
; Adjust the rendering function from exercise 45 so that it uses one cat image or the other based on whether the x-coordinate is odd
; Read up on odd? in the HelpDesk, and use a cond expression to select cat images.

(define WIDTH  1000)
(define HEIGHT 200)
(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define cat1 (bitmap/file "./images/cat1.png"))
(define cat2 (bitmap/file "./images/cat2.png"))

(define Y-LEVEL-CAT (- HEIGHT (/ (image-height cat1) 2) 1))
(define INCREASE-X-PER-TOCK (/ WIDTH 300))

; cat-prog func
; we use a ws as numb to represent cat world walking as image in action //1 data - inf represent
; Number -> Image //2.1 func sign
; gether all creations in prog func together and do a exit animate //2.2 func purpose
; without examples

(define (cat-prog ws)
  (big-bang ws
    [on-tick tock]
    [to-draw render]))


  
; wishlist
; time - prog tock ++
; render - to draw exit img ++



; Number -> Number
; tock func for BB
; given 0, expected (+ 0 INCREASE-X-PER-TOCK)
; given 100, expected (+ 100 INCREASE-X-PER-TOCK)

(define (tock ws)
  (modulo (round (+ ws INCREASE-X-PER-TOCK)) WIDTH))



; render func
; we get ws in numbers, and exit a img
; Number -> Image
; to draw exit img
; puts the cat1 image in an even coordinate and cat2 image in an odd one

(define (render ws)
  (if (even? ws)
      (place-image cat1 ws Y-LEVEL-CAT BACKGROUND)
      (place-image cat2 ws Y-LEVEL-CAT BACKGROUND)))
  
  

