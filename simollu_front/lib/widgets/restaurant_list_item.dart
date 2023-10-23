import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simollu_front/models/restaurant_model.dart';

class RestaurantListItem extends StatefulWidget {
  final RestaurantModel restaurant;
  const RestaurantListItem({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantListItem> createState() => _RestaurantListItemState();
}

class _RestaurantListItemState extends State<RestaurantListItem> {
  bool _isLiked = false;

  @override
  void initState() {
    _isLiked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 0.5)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: CachedNetworkImage(
              imageUrl: widget.restaurant.restaurantImage,
              width: 80,
              height: 80,
              errorWidget: (context, url, error) => CachedNetworkImage(
                  width: 80,
                  height: 80,
                  imageUrl:
                      "https://cdn.pixabay.com/photo/2023/04/28/07/07/cat-7956026_960_720.jpg"),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.restaurant.restaurantName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: Color(0xFFF6D000),
                      size: 24,
                    ),
                    Text(
                      "기다릴만해요 ${widget.restaurant.restaurantRating}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF6D000),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${widget.restaurant.restaurantCategory}, ${widget.restaurant.restaurantAddress}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFaaaaaa),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print(_isLiked);
              setState(() {
                _isLiked = !_isLiked;
              });
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: _isLiked
                  ? Icon(
                      Icons.favorite,
                      size: 32,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite_border_outlined,
                      size: 32,
                      color: Colors.red,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
