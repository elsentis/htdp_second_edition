;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise070-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise070-chapter005

; Q.:
; Spell out the laws for these structure type definitions
; Use DrRacket’s stepper to confirm 101 as the value of this expression


(define-struct centry [name home office cell])

; DrRacket adds these four laws to its knowledge

;(centry-name
; ((make-centry "Shriram Fisler"
;               (make-phone 207 "363-2421")
;               (make-phone 101 "776-1099")
;               (make-phone 208 "112-9981")))) == "Shriram Fisler"

;(centry-home
; ((make-centry "Shriram Fisler"
;               (make-phone 207 "363-2421")
;               (make-phone 101 "776-1099")
;               (make-phone 208 "112-9981")))) == (make-phone 207 "363-2421")

;(centry-office
; ((make-centry "Shriram Fisler"
;               (make-phone 207 "363-2421")
;               (make-phone 101 "776-1099")
;               (make-phone 208 "112-9981")))) == (make-phone 101 "776-1099")

;(centry-cell
; ((make-centry "Shriram Fisler"
;               (make-phone 207 "363-2421")
;               (make-phone 101 "776-1099")
;               (make-phone 208 "112-9981")))) == (make-phone 208 "112-9981")

(define-struct phone [area number])

; DrRacket adds these two laws to its knowledge

;(phone-area (make-phone 207 "363-2421")) == 207

;(phone-number (make-phone 207 "363-2421")) == "363-2421"


(phone-area
 (centry-office
  (make-centry "Shriram Fisler"
    (make-phone 207 "363-2421")
    (make-phone 101 "776-1099")
    (make-phone 208 "112-9981"))))



; == ; DrRacket uses the law for centry-office

(phone-area (make-phone 101 "776-1099"))

; == ; DrRacket uses the law for phone-area

101