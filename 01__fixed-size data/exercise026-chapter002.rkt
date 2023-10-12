;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise026-chapter002) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise026-chapter002

; Q.:
; What do you expect as the value of this program
; Confirm your expectation with DrRacket and its stepper


(define (string-insert s i)
  (string-append (substring s 0 i)
                 "_"
                 (substring s i)))


(string-insert "helloworld" 6)

; "hellow_orld"