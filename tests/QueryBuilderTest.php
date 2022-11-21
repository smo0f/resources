<?php declare(strict_types=1);

namespace Tests;

use PHPUnit\Framework\TestCase;
use Exception;
use codingChallenges\designPatterns\QueryBuilder;
require_once('./codingChallenges\designPatterns\QueryBuilder.php'); // why do I need this**********
// to run tests -> ./vendor/bin/phpunit .\tests\QueryBuilderTest.php or ./vendor/bin/phpunit --testdox tests


// *** HOW DO I KNOW I HAVE TESTED EVERYTHING???
// tests
    // QueryBuilderTest
        // QueryBuilderMethods
            // WhereClausBuilder.php
            // GroupByClausBuilder.php
            // JoinClausBuilder.php
            // ...
        // QueryBuilder.php

final class QueryBuilderTest extends TestCase
{

    public function test_QueryBuilder_class_makes_the_correct_sql_statement()
    {
        $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', '33')->orderBy('column_name')->get();
        $this->assertEquals("SELECT * FROM table_name WHERE id = '33' ORDER BY column_name;", $sqlQuery);
    }

    public function test_QueryBuilder_class_makes_the_correct_sql_statement_number_2()
    {
        $queryBuilder = new QueryBuilder('table_name');
        $sqlQuery = $queryBuilder->where([
            ['id', '=', 34],
        ])->whereOr('admin', '=', 1)->orderBy('column_name')->get();
        $this->assertEquals("SELECT * FROM table_name WHERE id = '34' OR admin = '1' ORDER BY column_name;", $sqlQuery);
    }

    public function test_QueryBuilder_class_makes_the_correct_sql_statement_number_3()
    {
        $queryBuilder = new QueryBuilder('table_name');
        $sqlQuery = $queryBuilder->where([
            ['id', '=', 34],
            // ['name', 'LIKE', 'somthing'] // TODO: need to fix
        ])->whereOr('admin', '=', 1)->orderBy('column_name')->get();
        $this->assertEquals("SELECT * FROM table_name WHERE id = '34' OR admin = '1' ORDER BY column_name;", $sqlQuery);
    }

    public function test_QueryBuilder_class_where_method_makes_sql_correctly_one_where_clause()
    {
        $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', 36)->get();
        $this->assertEquals("SELECT * FROM table_name WHERE id = '36';", $sqlQuery);
    }

    public function test_QueryBuilder_class_where_method_makes_sql_correctly_three_item_array_where_clause()
    {
        $sqlQuery = QueryBuilder::setTable('table_name')->where([
            ['id', '=', 36],
            ['name', '=', 'Sam'],
            ['age', '=', 30.5],
        ])->get();
        $this->assertEquals("SELECT * FROM table_name WHERE id = '36' AND name = 'Sam' AND age = '30.5';", $sqlQuery);
    }

    public function test_QueryBuilder_class_where_method_makes_sql_correctly_three_with_where_clauses()
    {
        $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', 36)->where('name', '=', 'Sam')->where('age', '=', 30.5)->get();
        $this->assertEquals("SELECT * FROM table_name WHERE id = '36' AND name = 'Sam' AND age = '30.5';", $sqlQuery);
    }

    public function test_QueryBuilder_class_throws_exception_in_where_method_when_value_to_find_is_an_array()
    {
        $this->expectException(Exception::class);
        QueryBuilder::setTable('table_name')->where('id','=',['13']);
    }

    /**
     * @dataProvider valueToFindProvider
     */
    public function test_QueryBuilder_class_where_method_acceptable_parameters_for_where_method_value_to_find($valueToFind, $valueInSql)
    {
        $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', $valueToFind)->get();

        $this->assertEquals("SELECT * FROM table_name WHERE id = $valueInSql;", $sqlQuery);
    }
    public function valueToFindProvider(): array
    {
        return [
            'number 36' => [36, "'36'"],
            'boolean true' => [true, "'1'"],
            'string Jim' => ['Jim', "'Jim'"],
            'string float' => [3.987, "'3.987'"],
        ];
    }

    /**
     * @dataProvider tableNameExceptionProvider
     */
    public function test_QueryBuilder_class_throws_exception_if_table_name_is_missing_static_instantiation($tableName)
    {
        $this->expectException(Exception::class);
        QueryBuilder::setTable($tableName);
    }
    

    /**
     * @dataProvider tableNameExceptionProvider
     */
    public function test_QueryBuilder_class_throws_exception_if_table_name_is_missing_new_class_instantiation($tableName)
    {
        $this->expectException(Exception::class);
        new QueryBuilder($tableName);
    }
    public function tableNameExceptionProvider(): array
    {
        return [
            'blank string' => [''],
            'spaces string' => ['     '],
        ];
    }

    public function test_QueryBuilder_class_throws_exception_if_not_enough_parameters_are_sent_to_the_where_clause_builder_not_in_array_path_yes_no_no()
    {
        $this->expectException(Exception::class);
        QueryBuilder::setTable('table_name')->where('id');
    }
    
    public function test_QueryBuilder_class_throws_exception_if_not_enough_parameters_are_sent_to_the_where_clause_builder_not_in_array_path_yes_yes_no()
    {
        $this->expectException(Exception::class);
        QueryBuilder::setTable('table_name')->where('id','=');
    }

    /**
     * @dataProvider invalidComparisonOperatorProvider
     */
    public function test_exception_is_thrown_if_not_valid_comparison_operators_for_where_clause_builder($invalidComparisonOperator)
    {
        $this->expectException(Exception::class);
        QueryBuilder::setTable('table_name')->where('id',$invalidComparisonOperator,'33');
    }
    public function invalidComparisonOperatorProvider(): array
    {
        return [
            'string number' => ['55'],
            'spaces string' => ['     '],
            'empty string' => [''],
        ];
    }

    /**
     * @dataProvider comparisonOperatorProvider
     */
    public function test_that_valid_comparison_operators_are_set_correctly_in_the_where_clause_builder($comparisonOperator)
    {
        $sqlQuery = QueryBuilder::setTable('table_name')->where('id',$comparisonOperator,'33')->get();
        $this->assertEquals("SELECT * FROM table_name WHERE id $comparisonOperator '33';", $sqlQuery);
    }
    public function comparisonOperatorProvider(): array
    {
        return [
            '=' => ['='],
            '>' => ['>'],
            '>=' => ['>='],
            '<' => ['<'],
            '<=' => ['<='],
            '<>' => ['<>'],
            '!=' => ['!='],
        ];
    }

    /**
     * @dataProvider invalidMainInputProvider
     */
    public function test_exception_for_where_clause_if_mainInput_is_not_a_string($mainInput)
    {
        $this->expectException(Exception::class);
        QueryBuilder::setTable('table_name')->where($mainInput,'=','33');
    }
    public function invalidMainInputProvider(): array
    {
        return [
            'array' => [[['id'],'=','33']],
            'boolean' => [true],
            'number' => [33],
            'float' => [908.99],
        ];
    }

    public function test_where_or_builder_works()
    {
        $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', 33)->whereOr('id', '=', 32)->get();

        $this->assertEquals("SELECT * FROM table_name WHERE id = '33' OR id = '32';", $sqlQuery);
    }

    public function test_where_or_builder_works_with_array_of_items()
    {
        $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', 33)->whereOr([['id', '=', 32],['id', '=', 31]])->get();

        $this->assertEquals("SELECT * FROM table_name WHERE id = '33' OR id = '32' OR id = '31';", $sqlQuery);
    }

    public function test_where_or_builder_works_with_many_where_or_calls()
    {
        $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', 33)->whereOr('id', '=', 32)->whereOr('id', '=', 31)->get();

        $this->assertEquals("SELECT * FROM table_name WHERE id = '33' OR id = '32' OR id = '31';", $sqlQuery);
    }

    public function test_order_by_method_works()
    {
        $sqlQuery = QueryBuilder::setTable('table_name')->where('id', '=', '33')->orderBy('column_name')->get();
        $this->assertEquals("SELECT * FROM table_name WHERE id = '33' ORDER BY column_name;", $sqlQuery);
    }
}
