import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({Key? key}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final urlImages = [
    'https://www.akijtakafullife.com.bd/public/backend/assets/images/products/Anticipated%20Endowment%20(5%20stage%20Payment)%20Insurance%20Plan%20(with%20profit)-1643098876-image.jpg',
    'https://www.akijtakafullife.com.bd/public/backend/assets/images/products/Single%20Three%20Payment%20Premium%20Plan-1656579930-image.jpg',
    'https://www.akijtakafullife.com.bd/public/backend/assets/images/products/Akij%20Takaful%20DPS%20Insurance%20(with%20profit)-1656576668-image.jpg',
    'https://www.akijtakafullife.com.bd/public/backend/assets/images/products/Akij%20Hajj%20Bima-with%20Profit-1656242978-image.jpeg',
  ];

  @override
  Widget build(BuildContext context) => CarouselSlider.builder(
      itemCount: urlImages.length,
      itemBuilder: (context, index, realIndex) {
        final urlImage = urlImages[index];

        return buildImage(urlImage, index);
      },
      options: CarouselOptions(
          height: 200,
          enlargeCenterPage: true,
          viewportFraction: 1,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3)));

  Widget buildImage(String urlImage, int index) => Container(
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
          width: double.maxFinite,
        ),
      );
}
