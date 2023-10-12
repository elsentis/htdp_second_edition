;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise109-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise109-chapter006

; Q.:
; Design a world program that recognizes a pattern in a sequence of KeyEvents. Initially the program shows a 100 by 100 white rectangle.
; Once your program has encountered the first desired letter, it displays a yellow rectangle of the same size.
; After encountering the final letter, the color of the rectangle turns green. If any “bad” key event occurs, the program displays a red rectangle.
; The specific sequences that your program looks for start with "a", followed by an arbitrarily long mix of "b" and "c", and ended by a "d".
; Clearly, "acbd" is one example of an acceptable string; two others are "ad" and "abcbbbcd". Of course, "da", "aa", or "d" do not match.

(define SIDE 100)

; a GameState from a three state
; -- AA, a game waiting for first symbol input
; -- BB, valid character entered waiting for next valid characters or end character
; -- DD, program end character entered
; -- ER, invalid character entered
(define AA "start, expect an 'a'")
(define BB "expect 'b', 'c', or 'd'")
(define DD "finished")
(define ER "error, illegal key")

; a GameSymbols is one of
; -- "a" for first symbol input for start the game
; -- "b" one of two characters from the game body sequence
; -- "c" one of two characters from the game body sequence
; -- "d" character to exit the game sequence
(define S-AA-BB "a")
(define S-BB-BB-1 "b")
(define S-BB-BB-2 "c")
(define S-BB-DD "d")


; a WorldState for main func is GameState
(define (main gs)
  (big-bang gs
    [to-draw render]
    [on-key on-pad?]))

; Functions:


; render func for BB, consume a GameState and produce an img
; GameState -> IMG
 
(define (render gs)
  (rectangle SIDE
             SIDE
             "outline"
             (cond [(string=? gs AA) "white"]
                   [(string=? gs BB) "yellow"]
                   [(string=? gs DD) "green"]
                   [(string=? gs ER) "red"])))



; func for BB for process the character entered into the game and return the next GameState
; GameState, String -> GameState

;(check-expect (on-pad? AA "a") BB)
;(check-expect (on-pad? AA "b") ER)
;(check-expect (on-pad? AA "f") ER)
;(check-expect (on-pad? BB "a") ER)
;(check-expect (on-pad? BB "b") BB)
;(check-expect (on-pad? BB "d") DD)
;(check-expect (on-pad? DD "d") AA)
;(check-expect (on-pad? ER " ") AA)

(define (on-pad? gs ke)
  (cond [(string=? gs AA)
         (cond [(string=? ke S-AA-BB) BB]
               [else ER])]
        [(string=? gs BB)
         (cond [(or (string=? ke S-BB-BB-1) (string=? ke S-BB-BB-2)) BB]
               [(string=? ke S-BB-DD) DD]
               [else ER])]
        [(string=? gs DD) AA]
        [(string=? gs ER) AA]))