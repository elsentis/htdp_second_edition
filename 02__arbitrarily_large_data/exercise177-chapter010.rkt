
; exercise177-chapter010

; Q.:
; Design the function create-editor. The function consumes two strings and produces an Editor.
; The first string is the text to the left of the cursor and the second string
; is the text to the right of the cursor. The rest of the section relies on this function.
; (the letters in pre precede the cursor presented in reverse order)

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – '()
; – (cons 1String Lo1S)
; (the letters in pre precede the cursor presented in reverse order)

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
(check-expect (create-editor "all" "good") ed2)
(check-expect (create-editor "" "") (make-editor '() '()))
(check-expect (create-editor "ab" "c") (make-editor (cons "b" (cons "a" '())) (cons "c" '())))
;
(define (create-editor s1 s2)
  (make-editor (rev (string-li1s s1)) (string-li1s s2)))

; String -> Lo1S
; consume String and produce Lo1S from this input String
;
(check-expect (string-li1s "good") good)
;
(define (string-li1s s)
  (cond
    [(<= (string-length s) 0) '()]
    [else (cons (string-ith s 0) (string-li1s (substring s 1)))]))


; Lo1s -> Lo1s 
; produces a reverse version of the given list 
 
(check-expect
  (rev (cons "a" (cons "b" (cons "c" '()))))
  (cons "c" (cons "b" (cons "a" '()))))
 
(define (rev l)
  (cond
    [(empty? l) '()]
    [else (add-at-end (rev (rest l)) (first l))]))


; Lo1s 1String -> Lo1s
; creates a new list by adding s to the end of l
 
(check-expect
  (add-at-end (cons "c" (cons "b" '())) "a")
  (cons "c" (cons "b" (cons "a" '()))))
 
(define (add-at-end l s)
  (cond
    [(empty? l) (cons s '())]
    [else
     (cons (first l) (add-at-end (rest l) s))]))

                              
