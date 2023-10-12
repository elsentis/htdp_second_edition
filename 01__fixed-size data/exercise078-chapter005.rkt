;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise078-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise078-chapter005

; Q.:
; Provide a structure type and a data definition for representing three-letter words.
; A word consists of lowercase letters, represented with the 1Strings "a" through "z" plus #false.

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