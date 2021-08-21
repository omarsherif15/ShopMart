class ChangeToFavoritesModel
{
  late bool status;
  String ?message;

  ChangeToFavoritesModel.fromjson(Map<String , dynamic> json)
  {
    status = json['status'];
    message =json['message'];
  }
}