;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise081-chapter005) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise081-chapter005

; Q.:
; Design the function time->seconds, which consumes instances of time structures (see exercise 77)
; and produces the number of seconds that have passed since midnight.
; For example, if you are representing 12 hours, 30 minutes, and 2 seconds with one of these structures
; and if you then apply time->seconds to this instance, the correct result is 45002.



(define-struct dailytime [hour minute second])
; a Dailytime is a structure
;     (make-dailytime Number [0..23] Number [0..59] Number [0..59])
; interpretation (make-dailytime a b c) is a elapsed time since midnight
; with a elapsed hours, b elapsed minutes (from the past hour) and c elapsed seconds (from the past minute)

(define SECONDS-IN-HOUR 3600)
(define MINUTES-IN-HOUR 60)
(define SECONDS-IN-MINUTE 60)

; Dailytime -> Number
; consumes instances of Dailytime
; and produces the number of seconds that have passed since midnight

(check-expect (dailytime-to-seconds (make-dailytime 3 56 8)) 14168)
(check-expect (dailytime-to-seconds (make-dailytime 0 0 0)) 0)
(check-expect (dailytime-to-seconds (make-dailytime 23 59 59)) 86399)

(define (dailytime-to-seconds ct)
  (+ (* SECONDS-IN-HOUR (dailytime-hour ct))
     (* SECONDS-IN-MINUTE (dailytime-minute ct))
     (dailytime-second ct)))
   
   