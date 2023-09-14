;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise064-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise064-chapter005

; Q.:
; Design the function manhattan-distance, which measures the Manhattan distance of the given posn to the origin.

; Posn -> Number
; compute the Manhattan distance of the given posn to the origin
; The Manhattan distance of a point to the origin considers a path that follows the rectangular grid of streets found in Manhattan

;(check-expect (manhattan-distance-to-0 (make-posn 0 5)) 5)
;(check-expect (manhattan-distance-to-0 (make-posn 7 0)) 7)
;(check-expect (manhattan-distance-to-0 (make-posn 3 4)) 7)
;(check-expect (manhattan-distance-to-0 (make-posn 6 (* 2 4))) 14)
;(check-expect (+ (manhattan-distance-to-0 (make-posn 12 5)) 10) 27)

(define (manhattan-distance-to-0 ap)
  (+ (posn-x ap)
     (posn-y ap)))

