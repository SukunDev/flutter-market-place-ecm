import 'package:ecm/Provider/cart_provider.dart';
import 'package:ecm/constants.dart';
import 'package:ecm/screens/nav_bar_screen.dart';
import 'package:ecm/screens/payments/checkout_page_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PaymentsPage extends StatefulWidget {
  final Map<String, dynamic> paymentMethod;
  final Map<String, dynamic> shipingOption;
  const PaymentsPage(
      {super.key, required this.paymentMethod, required this.shipingOption});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            const CheckoutPageAppBar(title: "Ringkasan Pesanan"),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Batas Akhir Pembayaran",
                              style: TextStyle(
                                color: kprimaryColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateFormat('EEEE, d MMMM y')
                                  .format(DateTime.now()),
                              style: const TextStyle(
                                color: kprimaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: kprimaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                child: Text(
                                  "Selesai",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  if (widget.paymentMethod['rek'] == null)
                    Row(
                      children: [
                        Text(
                          "Pembayaran ${widget.paymentMethod['name']}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(widget.paymentMethod['image'],
                            width: 80, height: 30)
                      ],
                    ),
                  if (widget.paymentMethod['rek'] != null)
                    Row(
                      children: [
                        Text(
                          "Transfer Bank ${widget.paymentMethod['name']}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(widget.paymentMethod['image'],
                            width: 80, height: 30)
                      ],
                    ),
                  if (widget.paymentMethod['rek'] != null)
                    const SizedBox(
                      height: 20,
                    ),
                  if (widget.paymentMethod['rek'] != null)
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Nomor Rekening Transfer",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              widget.paymentMethod['rek'].toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: widget.paymentMethod['rek'].toString()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Copied to clipboard')),
                            );
                          },
                          child: const Text(
                            'Salin',
                            style: TextStyle(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Pembayaran",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "Rp. 180.000,00",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        finalList.clear();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavBar()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kprimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'Kembali Ke Halaman Utama',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
