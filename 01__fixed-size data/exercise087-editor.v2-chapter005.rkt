;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |exercise087(editor.v2)-chapter005|) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise087-editor.v2-chapter005

; Q.:
; Develop a data representation for an editor based on our first idea, using a string and an index.
; Then solve the preceding exercises again.

(define SCENE-WIDTH  200)
(define SCENE-HEIGHT 20)

(define SCENE-BACKGROUND (empty-scene SCENE-WIDTH SCENE-HEIGHT))

(define SCENE-SIZE-TEXT 11)
(define SCENE-COLOR-TEXT "black")
(define SCENE-CURSOR (rectangle 1 SCENE-HEIGHT "solid" "red"))
(define SCENE-INDENT-FROM-RIGHT-BORDER (+ (image-width SCENE-CURSOR) 5))

(define-struct editor [word cpos])
; An Editor is a structure:
;   (make-editor String Number)
; interpretation (make-editor s t) describes an editor
; whose visible text is (word) with 
; the cursor displayed on the cpos position



; BB World proframm
; a WorldState is a Editor
; consume a String interpretations the 'word' field of editor type
; interpret a text

(define (run str)
  (big-bang (make-editor str (string-length str))
    [to-draw render]
    [on-key edit]))



; we use string and number to represent a text with cursor for showing
; Editor -> Image
; which consumes an Editor and produces an image
; with text from Editor, adding a Cursor in cpos

(define (render ed)
  (cond [( < (string-length (editor-word ed)) (editor-cpos ed)) (overlay/align "left"
                                                                               "center"
                                                                               (beside (text
                                                                                        (substring (editor-word ed) 0 (string-length (editor-word ed)))
                                                                                        SCENE-SIZE-TEXT
                                                                                        "black")
                                                                                       SCENE-CURSOR)
                                                                               SCENE-BACKGROUND)]
        [else (overlay/align "left"
                             "center"
                             (beside (text
                                      (substring (editor-word ed) 0 (editor-cpos ed))
                                      SCENE-SIZE-TEXT
                                      "black")
                                     SCENE-CURSOR
                                    (text
                                    (substring (editor-word ed) (editor-cpos ed))
                                    SCENE-SIZE-TEXT
                                    "black"))
                             SCENE-BACKGROUND)]))



; we use editor to  represent strings of text with cursor
; we use ke to represent action that we must do with text from editor
; Editor, KeyEvent -> Editor
; consumes two inputs, an editor ed and a KeyEvent ke, and it produces another editor

(define (edit ed ke)
  (cond
    [(string=? ke "\b") (aux-edit-backpace ed)]
    [(string=? ke "right") (aux-edit-right ed)]
    [(string=? ke "left") (aux-edit-left ed)]
    [(aux-edit-right-margin ed) ed]
    [(or (string=? ke "\t") (string=? ke "\r")) ed]
    [(= (string-length ke) 1) (aux-edit-symbol ed ke)]
    [else ed]))



;we use Editor to represent text
;Editor -> boolean
;aux func to determine the off at the right margin

(define (aux-edit-right-margin ed)
  (cond [(<= SCENE-INDENT-FROM-RIGHT-BORDER
             (- SCENE-WIDTH (image-width (text (editor-word ed) SCENE-SIZE-TEXT SCENE-COLOR-TEXT))))  #false]
        [else #true]))



; we use editor to represent text string
; Editor -> Editor
; auxulary func for edit , for handle condition \b from ke

(define (aux-edit-backpace ed)
  (cond
    [(= (editor-cpos ed) 0) ed]
    [else (make-editor
           (string-append
            (substring (editor-word ed) 0 (- (editor-cpos ed) 1))
            (substring (editor-word ed) (editor-cpos ed)))
           (- (editor-cpos ed) 1))]))



; we use editor to represent text string
; Editor -> Editor
; aux func for edit , for handle condition "left" from ke

(define (aux-edit-left ed)
  (cond
    [(= (editor-cpos ed) 0)  ed]
    [else (make-editor
           (editor-word ed)
           (- (editor-cpos ed) 1))]))



; we use editor to represent text string
; Editor -> Editor
; aux func for edit , for handle condition "right" from ke

(define (aux-edit-right ed)
  (cond
    [(<= (string-length (editor-word ed)) (editor-cpos ed)) ed]
    [else (make-editor
           (editor-word ed)
           (+ (editor-cpos ed) 1))]))



;we use editor to represent text string
;Editor -> Editor
;aux func for edit , for handle condition edit a symbol after cursor

(define (aux-edit-symbol ed ke)
  (make-editor
   (string-append (substring (editor-word ed) 0 (editor-cpos ed))
                  ke
                  (substring (editor-word ed) (editor-cpos ed)))
   (+ (editor-cpos ed) 1)))
   
