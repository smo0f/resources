<?php
    // @ eloquent model
        // # make a eloquent model through the command line
            // php artisan make:model <<model name>>
            // php artisan make:model Post

            // example
            namespace App\Models;

            use Illuminate\Database\Eloquent\Factories\HasFactory;
            use Illuminate\Database\Eloquent\Model;

            class Post extends Model
            {
                use HasFactory;
            }

        // # help when I make a model
            // php artisan help make:model
                // example: php artisan make:model Project -mc

            // Usage:
            // make:model [options] [--] <name>

            // Arguments:
            // name                  The name of the class

            // Options:
            // -a, --all             Generate a migration, seeder, factory, and resource controller for the model
            // -c, --controller      Create a new controller for the model
            // -f, --factory         Create a new factory for the model
            //     --force           Create the class even if the model already exists      
            // -m, --migration       Create a new migration file for the model
            // -s, --seed            Create a new seeder file for the model
            // -p, --pivot           Indicates if the generated model should be a custom intermediate table model
            // -r, --resource        Indicates if the generated controller should be a resource controller
            //     --api             Indicates if the generated controller should be an API 
            // controller
            // -h, --help            Display help for the given command. When no command is 
            // given display help for the list command
            // -q, --quiet           Do not output any message
            // -V, --version         Display this application version
            //     --ansi            Force ANSI output
            //     --no-ansi         Disable ANSI output
            // -n, --no-interaction  Do not ask any interactive question
            //     --env[=ENV]       The environment the command should run under
            // -v|vv|vvv, --verbose  Increase the verbosity of messages: 1 for normal output
?>