;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise171-chapter010) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise171-chapter010

; Q.:
; You know what the data definition for List-of-strings looks like.
; Spell it out.
; Make sure that you can represent Piet Hein’s poem
; as an instance of the definition where each line is represented
; as a string and another instance where each word is a string.
; Use read-lines and read-words to confirm your representation choices.
; Next develop the data definition for List-of-list-of-strings.
; Again, represent Piet Hein’s poem as an instance of the definition
; where each line is represented as a list of strings, one per word,
; and the entire poem is a list of such line representations.
; You may use read-words/line to confirm your choice.


; Q.:
; You know what the data definition for List-of-strings looks like.
; Spell it out.
; Make sure that you can represent Piet Hein’s poem
; as an instance of the definition where each line is represented
; as a string and another instance where each word is a string.
; Use read-lines and read-words to confirm your representation choices.

; A List-of-strings is one of
; -- '()
; -- (cons String List-of-strings)

; A.:
; an instance of the definition where each line is represented as a string:
; each separate line of text (even an empty one) is a separate element of a one-dimensional list
;
;(read-lines "ttt.txt")
;(cons  "  " (cons "" (cons "  TTT" (cons "" (cons "  " (cons ""
;(cons "  Put up in a place" (cons "" (cons "  where it's easy to see" ...

; A.:
; an instance of the definition where each word is represented as a string:
; there is also a one-dimensional list, where each individual element is a separate word of the text
; (words in the text are separated by spaces and newlines and tabs).
; there is no line division feature in the list itself, only individual words
; 
;(read-words "ttt.txt")
; (cons "TTT" (cons "Put" (cons "up" (cons "in" (cons "a" (cons
; "place" (cons "where" (cons "it's" (cons "easy" (cons "to" (cons
; "see" (cons "the" (cons "cryptic"


; Q.:
; Next develop the data definition for List-of-list-of-strings.
; Again, represent Piet Hein’s poem as an instance of the definition
; where each line is represented as a list of strings, one per word,
; and the entire poem is a list of such line representations.
; You may use read-words/line to confirm your choice.

; A List-of-list-of-strings is one of
; -- '()
; -- (cons List-of-strings List-of-list-of-strings)

; A.:
; each element of the list is a separate list
; (in which each individual element is a string - a separate word of the text)
; a sign of separation by lines in the text - each line is a separate list inside an external list 

(read-words/line "ttt.txt")
;(cons '() (cons '() (cons (cons "TTT" '()) (cons '() (cons '()
;(cons '() (cons (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '())))))
;(cons '() (cons (cons "where" (cons "it's"  (cons "easy" (cons "to" (cons "see" '())))))