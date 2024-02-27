;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise179-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise179-chapter010

; Q.:
; Design the functions
; Again, it is critical that you work through a good range of examples.


(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)

; Lo1s -> Lo1s 
; produces a reverse version of the given list 
; 
;(check-expect
;  (rev (cons "a" (cons "b" (cons "c" '()))))
;  (cons "c" (cons "b" (cons "a" '()))))
; 
(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end (rev (rest l)) (first l))]))


; Lo1s 1String -> Lo1s
; creates a new list by adding s to the end of l
; 
;(check-expect
;  (add-at-end (cons "c" (cons "b" '())) "a")
;  (cons "c" (cons "b" (cons "a" '()))))
; 
(define (add-at-end l s)
  (cond
    [(empty? l) (cons s '())]
    [else
     (cons (first l) (add-at-end (rest l) s))]))

; String, String -> Editor
; consumes two strings and produces an Editor
; (the letters in pre precede the cursor presented in reverse order)
;
;(check-expect (create-editor "all" "good") ed2)
;(check-expect (create-editor "" "") (make-editor '() '()))
;(check-expect (create-editor "ab" "c") (make-editor (cons "b" (cons "a" '())) (cons "c" '())))
;
(define (create-editor s1 s2)
  (make-editor (rev (string-li1s s1)) (string-li1s s2)))

; String -> Lo1S
; consume String and produce Lo1S from this input String
;
;(check-expect (string-li1s "good") good)
;
(define (string-li1s s)
  (cond
    [(<= (string-length s) 0) '()]
    [else (cons (string-ith s 0) (string-li1s (substring s 1)))]))


 
; data example 1: 
(define ed1 (create-editor "all" "good"))
 
; data example 2:
(define ed2 (create-editor "" "good"))

; data example 3:
(define ed3 (create-editor "good" ""))


; Editor -> Editor
; moves the cursor position one 1String left, 
; if possible
;
;(check-expect (editor-lft ed1) (create-editor "al" "lgood"))
;(check-expect (editor-lft ed2) ed2)
;(check-expect (editor-lft ed3) (create-editor "goo" "d"))
;
(define (editor-lft ed)
  (if (empty? (editor-pre ed))
       ed
       (make-editor (rest (editor-pre ed)) (cons (first (editor-pre ed)) (editor-post ed) ))))
                                              
 
; Editor -> Editor
; moves the cursor position one 1String right, 
; if possible
;
;(check-expect (editor-rgt ed1) (create-editor "allg" "ood"))
;(check-expect (editor-rgt ed2) (create-editor "g" "ood"))
;(check-expect (editor-rgt ed3) ed3)
;
(define (editor-rgt ed)
  (if (empty? (editor-post ed))
      ed
      (make-editor (cons (first (editor-post ed)) (editor-pre ed) )
                   (rest (editor-post ed)))))
 
; Editor -> Editor
; deletes a 1String to the left of the cursor,
; if possible
;
;(check-expect (editor-del ed1) (create-editor "al" "good"))
;(check-expect (editor-del ed2) ed2)
;(check-expect (editor-del ed3) (create-editor "goo" ""))
;
(define (editor-del ed)
  (if (empty? (editor-pre ed))
      ed
      (make-editor (rest (editor-pre ed))
                   (editor-post ed))))

