<?php
    // @ Route Notes
        // # get welcome view
            Route::get('/', function () {
                return view('welcome');
            });

        // # get URL parameters
            Route::get('/test', function () {
                $name = request('name');

                return view('test', [
                    'name' => $name
                ]);
            });

            // inline parameters
            Route::get('/test', function () {
                return view('test', [
                    'name' => request('name')
                ]);
            });


        // # applying folder structure for the view
            Route::get('/test/test', function () {
                return view('test.test');
            });

        // # wildcard routes
            // Route Wildcards
            Route::get('/posts/{post}', function ($post) {
                return view('posts', [
                    'post' => $post
                ]);
            });

            // with look up
            Route::get('/posts/{post}', function ($post) {
                $posts = [
                    'my-first-post' => 'Hello, this is my first blog post!',
                    'my-second-post' => 'Now I\'m getting the hang of this blog thing!',
                ];
                
                return view('posts', [
                    'post' => $posts[$post] ?? 'This post does not exist'
                ]);
            });

            // with abort
            Route::get('/posts/{post}', function ($post) {
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
            }); 

            // with Controller
                // option 1
                use App\Http\Controllers\PostsController;
                Route::get('/posts/{post}', [PostsController::class, 'show'])->name('posts.show');
                // option 2
                Route::get('/posts/{post}', [App\Http\Controllers\PostsController::class, 'show']);
                // * option 3
                Route::get('/posts/{post}', 'App\Http\Controllers\PostsController@show'); 
    // @ route verbiage
        // * GET /videos
            // list of videos
        // * GET /videos/create
            // create new record form***
        // * POST /videos
            // add record
        // * GET /videos/3
            // view specific record
        // * GET /videos/3/edit
            // edit specific record form***
        // * PUT /videos/3
            // update a specific record
        // * DELETE /videos/3
            // delete a specific record

        Route::get('user', 'UserController@index')->name('user');
        Route::post('user', 'UserController@index')->name('user');
        Route::put('users/{id}', function ($id) {
            
        });
        Route::delete('users/{id}', function ($id) {
            
        });

        // # examples 
            // # home
                Route::get('/', function () {
                    return view('welcome');
                })->name('home.index'); // http://127.0.0.1:8000/

                Route::get('/contact', function () {
                    return '<h1>Contact me!</h1>';
                })->name('home.contact'); // http://127.0.0.1:8000/contact

                Route::get('/test', function () {
                    return request('name');
                })->name('home.test'); // http://127.0.0.1:8000/test?name=Russell%20Moore

            // # user
                Route::get('/user/{id}', function ($id = null) {
                    return "User with id of {$id}";
                })->name('user.id'); // http://127.0.0.1:8000/user/22  -  http://127.0.0.1:8000/user/Russell%20Moore = fails // path to patterns app\Providers\RouteServiceProvider.php // Works like the one below, but automatically checks for a number whenever we use a variable for ID {id}

                // Route::get('/user/{id}', function ($id = null) {
                //     return "User with id of {$id}";
                // })->where([
                //     'id' => '[0-9]+'
                // ])->name('user.id'); // http://127.0.0.1:8000/user/22  -  http://127.0.0.1:8000/user/Russell%20Moore = fails

                Route::get('/user/{name?}', function ($name = null) {
                    return "User with name of \"{$name}\"";
                })->name('user.name'); // http://127.0.0.1:8000/user/  or  http://127.0.0.1:8000/user/Russell%20Moore // optional {name?}
            // # post
                Route::get('/post/{slug}', function ($slug) {
                    return $slug;
                })->name('post.home'); // http://127.0.0.1:8000/post/hi-there

                Route::get('/recent-posts/{daysAgo?}', function ($daysAgo = 0) {
                    return 'Recent Posts - ' . $daysAgo . ' days ago';
                })->name('post.recent.index'); // http://127.0.0.1:8000/recent-posts or http://127.0.0.1:8000/recent-posts/30 // optional {daysAgo?} // no //// {days-ago?}
?>