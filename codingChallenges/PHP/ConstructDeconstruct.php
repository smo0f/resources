<?php
    // ? https://edabit.com/challenge/e3RdbwNqcso47X3gu
    // Given a string, create a function which outputs an array, building and deconstructing the string letter by letter. See the examples below for some helpful guidance.

    // Examples
    // constructDeconstruct("Hello") ➞ [
    //   "H",
    //   "He",
    //   "Hel",
    //   "Hell",
    //   "Hello",
    //   "Hell",
    //   "Hel",
    //   "He",
    //   "H"
    // ]

    // constructDeconstruct("edabit") ➞ [
    //   "e",
    //   "ed",
    //   "eda",
    //   "edab",
    //   "edabi",
    //   "edabit",
    //   "edabi",
    //   "edab",
    //   "eda",
    //   "ed",
    //   "e"
    // ]

    // constructDeconstruct("the sun") ➞ [
    //   "t",
    //   "th",
    //   "the",
    //   "the ",
    //   "the s",
    //   "the su",
    //   "the sun",
    //   "the su",
    //   "the s",
    //   "the ",
    //   "the",
    //   "th",
    //   "t"
    // ]

    function constructDeconstruct($string) {
        $stringCount = strlen($string);
        // first part of array
        for ($i=0; $i < $stringCount; $i++) { 
            $arrayOfStrings[] = substr($string, 0, $i + 1);
        }
        // second part of array
        for ($i=$stringCount; $i > 1; $i--) { 
            $arrayOfStrings[] = substr($string, 0, $i - 1);
        }
        return $arrayOfStrings ?? [];
    }

    var_dump(constructDeconstruct('Ham '));
    var_dump(constructDeconstruct('Fun! Fun!'));
    var_dump(constructDeconstruct(''));
    


    // *** Some ones better solution ***
    // function constructDeconstruct($s) {
    //     $res = [];
    //     for ($x = 1; $x <= strlen($s); $x++) {
    //         array_push($res, substr($s, 0, $x));
    //     }
    //     return array_merge($res, array_slice(array_reverse($res), 1));
    // }
?>