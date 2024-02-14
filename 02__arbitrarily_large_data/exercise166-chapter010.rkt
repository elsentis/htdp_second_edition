;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise166-chapter010) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))

; exercise166-chapter010

; Q.:
; The wage*.v2 function consumes a list of work records and produces a list of numbers.
; Of course, functions may also produce lists of structures.
; Develop a data representation for paychecks.
; Assume that a paycheck contains two distinctive pieces of information:
; the employee’s name and an amount.
; Then design the function wage*.v3.
; It consumes a list of work records and computes a list of paychecks from it, one per record.
; In reality, a paycheck also contains an employee number.
; Develop a data representation for employee information
; and change the data definition for work records so that it uses employee information
; and not just a string for the employee’s name.
; Also change your data representation of paychecks
; so that it contains an employee’s name and number, too.
; Finally, design wage*.v4,
; a function that maps lists of revised work records to lists of revised paychecks.


; Q.:
; The wage*.v2 function consumes a list of work records and produces a list of numbers.
; Of course, functions may also produce lists of structures.
; Develop a data representation for paychecks.
; Assume that a paycheck contains two distinctive pieces of information:
; the employee’s name and an amount.

(define-struct paycheck [employee amount])
; A (piece of) Paycheck is a structure: 
;   (make-paycheck String Number)
; interpretation (make-work n a) combines the name 
; with the weekly wage of an employee


; Q.:
; Then design the function wage*.v3.
; It consumes a list of work records and computes a list of paychecks from it, one per record.

(define-struct work [employee rate hours])
; A (piece of) Work is a structure: 
;   (make-work String Number Number)
; interpretation (make-work n r h) combines the name 
; with the pay rate r and the number of hours h

; Low (short for list of works) is one of: 
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the 
; hours worked for a number of employees

; Lop (short for list of paychecks) is one of:
; - '()
; - (cons Paycheck Lop)
; interpretation an instance of Lop represents the
; the weekly wages amount for a number of employees

; Low -> Lop
; consumes a list of work records and computes a list of paychecks from it, one per record
;
(check-expect (wage*.v3 (cons (make-work "Robby" 11.95 39) '()))
              (cons (make-paycheck "Robby" (* 11.95 39)) '()))
;
(define (wage*.v3 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v3 (first an-low)) (wage*.v3 (rest an-low)))]))


; Work -> Paycheck
; computes the paycheck for the given work record w
(define (wage.v3 w)
  (make-paycheck
   (work-employee w)
   (* (work-rate w) (work-hours w))))


; Q.:
; In reality, a paycheck also contains an employee number.
; Develop a data representation for employee information
; and change the data definition for work records so that it uses employee information
; and not just a string for the employee’s name.

; A E-number fall into interval:
; - 0 through 10000
; interpretation a employee number

(define-struct work-v2 [e-number rate hours])
; A (piece of) Work-v2 is a structure: 
;   (make-work E-number Number Number)
; interpretation (make-work n r h) combines the employee number 
; with the pay rate r and the number of hours h


; Q.:
; Also change your data representation of paychecks
; so that it contains an employee’s name and number, too.


(define-struct paycheck-v2 [e-number amount])
; A (piece of) Paycheck-v2 is a structure: 
;   (make-paycheck E-number Number)
; interpretation (make-work n a) combines the employee number 
; with the weekly wage of an employee



; Q.:
; Finally, design wage*.v4,
; a function that maps lists of revised work records to lists of revised paychecks.

; Low-v2 (short for list of works) is one of: 
; – '()
; – (cons Work-v2 Low)
; interpretation an instance of Low-v2 represents the 
; hours worked for a number of employees

; Lop-v2 (short for list of paychecks) is one of:
; - '()
; - (cons Paycheck Lop-v2)
; interpretation an instance of Lop-v2 represents the
; the weekly wages amount for a number of employees

; Low-v2 -> Lop-v2
; consumes a list of work-v2 records and computes a list of paychecks-v2 from it, one per record
;
(check-expect (wage*.v4 (cons (make-work-v2 115 11.95 39) '()))
              (cons (make-paycheck-v2 115 (* 11.95 39)) '()))
;
(define (wage*.v4 an-low)
  (cond
    [(empty? an-low) '()]
    [(cons? an-low) (cons (wage.v4 (first an-low)) (wage*.v4 (rest an-low)))]))


; Work-v2 -> Paycheck-v2
; computes the paycheck for the given work record w
(define (wage.v4 w)
  (make-paycheck-v2
   (work-v2-e-number w)
   (* (work-v2-rate w) (work-v2-hours w))))

