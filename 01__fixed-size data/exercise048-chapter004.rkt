;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise048-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise048-chapter004

; Enter the definition of reward followed by (reward 18) into the definitions area of DrRacket and use the stepper to find out how DrRacket evaluates applications of the function.


; in this func numbers represent numbers of points getting by user
; number -> string
; compute a award of end game and show string

; given 3, expect "bronze"
; given 14, expect "silver"
; given 24, expect "gold"

(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [else "gold"]))

;(reward "a")
;(reward 0)
;(reward 18)
;(reward 39)