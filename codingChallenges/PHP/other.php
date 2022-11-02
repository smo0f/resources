<?php
    













    function countTrue(array $args = []) : int
    {
        $count = 0;
        foreach ($args as $value) {
            if ($value) {$count++;}
        }
        return $count;
    }
    // function countTrue(array $args = []) : int
    // {
    //     return array_sum($args);
    // }


    echo countTrue([true, false, false, true, false]); // ➞ 2
    echo "\n";
    
    echo countTrue([false, false, false, false]); // ➞ 0
    echo "\n";
    
    echo countTrue([]); // ➞ 0
    echo "\n";









?>