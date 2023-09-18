;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise077-chapter005) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise077-chapter005

; Q.:
; Provide a structure type definition and a data definition for representing points in time since midnight.
; A point in time consists of three numbers: hours, minutes, and seconds.



(define-struct dailytime [hour minute second])
; a Dailytime is a structure
;     (make-dailytime Number [0..23] Number [0..59] Number [0..59])
; interpretation (make-dailytime a b c) is a elapsed time since midnight
; with a elapsed hours, b elapsed minutes (from the past hour) and c elapsed seconds (from the past minute)