import 'package:ecm/constants.dart';
import 'package:ecm/screens/payments/checkout_page_app_bar.dart';
import 'package:ecm/screens/payments/payments_page.dart';
import 'package:flutter/material.dart';

class CheckOutPage extends StatefulWidget {
  final double price;
  const CheckOutPage({super.key, required this.price});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  bool _isAlamatEditable = false;
  int _selectedPaymentMethodIndex = 0;
  int _selectedShippingOptionIndex = 0;
  final TextEditingController _alamatController = TextEditingController();

  // Daftar metode pembayaran
  final List<Map<String, dynamic>> _paymentMethods = [
    {"name": "Tunai", "image": "assets/Tunai.jpg", "rek": null},
    {"name": "BCA", "image": "assets/BCA.png", "rek": 24647658584565},
    {"name": "Mandiri", "image": "assets/Mandiri.png", "rek": 13243543644},
  ];

  // Daftar metode pengiriman
  final List<Map<String, dynamic>> _shippingOptions = [
    {"name": "Reguler", "price": 10000},
    {"name": "Express", "price": 20000},
  ];

  void _bayarButton() {
    if (_alamatController.value.text.isEmpty) {
      const snackBar = SnackBar(
        content: Text(
          "Anda Belum Memasukkan Alamat",
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
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PaymentsPage(
                paymentMethod: _paymentMethods[_selectedPaymentMethodIndex],
                shipingOption: _shippingOptions[_selectedShippingOptionIndex],
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 35),
            const CheckoutPageAppBar(title: "Ringkasan Pesanan"),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Alamat Pengiriman",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            enabled: _isAlamatEditable,
                            controller: _alamatController,
                            decoration: const InputDecoration(
                              hintText: 'Alamat',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(8.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: SizedBox(
                            width: _isAlamatEditable ? 100 : 85,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isAlamatEditable = !_isAlamatEditable;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kprimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                _isAlamatEditable ? "Simpan" : "Ubah",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    "Metode Pembayaran",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: _paymentMethods.asMap().entries.map((entry) {
                        int idx = entry.key;
                        Map<String, dynamic> method = entry.value;
                        return _buildRadioButton(
                            method["name"]!, method["image"]!, idx);
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 35),
                  const Text(
                    "Metode Pengiriman",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<int>(
                    value: _selectedShippingOptionIndex,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      hintText: 'Pengiriman',
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    items: _shippingOptions.asMap().entries.map((entry) {
                      int idx = entry.key;
                      Map<String, dynamic> option = entry.value;
                      return DropdownMenuItem<int>(
                        value: idx,
                        child:
                            Text('${option["name"]} (Rp. ${option["price"]})'),
                      );
                    }).toList(),
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedShippingOptionIndex = newValue!;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Total Harga",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "Rp. ${widget.price}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 90,
                            child: ElevatedButton(
                              onPressed: _bayarButton,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                "Bayar",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(String text, String assetPath, int index) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Image.asset(assetPath, width: 55, height: 25),
          const SizedBox(width: 20),
          Text(text),
        ],
      ),
      trailing: Radio<int>(
        value: index,
        groupValue: _selectedPaymentMethodIndex,
        activeColor:
            Colors.orange, // Mengatur warna radio button menjadi orange
        onChanged: (int? newValue) {
          setState(() {
            _selectedPaymentMethodIndex = newValue!;
          });
        },
      ),
      onTap: () {
        setState(() {
          _selectedPaymentMethodIndex = index;
        });
      },
    );
  }
}
