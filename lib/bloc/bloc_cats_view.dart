import 'package:bloc_patern/bloc/cats_cubit.dart';
import 'package:bloc_patern/bloc/cats_repository.dart';
import 'package:bloc_patern/bloc/cats_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCatsView extends StatefulWidget {
  const BlocCatsView({Key? key}) : super(key: key);

  @override
  State<BlocCatsView> createState() => _BlocCatsViewState();
}

class _BlocCatsViewState extends State<BlocCatsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => CatsCubit(SampleCatsRepository())),
      child: buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) {
    return Scaffold(
      //floatingActionButton: floatingActionButtonCall(context),
      appBar: AppBar(
        title: const Text("hello"),
      ),
      body: BlocConsumer<CatsCubit, CatsState>(
        listener: ((context, state) {
          if (state is CatsError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        }),
        builder: ((context, state) {
          if (state is CatsInitial) {
            return Center(
              child: Column(
                children: [const Text("Hello"), floatingActionButtonCall(context)],
              ),
            );
          } else if (state is CatsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CatsCompleted) {
            return ListView.builder(
              itemBuilder: ((context, index) => ListTile(
                    title: Image.network(state.response[index].imageUrl.toString()),
                    subtitle: Text(
                      state.response[index].description.toString(),
                    ),
                  )),
              itemCount: state.response.length,
            );
          } else {
            final error = state as CatsError;
            return Text(error.toString());
          }
        }),
      ),
    );
  }

  FloatingActionButton floatingActionButtonCall(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<CatsCubit>().getCats();
      }, ////BURASİ
      child: Icon(Icons.add),
    );
  }
}
