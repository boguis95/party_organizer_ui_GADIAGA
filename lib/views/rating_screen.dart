import 'package:flutter/material.dart';

import '../modeles/Rating.dart';
import '../services/RatingService.dart';


class RatingScreen extends StatelessWidget {
  final int partyId;

  RatingScreen({required this.partyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ratings'),
      ),
      body: FutureBuilder<List<Rating>>(
        future: RatingService.getRatings(partyId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No ratings found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final rating = snapshot.data![index];
                return ListTile(
                  title: Text('Rating: ${rating.rating}'),
                  subtitle: Text('Comment: ${rating.comment}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}