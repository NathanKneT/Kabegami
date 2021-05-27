import 'package:wallpaper_newapp/model/categories_model.dart';

String apiKey = "563492ad6f917000010000016e7ebfa1f9d24c089c8a3746f8ae588d";

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = new List();
  CategoriesModel categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/1125136/pexels-photo-1125136.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280";
  categoriesModel.categoriesName = "Home";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/1576937/pexels-photo-1576937.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280";
  categoriesModel.categoriesName = "Top";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/255483/pexels-photo-255483.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280";
  categoriesModel.categoriesName = "New";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/577585/pexels-photo-577585.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280";
  categoriesModel.categoriesName = "Coding";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/5698363/pexels-photo-5698363.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280";
  categoriesModel.categoriesName = "Gaming";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.imgUrl =
      "https://images.pexels.com/photos/92870/pexels-photo-92870.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280";
  categoriesModel.categoriesName = "Chill";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  return categories;
}
