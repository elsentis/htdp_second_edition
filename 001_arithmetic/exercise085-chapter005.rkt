;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise085-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise085-chapter005

; Q.:
; Define the function run. Given the pre field of an editor, it launches an interactive editor, using render and edit from the preceding two exercises for the to-draw and on-key clauses, respectively.


(define SCENE-WIDTH  200)
(define SCENE-HEIGHT 20)

(define SCENE-BACKGROUND (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define SCENE-SIZE-TEXT 11)
(define SCENE-COLOR-TEXT "black")
(define SCENE-CURSOR (rectangle 1 SCENE-HEIGHT "solid" "red"))

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t



; BB World proframm
; a WorldState is a Editor data definition
; consume a String interpretations the 'pre' field of editor type
; interpret a part of editing text before cursor

(define (run str)
  (big-bang (make-editor str "")
    [to-draw render]
    [on-key edit]))



;we use strings to represent a text for showing
;Editor -> Image
;which consumes an Editor and produces an image
; with text from Editor, adding a Cursor

(define (render input-editor)
  (overlay/align "left"
                 "center"
                 (beside (text (editor-pre input-editor) SCENE-SIZE-TEXT SCENE-COLOR-TEXT)
                        SCENE-CURSOR
                         (text (editor-post input-editor) SCENE-SIZE-TEXT SCENE-COLOR-TEXT))
                SCENE-BACKGROUND))



; we use editor to  represent strings of text with cursor
; we use ke to represent action that we must do with text from editor
; Editor, KeyEvent -> Editor
; consumes two inputs, an editor ed and a KeyEvent ke, and it produces another editor

;(check-expect (edit (make-editor "hello " "world") "\t") (make-editor "hello " "world"))
;(check-expect (edit (make-editor "hello " "world") "\r") (make-editor "hello " "world"))
;(check-expect (edit (make-editor "hello " "world") "\b") (make-editor "hello" "world"))
;(check-expect (edit (make-editor "hello " "world") "left") (make-editor "hello" " world"))
;(check-expect (edit (make-editor "hello " "world") "right") (make-editor "hello w" "orld"))
;(check-expect (edit (make-editor "hello " "world") "z") (make-editor "hello z" "world"))

(define (edit ed ke)
  (cond
    [(string=? ke "\t") ed]
    [(string=? ke "\r") ed]
    [(string=? ke "\b") (aux-edit-backpace ed)]
    [(string=? ke "left") (aux-edit-left ed)]
    [(string=? ke "right") (aux-edit-right ed)]
    [(= (string-length ke) 1) (aux-edit-symbol ed ke)]
    [else ed]))



; we use editor to represent text string
; Editor -> Editor
; auxulary func for edit , for handle condition \b from ke

;(check-expect (aux-edit-backpace (make-editor "hello " "world")) (make-editor "hello" "world"))

(define (aux-edit-backpace ed)
  (make-editor
   (string-last-delete (editor-pre ed))
   (editor-post ed)))



; we use string to represent text
; String->String
; aux func for aux-edit-backpace for delete last ch from string

;(check-expect (string-last-delete "hello ") "hello")
;(check-expect (string-last-delete "h") "")

(define (string-last-delete str)
  (substring str 0 (- (string-length str) 1)))



; we use editor to represent text string
; Editor -> Editor
; aux func for edit , for handle condition "left" from ke

;(check-expect (aux-edit-left (make-editor "hello " "world")) (make-editor "hello" " world"))

(define (aux-edit-left ed)
  (make-editor
   (string-last-delete (editor-pre ed))
   (string-append (string-ith (editor-pre ed) (- (string-length (editor-pre ed)) 1))
                  (editor-post ed))))



; we use editor to represent text string
; Editor -> Editor
; aux func for edit , for handle condition "right" from ke

;(check-expect (aux-edit-right (make-editor "hello " "world")) (make-editor "hello w" "orld"))

(define (aux-edit-right ed)
  (make-editor
   (string-append (editor-pre ed)
                  (string-ith (editor-post ed) 0))
   (substring (editor-post ed) 1)))



;we use editor to represent text string
;Editor -> Editor
;aux func for edit , for handle condition edit a symbol after cursor 

;(check-expect (aux-edit-symbol (make-editor "hello " "world") "1") (make-editor "hello 1" "world"))

(define (aux-edit-symbol ed ke)
  (make-editor
   (string-append (editor-pre ed)
                  ke)
   (editor-post ed)))