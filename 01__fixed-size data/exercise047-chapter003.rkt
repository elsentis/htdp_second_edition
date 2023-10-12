;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise047-chapter003) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise047-chapter003

; Q.:
; Design a world program that maintains and displays a “happiness gauge.”
; Let’s call it gauge-prog, and let’s agree that happiness is a number between 0 and 100 (inclusive).

(define H-LOW-LIMIT 0)
(define H-MAX-LIMIT 100)

(define WIDTH   (* 10 H-MAX-LIMIT)) ;multiply by 10 for scale scalability
(define HEIGHT 100)
(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define DECREASE-H-PER-TOCK (/ H-MAX-LIMIT 1000))
(define COEFFICIENT-FOR-UP-KEY (/ 1 3))
(define COEFFICIENT-FOR-DOWN-KEY (/ 1 5))


(define (gauge-prog ws)
   (big-bang ws
     [on-tick tock]
     [on-pad hand-pad]
     [to-draw render]
     [stop-when end?]))


; Functions:

; we use H to represent a scale with gauge happiness 
; Number -> Number
; func for tock for change ws

(define (tock hap)
  (cond [(< (- hap DECREASE-H-PER-TOCK) H-LOW-LIMIT) H-LOW-LIMIT]
        [else (- hap DECREASE-H-PER-TOCK)]))



; Number, String  -> Number
; aux func for on-pad for compute hap depending on keystrokes
; func for respond to key presses
; up arrow - hap jumps by 1/3
; down arrow - hap decreases by 1/5

(define (hand-pad hap ke)
  (cond [(string=? "up" ke)
         (cond [(> (+ hap (* hap COEFFICIENT-FOR-UP-KEY)) H-MAX-LIMIT) H-MAX-LIMIT]
               [else (+ hap (* hap COEFFICIENT-FOR-UP-KEY))])]
        [(string=? "down" ke) (- hap (* hap COEFFICIENT-FOR-DOWN-KEY))]
        [else hap]))



; render func for BB
; Number -> Image
; consume a ws (hap as number) and produce an image
; with happiness gauge

(define (render hap)
  (overlay/align "left"
                 "middle"
                 (rectangle (* 10 hap) HEIGHT "solid" "red") ;multiply by 10 for scale scalability
                 BACKGROUND))



; end? func for BB
; Number -> Boolean
; consume a ws (hap as number) and produce a boolean
; if (<= ws 0) return #true (end of programm)

(define (end? hap)
  (cond [(<= hap H-LOW-LIMIT) #true]
        [else #false])) 
