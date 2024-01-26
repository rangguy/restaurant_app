import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_review_provider.dart';
import 'package:restaurant_app/widgets/success_dialog.dart';
import 'package:restaurant_app/widgets/warning_dialog.dart';

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
  bool _isLoading = false;

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
                  _isLoading = true;
                });
                try {
                  // Panggil fungsi addReview dari provider
                  RestaurantReviewProvider(
                      apiService: ApiService(),
                      id: widget.idRestaurant,
                      name: _nameController.text,
                      review: _reviewController.text);

                  // Gantikan halaman setelah menutup dialog
                  Navigator.pushReplacementNamed(context, '/restaurant_detail',
                      arguments: widget.idRestaurant);

                  // Beri keterlambatan sebelum menampilkan dialog sukses
                  await Future.delayed(const Duration(milliseconds: 300));

                  // Tampilkan dialog sukses jika berhasil
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const SuccessDialog(
                        description: "Success to add your review",
                      );
                    },
                  );
                } catch (e) {
                  // Tampilkan dialog error jika gagal
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return WarningDialog(
                          description: 'Failed to add review: $e');
                    },
                  );
                }
                setState(() {
                  _isLoading = false;
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
