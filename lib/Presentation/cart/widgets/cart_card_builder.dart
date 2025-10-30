import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_bloc.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_event.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_state.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

class CartCardList extends StatelessWidget {
  final CartLoaded state;

  const CartCardList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final item = state.items[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4F0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Product Image
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(baseHost + item.productImage),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Product Name & Quantity Controls
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lang.localeName == "en"
                              ? item.productEName
                              : item.productArName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // Decrease
                            InkWell(
                              onTap:
                                  item.quantity > 1
                                      ? () {
                                        context.read<CartBloc>().add(
                                          UpdateCartQuantityEvent(
                                            productId:
                                                item.productId.toString(),
                                            quantity: item.quantity - 1,
                                          ),
                                        );
                                      }
                                      : null,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child: Icon(
                                  Icons.remove,
                                  size: 16,
                                  color:
                                      item.quantity > 1
                                          ? Colors.black54
                                          : Colors.grey.shade400,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            // Increase
                            InkWell(
                              onTap: () {
                                if (item.quantity < item.stock) {
                                  context.read<CartBloc>().add(
                                    UpdateCartQuantityEvent(
                                      productId: item.productId.toString(),
                                      quantity: item.quantity + 1,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: item.quantity != item.stock ? 28 : 50,
                                height: 28,
                                decoration: BoxDecoration(
                                  color:
                                      item.quantity != item.stock
                                          ? Colors.white
                                          : Colors.redAccent,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                child:
                                    item.quantity != item.stock
                                        ? const Icon(
                                          Icons.add,
                                          size: 16,
                                          color: Colors.black54,
                                        )
                                        : Center(
                                          child: Text(
                                            "MAX",
                                            style: TextStyle(
                                              color: AppColors.fontWhite,
                                            ),
                                          ),
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Delete & Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lang.deleteMsg,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.red.shade50,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: Colors.red.shade200,
                                        ),
                                      ),
                                      child: Text(
                                        lang.undoneMsg,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                actionsPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                actions: <Widget>[
                                  ElevatedButton.icon(
                                    icon: Icon(
                                      Icons.close,
                                      color: AppColors.fontWhite,
                                    ),
                                    label: Text(
                                      lang.keepIt,
                                      style: TextStyle(
                                        letterSpacing: 3,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.fontWhite,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton.icon(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      lang.remove,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 2,
                                    ),
                                    onPressed: () {
                                      context.read<CartBloc>().add(
                                        DeleteCartItem(item.productId),
                                      );
                                      Navigator.of(dialogContext).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.delete_outline,
                            color: Colors.red.shade400,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset(
                            "assets/images/riyal_logo.png",
                            width: 16,
                          ),
                          Text(
                            ' ${item.productSalePrice}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
