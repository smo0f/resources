<?php

// $sqlQuery = QueryBuilder::setTable('table_name')->where('id = 33')->orderBy('column_name')->get();

// // SELECT *
// // FROM table_name
// // WHERE id = 33
// // ORDER BY column_name

// // or

// $queryBuilder = new QueryBuilder('table_name');
// $sqlQuery = $queryBuilder->where("id = 33 AND name LIKE'%somthing%'")->orderBy('column_name')->get();

// // SELECT *
// // FROM table_name
// // WHERE id = 33 AND name LIKE '%somthing%'
// // ORDER BY column_name

// // this also would return an instence of the QueryBuilder class
// $queryBuilder = QueryBuilder::table('table_name')->where('id = 33');

//     - reset
// - where (string)
// - select (string, Default *)
// - group by (string)
// - order by (string)
// - get = sql statement (in real life it would be the result of the SQL statement)
// - set table or in constructor


    class QueryBuilder
    {
        private $tableName;
        private $whereClause;
        private $orderByClause;
        private $groupByClause;
        private $select = '*';

        public function __construct(string $tableName) 
        {
            $tableName = trim($tableName);
            if (!$tableName) {
                throw new Exception("QueryBuilder class requires a table name to be passed in to the constructor.");
            }
            $this->tableName = $tableName;
        }

        public static function setTable(string $tableName) : QueryBuilder
        {
            return new QueryBuilder($tableName);
        }

        public function select(string $select): QueryBuilder
        {
            $this->select = $select;
            return $this;
        }

        public function where(string $whereClause): QueryBuilder
        {
            $this->whereClause = $whereClause;
            return $this;
        }

        public function orderBy(string $orderByClause): QueryBuilder
        {
            $this->orderByClause = $orderByClause;
            return $this;
        }

        public function groupBy(string $groupByClause): QueryBuilder
        {
            $this->groupByClause = $groupByClause;
            return $this;
        }

        public function get(): string
        {
            $query = "SELECT " . $this->select ?? "*";
            $query .= " FROM " . $this->tableName;
            if ($this->whereClause) {
                $query .= " WHERE " . $this->whereClause;
            }
            if ($this->groupByClause) {
                $query .= " GROUP BY " . $this->groupByClause;
            }
            if ($this->orderByClause) {
                $query .= " ORDER BY " . $this->orderByClause;
            }
            return $query;
        }
    }
    
    // $queryBuilder = new QueryBuilder('table_name');
    // $queryBuilder->where('is_bool = true');
    // var_dump($queryBuilder);
    // $sqlQuery = QueryBuilder::setTable('table_name')->where('id = 33')->orderBy('column_name')->groupBy('id')->get();
    // $sqlQuery = QueryBuilder::setTable('table_name')->where('id = 33')->orderBy('column_name')->groupBy('id');
    $sqlQuery = QueryBuilder::setTable('table_name')->where('id = 33')->orderBy('column_name')->groupBy('id')->select('id, name')->get();
    var_dump($sqlQuery);








?>