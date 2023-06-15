import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(LoadUserEvent(),),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_city_outlined),
                      Column(
                        children: [
                          Text('${state.dish.length}'),
                          const Text('asdasda')
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 35,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              width: 95,
                              height: 35,
                              color: Colors.red,
                              child: const Text(''),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 8 / 10,
                                crossAxisSpacing: 10,
                                crossAxisCount: 3,
                                mainAxisSpacing: 10),
                        itemCount: state.dish.length,
                        itemBuilder: (_, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: Container(
                                              width: double.infinity,
                                              color: Colors.white,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                                child: Column(mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    const SizedBox(height: 16),
                                                    Container(
                                                      color: Color(0xffF8F7F5),
                                                      height: 310,
                                                      width: double.infinity,
                                                      child: Image(
                                                        fit: BoxFit.contain,
                                                        image: NetworkImage(
                                                            state.dish[index].imageUrl ?? '0'),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(state.dish[index].name ?? '0'),
                                                    const SizedBox(height: 8),
                                                     Row(
                                                      children: [
                                                        Text('${state.dish[index].price}'),
                                                        Text('${state.dish[index].weight}')
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(state.dish[index].description ?? '0'),
                                                    const SizedBox(height: 16),
                                                    Container(
                                                      height: 50,
                                                      width: double.infinity,
                                                      color: Colors.blue,alignment: Alignment.center,
                                                      child: Text('Добавить в корзину'),
                                                    ),
                                                    SizedBox(height: 16),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                    height: 110,
                                    width: 110,
                                    color: Color(0xffF8F7F5),
                                    alignment: Alignment.center,
                                      child: Image(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(
                                            state.dish[index].imageUrl ?? '0'),
                                      )),
                              ),
                              Text(state.dish[index].name ?? '0',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'SF-Pro',
                              ),)
                            ],
                          );
                        }
                        ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

}
