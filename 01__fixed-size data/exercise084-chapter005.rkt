;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise084-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise084-chapter005

; Q.:
; Design edit. The function consumes two inputs, an editor ed and a KeyEvent ke, and it produces another editor.
; Its task is to add a single-character KeyEvent ke to the end of the pre field of ed, unless ke denotes the backspace ("\b") key.
; In that case, it deletes the character immediately to the left of the cursor (if there are any). The function ignores the tab key ("\t") and the return key ("\r").
; The function pays attention to only two KeyEvents longer than one letter: "left" and "right".
; The left arrow moves the cursor one character to the left (if any), and the right arrow moves it one character to the right (if any). All other such KeyEvents are ignored.

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t



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
  (cond [(> (string-length (editor-pre ed)) 0) (make-editor
                                                (string-last-delete (editor-pre ed))
                                                (editor-post ed))]
        [else ed]))



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
  (cond [(> (string-length (editor-pre ed)) 0)
         (make-editor
          (string-last-delete (editor-pre ed))
          (string-append (string-ith (editor-pre ed) (- (string-length (editor-pre ed)) 1)) (editor-post ed)))]
        [else ed]))



; we use editor to represent text string
; Editor -> Editor
; aux func for edit , for handle condition "right" from ke

;(check-expect (aux-edit-right (make-editor "hello " "world")) (make-editor "hello w" "orld"))

(define (aux-edit-right ed)
  (make-editor
   (string-append (editor-pre ed)
                  (cond [( > (string-length (editor-post ed)) 0) (string-ith (editor-post ed) 0)]
                        [else ""]))
   (cond [( > (string-length (editor-post ed)) 0) (substring (editor-post ed) 1)]
         [else (editor-post ed)])))



;we use editor to represent text string
;Editor -> Editor
;aux func for edit , for handle condition edit a symbol after cursor 

;(check-expect (aux-edit-symbol (make-editor "hello " "world") "1") (make-editor "hello 1" "world"))

(define (aux-edit-symbol ed ke)
  (make-editor
   (string-append (editor-pre ed)
                  ke)
   (editor-post ed)))
