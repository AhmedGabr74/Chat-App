import 'package:chatapp/constants.dart';
import 'package:chatapp/models/message.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = "chat-page";
  var dataaaa;
  final _controller = ScrollController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KmessagesCollection);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(KcreatedAt,descending: true).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          List<Message> messagesList = [];

          //if (!snapshot.hasData) return CircularProgressIndicator();
          //print(snapshot.data!.docs[0]['message']);
          if(snapshot.hasData) {
            for(int i =0;i<snapshot.data.docs.length;i++)
            {
              messagesList.add(Message.fromjson(snapshot.data.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kimagePath,
                      width: 60,
                      height: 60,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == email ?
                          ChatBuble(message: messagesList[index],) :
                          ChatBubleForaFriend(message: messagesList[index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onChanged: (text) => dataaaa = text,
                      onSubmitted: (data) {
                        dataaaa = data;
                        messages.add({
                          Kmessage: data,
                          KcreatedAt: DateTime.now(),
                          Kid: email,
                        });
                        controller.clear();
                        _controller.animateTo(0,
                            duration: Duration(seconds: 1),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            messages.add({
                              Kmessage: dataaaa,
                              KcreatedAt: DateTime.now(),
                              Kid: email,
                            });
                            controller.clear();
                            _controller.animateTo(0,
                                duration: Duration(seconds: 1),
                                curve: Curves.easeIn);
                          },
                          child: Icon(
                            Icons.send,
                            color: kPrimaryColor,
                          ),
                        ),
                        hintText: 'Send Message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          else{return Text('loading');}

        });
  }
}
