;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise083-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise083-chapter005

; Q.:
; Design the function render, which consumes an Editor and produces an image.
; The purpose of the function is to render the text within an empty scene of image pixels.
; For the cursor, use a image red rectangle and for the strings, black text of size 16.

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

;we use strings to represent a text for showing
;Editor -> Image
;which consumes an Editor and produces an image
; with text from Editor, adding a Cursor

(check-expect (render (make-editor "hello " "world"))
              (overlay/align "left"
                 "center"
                 (beside (text "hello " SCENE-SIZE-TEXT SCENE-COLOR-TEXT)
                        SCENE-CURSOR
                         (text "world" SCENE-SIZE-TEXT SCENE-COLOR-TEXT))
                SCENE-BACKGROUND))

(check-expect (render (make-editor "For every cons" "tant mentioned "))
              (overlay/align "left"
                 "center"
                 (beside (text "For every cons" SCENE-SIZE-TEXT SCENE-COLOR-TEXT)
                        SCENE-CURSOR
                         (text "tant mentioned " SCENE-SIZE-TEXT SCENE-COLOR-TEXT))
                SCENE-BACKGROUND))

(define (render input-editor)
  (overlay/align "left"
                 "center"
                 (beside (text (editor-pre input-editor) SCENE-SIZE-TEXT SCENE-COLOR-TEXT)
                        SCENE-CURSOR
                         (text (editor-post input-editor) SCENE-SIZE-TEXT SCENE-COLOR-TEXT))
                SCENE-BACKGROUND))
               
