;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise135-chapter008) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise135-chapter008

; Q.:
; Use DrRacket’s stepper to check the calculation for
; (contains-flatt? (cons "Flatt" (cons "C" '())))
; Also use the stepper to determine the value of
; (contains-flatt?
;  (cons "A" (cons "Flatt" (cons "C" '()))))
; What happens when "Flatt" is replaced with "B"?



; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a list of invitees, by last name


; List-of-names -> Boolean
; determines whether "Flatt" occurs on alon

(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(cons? alon)
     (cond
       [(string=? (first alon) "Flatt") #true]
       [else (contains-flatt? (rest alon))])]))

; (contains-flatt? (cons "Flatt" (cons "C" '())))

; (contains-flatt?
;   (cons "A" (cons "Flatt" (cons "C" '()))))

; Q.:
; What happens when "Flatt" is replaced with "B"?
;
; (contains-flatt?
;   (cons "A" (cons "B" (cons "C" '()))))
;
; A.:
; contains-flatt? function call itself two times
; first time for proccesing 'rest' of (cons "A" (cons "B" (cons "C" '())))
; == (cons "B" (cons "C" '()))
; second time for for proccesing 'rest' of  (cons "B" (cons "C" '()))
; == (cons "C" '())
; both uses of the function produce #false, because there are no "Flatt" string
; in the checked list

