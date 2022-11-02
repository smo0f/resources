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

     
    function countBattleships2(array $gameBoard) : array
    {
        $searchY = [1,1,0,-1,-1,-1,0,1];
        $searchX = [0,1,1,1,0,-1,-1,-1];

        $alreadyFoundShipPeaces = [];

        $subs = 0;
        $patrolShips = 0;
        $battleships = 0;

        for ($y=0; $y < count($gameBoard); $y++) { // y board axis
            for ($x=0; $x < count($gameBoard[0]); $x++) { // x board axis
                $shipPeacesCount = 0;
                if ($gameBoard[$y][$x] && !in_array("{$y}{$x}",$alreadyFoundShipPeaces)) { // found a ship peace
                    $alreadyFoundShipPeaces[] = "{$y}{$x}";
                    $shipPeacesCount++;
                    for ($i=0; $i < count($searchY); $i++) { // first search
                        $yAxis = $y + $searchY[$i];
                        $xAxis = $x + $searchX[$i];
                        $indexStringKey = $yAxis . $xAxis;
                        if (
                            isset($gameBoard[$yAxis][$xAxis]) && 
                            $gameBoard[$yAxis][$xAxis] &&
                            !in_array($indexStringKey,$alreadyFoundShipPeaces)
                        ) {
                            $alreadyFoundShipPeaces[] = $indexStringKey;
                            $shipPeacesCount++;
                            for ($si=0; $si < count($searchY); $si++) { // second search
                                $subIndexStringKey = ($yAxis + $searchY[$si]) . ($xAxis + $searchX[$si]);
                                if (
                                    isset($gameBoard[$yAxis + $searchY[$si]][$xAxis + $searchX[$si]]) && 
                                    $gameBoard[$yAxis + $searchY[$si]][$xAxis + $searchX[$si]] &&
                                    !in_array($subIndexStringKey,$alreadyFoundShipPeaces)
                                ) {
                                    $alreadyFoundShipPeaces[] = $subIndexStringKey;
                                    $shipPeacesCount++;      
                                }
                            }
                        }
                    }
                    switch ($shipPeacesCount) {
                        case 1: $subs++; break;
                        case 2: $patrolShips++; break;
                        default: $battleships++; break;
                    }
                }
            }
        }
        return [$subs,$patrolShips,$battleships];
    }

    $time_start = microtime(true);
    for ($i=0; $i < 100000; $i++) { 
        $battleshipCount = countBattleships2([
            [0,0,0,0,0,0,0,1],
            [0,1,0,0,0,1,0,0],
            [0,1,0,0,0,0,0,0],
            [0,0,0,0,0,1,0,0],
            [0,0,0,0,0,1,1,0],
            [1,1,1,0,0,0,0,0]
        ]);
    }
    $time_end = microtime(true);
    $execution_time = ($time_end - $time_start); // seconds
    echo "Total Execution Time countBattleships for loop: {$execution_time} seconds";


    // vs


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

    echo "\n";
    $time_start = microtime(true);
    for ($i=0; $i < 100000; $i++) { 
        $battleshipCount = countBattleships([
            [0,0,0,0,0,0,0,1],
            [0,1,0,0,0,1,0,0],
            [0,1,0,0,0,0,0,0],
            [0,0,0,0,0,1,0,0],
            [0,0,0,0,0,1,1,0],
            [1,1,1,0,0,0,0,0]
        ]);
    }
    $time_end = microtime(true);
    $execution_time = ($time_end - $time_start); // seconds
    echo "Total Execution Time countBattleships recursive function: {$execution_time} seconds";


    // vs


    // Lucas code
    function shipCount($board)
    {
        $subs = 0;
        $patrols = 0;
        $destroyers = 0;

        for ($row=0; $row < count($board); $row++) {
            for ($col=0; $col < count($board[$row]); $col++) {
                switch (shipLength($board, $row, $col, 0)) {
                    case 1:
                        $subs++;
                        break;
                    case 2:
                        $patrols++;
                        break;
                    case 3:
                        $destroyers++;
                        break;
                }
            }
        }
        return [$subs, $patrols, $destroyers];
    }
    function shipLength(&$board, $row, $col, $count)
    {
        //out of bounds
        if(count($board) <= $row || $row < 0 || count($board[$row]) <= $col || $col < 0) {
            return 0;
        }

        //if ship segment
        if ($board[$row][$col]) {
            //clear current ship segment
            $board[$row][$col] = 0;

            //recursively search for neighboring segments
            $down = shipLength($board, $row+1, $col, $count);
            $right = shipLength($board, $row, $col+1, $count);

            //return count + current segment + any neighboring segments
            return $count + 1 + $down + $right;
        }

        return 0;
    }
    
    echo "\n";
    $time_start = microtime(true);
    for ($i=0; $i < 100000; $i++) { 
        $battleshipCount = shipCount([
            [0,0,0,0,0,0,0,1],
            [0,1,0,0,0,1,0,0],
            [0,1,0,0,0,0,0,0],
            [0,0,0,0,0,1,0,0],
            [0,0,0,0,0,1,1,0],
            [1,1,1,0,0,0,0,0]
        ]);
    }
    $time_end = microtime(true);
    $execution_time = ($time_end - $time_start); // seconds
    echo "Total Execution Time shipCount: {$execution_time} seconds";


    // vs


    // Lucas + Russell code
    function countBattleshipsNew($gameBoard) : array
    {
        $shipCounts = [0,0,0]; // index -> 0=sub, 1=patrolShips, 2=battleships

        for ($y=0; $y < count($gameBoard); $y++) { // y board axis
            for ($x=0; $x < count($gameBoard[0]); $x++) { // x board axis
                if ($gameBoard[$y][$x]) {
                    $shipCounts[recursiveShipCountNew($y, $x, $gameBoard) - 1] += 1; //  - 1 to set the index correctly
                }
            }
        }
        return $shipCounts;
    }
    function recursiveShipCountNew($y, $x, &$gameBoard) : int 
    {    
        $gameBoard[$y][$x] = 0; // set the ship peace to water
        $searchY = [1,1,0,-1,-1,-1,0,1];
        $searchX = [0,1,1,1,0,-1,-1,-1];
        $count = 1;

        for ($i=0; $i < count($searchY); $i++) {
            $yAxis = $y + $searchY[$i];
            $xAxis = $x + $searchX[$i];
            if ($gameBoard[$yAxis][$xAxis] ?? null) {
                $count += recursiveShipCountNew($yAxis, $xAxis, $gameBoard);
            }
        }
        return $count;
    }   
    
    echo "\n";
    $time_start = microtime(true);
    for ($i=0; $i < 100000; $i++) { 
        $battleshipCount = countBattleshipsNew([
            [0,0,0,0,0,0,0,1],
            [0,1,0,0,0,1,0,0],
            [0,1,0,0,0,0,0,0],
            [0,0,0,0,0,1,0,0],
            [0,0,0,0,0,1,1,0],
            [1,1,1,0,0,0,0,0]
        ]);
    }
    $time_end = microtime(true);
    $execution_time = ($time_end - $time_start); // seconds
    echo "Total Execution Time countBattleshipsNew: {$execution_time} seconds";

    // note 
        // $gameBoard[$yAxis][$xAxis] ?? null is faster then 
        // isset($gameBoard[$yAxis][$xAxis]) && $gameBoard[$yAxis][$xAxis]

    // 100,000 times
    // Total Execution Time countBattleships for loop:              1.881068944931 seconds
    // Total Execution Time countBattleships recursive function:    2.3593790531158 seconds
    // Total Execution Time shipCount:                              1.356917142868 seconds
    // Total Execution Time countBattleshipsNew:                    1.1244261264801 seconds

    // Total Execution Time countBattleships for loop:              1.9097890853882 seconds
    // Total Execution Time countBattleships recursive function:    2.35227394104 seconds
    // Total Execution Time shipCount:                              1.4136919975281 seconds
    // Total Execution Time countBattleshipsNew:                    1.1356880664825 seconds

    // Total Execution Time countBattleships for loop:              1.892410993576 seconds
    // Total Execution Time countBattleships recursive function:    2.2862861156464 seconds
    // Total Execution Time shipCount:                              1.4157118797302 seconds
    // Total Execution Time countBattleshipsNew:                    1.140086889267 seconds

    // Total Execution Time countBattleships for loop:              1.8511080741882 seconds
    // Total Execution Time countBattleships recursive function:    2.3284640312195 seconds
    // Total Execution Time shipCount:                              1.3610029220581 seconds
    // Total Execution Time countBattleshipsNew:                    1.0685720443726 seconds

    // Total Execution Time countBattleships for loop:              1.9041700363159 seconds
    // Total Execution Time countBattleships recursive function:    2.4550161361694 seconds
    // Total Execution Time shipCount:                              1.3834609985352 seconds
    // Total Execution Time countBattleshipsNew:                    1.1900749206543 seconds

    




    // Total Execution Time countBattleships for loop:              2.0255100727081 seconds
    // Total Execution Time countBattleships recursive function:    2.3220870494843 seconds

    // Total Execution Time countBattleships for loop:              1.8063309192657 seconds
    // Total Execution Time countBattleships recursive function:    2.2946789264679 seconds

    // Total Execution Time countBattleships for loop:              1.820335149765 seconds
    // Total Execution Time countBattleships recursive function:    2.3164591789246 seconds

    // Total Execution Time countBattleships for loop:              1.888603925705 seconds
    // Total Execution Time countBattleships recursive function:    2.4131319522858 seconds

    // Total Execution Time countBattleships for loop:              1.8699629306793 seconds
    // Total Execution Time countBattleships recursive function:    2.2408409118652 seconds

    // Total Execution Time countBattleships for loop:              1.7997150421143 seconds
    // Total Execution Time countBattleships recursive function:    2.3277268409729 seconds


    // Total Execution Time countBattleships for loop:              1.8351230621338 seconds
    // Total Execution Time countBattleships recursive function:    2.2612011432648 seconds
    // Total Execution Time shipCount:                              1.2982971668243 seconds

    // Total Execution Time countBattleships for loop:              1.8366930484772 seconds
    // Total Execution Time countBattleships recursive function:    2.322968006134 seconds
    // Total Execution Time shipCount:                              1.3074448108673 seconds

    // Total Execution Time countBattleships for loop:              1.8736109733582 seconds
    // Total Execution Time countBattleships recursive function:    2.2733731269836 seconds
    // Total Execution Time shipCount:                              1.305783033371 seconds


    echo "\n\n";
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






    echo "\n\n";
    var_dump(countBattleships2([
        [0,0,0,0,0,0,0,1],
        [0,1,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,0,0,0,1,0,0],
        [0,0,0,0,0,1,1,0],
        [1,1,1,0,0,0,0,0]
    ]) == [2,1,2]);

    var_dump(countBattleships2([
        [0,1,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,0,0,0,1,1,0],
        [1,1,1,0,0,0,0,0]
    ]) == [1,2,1]);

    var_dump(countBattleships2([
        [1,0,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,1]
    ]) == [2,1,1]);
    
    
    
    
    
    
    
    echo "\n\n";
    var_dump(shipCount([
        [0,0,0,0,0,0,0,1],
        [0,1,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,0,0,0,1,0,0],
        [0,0,0,0,0,1,1,0],
        [1,1,1,0,0,0,0,0]
    ]) == [2,1,2]);

    var_dump(shipCount([
        [0,1,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,0,0,0,1,1,0],
        [1,1,1,0,0,0,0,0]
    ]) == [1,2,1]);

    var_dump(shipCount([
        [1,0,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,1]
    ]) == [2,1,1]);








    
    echo "\n\n";
    var_dump(countBattleshipsNew([
        [0,0,0,0,0,0,0,1],
        [0,1,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,0,0,0,1,0,0],
        [0,0,0,0,0,1,1,0],
        [1,1,1,0,0,0,0,0]
    ]) == [2,1,2]);

    var_dump(countBattleshipsNew([
        [0,1,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,0,0,0,1,1,0],
        [1,1,1,0,0,0,0,0]
    ]) == [1,2,1]);

    var_dump(countBattleshipsNew([
        [1,0,0,0,0,1,0,0],
        [0,1,0,0,0,0,0,0],
        [0,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,1]
    ]) == [2,1,1]);
?>