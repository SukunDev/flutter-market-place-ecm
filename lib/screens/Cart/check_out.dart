import 'package:ecm/screens/payments/checkout_page.dart';
import 'package:flutter/material.dart';
import '../../Provider/cart_provider.dart';
import '../../constants.dart';

class CheckOutBox extends StatelessWidget {
  const CheckOutBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    return Container(
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
              filled: true,
              fillColor: kcontentColor,
              hintText: "Enter Discount Code",
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              suffixIcon: TextButton(
                onPressed: () {},
                child: const Text(
                  "Apply",
                  style: TextStyle(
                    color: kprimaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Subtotal",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                "Rp.${provider.totalPrice()}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Rp.${provider.totalPrice()}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              if (provider.cart.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CheckOutPage(price: provider.totalPrice())),
                );
              } else {
                const snackBar = SnackBar(
                  content: Text(
                    "Keranjang Belanja Anda Kosong",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  duration: Duration(seconds: 1),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kprimaryColor,
              minimumSize: const Size(double.infinity, 38),
            ),
            child: const Text(
              "Check out",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
