;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise072-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise072-chapter005

; Q.:
; Formulate a data definition for the above phone structure type definition that accommodates the given examples
; Next formulate a data definition for phone numbers using this structure type definition
; (define-struct phone# [area switch num])
; Historically, the first three digits make up the area code, the next three the code for the phone switch (exchange) of your neighborhood,
; and the last four the phone with respect to the neighborhood. Describe the content of the three fields as precisely as possible with intervals.


(define-struct phone [area] [number])
; an Phone is a structure
;     (make-phone Number String)
; interpretation a area code and the local number

(define-struct phone# [area switch num])
; an Phone# is a structure
;     (make-phone# Number Number Number)
; interpretation a area code (000..999), phone switch (exchange) (000..999) and the local number (0000..9999)