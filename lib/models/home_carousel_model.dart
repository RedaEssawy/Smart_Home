class HomeCarouselModel {
  final String id;
  final String imageUrl;

  HomeCarouselModel({
    required this.id,
    required this.imageUrl,
  });
}

List<HomeCarouselModel> homeCarouselImages = [
  HomeCarouselModel(id: '1', imageUrl: 'assets/images/carousel1.jpeg'),
  HomeCarouselModel(id: '2', imageUrl: 'assets/images/carousel2.jpeg'),
  HomeCarouselModel(id: '3', imageUrl: 'assets/images/carousel3.jpeg'),
  HomeCarouselModel(id: '4', imageUrl: 'assets/images/carousel4.jpeg'),
  HomeCarouselModel(id: '5', imageUrl: 'assets/images/carousel5.jpeg'),


];