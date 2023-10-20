;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise133-chapter008) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise133-chapter008

; Q.:
; Here is another way of formulating the second cond clause in contains-flatt?
; ... (cond
;       [(string=? (first alon) "Flatt") #true]
;       [else (contains-flatt? (rest alon))]) ...
; Explain why this expression produces the same answers as the or expression in the version of figure 47;
; Which version is clearer to you? Explain



; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name


; List-of-names -> Boolean
; determines whether "Flatt" occurs on alon
(check-expect
  (contains-flatt? (cons "X" (cons "Y"  (cons "Z" '()))))
  #false)
(check-expect
  (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '()))))
  #true)
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (cond
       [(string=? (first alon) "Flatt") #true]
       [else (contains-flatt? (rest alon))])]))

; Q.:
; Explain why this expression produces the same answers as the or expression
; in the version of figure 47.
;
;A.:
; condition expression in cond clauses perform the same function that expressions in 'or' conditional
; for an explicit value for function returns boolean in func
; while 'or' conditional return that by default

; Q.:
; Which version is clearer to you? Explain
;
; A.:
; For me more clearer version with cond construction, because this form more immediately understandable
; Addition after exercise-134:
; to avoid confusion due to use and receiving the wrong answer using cond construction during processing
; self-referential data type we must using 'else' cond clause when we deals with 'rest' component of list.
; otherwise we may have an error checking this list component if there is a lot of nesting self-referential data type
; maybe better for this data type using 'if' consruciton because 'else' clause is defolt in this construction or
; or 'conditional'