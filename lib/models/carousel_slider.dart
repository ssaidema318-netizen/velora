// ignore_for_file: public_member_api_docs, sort_constructors_first

class CarouselSliders {
  final String id;
  final String imageUrl;

  CarouselSliders({required this.id, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
    };
  }

  factory CarouselSliders.fromMap(Map<String, dynamic> map) {
    return CarouselSliders(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }


}
List<CarouselSliders> dummySliders=[
CarouselSliders(id: "1", imageUrl:"assets/images/carousel_slider_1.jfif" ),
CarouselSliders(id: "2", imageUrl:"assets/images/carousel_slider_2.jfif" ),
CarouselSliders(id: "3", imageUrl:"assets/images/carousel_slider_3.jfif" ),];
