;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise108-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise108-chapter006

; Q.:
; Design a world program that implements such a pedestrian traffic light. The light switches from its default state when you press the space bar on your keyboard.
; All other transitions must be reactions to clock ticks.


; TrafficLight falls into one of three intervals
; determines the amount of time for the traffic light to burn
; -- 20 through 10 phase for allow the pedestrian to cross the street
; -- 9 through 0 phase for return report informing about the completion of the transition
; -- -1 road crossing ban

(define WIDTH  1000)
(define SCENE-HEIGHT 200)
(define SCENE-BACKGROUND (empty-scene WIDTH SCENE-HEIGHT))

(define IMAGE-STOP (bitmap/file "./images/stop.png"))
(define IMAGE-GO (bitmap/file "./images/go.png"))

(define TEXT-SIZE (/ SCENE-HEIGHT 10))

(define TL-START-COUNTING 20)
(define TL-START-WARNING-COUNTING 9)
(define TL-END-COUNTING 0)
(define TL-STOP-FLAG -1)




(define (main tl)
  (big-bang tl
    [to-draw render]
    [on-tick tock 1]
    [on-key on-pad?]))



; Functions:

; render func for BB TL handler
; TL -> Image

(define (render ws-tl)
  (cond [(<= ws-tl TL-END-COUNTING) (overlay/align
                      "middle" "middle"
                      (above
                       IMAGE-STOP
                       (text "click on the 'space' button" TEXT-SIZE "orange"))
                      SCENE-BACKGROUND)]
        [(and (<= ws-tl TL-START-COUNTING ) (>= ws-tl (+ 1 TL-START-WARNING-COUNTING))) (overlay/align
                                            "middle" "middle"
                                            (above
                                             IMAGE-GO
                                              (text (number->string ws-tl) TEXT-SIZE "green"))
                                            SCENE-BACKGROUND)]
        [(and (<= ws-tl TL-START-WARNING-COUNTING ) (> ws-tl (- TL-END-COUNTING 1))) (overlay/align
                                            "middle" "middle"
                                            (above
                                             IMAGE-GO
                                              (text (number->string ws-tl) TEXT-SIZE (cond [(odd? ws-tl) "orange"]
                                                                                           [(even? ws-tl) "green"])))
                                            SCENE-BACKGROUND)]                                              
        [else (overlay/align
               "middle" "middle"
               (above
                IMAGE-STOP
                (text "error" TEXT-SIZE "orange"))
               SCENE-BACKGROUND)]))



; tock func for BB TL handler
; TL -> TL

;(check-expect (tock -1) -1)
;(check-expect (tock 19) 18)
;(check-expect (tock 0) -1)

(define (tock ws-tl)
  (cond [(< ws-tl TL-END-COUNTING) ws-tl]
        [else (sub1 ws-tl)]))



; render func for BB TL handler
; TL -> Image

;(check-expect (on-pad? -1 " ") 19)
;(check-expect (on-pad? 15 " ") 15)
;(check-expect (on-pad? 15 "k") 15)
;(check-expect (on-pad? -1 "k") -1)

(define (on-pad? ws-tl ke)
  (cond [(and (string=? " " ke) (< ws-tl TL-END-COUNTING)) TL-START-COUNTING]
        [else ws-tl]))