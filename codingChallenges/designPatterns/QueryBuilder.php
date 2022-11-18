<?php

    namespace codingChallenges\designPatterns;
    // just a prototype++, tracer code
    // no sql injection protection

    // *** use as a prototype, testing strategy, documentation strategy, code strategy, also find a way to do mocks

    // ! work on ***********************************************************************
    // Fork
    // split up the logic
        // main QueryBuilder class
            // WhereClauseBuilder class
            // OrderByClauseBuilder class (add string)
            // SelectStatementBuilder class (add string, default *)

        // make test files for each of them
            // ex
            // QueryBuilderTest (Component Integration)
            // WhereClauseBuilderTest (Unit Tests)
            // OrderByClauseBuilderTest (Unit Tests)
            // SelectStatementBuilderTest (Unit Tests)

        // Notion Docs
        

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
    // component integration test
        // QueryBuilder
            // end

    use Exception;

    class QueryBuilder
    {
        private string $selectRaw;
        private string $tableName;
        private array $whereClauses = [];
        private array $orderBy = [];

        private array $comparisonOperator = ['=','>=','>','<=','<','!=','<>'];

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

        // @QueryBuilder:where https://www.notion.so/fox-pest/Query-Builder-Docs-e41f8d9bf72249dbb72709ad45e5e694#1b87c3718c484c9eafb616ca15b8ff61 (002)
        public function where($mainInput, string $comparisonOperator = null, $valueToFind = null, string $whereMethodType = null, string $whereConnectorType = null) : QueryBuilder
        {

            if (is_array($mainInput)) {
                $this->setWhereClauses($mainInput, $whereMethodType, $whereConnectorType);
                return $this;
            }

            // then set array
            $this->setWhereClauses([[$mainInput, $comparisonOperator, $valueToFind]], $whereMethodType, $whereConnectorType);
            return $this;
        }

        // TODO: refactor this so that where and whereOr use the same code (done)
        public function whereOr($mainInput, string $comparisonOperator = null, $valueToFind = null) : QueryBuilder
        {
            return $this->where($mainInput, $comparisonOperator, $valueToFind, 'whereOr', 'OR');
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
            $mainInput = $whereClause[0] ?? null;
            $comparisonOperator = $whereClause[1] ?? null;
            $valueToFind = $whereClause[2] ?? null;

            if (gettype($mainInput) != 'string') {
                throw new Exception("QueryBuilder class '{$whereMethodType}' method requires the 'column name' be a string, '" . gettype($mainInput) . "' given.");
            }

            if ($mainInput == null || $comparisonOperator == null || $valueToFind == null) {
                throw new Exception("QueryBuilder class '{$whereMethodType}' method requires a 'column name', 'comparison operator', and a 'value to find' parameter if using the first parameter as a column.");
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
            $this->whereClauses = [];
            $this->orderBy = [];
        }

        public function get() : string
        {
            // construct SQL
            $sql = 'SELECT ';
            $sql .= $this->selectRaw ?? '*' . ' ';
            $sql .= "FROM {$this->tableName} ";
            // WHERE clause(s)
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