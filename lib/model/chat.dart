
class ChatUser {

  String name;
  String image;
  ChatUser({
    required this.image,
    required this.name,
  });
 
 factory ChatUser.fromDocument(jsonData)
 {
  return ChatUser( name: jsonData.data()['name'], image: jsonData['image']);
 }
}
