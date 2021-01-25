








$.ajax({
    method: "GET",
    url: "https://www.adilas.biz/new_and_updates/wp-json/wp/v2/posts/",
    data: { name: "John", location: "Boston" }
}).done(function(data) {
    console.log(data);
});




console.log('');