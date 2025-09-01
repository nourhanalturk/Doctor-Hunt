class MenuItemModel {
  String imagePath;

  String title;

  void Function()? onTap ;



  MenuItemModel({
    required this.imagePath,
    required this.title,
    required this.onTap,
  });
}
