;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise104-chapter006) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
; exercise104-chapter006

; Q.:
; Your home town manages a fleet of vehicles: automobiles, vans, buses, and SUVs. Develop a data representation for vehicles.
; Develop a template for functions that consume vehicles.


;   A NumberOfPassangers is interval: 
; – between 0 and 100
; interpretation means the number of passengers
; that the vehicle can carry


;  A LicensePlateNumber is interval:
;  – between 75000 and 85000 (fictional range for a N-city)
;  interpretation means the range of license plates registered in the N-city


; A FuelConsumption is interval:
; -between 10 and 110
; vehicle fuel consumption (miles per gallon)


; a VehicleType is one of
; - "automobile"
; - "van"
; - "bus"
; - "SUV"
; interpretation means the names for types of vehicle


(define-struct vehicle [type number-of-passangers license-plate-number fuel-consumption])
; a VEHICLE is a structure
; (make-vehicle VehicleType NumberOfPassangers LicensePlateNumber FuelConsumption)
; a data representation for the following types of vehicles
; - automobiles
; - vans
; - buses
; - SUVs


;develop a template for functions that consume vehicles:

(define (vehicle-handler s-vehicle)
  (cond
    [(string=? (vehicle-type s-vehicle) "automobile")
     (... (vehicle-license-plate-number s-vehicle) ...)]
    [(string=? (vehicle-type s-vehicle) "van")
     (... (vehicle-number-of-passangers s-vehicle) ...)]
    [(string=? (vehicle-type s-vehicle) "bus")
     (... (vehicle-license-plate-number s-vehicle) ... (vehicle-license-plate-number s-vehicle))]
    [(string=? (vehicle-type s-vehicle) "SUV")
     (... (vehicle-fuel-consumption s-vehicle) ...)]))
