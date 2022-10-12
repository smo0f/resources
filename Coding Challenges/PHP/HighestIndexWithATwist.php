<?php
    // Given a name, return the letter with the highest index in alphabetical order, with its corresponding index, in the form of a string.

    function alphabetIndex(string $string) : string
    {
        // my notes split string into array → sort array descending → get first item → find index → make string
        $alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];

        $stringArray = str_split($string);
        sort($stringArray);
        $highestValeCharacter = array_pop($stringArray);

        return (array_search($highestValeCharacter, $alphabet) + 1) . $highestValeCharacter;
    }

    var_dump(alphabetIndex('Flavio') == '22v');

    var_dump(alphabetIndex('Andrey') == '25y');

    var_dump(alphabetIndex('Oscar') == '19s');
?>