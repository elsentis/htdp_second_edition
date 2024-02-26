;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise177-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise177-chapter010

; Q.:
; Design the function create-editor. The function consumes two strings and produces an Editor.
; The first string is the text to the left of the cursor and the second string
; is the text to the right of the cursor. The rest of the section relies on this function.

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

(define good
  (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all
  (cons "a" (cons "l" (cons "l" '()))))
(define lla
  (cons "l" (cons "l" (cons "a" '()))))
 
; data example 1: 
(define ed1 (make-editor all good))
 
; data example 2:
(define ed2 (make-editor lla good))


; String, String -> Editor
; consumes two strings and produces an Editor
;
(check-expect (create-editor "all" "good") ed1)
(check-expect (create-editor "" "") (make-editor '() '()))
(check-expect (create-editor "ab" "c") (make-editor (cons "a" (cons "b" '())) (cons "c" '())))
;
(define (create-editor s1 s2)
  (make-editor (string-li1s s1) (string-li1s s2)))

; String -> Lo1S
; consume String and produce Lo1S from this input String
;
(check-expect (string-li1s "good") good)
;
(define (string-li1s s)
  (cond
    [(<= (string-length s) 0) '()]
    [else (cons (string-ith s 0) (string-li1s (substring s 1)))]))
                              
