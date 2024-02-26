;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise178-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise178-chapter010

; Q.:
; Explain why the template for editor-kh deals
; with "\t" and "\r" before it checks for strings of length 1.

; A.:
; Separate clause for handling keyboard events "\t" and "\r" they are located before
; processing notifying about entering a single character keyboard events, because,
; despite that these characters are also represented by a string with a length of 1,
; they are the control characters and their effect will be different
; (in case \t horizontal tabulation, in case \r moving the print position to the leftmost position)
; from just adding a single character.
; Location of event handlers for "\t" and "\r" keyboard events before checking a string
; with a length of 1 it is necessary in order to prevent the function from mistaking
; control characters for single text characters.