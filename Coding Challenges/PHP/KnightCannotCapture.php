<?php

    // I would change cannotCapture to canKnightCaptureOtherKnight
    // I feel like the name in a negative sense make things more confusing 
    
    function cannotCapture(array $chessBoard) : bool
    {
        foreach ($chessBoard as $rowIndex => $row) {
            if (implode('', $row) == 0) continue; // no knights on row
            foreach ($row as $squareIndex => $squareVale) {
                if ($squareVale) { // if knight
                    $searchMap = createSearchMap($rowIndex, $squareIndex);
                    if (knightCanCapture($chessBoard, $searchMap)) return false;
                }
            }
        }
        return true;
    }

    function createSearchMap(int $rowIndex, int $squareIndex) : array
    {
        return [
            // top check
            [$rowIndex - 2, $squareIndex - 1],
            [$rowIndex - 2, $squareIndex + 1],
            // right check
            [$rowIndex - 1, $squareIndex + 2],
            [$rowIndex + 1, $squareIndex + 2],
            // bottom check
            [$rowIndex + 2, $squareIndex - 1],
            [$rowIndex + 2, $squareIndex + 1],
            // left check
            [$rowIndex - 1, $squareIndex - 2],
            [$rowIndex + 1, $squareIndex - 2],
        ];
    }

    function knightCanCapture(array $chessBoard, array $searchMap)
    {
        foreach ($searchMap as $checkArray) {
            $rowIndex = $checkArray[0];
            $squareIndex = $checkArray[1];
            if ($rowIndex < 0 || $squareIndex < 0) continue; // off board
            if ($rowIndex > 7 || $squareIndex > 7) continue; // off board
            if ($chessBoard[$rowIndex][$squareIndex]) return true;
        }
        return false;
    }

    // tests
    var_dump('test_create_search_map_creates_correctly', createSearchMap(3,4) == [
        [1,3],
        [1,5],
        [2,6],
        [4,6],
        [5,3],
        [5,5],
        [2,2],
        [4,2],
    ]);

    var_dump('test_cannot_capture_no_knight_can_capture', cannotCapture([
        [0, 0, 0, 1, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 1, 0, 1, 0],
        [0, 1, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 1, 0, 0, 0, 0, 0, 1],
        [0, 0, 0, 0, 1, 0, 0, 0]
    ]) === true);
      
    var_dump('test_cannot_capture_at_least_one_knight_can_capture', cannotCapture([
        [1, 0, 1, 0, 1, 0, 1, 0],
        [0, 1, 0, 1, 0, 1, 0, 1],
        [0, 0, 0, 0, 1, 0, 1, 0],
        [0, 0, 1, 0, 0, 1, 0, 1],
        [1, 0, 0, 0, 1, 0, 1, 0],
        [0, 0, 0, 0, 0, 1, 0, 1],
        [1, 0, 0, 0, 1, 0, 1, 0],
        [0, 0, 0, 1, 0, 1, 0, 1]
    ]) === false);




    // better solution 
    // function cannotCapture($chessBoard) {
    //     $yMove = [1, 2, 2, 1,-1,-2,-2,-1];
    //     $xMove = [2, 1,-1,-2,-2,-1, 1, 2];
    //     for ($y=0; $y < sizeof($chessBoard); $y++) {
    //         for ($x=0; $x < sizeof($chessBoard); $x++) {
    //             if ($chessBoard[$y][$x]) {
    //                 for ($i=0; $i < sizeof($xMove); $i++) { // potential moves for a knight 8
    //                     if (
    //                         isset($chessBoard[$y+$yMove[$i]][$x+$xMove[$i]]) && 
    //                         $chessBoard[$y+$yMove[$i]][$x+$xMove[$i]] == 1
    //                     ) {
    //                         return false;
    //                     }
    //                 }
    //             }	
    //         }
    //     }
    //     return true;
    // }

   
?>