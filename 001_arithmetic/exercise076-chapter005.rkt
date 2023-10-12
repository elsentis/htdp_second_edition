;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise076-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise076-chapter005

; Q.:
; Formulate data definitions for the following structure type definitions
; Make sensible assumptions as to what kind of values go into each field



(define-struct movie [title producer year])
; A Movie is a structure
;     (make-movie String String Number [1900..2050])
; interpretation (make-movie a b c) is a movie with
; title a made by producer b in c year

(define-struct person [name hair eyes phone])
; a Person is a structure
;     (make-person String String String Number (9000000000..9999999999])
; interpretation (make-movie a b c d) is a person whose 
;  name is a, with b color of hair, c color of eyes and
; d phone number

(define-struct pet [name number])
; a Pet is a structure
;     (make-pet String Number [1..9999])
; interpretation (make-pet a b) is the pet of this residential area
; with a a name and b serial number in the database

(define-struct CD [artist title price])
; a CD is a structure
;     (make-CD String String Number [from 0..10000])
; interpretation (make-CD a b c) is a definition of CD in the base
; with base graphs - a is artist, b is title and c is price of this CD

(define-struct sweater [material size producer])
; a Sweater is a structure
;     (make-sweater String String String)
; interpretation (make-sweater a b c) is a sweater
; made of a material and b size, made by c producer

(1 + 1)
