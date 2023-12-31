import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dish_bloc/dish_bloc.dart';
import '../cart_bloc/cart_bloc.dart';

class CategoryScreen extends StatelessWidget {
   CategoryScreen({super.key, required this.categoryName});
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DishBloc()..add(LoadDishEvent()),
        ),
        BlocProvider.value(
          value: BlocProvider.of<CartBloc>(context),
        ),
      ],
      child: BlocBuilder<DishBloc, DishState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status.isError) {
            return const Center(
              child: Text('error'),
            );
          }
          if (state.status.isSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                   Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Text(categoryName??'0'),
                    ],
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
                                      builder: (BuildContext ctx) {
                                        return Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const SizedBox(height: 16),
                                                    Container(
                                                      height: 310,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffF8F7F5),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Image(
                                                        fit: BoxFit.contain,
                                                        image: NetworkImage(
                                                            state.dish[index]
                                                                    .imageUrl ??
                                                                '0'),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      state.dish[index].name ??
                                                          '0',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${state.dish[index].price}\u20bd',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '${state.dish[index].weight}г',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(state.dish[index]
                                                            .description ??
                                                        '0'),
                                                    const SizedBox(height: 16),
                                                    Material(
                                                      child: Ink(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xff3364E0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            context
                                                                .read<
                                                                    CartBloc>()
                                                                .add(CartDishAdded(
                                                                    state.dish[
                                                                        index]));
                                                          },
                                                          child: Container(
                                                            height: 50,
                                                            width:
                                                                double.infinity,
                                                            alignment: Alignment
                                                                .center,
                                                            child: const Text(
                                                              'Добавить в корзину',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
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
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF8F7F5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Image(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                          state.dish[index].imageUrl ?? '0'),
                                    )),
                              ),
                              Text(
                                state.dish[index].name ?? '0',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'SF-Pro',
                                ),
                              )
                            ],
                          );
                        }),
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

  /* Widget PopUpCard(BuildContext context, int index) {
    BlocBuilder<DishBloc, DishState>(builder: (context, state) {
      if (state.status.isLoading) {
        return const CircularProgressIndicator();
      }
      if (state.status.isError) {
        return const Center(
          child: Text('error'),
        );
      }
      if (state.status.isSuccess) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      color: const Color(0xffF8F7F5),
                      height: 310,
                      width: double.infinity,
                      child: Image(
                        fit: BoxFit.contain,
                        image: NetworkImage(state.dish[index].imageUrl ?? '0'),
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
                    GestureDetector(
                      onTap: () {
                        context
                            .read<CartBloc>()
                            .add(CartDishAdded(state.dish[index]));
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: const Text('Добавить в корзину'),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return Container();
      }
    });
    return Container();
  }*/
}
