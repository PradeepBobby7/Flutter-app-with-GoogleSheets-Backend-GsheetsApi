import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsheet_app/bloc/events/product_event.dart';
import 'package:gsheet_app/bloc/states/product_state.dart';
import 'package:gsheet_app/models/produce_model.dart';
import 'package:gsheet_app/repository/gsheet_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GoogleSheetRepository repository;
  ProductBloc(this.repository) : super(ProductIntial());

  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is FetchProductEvent) {
      yield ProductLoading();
      try {
        final products = await repository.getProducts();
        yield ProductLoaded(products);
      } catch (_) {
        yield const ProductError('Failed to Load Products');
      }
    } else if (event is AddProductEvent) {
      try {
        await repository.addProduct(event.name as Product, event.description,
            event.price, event.imageUrl);
        yield ProductAdded();
      } catch (_) {
        yield const ProductError('Failed to add Product');
      }
    }
  }
}
