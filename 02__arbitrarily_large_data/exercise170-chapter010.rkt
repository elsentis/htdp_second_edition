;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise170-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise170-chapter010

; Q.:
; Here is one way to represent a phone number
; Design the function replace.
; It consumes and produces a list of Phones.
; It replaces all occurrence of area code 713 with 281.

(define AREA-IRRELEVANT 713)
(define AREA-RELEVANT 281)

(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is a Number between 100 and 999. 
; A Four is a Number between 1000 and 9999. 

; Lop (short for list of Phones) is one of:
; - '()
; - (cons Phone Lop)
; interpretation an instance of Lop  represents the
; list of some phones which combines area switch and four
; numbers of abonent

; Lop -> Lop
; consumes and produces a list of Phones.
; It replaces all occurrence of area code 713 with 281.
;
(check-expect (replace (cons (make-phone 812 706 9651)
                             (cons (make-phone 812 702 9154)
                                   (cons (make-phone 812 701 5032) '()))))
              (cons (make-phone 812 706 9651)
                    (cons (make-phone 812 702 9154)
                          (cons (make-phone 812 701 5032) '()))))
                                                                
(check-expect (replace (cons (make-phone 713 706 9651)
                             (cons (make-phone 812 702 9154)
                                   (cons (make-phone 713 701 5032) '()))))
              (cons (make-phone 281 706 9651)
                    (cons (make-phone 812 702 9154)
                          (cons (make-phone 281 701 5032) '()))))
;
(define (replace lop)
  (cond
    [(empty? lop) '()]
    [(aux-replace-irrelevant? (first lop))
     (cons (aux-replace-relevant (first lop)) (replace (rest lop)))]
    [else (cons (first lop) (replace (rest lop)))]))


; Phone -> Boolean
; determine Phone with AREA-IRRELEVANT value
; as area number
;
;(check-expect (aux-replace-irrelevant? (make-phone 812 702 9154)) #f)
;(check-expect (aux-replace-irrelevant? (make-phone 713 706 9651)) #t)
;
(define (aux-replace-irrelevant? p)
  (if (= AREA-IRRELEVANT (phone-area p))
      #t
      #f))


; Phone -> Phone
; aux func for 'replace' func
; consume phone structure and produce
; same phone structure with AREA-RELEVANT
; as area number
;
;(check-expect (aux-replace-relevant (make-phone 812 702 9154))
;              (make-phone AREA-IRRELEVANT 702 9154))
;
(define (aux-replace-relevant p)
  (make-phone AREA-RELEVANT (phone-switch p) (phone-four p)))