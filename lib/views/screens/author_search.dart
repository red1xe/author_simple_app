import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/author_search_bloc.dart';
import '../../constants/colors.dart';
import '../models/author_model.dart';
import 'author_details.dart';

class AuthorSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Author Search App'),
      ),
      body: BlocProvider(
        create: (context) => AuthorSearchBloc(),
        child: AuthorSearchForm(),
      ),
    );
  }
}

class AuthorSearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextFormField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              hintText: 'Enter author name',
            ),
            onChanged: (value) {
              BlocProvider.of<AuthorSearchBloc>(context)
                  .add(SearchAuthor(query: value));
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<AuthorSearchBloc, AuthorSearchState>(
            builder: (context, state) {
              if (state is AuthorSearchLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AuthorSearchLoaded) {
                return ListView.builder(
                  itemCount: state.author.length,
                  itemBuilder: (context, index) {
                    return AuthorTile(author: state.author[index]);
                  },
                );
              } else if (state is AuthorSearchError) {
                return Center(
                  child: Text('Error: ${state.message}'),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}

class AuthorTile extends StatelessWidget {
  final Author author;

  const AuthorTile({required this.author});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.getBackgroundColor2(),
      ),
      padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0),
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AuthorDetailsPage(
                author: author,
              ),
            )),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.getPrimaryColor(),
                border: Border.all(color: AppColors.getAccentColor()),
              ),
              child: Center(
                child: Text(
                  author.name[0],
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    author.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text('(${author.birthDate}-${author.deathDate})',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      )),
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 5.0,
                    children: [
                      Text(
                        '⭐ ${author.topWork}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthorDetailsPage(
                        author: author,
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.getSecondaryColor(),
                ))
          ],
        ),
      ),
    );
  }
}
