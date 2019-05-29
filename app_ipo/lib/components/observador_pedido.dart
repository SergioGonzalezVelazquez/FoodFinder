import 'package:app_ipo/model/producto_cantidad_model.dart';


abstract class ObservadorPedido {
  void updatePedido();
  void removeItem(ProductoCantidad removedItem, int removeIndex);
}
