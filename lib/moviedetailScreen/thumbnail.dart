// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MovieListViewDetails extends StatelessWidget {
  final String movieActors;
  final String movieName;
  final String movieImages;
  final String movieGenre;
  final String moviePlot;
  final String movieLanguage;
  final String movieCountry;
  final String movieAwards;
  final String moviePoster;
  final String movieMetascore;
  final String movieImdbRating;
  final String movieImdbVotes;
  final String movieImdbID;
  final String movieType;
  final String movieResponse;
  final String movieyear;
  final String movieDirector;
  final  movieImagesList;

   const MovieListViewDetails({
    Key? key,
    required this.movieName,
    required this.movieImages,
    required this.movieGenre,
    required this.moviePlot,
    required this.movieLanguage,
    required this.movieCountry,
    required this.movieAwards,
    required this.moviePoster,
    required this.movieMetascore,
    required this.movieImdbRating,
    required this.movieImdbVotes,
    required this.movieImdbID,
    required this.movieType,
    required this.movieResponse,
    required this.movieyear,
    required this.movieActors,
    required this.movieDirector, this.movieImagesList, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' $movieName'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: <Widget>[
          MovieDetailThumbnail(
            thumbnails: movieImages,
            //description: movieGenre,
          ),
          MovieDetailPoster(
            moviePoster: movieImages,
            movieYear: movieyear,
            movieGenre: movieGenre,
            moviename: movieName,
            movieplot: moviePlot,
          ),
          MovieCastDetail(
            castMovie: movieActors,
            directorMovie: movieDirector,
          ),
          const HorizontalLine(),
          MorePoster(morePP: movieImagesList),
        ],
      ),
    );
  }
}

class MorePoster extends StatelessWidget {
  final List<String> morePP;
  const MorePoster({Key? key, required this.morePP}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'More Poster',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 200,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4,
                            height: 160,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(morePP[index]),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8.0),
                    itemCount: morePP.length),
              )
            ]));
  }
}

class MovieCastDetail extends StatelessWidget {
  final castMovie, directorMovie;
  const MovieCastDetail({Key? key, this.castMovie, this.directorMovie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(children: [
        //Text("$castMovie"),
        MovieField(field: "cast", value: castMovie),
        MovieField(field: "Directors", value: directorMovie),
      ]),
    );
  }
}

class HorizontalLine extends StatelessWidget {
  const HorizontalLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.6,
      color: Colors.grey,
    );
  }
}

class MovieField extends StatelessWidget {
  final field, value;
  const MovieField({Key? key, this.field, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$field : ",
          style: const TextStyle(
              color: Colors.black38, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }
}

class MovieDetailThumbnail extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String thumbnails;
  //final String description;

  const MovieDetailThumbnail({
    super.key,
    required this.thumbnails,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(thumbnails),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Icon(Icons.play_circle_outline,
                size: 50, color: Colors.white),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          height: 80,
        ),
      ],
    );
  }
}

class MovieDetailPoster extends StatelessWidget {
  final moviePoster, movieplot;
  final movieYear, movieGenre, moviename;
  const MovieDetailPoster(
      {Key? key,
      required this.moviePoster,
      this.movieYear,
      this.movieGenre,
      this.moviename,
      this.movieplot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          //MoviePoster(poster: movie.movieImages![0].toString())
          MoviePoster(poster: moviePoster.toString()),
          const SizedBox(width: 16),
          Expanded(
            child: MovieDetailHeader(
              movieyear: movieYear.toString(),
              moviegenre: movieGenre,
              title: moviename,
              plot: movieplot,
            ),
          )
        ],
      ),
    );
  }
}

class MovieDetailHeader extends StatelessWidget {
  final movieyear, plot;
  final moviegenre, title;
  const MovieDetailHeader(
      {Key? key, this.movieyear, this.moviegenre, this.title, this.plot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "$movieyear . $moviegenre".toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.cyan,
          ),
        ),
        Text(
          '$title',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 4, 4, 4),
          ),
        ),
        Text.rich(TextSpan(
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
            children: <TextSpan>[
              TextSpan(text: "$plot"),
              const TextSpan(
                text: 'More...',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.cyan,
                ),
              ),
            ])),
      ],
    );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;
  const MoviePoster({Key? key, required this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var borderRadius = const BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(poster),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
