import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_review_provider.dart';

class AddReview extends StatefulWidget {
  final String idRestaurant;
  const AddReview({Key? key, required this.idRestaurant}) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Your name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Name cannot be empty";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _reviewController,
            decoration: const InputDecoration(
              hintText: 'Your review',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "A review cannot be empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            onPressed: () async {
              var validate = _formKey.currentState!.validate();
              if (validate) {
                setState(() {
                });
                try {
                  // Panggil fungsi addReview dari provider
                  RestaurantReviewProvider(
                      apiService: ApiService(Client()),
                      id: widget.idRestaurant,
                      name: _nameController.text,
                      review: _reviewController.text);

                  // Gantikan halaman setelah menutup dialog
                  Navigator.pushReplacementNamed(context, '/restaurant_detail',
                      arguments: widget.idRestaurant);

                  // Beri keterlambatan sebelum menampilkan dialog sukses
                  await Future.delayed(const Duration(milliseconds: 300));

                  AlertDialog alert = AlertDialog(
                    title: const Text("Success"),
                    content: const Text("Success to add your review!"),
                    actions: [
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () => Navigation.back(),
                      ),
                    ],
                  );

                  showDialog(context: context, builder: (context) => alert);
                  return;
                } catch (e) {
                  // Tampilkan dialog error jika gagal
                  AlertDialog alert = AlertDialog(
                    title: const Text("Failed"),
                    content: const Text("Failed to add review"),
                    actions: [
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () => Navigation.back(),
                      ),
                    ],
                  );
                  showDialog(context: context, builder: (context) => alert);
                }
                setState(() {
                });
              }
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                backgroundColor: secondaryColor),
            child: const Text(
              'Add Review',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.clear();
    _reviewController.clear();
    super.dispose();
  }
}
