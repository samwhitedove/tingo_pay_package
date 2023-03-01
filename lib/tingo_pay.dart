library tingo_pay;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tingo_pay/tingo_controller.dart';

class TingoGateWay extends StatefulWidget {
  String email;
  String description;
  String firstName;
  String lastName;
  String? title;
  String? currency;
  TingoGateWay(
      {super.key,
      required this.email,
      required this.description,
      required this.firstName,
      required this.lastName,
      this.title,
      this.currency});

  @override
  State<TingoGateWay> createState() => _TingoGateWayState();
}

class _TingoGateWayState extends State<TingoGateWay> {
  final _ = Get.put(Tingo());
  final _controller = Get.find<Tingo>();

  @override
  void initState() {
    _controller.user(
      email: widget.email,
      description: widget.description,
      firstName: widget.firstName,
      lastName: widget.lastName,
      currency: widget.currency,
      title: widget.title,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? _controller.title)),
      body: Scaffold(
        body: Column(
          children: [
            amountField(
                controller: _controller.amount,
                hintText: "100",
                onChange: () {
                  _controller.removeFirstCharacter();
                  if (_controller.amount.text.isEmpty ||
                      _controller.amount.text.length < 3) {
                    _controller.deactivateButton.value = false;
                    return;
                  }
                  _controller.deactivateButton.value = true;
                },
                enabled: !_controller.isLoading.value),
            button(_controller.makeRquest, "Pay")
          ],
        ),
      ),
    );
  }

  SizedBox button(onTap, text, {key}) {
    return SizedBox(
      key: key,
      height: 50,
      width: Get.width * .9,
      child: Obx(() => ElevatedButton(
            onPressed: _controller.deactivateButton.value
                ? _controller.isLoading.value
                    ? null
                    : () => onTap(context)
                : null,
            child: _controller.isLoading.value
                ? const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(color: Colors.orange),
                  )
                : Text(
                    text,
                    style: const TextStyle(fontSize: 16),
                  ),
          )),
    );
  }

  Container amountField({
    required TextEditingController controller,
    required String hintText,
    Function()? onChange,
    bool? enabled = true,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Text("Amount"),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey, style: BorderStyle.solid, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextFormField(
                  enabled: enabled,
                  controller: controller,
                  onChanged: onChange == null ? null : (text) => onChange(),
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.withOpacity(.5),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
