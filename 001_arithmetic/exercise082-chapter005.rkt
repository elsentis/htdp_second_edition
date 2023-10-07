;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise082-chapter005) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise082-chapter005

; Q.:
; Design the function compare-word. The function consumes two three-letter words (see exercise 78).
; It produces a word that indicates where the given ones agree and disagree.
; The function retains the content of the structure fields if the two agree; otherwise it places #false in the field of the resulting word.
; Hint The exercises mentions two tasks: the comparison of words and the comparison of “letters.”


(define-struct gameword [1-letter 2-letter 3-letter])
; a Gameword is a structure
;     (make-gameword Gameletter Gameletter Gameletter])
; interpretation (make-gameword a b c) is a hidden word for
; a hangman game, with a strict rule of a 3 letters word,
; where a is a first 1Symbol letter, b is second and c is third

; An Gameletter (for hangman game) is one of:
; - a 1String is one of
;                    - "a"
;                    - "b"
;                    ...
;                    - "z"
; - #false
; interpretation a 1String letter for 3-symbol word in hangman game
; respectively the letter represents the value any letter of the alphabet
; and #false in case of failure



; Gameword Gameword -> Gameword
; a function for a compare two gameword hangman game and resume a 3-rd with exit

(check-expect (compare-word (make-gameword "c" "a" "b") (make-gameword "c" "d" "b")) (make-gameword "c" #false "b"))
(check-expect (compare-word (make-gameword "b" "d" "a") (make-gameword "b" "d" "a")) (make-gameword "b" "d" "a"))
(check-expect (compare-word (make-gameword "b" "d" "a") (make-gameword "e" "b" "c")) (make-gameword #false #false #false))


(define (compare-word 1-word 2-word)
  (make-gameword (compare-letter (gameword-1-letter 1-word) (gameword-1-letter 2-word))
                 (compare-letter (gameword-2-letter 1-word) (gameword-2-letter 2-word))
                 (compare-letter (gameword-3-letter 1-word) (gameword-3-letter 2-word))))


; Gameletter, Gameletter -> Gameletter
; helper func for compare-wordfor compare two gamelleter and produce result gameletter

;(check-expect (compare-letter "a" "b") #false)
;(check-expect (compare-letter "a" "a") "a")

(define (compare-letter 1-letter 2-letter)
  (cond [(string=? 1-letter 2-letter) 1-letter]
        [else #false]))


  