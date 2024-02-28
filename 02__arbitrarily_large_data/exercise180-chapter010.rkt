;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise180-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise180-chapter010

; Q.:
; Design editor-text without using implode.



(define HEIGHT 20) ; the height of the editor 
(define WIDTH 200) ; its width 
(define FONT-SIZE 16) ; the font size 
(define FONT-COLOR "black") ; the font color 
 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))


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


; main : String -> Editor
; launches the editor given some initial string 
(define (main s)
   (big-bang (create-editor s "")
     [on-key editor-kh]
     [to-draw editor-render]))


; Editor, KeyEvent -> Editor
; consumes two inputs, an editor ed and a KeyEvent ke, and it produces another editor
(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-lft ed)]
    [(key=? k "right") (editor-rgt ed)]
    [(key=? k "\b") (editor-del ed)]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(= (string-length k) 1) (editor-ins ed k)]
    [else ed]))

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
       (make-editor (rest (editor-pre ed)) (cons (first (editor-pre ed))
                                                       (editor-post ed) ))))
                                              
 
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

; insert the 1String k between pre and post
;
;(check-expect
;  (editor-ins (make-editor '() '()) "e")
;  (make-editor (cons "e" '()) '()))
; 
;(check-expect
;  (editor-ins
;    (make-editor (cons "d" '())
;                 (cons "f" (cons "g" '())))
;    "e")
;  (make-editor (cons "e" (cons "d" '()))
;               (cons "f" (cons "g" '()))))
;
(define (editor-ins ed k)
  (make-editor (cons k (editor-pre ed))
               (editor-post ed)))


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

; Editor -> Image
(define (editor-render e)
  (place-image/align
    (beside (editor-text (reverse (editor-pre e)))
            CURSOR
            (editor-text (editor-post e)))
    1 1
    "left" "top"
    MT))


; Lo1S -> String
; consume Lo1S and produce String from this input Lo1S
; analogue implode (reverce function for string-li1s for me)
;
;(check-expect (string-li1s good) "good")
;
(define(li1s-string l)
  (cond
    [(empty? l) ""]
    [else (string-append (first l) (li1s-string (rest l)))]))


; Lo1s -> Image
; renders a list of 1Strings as a text image 
(define (editor-text s)
  (text (li1s-string s) FONT-SIZE FONT-COLOR))
