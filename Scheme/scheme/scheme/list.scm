; The gcd function computes the greatest common divisor of m and n.
; Inputs - m First number
;          n Second number
; Output - the GCD
; Examples
;    (gcd 4 2) returns 2
;    (gcd 7 3) returns 1
(define (gcd m n)
  (cond ((< m n) (gcd m (- n m)))
        ((< n m) (gcd (- m n) n))
        (else m)))


(define (countingNumbers limit)
  (let loop ((limit limit) (accumulator '()))
    (if (zero? limit)
        accumulator
        (loop (- limit 1) (cons limit accumulator))))
)


(define (evenNumbers limit)
	(define evenlist '())
	(define count 1)
	(cond [(= count limit) (evenlist)]
		  [(even? count) (cons count evenlist) (+ count 1) (evenNumbers limit)]
		  [(odd? count) (+ count 1) (evenNumbers limit)]))

(define (primesUpTo n) 
  (let loop ((x n) 
             (result '())) 
    (cond 
      ((<= x 1) result)  
      ((isPrime x) 
            (loop (- x 1) (cons x result)))   
      (else (loop (- x 1) result)))))  

(define (isPrimeHelper x k)
  (if (= x k) 
      #t                          
      (if (= (remainder x k) 0)   
          #f                              
          (isPrimeHelper x (+ k 1)))))    

(define ( isPrime x )
    (cond
      (( = x 2 ) #t)
      ( else (isPrimeHelper x 2 ) )))

(define (merge listOne listTwo)
     (if (null? listOne) listTwo
          (if (null? listTwo) listOne
              (cons (car listOne) (cons (car listTwo) (merge (cdr listOne) (cdr listTwo))))))
)

(define (wrap numberToWrap aList)
  (lambda (numberToWrap aList)
    (if (null? aList)
        (list numberToWrap)
        (cons (car aList) (attach-at-end numberToWrap (cdr aList)))))
)

(define (subLists aList)
 (if (null? aList) 
	'()
	(append (subLists (reverse (cdr (reverse aList))))(list aList)) 	
	)
)
	

(define (reduceLists func initialValue listOfLists)
    ;still need to call function again for each sub-list
	(if (null? listOfLists) initialValue
		(reduce func (func initialValue (car listOfLists)) (cdr listOfLists)))
)
