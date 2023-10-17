;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise120-intermezzo01) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise120-intermezzo01

; Discriminate the legal from the illegal sentences
; Explain why the sentences are legal or illegal. Determine whether the legal ones belong to the category expr or def



; (x)
; x is variable
; expr = variable
; bacause there are no define keyword this is not def
; because there are no (variable) forms in expr types this is not expr
; compound sentence (variable) not included in BSL core grammar
; illegal


; (+ 1 (not x))
; 1 is a number
; number is a value
; expr = value
; x is a variable
; expr = variable
; '+', 'not' is a primitive
; (not x) == (primitive expr) == expr
; ( + 1 (not x)) == (+ 1 expr) == (+ expr expr) == expr
; because expr = (primitive expr expr ...)
; because '+' is working only with numbers as value it will be procedure error
; because (not x) procedure return boolean value
; but from the BSL grammar side this is
; legal


; (+ 1 2 3)
; 1, 2, 3 is a number
; number is a value
; expr = value
; '+' is a primitive
; because expr = (primitive expr expr ...)
; (+ 1 2 3) == (primitive expr expr expr) == expr
; legal