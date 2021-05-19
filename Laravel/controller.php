<?php
    // @ controller
        // # make a controller through the command line
            // php artisan make:controller <<controller name>>
            // php artisan make:controller PostsController

        // # code
        namespace App\Http\Controllers;

        use Illuminate\Http\Request;

        class PostsController extends Controller
        {
            //
        }

        // other
        namespace App\Http\Controllers;

        use Illuminate\Http\Request;

        class PostsController extends Controller
        {
            public function show($slug)
            {

                // look up
                $posts = [
                    'my-first-post' => 'Hello, this is my first blog post!',
                    'my-second-post' => 'Now I\'m getting the hang of this blog thing!',
                ];

                if (! array_key_exists($post, $posts)) {
                    abort(404, 'Sorry, that post was not found.');
                }
                
                return view('posts', [
                    'post' => $posts[$post]
                ]);
            }
        }


        namespace App\Http\Controllers;

        use Illuminate\Http\Request;

        class PostsController extends Controller
        {
            public function show($slug)
            {
                $post = \DB::table('posts')->where('slug', $slug)->first();
            
                // to get info, dd = dump and die
                dd($post);

                if (! array_key_exists($post, $posts)) {
                    abort(404, 'Sorry, that post was not found.');
                }
                
                return view('posts', [
                    'post' => $posts[$post]
                ]);
            }
        }
























?>