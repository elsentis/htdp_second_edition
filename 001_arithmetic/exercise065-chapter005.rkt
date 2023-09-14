;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise065-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise065-chapter005

; Q.:
; Take a look at the following structure type definitions
; Write down the names of the functions (constructors, selectors, and predicates) that each introduces.



(define-struct movie [title producer year])

; (define m-1 (make-movie "revolver" "guy ritchie" 2005)) ;; constructor
; (movie-title m-1) ;; selector
; (movie-producer m-1) ;; selector
; (movie-year m-1) ;; selector
; (movie? m-1) ;; structure predicate


(define-struct person [name hair eyes phone])

; (define p-1 (make-person "ivan" "black" "brown" 222)) ;; constructor
; (person-name p-1) ;; selector
; (person-hair p-1) ;; selector
; (person-eyes p-1) ;; selector
; (person-phone p-1) ;; selector
; (person? p-1) ;; structure predicate


(define-struct pet [name number])

; (define dog-1 (make-pet "flo" 1)) ;; constructor
; (pet-name dog-1) ;; selector
; (pet-number dog-1) ;; selector
; (pet? dog-1) ;; structure predicate


(define-struct CD [artist title price])

; (define karate-smo (make-CD "smo" "karate" "2.99")) ;; constructor
; (CD-artist karate-smo) ;; selector
; (CD-title karate-smo) ;; selector
; (CD-price karate-smo) ;; selector
; (CD? karate-smo) ;; structure predicate


(define-struct sweater [material size producer])

; (define sweater-for-winter (make-sweater  "wool" "l" "z")) ;; constructor
; (sweater-material sweater-for-winter) ;; selector
; (sweater-size sweater-for-winter) ;; selector
; (sweater-producer sweater-for-winter) ;; selector
; (sweater? sweater-for-winter) ;; structure predicate

