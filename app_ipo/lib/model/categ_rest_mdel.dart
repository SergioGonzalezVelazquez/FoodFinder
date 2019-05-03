/**
 * Para mostrar el filtrado de restaurantes por tipo de comida,
 * vamos a utilizar una estructura List<ModeloCategRest> con la que 
 * poblaremos un un widget ListView. 
 */

class ModeloCategRest{
  String _nombre;
  String _imagenFondo;


  ModeloCategRest(this._nombre, this._imagenFondo);

  String get nombre => _nombre;
  String get imagenFondo => _imagenFondo;
}