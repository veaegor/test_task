import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart_bloc/cart_bloc.dart';
import '../category_bloc/user_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<CartBloc>(context),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const CircularProgressIndicator();
            }
            if (state.status.isError) {
              return const Center(
                child: Text('error'),
              );
            }
            if (state.status.isSuccess) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.location_city_outlined),
                        Column(
                          children: [Text('134342'), Text('asdasda')],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: state.cart.length,
                          itemBuilder: (_, index) {
                            return CartCard(context, index);
                          }),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      height: 50,
                      color: Colors.blue,
                      child: const Center(
                        child: Text('23021301203'),
                      ),
                    ),
                    const SizedBox(
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

  Widget CartCard(BuildContext context, int index) {
    return BlocProvider.value(
        value: BlocProvider.of<CartBloc>(context),
        child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          if (state.status.isLoading) {
            return const CircularProgressIndicator();
          }
          if (state.status.isError) {
            return const Center(
              child: Text('error'),
            );
          }
          if (state.status.isSuccess) {
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
                        image: NetworkImage(state.cart[index].imageUrl ?? '0'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${state.cart[index].name}'),
                        Row(
                          children: [
                            Text("${state.cart[index].price}"),
                            const SizedBox(
                              width: 5,
                            ),
                            Text('${state.cart[index].weight}'),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      color: Colors.grey,
                      width: 100,
                      height: 32,
                      child: const Row(
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
