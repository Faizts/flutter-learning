import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:movies/moviesfilm.dart';
import 'package:movies/moviedetailScreen/thumbnail.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: FutureBuilder(
          future: ReadfromJson(),
          builder: (context, data) {
            //itemBuilder: (BuildContext context, int index) {
            if (data.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else if (data.hasData) {
              var movies = data.data as List<moviesFilm>;
              return ListView.builder(itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(13.9),
                        ),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: movieImage(
                              movies[index % 10].images![0].toString()),
                        ),
                      ),
                    ),
                    //trailing: Text("..."),
                    title: Text(movies[index % 10].title.toString()),
                    subtitle: Text(movies[index % 10].genre.toString()),
                    trailing: const Icon(Icons.more_vert),
                    onTap: () {
                      //print('Tapped on $index');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieListViewDetails(
                            // allMovies: movies[index].toString(),
                            movieName: movies[index % 10].title.toString(),
                            movieImages:
                                movies[index % 10].images![0].toString(),
                            movieGenre: movies[index % 10].genre.toString(),
                            movieImdbID: movies[index % 10].imdbID.toString(),
                            moviePlot: movies[index % 10].plot.toString(),
                            movieLanguage:
                                movies[index % 10].language.toString(),
                            movieCountry: movies[index % 10].country.toString(),
                            movieAwards: movies[index % 10].awards.toString(),
                            moviePoster: movies[index % 10].poster.toString(),
                            movieMetascore:
                                movies[index % 10].metascore.toString(),
                            movieImdbRating:
                                movies[index % 10].imdbRating.toString(),
                            movieImdbVotes:
                                movies[index % 10].imdbVotes.toString(),
                            movieType: movies[index % 10].type.toString(),
                            movieResponse:
                                movies[index % 10].response.toString(),
                            movieyear: movies[index % 10].year.toString(),
                            movieActors: movies[index % 10].actors.toString(),
                            movieDirector:
                                movies[index % 10].director.toString(),
                            movieImagesList: movies[index].images,
                          ),
                        ),
                      );
                    },
                  ),
                );
              });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  // ignore: non_constant_identifier_names
  Future<List<moviesFilm>> ReadfromJson() async {
    final String moviesJson =
        await rootBundle.rootBundle.loadString('assets/film.json');
    final movies = json.decode(moviesJson) as List<dynamic>;
    return movies.map((e) => moviesFilm.fromJson(e)).toList();
  }

  Widget movieImage(String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
