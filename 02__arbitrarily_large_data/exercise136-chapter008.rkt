;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise136-chapter008) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise136-chapter008

; Q.:
; Validate with DrRacket’s stepper
; (our-first (our-cons "a" '())) == "a"
; (our-rest (our-cons "a" '())) == '()



(define-struct pair [left right])
; A ConsPair is a structure:
;   (make-pair Any Any).
 
; Any Any -> ConsPair
(define (our-cons a-value a-list)
  (make-pair a-value a-list))

; ConsOrEmpty -> Any
; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))

; ConsOrEmpty -> Any
; extracts the right part of the given pair
(define (our-rest a-list)
  (if (empty? a-list)
      a-list
      (pair-right a-list)))


; (our-first (our-cons "a" '())) == "a"
; (our-rest (our-cons "a" '())) == '()
; (our-rest '()) == '()
; (our-first '()) == error 'our-first "..."

