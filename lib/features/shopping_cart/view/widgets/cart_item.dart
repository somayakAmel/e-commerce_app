import 'package:flutter/material.dart';

import '../../model/cart_item.dart';
import '../../view_model/cart/cart_cubit.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.item,
  });
  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Image.asset("assets/images/${item.id.toString()}1.jpg"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(item.title.characters.take(17).toString(),
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.w400)),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "\$${item.price.truncate()}",
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            CartCubit.get(context).removeOneItem(item.id);
                          },
                        ),
                        Text(item.quantity.toString(),
                            style: const TextStyle(fontSize: 16)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () {
                            CartCubit.get(context)
                                .addItem(item.id, item.title, item.price, 1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(" \$${(item.price * item.quantity).truncate()}",
                    style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.w500)),
                const SizedBox(
                  height: 5,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    CartCubit.get(context).removeItem(item.id);
                  },
                ),
              ],
            ),
          ),
        ]));
  }
}
