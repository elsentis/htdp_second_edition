;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise088-chapter005) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise088-chapter005

; Q.:
; Define a structure type that keeps track of the cat’s x-coordinate and its happiness.
; Then formulate a data definition for cats, dubbed VCat, including an interpretation.

; H is a Number between [0..100].
; interpretation represents a happiness value

; X-coord is a Number
; interpretation represents a object location coordinate


(define-struct vcat (x hap))
;; A VCat is a structure:
;;   (make-vcat Image Track)
;; interp. a virtual cat, including 
;;         information about its movement and happiness and path direction
;;         x is the X-coord of the cat on the screen
;;         hap is its happiness H