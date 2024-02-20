;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise173-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise173-chapter010

; Q.:
; Design a program that removes all articles from a text file.
; The program consumes the name n of a file, reads the file, removes the articles,
; and writes the result out to a file whose name is the result of concatenating "no-articles-" with n.
; For this exercise, an article is one of the following three words: "a", "an", and "the".
; Use read-words/line so that the transformation retains the organization of the original text
; into lines and words. When the program is designed, run it on the Piet Hein poem.


; An Los (List-of-String) 
; is one of: 
; – '() 
; – (cons String Los)

; An LN is one of: 
; – '()
; – (cons Los LN)
; interpretation a list of lines, each is a list of Strings


(define articles-keeper (cons "a" (cons "an" (cons "the" '()))))

(define line0 (cons "a" (cons "world" '())))
(define line1 '())
(define line2 (cons "the" (cons "world" (cons "an" (cons "big" (cons "hope" '()))))))

; String (name of file) -> String (name of file)
; The program consumes the name n of a file, reads the file, removes the articles,
; and writes the result out to a file whose name is the result of concatenating "no-articles-" with n.
; For this exercise, an article is one of the following three words: "a", "an", and "the".
;
(define (remove-articles f)
  (if (file-exists? f)
      (write-file (string-append "no-articles-" f) (aux-remove-articles-file (read-words/line f)))
      (error "file doesn't exist")))


; LN -> String
; aux func for remove-articles
; convert a list of lines into a string with removed articles
;
(check-expect (aux-remove-articles-file (cons line1 (cons line2 '())))
              "\nworld big hope\n")
(check-expect (aux-remove-articles-file (cons line0 (cons line2 '())))
              "world\nworld big hope\n")
(check-expect (aux-remove-articles-file (cons line1 '()))
              "\n")
;
(define (aux-remove-articles-file lls)
  (cond
    [(empty? lls) ""]
    [else
     (string-append (aux-remove-articles-string (first lls))
                    (aux-remove-articles-file (rest lls)))]))


; Los -> String
; aux func for remove-articles
; for processing a single line
; and deleting a given article
;
(check-expect (aux-remove-articles-string line0) "world\n")
(check-expect (aux-remove-articles-string line1) "\n")
(check-expect (aux-remove-articles-string line2) "world big hope\n")
;
(define (aux-remove-articles-string los)
  (cond
    [(empty? los) "\n"]
    [else
     (string-append (if (member? (first los)articles-keeper) "" (first los))
                    (if (or (empty? (rest los)) (member? (first los)articles-keeper)) "" " ")
                    (aux-remove-articles-string (rest los)))]))