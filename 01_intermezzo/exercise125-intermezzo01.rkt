;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise125-intermezzo01) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; exercise125-intermezzo01

; Q.:
; Discriminate the legal from the illegal sentences
; Explain why the sentences are legal or illegal


; 1.
; (define-struct oops [])
; define-struct is a keyword for structure type definition
; oops is a name of definable structure
; because structure type definition grammar rule is
; definition = (define-struct name [name ...])
; where  three dots is means  as many repetitions of what precedes the dots as you wish
; that a structure contain is either nothing or a single occurrence of  component's name or a sequence of two of them, or three, four, five, or however many
; that's structure type definition with indicating none component's name is acceptable
;
; Q.:
; Discriminate the legal from the illegal sentences
; A.:
; Legal


; 2.
; (define-struct child [parents dob date])
; define-struct is a keyword for structure type definition
; child is a name of definable structure
; parents, dob, date is a names of components of the structure value
; because structure type definition grammar rule is
; definition = (define-struct name [name ...])
; where  three dots is means  as many repetitions of what precedes the dots as you wish
; this structure type definition completely suitable to a structure type definition grammar rule
;
; Q.:
; Discriminate the legal from the illegal sentences
; A.:
; Legal


; 3.
; (define-struct (child person) [dob date])
; define-struct is a keyword for structure type definition
; because structure type definition grammar rule is
; definition = (define-struct name [name ...])
; in current exercise  structure type definition
; is not followed by a single variable name for structure type naming and
; variables and the parentheses are not placed according to the grammatical pattern
;
; Q.:
; Discriminate the legal from the illegal sentences
; A.:
; Illegal