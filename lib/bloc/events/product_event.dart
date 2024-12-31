import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductEvent extends ProductEvent {
  final String userId;
  const FetchProductEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AddProductEvent extends ProductEvent {
  final String name;
  final String description;
  final String price;
  final String imageUrl;

  const AddProductEvent({required this.name,required this.description,required this.price,required this.imageUrl});

  @override
  List<Object?> get props => [name, description, price, imageUrl];
}
