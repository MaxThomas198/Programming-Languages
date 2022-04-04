// Do not remove or rename the package
package lists


val <T> List<T>.tail: List<T>
get() = drop(1)

/*
* Extend the List class with a "head" getter to get the head of a *list.
* Below is an example of how you would use head
*    val a = listOf(1,2,3)
*    val h = a.head
*    println("head of $a is $h") // prints 1
*/
val <T> List<T>.head: T
get() = first()

/* 
* The isPrime function takes as input an Int
*      x : an Int object to test
* and returns a Boolean
*      true  if x is a prime
*      false if x is not a prime
*/
fun isPrime(x : Int) : Boolean {
    for (i in 2..(x-1)) {
        if (x % i == 0) {
            return false
        }    
    }
    return true
}

/* The compose function takes as input
*     f - A function that takes as input a value of type T and returns a value of type T
*     g - A function that takes as input a value of type T and returns a value of type T
*  and returns as output the composition of the functions
*     f(g(x))
*/
fun<T> compose(f: (T)->T,  g:(T) -> T) : (T) -> T = { f(g(it)) }

/* countingNumbers builds a list of counting numbers 
* (counting numbers start at 1).
* takes int n and will build a list up to n
* returns list of INTs or null
* Ex: countingNumbers(3)    // returns the list [1,2,3]
*/ 
fun countingNumbers(n : Int?) : List<Int>? {
  if (n == null) return null
    if (n <= 0) return listOf<Int>()
    val list : MutableList<Int>? = mutableListOf<Int>()
    for (i in 1..n) {
        list?.add(i)
    }
    return list
}

/* evenNumbers builds a list of only even numbers 
* takes int n and will build a list up to n
* returns list of even INTs or null
* Ex: evenNumbers(5)    // returns the list [2,4]
*/ 
fun evenNumbers(n : Int?) : List<Int>? {
    if (n == null) return null
    if (n <= 0) return listOf<Int>()
    return countingNumbers(n)?.filter { it % 2 == 0 }
}

/* primeNumbers builds a list of only prime numbers 
* takes int n and will build a list up to n
* returns list of even INTs or null
* Ex: primeNumbers(5)    // returns the list [2,3,5]
*/ 
fun primeNumbers(n : Int?) : List<Int>? {
    if (n == null) return null
    if (n <= 0) return listOf<Int>()
    return countingNumbers(n)?.filter { isPrime(it) }
}

/*  merge takes two lists of comparable types (in sorted order) 
*  Either list may be empty or null
*  returns single combined sorted list
*  Ex: merge(listOf(1,2,3),listOf(1,7)) //returns the list [1,1,2,3,7]
*/ 
fun<T : Comparable<T>> merge(a : List<T>?, b : List<T>?) : List<T>? {
    if (a == null || b == null) return null
    val a1 : MutableList<T> = a.toMutableList()
    val b1 : MutableList<T> = b.toMutableList()
    val result : MutableList<T>? = mutableListOf<T>()
    while (a1.isEmpty() == false && b1.isEmpty() == false) {
        when {
            a1.head <= b1.head -> { result?.add(a1.head) ; a1.removeAt(0) }
            a1.head > b1.head  -> { result?.add(b1.head) ; b1.removeAt(0) }
        }
    }
    result?.addAll(a1)
    result?.addAll(b1)
    return result
}

/*  subLists builds a list of sub-lists 
*  The nth sub-list is the elements from 1 to n in the list 
*  Either list may be empty or null
*  returns list of lists of size n
*  Ex: subLists(listOf(1,2,3)) // returns the list [[1],[1,2],[1,2,3]]
*/ 
fun<T> subLists(a : List<T>?) : List<List<T>>? {
    if (a == null) return null
    if (a.isEmpty()) return listOf<List<T>>()
    val result : MutableList<List<T>> = mutableListOf<List<T>>()
    for (i in 1..a.size) {
        result.addAll(listOf(a.subList(0, i)))
    }
    return result
}

/*  countElements will count the total number of elements in a list  *  of lists
*  An element in the list or the list itself may be null
*  Null is counted as 0 
*  Ex: countElements(subLists(listOf(1,2,3)))    // returns 6
*  Ex: countElements(null)                       // returns 0
*/ 
fun<T> countElements(a : List<List<T>?>?) : Int? {
    if (a == null) return null
    var result : Int = 0
    for (i in a) {
        if (i != null) {
            for (j in i) {
                if (j != null) ++result
            }
        }
    }
    return result
}

/*  listApply will aply a binary function, f, to elements of a list
*  Should work like listApply(f,[[x1, x2, x3] [y1, y2], [w1]]) = 
* [f(x1, f(x2, x3)), f(y1, y2), w1]
*  The second parameter, the list of lists, may be null, in which    *  case the function should return null
*  Ex: fun add(x : Int, y : Int) : Int = x + y
*  Ex: listApply(::add, subLists(listOf(1,2,3))) // returns [1, 3, 6]
*  Ex: listApply(::add, null)                    // null
*/ 
fun<T : Any> listApply(f : (T, T) -> T, a : List<List<T>>?) : List<T>? {
    if (a == null) return null
    val result : MutableList<T> = mutableListOf()
    for (i in a) {
        if (i.size == 1) result.add(i.head)
        else if (i.size != 0) {
            val apply : T = f(i.get(i.size - 1), i.get(i.size - 2))
            val temp : MutableList<T> = i.dropLast(2).toMutableList()
            temp.add(apply)
            val recurse : List<T>? = listApply(f, listOf(temp))
            if (recurse != null) result.addAll(recurse)
        }
    }
    return result
}

/*  composeList takes a list a, and builds a function that is the    *  composition of the functions in the list a
*  each function in the list is a unary function (takes one argument)
*  This function is not null safe
*  Ex:   fun add1(x : Int) : Int = x + 1
*  Ex:   fun add2(x : Int) : Int = x + 2
*  Ex:   val f = composeList(listOf(::add1,::add2)) 
*  Ex:   f(4) // returns 7 
*/ 
fun<T : Any> composeList(a : List<(T) -> T>) : (T) -> T {
   if (a.size == 1) return a.head
   val f = compose(a.head, a.get(1))
   val funList = mutableListOf(f)
   funList.addAll(a.drop(2).toMutableList())
   return composeList(funList)
}
