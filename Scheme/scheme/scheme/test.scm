(load "list.scm")

(display "------testing countingNumbers--------------------------")
(display "\n")
(display "(countingNumbers 4) returns ")
(display (countingNumbers 4))
(display "\n")
(display "(countingNumbers 8) returns ")
(display (countingNumbers 8))
(display "\n")
(display "\n")
(display "------testing evenNumbers--------------------------")
(display "\n")
(display "(evenNumbers 2) returns ")
(display (evenNumbers 2))
(display "\n")
(display "(evenNumbers 9) returns ")
(display (evenNumbers 9))
(display "\n")
(display "\n")
(display "------testing primeNumbers--------------------------")
(display "\n")
(display "(primeNumbers 9) returns ")
(display (primeNumbers 9))
(display "\n")
(display "(primeNumbers 20) returns ")
(display (primeNumbers 20))
(display "\n")
(display "\n")
(display "------testing merge--------------------------")
(display "\n")
(display "(merge (evenNumbers 8) (countingNumbers 4)) returns ")
(display (merge (evenNumbers 8) (countingNumbers 4)))
(display "\n")
(display "(merge '() (countingNumbers 4)) returns ")
(display (merge '() (countingNumbers 4)))
(display "\n")
(display "\n")
(display "------testing wrap--------------------------")
(display "\n")
(display "(wrap 1 (countingNumbers 4)) returns ")
(display (wrap 1 (countingNumbers 4))) 
(display "\n")
(display "(wrap 3 (countingNumbers 4)) returns ")
(display (wrap 3 (countingNumbers 4))) 
(display "\n")
(display "\n")
(display "------testing subLists--------------------")
(display "\n")
(display "(subLists (countingNumbers 4)) returns ")
(display (subLists (countingNumbers 4)))
(display "\n")
(display "(subLists (primeNumbers 10)) returns ")
(display (subLists (primeNumbers 10)))
(display "\n")
(display "\n")
(display "------testing reduceLists--------------------")
(display "\n")
(display "(reduceLists + 0 (subLists (countingNumbers 4)))) returns")
(display (reduceLists + 0 (subLists (countingNumbers 4))))
(display "\n")
(display "(reduceLists * 1 (subLists (primeNumbers 10)))) returns")
(display (reduceLists * 1 (subLists (primeNumbers 10))))
(display "\n")
(display "\n")
