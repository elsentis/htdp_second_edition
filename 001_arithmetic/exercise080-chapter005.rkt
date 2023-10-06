;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise080-chapter005) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise080-chapter005

; Q.:
; Create templates for functions that consume instances of the following structure types
; No, you do not need data definitions for this task.


(define-struct movie [title director year])

; Movie -> String
; displays an information line about the movie from Movie

(define (movie-string-handler m)
  (... (movie-title m) ... (movie-director m) ... (movie-year m)))



(define-struct pet [name number])

; Pet -> Boolean
; consume two instances of Pet and return #true if name and number match
; #false otherwise

(define (pet-comparator p-1 p-2)
  (... (... (pet-name p-1) ... (pet-name p-2))
       (... (pet-number p-1) ... (pet-number p-2))
       ...)
  )
   