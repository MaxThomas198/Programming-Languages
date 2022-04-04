module Lists where
import Data.List

-- Requires an integer n and Outputs a list of numbers from 1 to n
countingNumbers :: [Integer]
countingNumbers = [1..]

-- Requires an integer y which is the length of list
-- Also requires an integer x which is the number being multiplied
-- Then x is multiplied by y to create a list of multiples of x, y times.
muliplesOfNumbers :: Integer -> [Integer]
muliplesOfNumbers y = [x * y | x <- [1..]]

-- Requires an integer n and Outputs a list of Woodall numbers from 1 to n
woodallNumbers :: [Integer]
woodallNumbers = [x * 2^x - 1 | x <- [1..]]

-- Requires an integer n and Outputs a list of Padovan numbers from 1 to n
padovanNumbers :: [Integer]
padovanNumbers = unfoldr f (1, 1, 1)
  where
    f (a, b, c) = Just (a, (b, c, a + b))

-- Requires a binary comparator and two sorted lists 
-- Outputs a single sorted list based on the comparator
-- Chooses the element from the first list if true and from the second list if false.
order :: (Num a, Ord a) => [a] -> [a] -> [a]
order f xs1 [] = xs1
order f [] xs2 = xs2
order f xs1 xs2 = 
     if head xs1 f head xs2
     then (head xs1) : (merge (tail xs1) xs2)
     else (head xs2) : (merge (tail xs2) xs1)
	 
-- Requires a list and Outputs a list of lists 
-- Each sub-list is a pair of elements (in sequence) in the original list
pairUp  :: [a] -> [[a]]
pairUp  [] = []
pairUp xs =
    let (ys, zs) = splitAt 2 xs
    in  ys : pairUp zs
	
-- Requires a list and Outputs the run-length encoding of that list
-- The run-length encoding is a list of tuples where each tuple is a pair 
-- The pairs consist of the number of elements found consecutively in the list
runLengthEncoding :: (Eq a) => [a] -> [(a, Int)]
runLengthEncoding = map (\x -> (head x, length x)) . group

-- This function requires a pair of functions and a list
-- This function is helping listPairApply by applying both functions
listPairApplyHelper :: (a -> a -> a) -> [a] -> a
listPairApplyHelper [f1, f2] xs | ((length xs) <= 2) = foldl f (head xs) (tail xs) 
listPairApplyHelper [f1, f2] xs = listPairApplyHelper [f1, f2] (w ++ [f1 (v !! 0) f2(v !! 1)])
    where
        w = (take ((length xs) - 2) xs) -- all but the last two elements of xs
        v = (drop ((length xs) - 2) xs) -- the last two elements of xs

-- This function requires a pair of functions and a list of lists
-- It applies apply a binary function f chosen in order from a list of functions to the pair of elements or single element
listPairApply :: (a -> a -> a) -> [[a]] -> [a]
listPairApply [f1, f2] [] = []
listPairApply [f1, f2] xs = [listPairApplyHelper [f1, f2] x | x <- xs]

-- This function requires a list and outputs a function that is the composition of the functions in the list
composeList :: [(a -> a)] -> (a -> a)
composeList [] = (\x -> x)
composeList xs = foldl (.) (head xs) (tail xs)