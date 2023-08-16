;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise054-chapter004) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise054-chapter004

; Q.:
; Why would it be incorrect to use (string=? "resting" x) as the first condition in show?
; Conversely, formulate a completely accurate condition, that is, a Boolean expression that evaluates to #true precisely when x belongs to the first sub-class of LRCD.


; (define (show x)
;   (cond
;     [(string? x) ...]
;     [(<= -3 x -1) ...]
;     [(>= x 0) ...]))



; Why would it be incorrect to use (string=? "resting" x) as the first condition in show?

; if we have a numeric state of LR (for denote countdown or flight coordinates)
; first question-expression of cond return a error message instead #false
; program execution will be interrupted
; we must use (string? x) or more accurate question-expression of cond
; for definition of the first state of LR in cond
; for continue checking LR state in case of string validation failure



; Conversely, formulate a completely accurate condition, that is, a Boolean expression that evaluates to #true precisely when x belongs to the first sub-class of LRCD.

; (define (show x)
;   (cond
;     [(and (string? x) (string=? "resting" x)) ...]
;     [(<= -3 x -1) ...]
;     [(>= x 0) ...]))