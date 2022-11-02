<?php
    // Create a function that takes an array and finds the integer which appears an odd number of times.

    // Examples
    // findOdd([1, 1, 2, -2, 5, 2, 4, 4, -1, -2, 5]) ➞ -1
    
    // findOdd([20, 1, 1, 2, 2, 3, 3, 5, 5, 4, 20, 4, 5]) ➞ 5
    
    // findOdd([10]) ➞ 10

    // Notes
    // There will always only be one integer that appears an odd number of times.

    function findOdd(array $numbers) : int
    {
        $numbersAndOccurrences = array_count_values($numbers);
        foreach ($numbersAndOccurrences as $number => $count) {
            if ($count % 2 == 1) {return $number;}
        }
    }

    // function findOdd(array $numbers) {
    //     foreach(array_count_values($numbers) as $number => $count) if ($count % 2) return $number;
    // }

    var_dump(findOdd([1, 1, 2, -2, 5, 2, 4, 4, -1, -2, 5]) == -1);
    var_dump(findOdd([20, 1, 1, 2, 2, 3, 3, 5, 5, 4, 20, 4, 5]) == 5);
    var_dump(findOdd([10]) == 10);
?>