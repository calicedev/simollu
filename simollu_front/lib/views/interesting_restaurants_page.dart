import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simollu_front/viewmodels/user_view_model.dart';
import 'package:simollu_front/widgets/restaurant_list_item.dart';

class InterestingRestaurantsPage extends StatelessWidget {
  InterestingRestaurantsPage({super.key});

  UserViewModel userViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              ...List.generate(
                userViewModel.interestRestaurantList.value.length,
                (index) => RestaurantListItem(
                  restaurant: userViewModel.interestRestaurantList.value[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
