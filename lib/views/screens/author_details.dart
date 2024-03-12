import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/author_details_bloc.dart';
import '../../constants/colors.dart';
import '../models/author_model.dart';

class AuthorDetailsPage extends StatelessWidget {
  final Author author;

  const AuthorDetailsPage({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Author Search App'),
      ),
      body: BlocProvider(
        create: (context) => AuthorDetailsBloc(dio: Dio()),
        child: AuthorDetails(author: author),
      ),
    );
  }
}

class AuthorDetails extends StatelessWidget {
  final Author author;

  const AuthorDetails({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorDetailsBloc, AuthorDetailsState>(
      builder: (context, state) {
        if (state is AuthorDetailsInitial) {
          BlocProvider.of<AuthorDetailsBloc>(context)
              .add(LoadAuthorWorks(author.id));
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthorDetailsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AuthorDetailsLoaded) {
          return SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 10,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 70,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.getBackgroundColor2(),
                        border: Border.all(color: AppColors.getAccentColor()),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.getPrimaryColor(),
                              border:
                                  Border.all(color: AppColors.getAccentColor()),
                            ),
                            child: Text(author.name[0],
                                style: TextStyle(
                                    fontSize: 40,
                                    color: AppColors.getAccentColor())),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            author.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Wrap(
                            spacing: 5,
                            children: [
                              Chip(
                                  label: Text('Born: ${author.birthDate}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.getAccentColor()))),
                              Chip(
                                  label: Text('Died: ${author.deathDate}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.getAccentColor()))),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Top Work',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.getAccentColor(),
                        border: Border.all(color: AppColors.getPrimaryColor()),
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 5, top: 5),
                      child: ListTile(
                        leading: Text('⭐',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.getBackgroundColor2())),
                        title: Text(author.topWork,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.getBackgroundColor2())),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.works.length.toString() + ' Total Works',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: double.infinity,
                      height: 500 * state.works.length.toDouble() / 5,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.works.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.getBackgroundColor2(),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)),
                            ),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 5, top: 5),
                            child: ListTile(
                              leading: Text('${index + 1}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.getAccentColor())),
                              title: Text(state.works.keys.elementAt(index)),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (state is AuthorDetailsError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${state.error}'),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Unknown state'),
            ),
          );
        }
      },
    );
  }
}
