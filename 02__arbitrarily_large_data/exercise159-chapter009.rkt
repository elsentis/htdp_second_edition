;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname exercise159-chapter009) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; exercise159-chapter009

; Q.:
; Turn the solution of exercise 153 into a world program
; Its main function, dubbed riot, consumes how many balloons the students want to throw
; its visualization shows one balloon dropping after another at a rate of one per second
; The function produces the list of Posns where the balloons hit

(define SQUARE-SIDE 10)
(define SQUARE (square SQUARE-SIDE "outline" "black"))
(define SQUARE-HALL-X 10) ; the size of the hall in squares on the x scale
(define SQUARE-HALL-Y 10) ; the size of the hall in squares on the y scale
(define RED-DOT (circle 3 "solid" "red"))
(define SEATS-NUMBER (random (* (- SQUARE-HALL-X 1) (- SQUARE-HALL-Y 1))))
;(define BACKGROUND (empty-scene (* SQUARE-HALL-X SQUARE-SIDE) (* SQUARE-HALL-Y SQUARE-SIDE)))


; An N is one of:
; – 0
; – (add1 N)
; Represents the counting numbers.

; A Lext-X fall in interval:
; - 0 to SQUARE-HALL-X

; A Lext-Y fall in interval:
; - 0 to SQUARE-HALL-Y

; A Lect-Posn is a structure:
;  (make-posn Lect-x Lect-y)
; interpretation the range of points available for throwing the ball is within Lecture-hall

;; An List-of-Lect-Posns is one of:
;; -  '()
;; - (cons Lect-Posn List-of-Lect-Posns)

; A Number-of-Baloons is a interval
;; 0 to Seats (* (- SQUARE-HALL-X 1) (- SQUARE-HALL-Y 1))
; interpretation the maximum available number of balls to throw
; limited by the number seats in the lecture hall
; thrifty students didn't wear more baloons than they needed

(define-struct pair [balloon# lob])
; A Pair is a structure (make-pair Number-of-Baloons List-of-Lect-Posns)

; A SpaceHoldFlag is enumeration
; -- "true"
; -- "false"
; interpretation a flag notifying about the event of the user pressing the space bar

(define-struct kepair [pair ke])
; A KEpair is a structure (make-kepair Pair SpaceHoldFlag)

; A BBS is one of: 
; – (make-pair Number-of-Baloons List-of-Lect-Posns)
; – (make-kepair (make-pair Number-of-Baloons List-of-Lect-Posns) SpaceHoldFlag)
; interpretation represents the complete state of a bb

(define kepair-false (make-kepair
                      (make-pair
                       3
                       (cons (make-posn 0 1)
                             (cons (make-posn 0 2)
                                   (cons (make-posn 0 3) '()))))
                      #false))
(define pair-1 (make-pair
                3
                (cons (make-posn 0 1)
                      (cons (make-posn 0 2)
                            (cons (make-posn 0 3) '())))))

(define pair-2 (make-pair
                0
                (cons (make-posn 0 1)
                      (cons (make-posn 0 2)
                            (cons (make-posn 0 3) '())))))

(define pair-3 (make-pair
                4
                (cons (make-posn 0 1)
                      (cons (make-posn 0 2)
                            (cons (make-posn 0 3) '())))))
             

; scene launch
; consume how many balloons the students want to throw
; offer a hold space key for ballons throwing
; produce the list of Posns where the balloons hit
; coordinates are selected by random function
; one coordinate can be hit by two or more balloons
; produce error if incorrect input 
(define (riot nb)
  (cond
    [(and (number? nb) (and (>= nb 1) (<= nb SEATS-NUMBER)))
     (pair-lob
      (big-bang (make-kepair (make-pair 0 (make-random-list nb)) #false)
        [to-draw render-scene]
        [on-tick pair-move 1]
        [on-key key-control]
        [stop-when list-end?]))]
    [else (error "invalid input")]))



; Number-of-Baloons -> List-of-Lect-Posns
; consume desired number of baloons and produce list of posn
; for the purposes of balloons with random coordinates for each balloons
;
;(check-expect (make-random-list 0) '())
;(check-random (make-random-list 4) (cons (make-posn
;                                          (random (- SQUARE-HALL-X 1))
;                                          (random (- SQUARE-HALL-Y 1)))
;                                         (cons (make-posn
;                                                (random (- SQUARE-HALL-X 1))
;                                                (random (- SQUARE-HALL-Y 1)))
;                                               (cons (make-posn
;                                                      (random (- SQUARE-HALL-X 1))
;                                                      (random (- SQUARE-HALL-Y 1)))
;                                                     (cons (make-posn
;                                                            (random (- SQUARE-HALL-X 1))
;                                                            (random (- SQUARE-HALL-Y 1))) '())))))
;                                       
(define (make-random-list nb)
  (cond
    [(= nb 0) '()]
    [else (cons (make-posn (random (- SQUARE-HALL-X 1))
                           (random (- SQUARE-HALL-Y 1)))
                (make-random-list (sub1 nb)))]))
    
    
; BBS -> Image
; produce an image with scene of lecture hall with abandoned balloons
; clear lecture-hall if this is first scene
; scene with invitation to click space key if there is first scene
; 
(define (render-scene pr)
  (cond
    [(kepair? pr)
     (cond
       [(false? (kepair-ke pr))
        (place-image (overlay
                      (text/font "hold space" 10 "red" #f "default" "normal" "bold" #t)
                      (rectangle 70 20 "solid" "white"))
                     (/ (* SQUARE-HALL-X SQUARE-SIDE) 2)
                     (/ (* SQUARE-HALL-Y SQUARE-SIDE) 2)
                     (lecture-hall SQUARE-HALL-X SQUARE-HALL-Y))]
       [(kepair-ke pr)
        (lecture-hall SQUARE-HALL-X SQUARE-HALL-Y)])]
    [(pair? pr)
     (cond [(or (= (pair-balloon# pr) 0) (empty? (pair-lob pr)))
           (lecture-hall SQUARE-HALL-X SQUARE-HALL-Y)]
           [(> (pair-balloon# pr) 0)
            (place-image RED-DOT
                         (* SQUARE-SIDE (posn-x (first (pair-lob pr))))
                         (* SQUARE-SIDE (posn-y (first (pair-lob pr))))
                         (render-scene (make-pair (sub1 (pair-balloon# pr))
                                                  (rest (pair-lob pr)))))])]))




; N, Image -> Image
; consumes a natural number n and an image img.
; It produces a column—a vertical arrangement—of n copies of img
;
;(check-expect  (col 5 (circle 5 "outline" "red")) (above (circle 5 "outline" "red")
;                                                         (circle 5 "outline" "red")
;                                                         (circle 5 "outline" "red")
;                                                         (circle 5 "outline" "red")
;                                                         (circle 5 "outline" "red")))
;                                                
;
(define (col n img)
  (cond
    [(zero? n) empty-image]
    [else (above img (col (sub1 n) img))]))



; N, Image -> Image
; consumes a natural number n and an image img.
; It produces a column—a vertical arrangement—of n copies of img
;
;(check-expect  (row 5 (circle 5 "outline" "red")) (beside (circle 5 "outline" "red")
;                                                          (circle 5 "outline" "red")
;                                                          (circle 5 "outline" "red")
;                                                          (circle 5 "outline" "red")
;                                                          (circle 5 "outline" "red")))
;
(define (row n img)
  (cond
    [(zero? n) empty-image]
    [else (beside img (row (sub1 n) img))]))


; N, N -> Image
; create a rectangle of y COLUMNS by x ROWS squares
; and place it in an empty-scene of the same size
;
(define (lecture-hall x y)
  (place-image
   (col y (row x SQUARE))
   (/ (* SQUARE-SIDE x) 2)
   (/ (* SQUARE-SIDE y) 2)
   (empty-scene (* x SQUARE-SIDE) (* y SQUARE-SIDE))))


; BBS, KeyEvent -> BBS
; func for big-bang for key-event handler
;  it consumes a bb state and a KeyEvent
; and produce a new game state
; it reacts to only one key only once
; pressing 'space' when bb state is 'kepair' struct for start balloon hit
;
;(check-expect (key-control kepair-false " ") (make-pair 3
;                                                        (cons (make-posn 0 1)
;                                                              (cons (make-posn 0 2)
;                                                                    (cons (make-posn 0 3) '())))))
;(check-expect (key-control pair-1 " ") pair-1)
;(check-expect (key-control kepair-false "l") kepair-false)
;
(define (key-control pr ke)
  (cond
    [(and (string=? ke " ")
          (kepair? pr)
          (false? (kepair-ke pr)))
     (make-pair
      (pair-balloon# (kepair-pair pr))
      (pair-lob (kepair-pair pr)))]
    [else pr]))



; BBS -> BBS
; this function is called for every clock tick to
; determine what item of the lob list is must processing
; for rendering next red dot at lecture hall
; by changing balloon# pair parameter
; nothing change if bbs nepair
;
;(check-expect (pair-move kepair-false) kepair-false)
;(check-expect (pair-move pair-1) (make-pair
;                4
;                (cons (make-posn 0 1)
;                      (cons (make-posn 0 2)
;                            (cons (make-posn 0 3) '())))))
(define (pair-move pr)
  (cond
    [(pair? pr)
     (make-pair
      (add1 (pair-balloon# pr))
      (pair-lob pr))]
    [else pr]))


; BBS -> Boolean
; check pair bbs for reaching balloon# paremeter
; end of lob in the form of increasing the number of list items
; if reaching #true
; if bbs kepair #false
;
;(check-expect (list-end? kepair-false) #false)
;(check-expect (list-end? pair-1) #false)
;(check-expect (list-end? pair-2) #false)
;(check-expect (list-end? pair-3) #true)
;
(define (list-end? pr)
  (cond
    [(and (pair? pr)
          (< (how-many (pair-lob pr)) (pair-balloon# pr)))
          #true]
    [else #false]))


; List-of-strings -> Number
; determines how many balloons are on lob
(define (how-many lob)
  (cond
    [(empty? lob) 0]
    [else (+ (how-many (rest lob)) 1)]))






