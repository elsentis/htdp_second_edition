;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise103-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise103-chapter006

; Q.:
; Develop a data representation for the four kinds of zoo animals
; Develop a template for functions that consume zoo animals
; Design the fits? function, which consumes a zoo animal and a description of a cage. It determines whether the cage’s volume is large enough for the animal.

;   A AnimalKind is one of: 
; – "spiders"
; – "elephants"
; – "boa constrictors"
; – "armadillos"
; interpretation means the kind of
; animal for transportation

;   A SpiderLegs is is one of: 
; – NonnegativeNumber
; -#false
; interpretation means the number of legs
; of transported animal if this is a spiders
; #false if this is not a spiders

; A Volume is
; - NonnegativeNumber
; - #false
; interpretation means the the amount of space
; occupied by the animal of movement in transport
; #false if this is not indicated for some kinds

;   A BoaLength is is one of: 
; – NonnegativeNumber
; - #false
; interpretation means the length
; of transported animal if this is a boa constrictors
; #false if this is not a boa

;   A BoaGirth is is one of: 
; – NonnegativeNumber
; - #false
; interpretation means the girth
; of transported animal if this is a boa constrictors
; #false if this is not a boa

;   A ArmadilloTeeth is is one of: 
; – NonnegativeNumber
; - #false
; interpretation means the number of teeth
; of transported animal if this is a armadillo
; #false if this is not a armadillo


(define-struct animal [kind volume spider-legs boa-length boa-girth armadillo-teeth])
; a ANIMAL is a structure
; (make-animal AnimalKind Volume SpiderLegs BoaLength BoaGirth ArmadilloTeeth)
; a data representation for the following four kinds of zoo animals:
;; - spiders
;; - elephants
;; - boa constrictors
;; - armadillos


(define-struct cage [width height length])
;   A Cage is a structure:
;(make-cage NonnegativeNumber NonnegativeNumber NonnegativeNumber)
; data representation for definition fom three-dimensional parametres
; of cage for transporting animals



; template for functions that consume zoo animals:

(define (animal-handler s)
  (cond [(string=? "spiders" (animal-kind s))
         (... (animal-volume s) ... (animal-spider-legs s))]
        [(string=? "elephants" (animal-kind s))
         (... (animal-volume s) ...)]
        [(string=? "boa constrictors" (animal-kind s))
         (... (animal-boa-length s) ... (animal-boa-girth s))]
        [(string=? "armadillos" (animal-kind s))
         (... (animal-volume s) ... (animal-armadillo-teeth s))]))



; Design the fits? function, which consumes a zoo animal and a description of a cage. It determines whether the cage’s volume is large enough for the animal.

; func for determines whether the cage’s volume
; is large enough for the animal
; Cage, Animal -> String
; consume cage and animal descriprion and
; compute a opportunity to place animal in a cage
; result as a text for the operator

(define (fits? s-cage s-animals)
  (cond [(string=? "spiders" (animal-kind s-animals))
         (result-text (compute-3d-volume (cage-width s-cage) (cage-height s-cage) (cage-length s-cage)) (animal-volume s-animals))]
        [(string=? "elephants" (animal-kind s-animals))
         (result-text (compute-3d-volume (cage-width s-cage) (cage-height s-cage) (cage-length s-cage)) (animal-volume s-animals))]
        [(string=? "boa constrictors" (animal-kind s-animals))
         (result-text (compute-3d-volume (cage-width s-cage) (cage-height s-cage) (cage-length s-cage)) (boa-volume (animal-boa-length s-animals) (animal-boa-girth s-animals)))]
        [(string=? "armadillos" (animal-kind s-animals))
         (result-text (compute-3d-volume (cage-width s-cage) (cage-height s-cage) (cage-length s-cage)) (animal-volume s-animals))]))



; func for compute volume from three-dimensional
; parametres of the object
; Number, Number, Number -> Number
; (define (compute-3d-volume width height length))
; consume width height length and compute volume
; for the math formula

(define (compute-3d-volume width height length)
  (* width height length))



; func for determining whether it is possible to
; place an animal in a cage and displaying the resulting text
; Number, Number -> Img
; compute a two numbers - volume of cage
; and volume a transporing animals
; resume it and output text about the possibility of transportation

(define (result-text cage-volume animals-volume)
  (cond [(< animals-volume cage-volume)
         "we have the possibility of transporting animals of this volume"]
        [else
         "we have no possibility to transport animals of this volume"]))



; func for compute a boa  constrictors volume
; Number, Number -> Number
; calculates the volume of a boa
; based on its length and girth

(define (boa-volume s-boa-length s-boa-girth)
  (* (/ (sqr s-boa-girth) 4) s-boa-length))



;(define-struct animal [kind volume spider-legs boa-length boa-girth armadillo-teeth])
;(define CAGE1 (make-cage 5 5 5))
;(define SPIDERS1 (make-animal "spiders" 0.5 156 #false #false #false))
;(define ELEPHANTS (make-animal "elephants" 130 #false #false #false #false))

;(fits? CAGE1 ELEPHANTS)

