import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserBloc()..add(LoadUserEvent()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserErrorState) {
              return const Center(
                child: Text('error'),
              );
            }
            if (state is UserLoadedState) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_city_outlined),
                        Column(
                          children: [Text('134342'), const Text('asdasda')],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.dish.length,
                          itemBuilder: (_, index) {
                            return CartCard(index);
                          }),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.blue,
                      child: Center(
                        child: Text('23021301203'),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ));
  }

  BlocProvider<UserBloc> CartCard(int index) {
    return BlocProvider(
        create: (context) => UserBloc()..add(LoadUserEvent()),
        child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserErrorState) {
            return const Center(
              child: Text('error'),
            );
          }
          if (state is UserLoadedState) {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                child: Row(
                  children: [
                    Container(
                      height: 62,
                      width: 62,
                      color: Colors.grey,
                      child: Image(
                        fit: BoxFit.contain,
                        image: NetworkImage(state.dish[index].imageUrl ?? '0'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${state.dish[index].name}'),
                        Row(
                          children: [
                            Text("${state.dish[index].price}"),
                            SizedBox(
                              width: 5,
                            ),
                            Text('${state.dish[index].weight}'),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      color: Colors.grey,
                      width: 100,
                      height: 32,
                      child: Row(
                        children: [],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        }));
  }
}
