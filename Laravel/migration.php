<?php
    // @ migration
        // # make a migration through the command line
            // php artisan make:migration <<migration name>>
            // php artisan make:migration create_post_table

            // example
            namespace App\Models;

            use Illuminate\Database\Eloquent\Factories\HasFactory;
            use Illuminate\Database\Eloquent\Model;

            class Post extends Model
            {
                use HasFactory;
            }

        // # run migration
            // php artisan migrate

            // place holder
                // php artisan migrate:fresh

            // if adding colum make sure to create a new migration for additional database columns

            // * migrate
                // migrate:fresh        Drop all tables and re-run all migrations
                // migrate:install      Create the migration repository
                // migrate:refresh      Reset and re-run all migrations
                // migrate:reset        Rollback all database migrations
                // migrate:rollback     Rollback the last database migration
                // migrate:status       Show the status of each migration
// ?>