// # getting started training
// docker run -dp 80:80 docker/getting-started
// ? http://localhost

// # build local Docker image
// docker build -t getting-started .

// # Run local Docker image
// docker run -dp 3000:3000 getting-started
// Navigate to: http://localhost:3000
// look at Docker dashboard - Application on desktop


// # Replacing our Old Container
// Get the ID of the container by using the docker ps command.
    // docker ps
// Use the docker stop command to stop the container.
    // docker stop <the-container-id>
// Once the container has stopped, you can remove it by using the docker rm command.
    // docker rm <the-container-id>

// You can stop and remove a container in a single command by adding the "force" flag to the docker rm command. For example: 
// docker rm -f <the-container-id>

// ***Removing a container using the Docker Dashboard or vscode docker extension

// Push to repo
// docker push russellam379/getting-started:tagname
// training
// ? http://localhost/tutorial/sharing-our-app/
// docker push russellam379/getting-started


// Login to the Docker Hub
// docker login -u YOUR-USER-NAME
// training
// ? http://localhost/tutorial/sharing-our-app/

// # Other
// docker-compose version



// # Running our Application Stack
// docker-compose up -d
// docker-compose up
// docker build -t getting-started .

// # Our Commands
// docker-compose build
// docker-compose up
// control + c or docker-compose down
// docker-compose exec <<container name>> bash


// # Notes// container = object
// Application = conglomerate of containers

// Ports:
    // - 3000:3000
    // - localhost:container port

// # php artisan
    // php artisan tinker
        // ex
        // $Assignment = new App\Models\Assignment;
        // $Assignment->body = 'Finishing at work!';
        // $Assignment->save();

        // App\Models\Assignment::all();
        // App\Models\Assignment::first();
        // App\Models\Assignment::where('completed', false)->get(); // ? ->get() why not just where?
        // App\Models\Assignment::where('completed', false)->first();

        // $Assignment = App\Models\Assignment::where('completed', false)->first();
        // $Assignment->complete();