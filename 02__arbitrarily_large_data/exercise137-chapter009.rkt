;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise137-chapter009) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise137-chapter009

; Q.:
; Compare the template for contains-flatt? with the one for how-many.
; Ignoring the function name, they are the same. Explain the similarity.


; A List-of-strings is one of
; -- '()
; -- (cons String List-of-strings)

; List-of-strings -> Number
; determines how many strings are on alos
(define (how-many alos)
  (cond
    [(empty? alos) ...]
    [else
     (... (first alos) ...
      ... (how-many (rest alos)) ...)]))



; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name

; List-of-names -> Boolean
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (... (string=? (first alon) "Flatt") ...
      ... (contains-flatt? (rest alon)) ...)]))


; Q.:
; Explain the similarity
;
; both functions are important to determine empty list in the input data
; therefore first cond clause in the both functions designed for this purpose
; the next cond clause in the both functions defined for deal with self-reference data
; how-many's cond clause processes List-of-strings data, contains-flatt's - List-of-names
; in this clause functions uses 'first' selector for processing last added item in the list
; (in List-of-strings - the most external String, in List-of-names - the most external Name)
; and 'rest' selector for formulating “natural recursions” in order to processing the remaining part
; self-references data

