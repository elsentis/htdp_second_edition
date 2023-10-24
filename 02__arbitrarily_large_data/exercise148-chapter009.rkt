;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise148-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise148-chapter009

; Q.:
; Compare the function definitions from this section (sum, how-many, all-true, one-true)
; with the corresponding function definitions from the preceding sections.
; Is it better to work with data definitions that accommodate empty lists as opposed to definitions for non-empty lists? Why? Why not?



; It is more convenient to work with non-empty lists because there is no need to define the behavior of the function when working with an empty list.
; Otherwise if information from the real world assumes the presence of an empty definition of data in the list we are need
; empty list data type. (in some cases “a lack of information is also information”)
; in general, we are need to start from the task in data definition, but try to avoid empty lists where they are not required