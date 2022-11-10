<?php

    namespace codingChallenges\designPatterns;
    // just a prototype++, tracer code
    // no sql injection protection

    // *** use as a prototype, testing strategy, documentation strategy, code strategy, also find a way to do mocks

    // ! work on ***********************************************************************
    // TODO: split into many classes for separation of logic and for testing***, Single responsibility
        // Component Integration (classes together), and Unit Tests
            // Component Integration (classes together)
                // QueryBuilder
            // individual classes and Unit Tests
                // where && whereOr
                // orderBy
                // select
                // others

    // TODO: Lots more work to do, lots of refactoring tests and code
    // can do after Core Integration Laravel*****
    // do smaller 

    // unit test 
        // where class
        // order by class
        // group by class
            // parts
    // component integration test
        // QueryBuilder
            // end

    use Exception;

    class QueryBuilderOld
    {
        private $selectRaw;
        private $tableName;
        private $groupBy = [];
        private $whereClauses = [];
        private $orderBy = [];

        private $comparisonOperator = ['=','>=','>','<=','<','!=','<>'];

        public function __construct(string $tableName) 
        {
            $tableName = trim($tableName);
            if (!$tableName) {
                throw new Exception("QueryBuilder class requires a table name to be passed in to the constructor.");
            }
            $this->tableName = $tableName;
        }
        
        public function selectRaw($selectRawString) : QueryBuilder
        {
            $this->selectRaw = $selectRawString;
            return $this;
        }

        public static function setTable($tableName) : QueryBuilder
        {
            return new QueryBuilder($tableName);
        }

        public function groupBy() : QueryBuilder
        {
            return $this;
        }

        // @QueryBuilder:WhereBuilder https://www.notion.so/fox-pest/FoxPay-API-Documentation-v1-0-0-6eb02b79040d47e9b497c9c68c716944 (002)
        public function where($mainInput, string $comparisonOperator = null, $valueToFind = null) : QueryBuilder
        {

            if (is_array($mainInput)) {
                $this->setWhereClauses($mainInput);
                return $this;
            }

            // then set array
            $this->setWhereClauses([[$mainInput, $comparisonOperator, $valueToFind]]);
            return $this;
        }

        // TODO: refactor this so that where and whereOr use the same code
        public function whereOr($mainInput, string $comparisonOperator = null, $valueToFind = null) : QueryBuilder
        {
            if (is_array($mainInput)) {
                $this->setWhereClauses($mainInput, 'whereOr', 'OR');
                return $this;
            }

            // then set array
            $this->setWhereClauses([[$mainInput, $comparisonOperator, $valueToFind]], 'whereOr', 'OR');
            return $this;
        }

        private function setWhereClauses(array $whereClauses, string $whereMethodType = 'where', string $whereConnectorType = 'AND')
        {
            foreach ($whereClauses as $whereClause) {
                $this->validateWhereClause($whereClause, $whereMethodType);
                $this->whereClauses[] = [$whereClause[0],$whereClause[1],$whereClause[2], $whereConnectorType];
            }
        }

        private function validateWhereClause(array $whereClause, string $whereMethodType) : void
        {
            $mainInput = isset($whereClause[0]) ? $whereClause[0] : null;
            $comparisonOperator = isset($whereClause[1]) ? $whereClause[1] : null;
            $valueToFind = isset($whereClause[2]) ? $whereClause[2] : null;

            if (gettype($mainInput) != 'string') {
                throw new Exception("QueryBuilder class '{$whereMethodType}' method requires the 'column name' be a string, '" . gettype($mainInput) . "' given.");
            }

            if ($mainInput == null || $comparisonOperator == null || $valueToFind == null) {
                throw new Exception("QueryBuilder class '{$whereMethodType}' method requires a 'column name', 'comparison operator', and a 'value to find' parameter if using the first paramiter as a column.");
            }

            if (!in_array($comparisonOperator, $this->comparisonOperator)) {
                throw new Exception("QueryBuilder class '{$whereMethodType}' method requires a comparison operator to be one of these acceptable comparison operators " . implode(', ', $this->comparisonOperator) . '.');
            }

            if (gettype($valueToFind) == 'array') {
                throw new Exception("QueryBuilder class '{$whereMethodType}' method requires the 'value to find' to be a string, '" . gettype($valueToFind) . "' given.");
            }
        }

        public function orderBy($orderBy) : QueryBuilder
        {
            if (is_array($orderBy)) {
                foreach ($orderBy as $orderByValue) {
                    // TODO:
                    // validate id array
                    // validate not number
                    $this->orderBy[] = $orderByValue;
                }
                return $this;
            }

            // then set array
            $this->orderBy[] = $orderBy;
            return $this;
        }

        public function reset()
        {
            $this->selectRaw = null;
            $this->tableName = null;
            $this->groupBy = null;
            $this->whereClauses = null;
            $this->orderBy = null;
        }

        public function get() : string
        {
            // construct SQL
            $sql = 'SELECT ';
            $sql .= $this->selectRaw ?? '*' . ' ';
            $sql .= "FROM {$this->tableName} ";
            // group by
            if ($this->whereClauses) {
                $sql = $this->whereSqlBuilder($sql);
            }
            // order by
            if ($this->orderBy) {
                $sql .= 'ORDER BY ' . implode(',',$this->orderBy);
            }
            $sql = trim($sql) . ';';
            return $sql;
        }

        private function whereSqlBuilder(string $sql) : string
        {
            foreach ($this->whereClauses as $key => $whereClause) {
                $columnName = $whereClause[0];
                $comparisonOperator = $whereClause[1];
                $valueToFind = $whereClause[2];
                $whereConnectorType = $whereClause[3];
                if ($key === array_key_first($this->whereClauses)) {
                    $sql .= "WHERE {$columnName} {$comparisonOperator} '{$valueToFind}' ";
                } else {
                    $sql .= "{$whereConnectorType} {$columnName} {$comparisonOperator} '{$valueToFind}' ";
                }
            }
            return $sql;
        }
    }
    
    // debugging
    // var_dump($sqlQuery = QueryBuilder::setTable('table_name'));
    // var_dump($sqlQuery->where('id', '=', 33));
    // var_dump($sqlQuery->orderBy('column_name'));
    // var_dump($sqlQuery->get());
    // die();

























    // test stuff ====================================================================================================
//     function assertEquals($value, $expectedValue)
//     {
//         echo $value === $expectedValue ? "\nPASSED ✓" : "\nFAILED X***";
//     }

//     function assertTrue($value)
//     {
//         echo $value == true ? "\nPASSED ✓" : "\nFAILED X***";
//     }

//     // tests criteria 1 works
//     echo "tests criteria 1 works";
//     $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', 33)->orderBy('column_name')->get();
//     assertEquals($sqlQuery, 'SELECT * FROM table_name WHERE id = 33 ORDER BY column_name');
//     echo "\n\n";

//     // tests criteria 2 works
//     echo 'tests criteria 2 works';
//     $queryBuilder = new QueryBuilder('table_name');
//     $sqlQuery = $queryBuilder->where([
//         ['id', '=', 34],
//         // ['name', 'LIKE', 'somthing'] // TODO: need to fix
//     ])->whereOr('admin', '=', 1)->orderBy('column_name')->get();
//     assertEquals($sqlQuery, "SELECT * FROM table_name WHERE id = 34 AND name LIKE '%somthing%' OR admin = 1 ORDER BY column_name");
//     echo "\n\n";

//     // WHERE clause tests
//     echo "WHERE clause builder tests";
//     echo "\ntests where method works, 1 where clause";
//     $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', 36)->get();
//     assertEquals($sqlQuery, "SELECT * FROM table_name WHERE id = '36';");
//     echo "\ntests where method works, 3 where clauses";
//     $sqlQuery = QueryBuilder::setTable('table_name')->where([
//         ['id', '=', 36],
//         ['name', '=', 'Sam'],
//         ['age', '=', 30.5],
//     ])->get();
//     assertEquals($sqlQuery, "SELECT * FROM table_name WHERE id = '36' AND name = 'Sam' AND age = '30.5';");
//     echo "\n\n";
//     // [[30]]

//     // acceptable parameters for 'where' method 'value to find'
//     echo "acceptable parameters for 'where' method 'value to find'";
//     echo "\n'value to find' = 36";
//     $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', 36)->get();
//     assertEquals($sqlQuery, "SELECT * FROM table_name WHERE id = '36';");
//     echo "\n'value to find' = true";
//     $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', true)->get();
//     assertEquals($sqlQuery, "SELECT * FROM table_name WHERE id = '1';");
//     echo "\n'value to find' = 'Jim'";
//     $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', 'Jim')->get();
//     assertEquals($sqlQuery, "SELECT * FROM table_name WHERE id = 'Jim';");
//     echo "\n'value to find' = 3.987";
//     $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', 3.987)->get();
//     assertEquals($sqlQuery, "SELECT * FROM table_name WHERE id = '3.987';");
//     echo "\n\n";

//     // exception in constructor
//     echo "exception is thrown if no table name is provided when constructing a QueryBuilder class.";
//     echo "\nnew class constructor";
//     try {
//         new QueryBuilder('');
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\nnew static class constructor";
//     try {
//         QueryBuilder::setTable('');
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\nnew class constructor empty string";
//     try {
//         new QueryBuilder('    ');
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\n\n";

//     // exception in where clause not enough parameters
//     echo "exception is thrown if not enough parameters are sent to the 'where' clause builder, not in array path";
//     echo "\nparameters sent (yes,no,no)";
//     try {
//         QueryBuilder::setTable('table_name')->where('id');
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\nparameters sent (yes,yes,no)";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','=');
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\nparameters sent (yes,yes,yes)";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','=','13');
//         assertTrue(true);
//     } catch (\Throwable $th) {
//         assertTrue(false);
//     }
//     echo "\n\n";

//     // exception in where clause 'value to find' 
//     echo "exception in where clause if 'value to find' is array.";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','=',['13']);
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\n\n";

//     // where comparisonOperators 
//     echo "exception is thrown if not valid comparison operators for where clause builder.";
//     echo "\ncomparison operator '55'";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','55','33');
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\ncomparison operator ' '";
//     try {
//         QueryBuilder::setTable('table_name')->where('id',' ','33');
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\ncomparison operator 'GT'";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','GT','33');
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\n\n";

//     echo "these comparison operators pass validation and are accepted for where clause builder.";
//     echo "\ncomparison operator '='";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','=','33');
//         assertTrue(true);
//     } catch (\Throwable $th) {
//         assertTrue(false);
//     }
//     echo "\ncomparison operator '>'";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','>','33');
//         assertTrue(true);
//     } catch (\Throwable $th) {
//         assertTrue(false);
//     }
//     echo "\ncomparison operator '>='";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','>=','33');
//         assertTrue(true);
//     } catch (\Throwable $th) {
//         assertTrue(false);
//     }
//     echo "\ncomparison operator '<='";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','<=','33');
//         assertTrue(true);
//     } catch (\Throwable $th) {
//         assertTrue(false);
//     }
//     echo "\ncomparison operator '<'";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','<','33');
//         assertTrue(true);
//     } catch (\Throwable $th) {
//         assertTrue(false);
//     }
//     echo "\ncomparison operator '!='";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','!=','33');
//         assertTrue(true);
//     } catch (\Throwable $th) {
//         assertTrue(false);
//     }
//     echo "\ncomparison operator '<>'";
//     try {
//         QueryBuilder::setTable('table_name')->where('id','<>','33');
//         assertTrue(true);
//     } catch (\Throwable $th) {
//         assertTrue(false);
//     }
//     echo "\n\n";

//     // exception in where clause if $mainInput is not a string
//     echo "exception is thrown if main input in the 'where' clause builder is not a string";
//     echo "\nparameters sent '[]'";
//     try {
//         QueryBuilder::setTable('table_name')->where(['id'],'=',13);
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\nparameters sent '[[]]'";
//     try {
//         QueryBuilder::setTable('table_name')->where([[[234],'=',13]]);
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\nparameters sent 'number'";
//     try {
//         QueryBuilder::setTable('table_name')->where([123.99,'=',13]);
//         assertTrue(false);
//     } catch (\Throwable $th) {
//         assertTrue(true);
//     }
//     echo "\n\n";
// ?>