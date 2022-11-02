<?php
    
    // variable grid
    // variable row
    // a ship must be separated by water 0
    // ships are 1
    // one ship piece is a submarine
    // 2 ship pieces is a patrol boat
    // 3 ship pieces is a battleship
    // the function returns a count of submarines, patrol ships, and battleships
    // [submarines, patrolShips, battleships]

    // function countBattleships(array $gameBoard) : array
    // {
    //     // $searchYX = [[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]];
    //     $searchY = [1,1,0,-1,-1,-1,0,1];
    //     $searchX = [0,1,1,1,0,-1,-1,-1];

    //     $alreadyFoundShipPeaces = [];

    //     $subs = 0;
    //     $patrolShips = 0;
    //     $battleships = 0;

    //     for ($y=0; $y < count($gameBoard); $y++) { // y board axis
    //         for ($x=0; $x < count($gameBoard[0]); $x++) { // x board axis
    //             $shipPeacesCount = 0;
    //             if ($gameBoard[$y][$x] && !in_array("{$y}{$x}",$alreadyFoundShipPeaces)) { // found a ship peace
    //                 $alreadyFoundShipPeaces[] = "{$y}{$x}";
    //                 $shipPeacesCount++;
    //                 echo '$shipPeacesCount ' . $shipPeacesCount;
    //                 echo "\n";
    //                 echo "{$y}{$x}";
    //                 echo "\n";
    //                 for ($i=0; $i < count($searchY); $i++) { // first search
    //                     $yAxis = $y + $searchY[$i];
    //                     $xAxis = $x + $searchX[$i];
    //                     $indexStringKey = $yAxis . $xAxis;
    //                     echo 'first search';
    //                     echo "\n";
    //                     echo 'index -> ' . $indexStringKey;
    //                     echo "\n";
    //                     if (
    //                         isset($gameBoard[$yAxis][$xAxis]) && 
    //                         $gameBoard[$yAxis][$xAxis] &&
    //                         !in_array($indexStringKey,$alreadyFoundShipPeaces)
    //                     ) {
    //                         $alreadyFoundShipPeaces[] = $indexStringKey;
    //                         $shipPeacesCount++;
    //                         echo '$shipPeacesCount ' . $shipPeacesCount;
    //                         echo "\n";
    //                         echo '$indexStringKey ' . $indexStringKey;
    //                         echo "\n";
    //                         for ($si=0; $si < count($searchY); $si++) { // second search
    //                             $subIndexStringKey = ($yAxis + $searchY[$si]) . ($xAxis + $searchX[$si]);
    //                             echo 'second search';
    //                             echo "\n";
    //                             echo 'index -> ' . ($yAxis + $searchY[$si]) . ($xAxis + $searchX[$si]);
    //                             echo "\n";
    //                             if (
    //                                 isset($gameBoard[$yAxis + $searchY[$si]][$xAxis + $searchX[$si]]) && 
    //                                 $gameBoard[$yAxis + $searchY[$si]][$xAxis + $searchX[$si]] &&
    //                                 !in_array($subIndexStringKey,$alreadyFoundShipPeaces)
    //                             ) {
    //                                 $alreadyFoundShipPeaces[] = $subIndexStringKey;
    //                                 $shipPeacesCount++;      
    //                                 echo '$shipPeacesCount ' . $shipPeacesCount;
    //                                 echo "\n";
    //                                 echo ($yAxis + $searchY[$si]) . ($xAxis + $searchX[$si]);
    //                                 echo "\n";
    //                             }
    //                         }
    //                     }
    //                 }
    //                 switch ($shipPeacesCount) {
    //                     case 1: $subs++; break;
    //                     case 2: $patrolShips++; break;
    //                     default: $battleships++; break;
    //                 }
    //                 var_dump($subs,$patrolShips,$battleships);
    //                 echo "\n";echo "\n";echo "\n";echo "\n";
    //             }
    //         }
    //     }
    //     return [$subs,$patrolShips,$battleships];
    // }


    // function countBattleships(array $gameBoard) : array
    // {
    //     $searchY = [1,1,0,-1,-1,-1,0,1];
    //     $searchX = [0,1,1,1,0,-1,-1,-1];

    //     $alreadyFoundShipPeaces = [];

    //     $subs = 0;
    //     $patrolShips = 0;
    //     $battleships = 0;

    //     for ($y=0; $y < count($gameBoard); $y++) { // y board axis
    //         for ($x=0; $x < count($gameBoard[0]); $x++) { // x board axis
    //             $shipPeacesCount = 0;
    //             if ($gameBoard[$y][$x] && !in_array("{$y}{$x}",$alreadyFoundShipPeaces)) { // found a ship peace
    //                 $alreadyFoundShipPeaces[] = "{$y}{$x}";
    //                 $shipPeacesCount++;
    //                 for ($i=0; $i < count($searchY); $i++) { // first search
    //                     $yAxis = $y + $searchY[$i];
    //                     $xAxis = $x + $searchX[$i];
    //                     $indexStringKey = $yAxis . $xAxis;
    //                     if (
    //                         isset($gameBoard[$yAxis][$xAxis]) && 
    //                         $gameBoard[$yAxis][$xAxis] &&
    //                         !in_array($indexStringKey,$alreadyFoundShipPeaces)
    //                     ) {
    //                         $alreadyFoundShipPeaces[] = $indexStringKey;
    //                         $shipPeacesCount++;
    //                         for ($si=0; $si < count($searchY); $si++) { // second search
    //                             $subIndexStringKey = ($yAxis + $searchY[$si]) . ($xAxis + $searchX[$si]);
    //                             if (
    //                                 isset($gameBoard[$yAxis + $searchY[$si]][$xAxis + $searchX[$si]]) && 
    //                                 $gameBoard[$yAxis + $searchY[$si]][$xAxis + $searchX[$si]] &&
    //                                 !in_array($subIndexStringKey,$alreadyFoundShipPeaces)
    //                             ) {
    //                                 $alreadyFoundShipPeaces[] = $subIndexStringKey;
    //                                 $shipPeacesCount++;      
    //                             }
    //                         }
    //                     }
    //                 }
    //                 switch ($shipPeacesCount) {
    //                     case 1: $subs++; break;
    //                     case 2: $patrolShips++; break;
    //                     default: $battleships++; break;
    //                 }
    //             }
    //         }
    //     }
    //     return [$subs,$patrolShips,$battleships];
    // }



    // function countBattleships(array $gameBoard) : array
    // {
    //     $alreadyFoundShipPeaces = [];
    //     $shipCount = [0,0,0];

    //     for ($y=0; $y < count($gameBoard); $y++) { // y board axis
    //         for ($x=0; $x < count($gameBoard[0]); $x++) { // x board axis
    //             if ($gameBoard[$y][$x] && !in_array("{$y}{$x}",$alreadyFoundShipPeaces)) {
    //                 var_dump('out of ',$y, $x);
    //                 $recursiveShipCountResult = recursiveShipCount($y, $x, $gameBoard, $alreadyFoundShipPeaces);
    //                 var_dump('$recursiveShipCountResult[count] ',$recursiveShipCountResult['count']);
    //                 $shipCount[$recursiveShipCountResult['count']] += 1;
    //                 $alreadyFoundShipPeaces = $recursiveShipCountResult['alreadyFoundShipPeaces'];
    //                 var_dump('out of ',$recursiveShipCountResult, $shipCount);
    //                 echo "\n";
    //                 echo "\n";
    //                 echo "\n";
    //             }
    //         }
    //     }
    //     return $shipCount;
    // }

    // function recursiveShipCount($y, $x, $gameBoard, $alreadyFoundShipPeaces)    
    // {    
    //     $searchY = [1,1,0,-1,-1,-1,0,1];
    //     $searchX = [0,1,1,1,0,-1,-1,-1];
    //     $alreadyFoundShipPeaces[] = $y . $x;
    //     $count = 0;

    //     for ($i=0; $i < count($searchY); $i++) {
    //         $yAxis = $y + $searchY[$i];
    //         $xAxis = $x + $searchX[$i];
    //         $indexStringKey = $yAxis . $xAxis;
    //         if (
    //             isset($gameBoard[$yAxis][$xAxis]) && 
    //             $gameBoard[$yAxis][$xAxis] &&
    //             !in_array($indexStringKey,$alreadyFoundShipPeaces)
    //         ) {
    //             var_dump("indexStringKey -> $indexStringKey");
    //             // $alreadyFoundShipPeaces[] = $indexStringKey;
    //             $count++;
    //             $recursiveShipCountResult = recursiveShipCount($yAxis, $xAxis, $gameBoard, $alreadyFoundShipPeaces);
    //             var_dump("recursiveShipCountResult -> ", $recursiveShipCountResult);
    //             var_dump("count -> ", $count);
    //             $count += $recursiveShipCountResult['count'];
    //             var_dump("count -> ", $count);
    //             $alreadyFoundShipPeaces = $recursiveShipCountResult['alreadyFoundShipPeaces'];
    //         }
    //     }
    //     return ['count' => $count, 'alreadyFoundShipPeaces' => $alreadyFoundShipPeaces];
    //     // if ($n < 0)    
    //     //     return -1; // Wrong value    
    //     // if ($n == 0)    
    //     //     return 1; // Terminating condition   
    //     // return ($n * factorial ($n -1));    
    // }   

    function countBattleships(array $gameBoard) : array
    {
        $alreadyFoundShipPeaces = [];
        $shipCounts = [0,0,0]; // index -> 0=sub, 1=patrolShips, 2=battleships

        for ($y=0; $y < count($gameBoard); $y++) { // y board axis
            for ($x=0; $x < count($gameBoard[0]); $x++) { // x board axis
                if ($gameBoard[$y][$x] && !in_array($y . $x, $alreadyFoundShipPeaces)) {
                    $result = recursiveShipCount($y, $x, $gameBoard, $alreadyFoundShipPeaces);
                    $shipCounts[$result['count']] += 1; 
                    $alreadyFoundShipPeaces = $result['alreadyFoundShipPeaces'];
                }
            }
        }
        return $shipCounts;
    }

    function recursiveShipCount($y, $x, $gameBoard, $alreadyFoundShipPeaces) : array 
    {    
        $searchY = [1,1,0,-1,-1,-1,0,1];
        $searchX = [0,1,1,1,0,-1,-1,-1];
        $alreadyFoundShipPeaces[] = $y . $x;
        $count = 0;

        for ($i=0; $i < count($searchY); $i++) {
            $yAxis = $y + $searchY[$i];
            $xAxis = $x + $searchX[$i];
            $indexStringKey = $yAxis . $xAxis;
            if (
                isset($gameBoard[$yAxis][$xAxis]) && 
                $gameBoard[$yAxis][$xAxis] &&
                !in_array($indexStringKey, $alreadyFoundShipPeaces)
            ) {
                $count++;
                $result = recursiveShipCount($yAxis, $xAxis, $gameBoard, $alreadyFoundShipPeaces);
                $count += $result['count'];
                $alreadyFoundShipPeaces = $result['alreadyFoundShipPeaces'];
            }
        }
        return ['count' => $count, 'alreadyFoundShipPeaces' => $alreadyFoundShipPeaces];
    }   

    var_dump(countBattleships([
        [0,0,0,0,0,0,0,1],
        [0,1,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,0,0,0,1,0,0],
        [0,0,0,0,0,1,1,0],
        [1,1,1,0,0,0,0,0]
    ]) == [2,1,2]);

    var_dump(countBattleships([
        [0,1,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,0,0,0,1,1,0],
        [1,1,1,0,0,0,0,0]
    ]) == [1,2,1]);

    var_dump(countBattleships([
        [1,0,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,1]
    ]) == [2,1,1]);

    var_dump(countBattleships([
        [0,1,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,0,0,0,1,1,1],
        [1,1,1,1,0,0,0,0]
    ]) == [1,1,1,1]);

?>