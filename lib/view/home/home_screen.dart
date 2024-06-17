import 'package:bloc_mvc/bloc/movies/bloc/movies_bloc.dart';
import 'package:bloc_mvc/bloc/movies/bloc/movies_event.dart';
import 'package:bloc_mvc/bloc/movies/bloc/movies_state.dart';
import 'package:bloc_mvc/config/components/internet_exception_widget.dart';
import 'package:bloc_mvc/config/routes/routes.dart';
import 'package:bloc_mvc/data/response/status.dart';
import 'package:bloc_mvc/main.dart';
import 'package:bloc_mvc/services/storage/local_storage.dart';
import 'package:bloc_mvc/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MoviesBloc moviesBloc;

  @override
  void initState() {
    super.initState();
    moviesBloc = MoviesBloc(moviesRepository: getIt());
  }

  @override
  void dispose() {
    moviesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              LocalStorage localStorage = LocalStorage();
              localStorage.clearValue('token').then((value) {
                localStorage.clearValue('isLogin');
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: BlocProvider(
          create: (context) => moviesBloc..add(MovieFetched()),
          child: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
            switch (state.movieList.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());

              case Status.error:
                if (state.movieList.message == 'No Internet Connection') {
                  return InterNetExceptionWidget(onPress: () {
                    moviesBloc.add(MovieFetched());
                  });
                }
                return Center(
                  child: Text(state.movieList.message!.toLowerCase()),
                );
              case Status.completed:
                if (state.movieList.data == null) {
                  return const Center(
                    child: Text('No data found'),
                  );
                }
                final moviewList = state.movieList.data!;

                return ListView.builder(
                    itemCount: moviewList.tvShows.length,
                    itemBuilder: (context, index) {
                      final tvShow = moviewList.tvShows[index];
                      return Card(
                        child: ListTile(
                          title: Text(tvShow.name.toString()),
                        ),
                      );
                    });
              case null:
                return SizedBox();
            }
          })),
    );
  }
}
