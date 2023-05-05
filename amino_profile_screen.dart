import 'package:appamino/networking/client.dart';
import 'package:appamino/models/user/user_model.dart';
import 'package:appamino/s.dart';
import 'package:appamino/shared/components/components.dart';
import 'package:appamino/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'invite_page.dart';
import 'login_screen.dart';

class AminoProfileScreen extends StatefulWidget {
  @override
  State<AminoProfileScreen> createState() => _AminoProfileState();
}

class _AminoProfileState extends State<AminoProfileScreen>
    with TickerProviderStateMixin {
  // تعريف المتغير

  String? nickName;
  int? followersCount;
  int? followingCount;
  String? profileUrl;
  String? aminoId;
  String? Sid;
  bool _isVisible = true;
  List<UserModel> users = [];
  int _sleepTime = 0;
  int connectedUsersCount = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var fromKey = GlobalKey<FormState>();
  var chatLinkController = TextEditingController();
  int numInvitedMembers = 0;
  void f() async {
    nickName = await CacheHelper.getNickname();
    followersCount = await CacheHelper.getFollowersCount();
    followingCount = await CacheHelper.getFollowingCount();
    profileUrl = await CacheHelper.getIconLink();
    aminoId = await CacheHelper.getAminoId();

    Sid = await CacheHelper.getSid();
    setState(() {});
    print([nickName, followersCount, followingCount, profileUrl]);
    print(users);
  }

  @override
  void initState() {
    super.initState();
    f();
  }

  void d() {}

  @override
  Widget build(BuildContext context) {
    CacheHelper.setRouteName('amino_profile_screen');
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Tooltip(
                    decoration: const BoxDecoration(color: Color(0xFF323232)),
                    // Color(0xFF323232)
                    message: ' copy sid ',
                    textStyle: const TextStyle(
                      fontFamily: 'Sniglet',
                      color: Colors.white,
                    ),

                    child: IconButton(
                      icon: const Icon(Icons.copy_rounded),
                      onPressed: () async {
                        {
                          await Clipboard.setData(
                              ClipboardData(text: Sid ?? ''));
                          print('sid :$Sid');
                          var snackBar = const SnackBar(
                            content: Text('Copy successful!',style: TextStyle( fontFamily: 'Sniglet'),),
                          );
                          await ScaffoldMessenger.of(context).showSnackBar(
                            snackBar,
                          );
                        }
                      },
                    ),
                  ),
                  Tooltip(
                    decoration: const BoxDecoration(color: Color(0xFF323232)),
                    message: ' logout ',
                    textStyle: const TextStyle(
                      fontFamily: 'Sniglet',
                      color: Colors.white,
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.logout_rounded),
                        onPressed: () async {
                          if (Navigator.of(context).canPop()) {
                            await CacheHelper.clearCache();
                            Navigator.of(context).pop();
                          } else {
                            await CacheHelper.clearCache();

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          }
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              userProfileInfo(null),
              const SizedBox(
                height: 50,
              ),
              Card(
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(57, 126, 125, 125),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            (followersCount ?? '0').toString(),
                            style: TextStyle(
                                fontFamily: 'Sniglet',
                                color: Colors.green[500],
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          const Text(
                            'Followers',
                            style: TextStyle(
                              fontFamily: 'Sniglet',
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            (followingCount ?? '0').toString(),
                            style: TextStyle(
                                fontFamily: 'Sniglet',
                                color: Colors.green[500],
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                          const Text(
                            'Following',
                            style: TextStyle(
                              fontFamily: 'Sniglet',
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Divider(
                thickness: 2.3,
                color: Colors.green[500],
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(57, 126, 125, 125),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          defaultButton(
                              width: 160,
                              height: 45,
                              background: Colors.green[500],
                              radius: 15,
                              text: 'Online Chat Invite',
                              function: () {
                               

                              scaffoldKey.currentState!.showBottomSheet(
     
      (BuildContext context) {
        
    
  return statefulBuilderWidget(context, setState);



      },
      enableDrag: true,
   ).closed.then((value) {

    });
                              }),
                          defaultButton(
                              width: 160,
                              height: 45,
                              background: Colors.green[500]!,
                              radius: 15,
                              text: 'Send Activation',
                              function: () {}),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          defaultButton(
                              width: 160,
                              height: 45,
                              background: Colors.green[500]!,
                              radius: 15,
                              text: 'login',
                              function: () {}),
                          defaultButton(
                              width: 160,
                              height: 45,
                              background: Colors.green[500]!,
                              radius: 15,
                              text: 'login',
                              function: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userProfileInfo(String? userProfileImageLink) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            width: 60, height: 60, child: manageContainerImage(profileUrl)),
        const SizedBox(
          width: 20,
        ),
        Column(
          children: <Widget>[
            Text(
              nickName ?? 'username',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  shadows: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Sniglet'),
            ),
            Text(
              aminoId != null
                  ? '@${textSubString(text: aminoId.toString())}'
                  : 'aminoId',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Sniglet'),
            )
          ],
        )
      ],
    );
  }

  Future<String> inviteToChat(
      {required String userId,
      required String chatId,
      required int comId}) async {
    print(_sleepTime);
    try {
      await Future.delayed( Duration(milliseconds: _sleepTime==0?500:_sleepTime));

      String result = await AminoClient(sid: Sid)
          .invite_to_chat(userId: userId, chatId: chatId, comId: comId);

      // if ((result == 'Error occurred' || result == '403') ||
      //     result == "Invalid session. Please re-login.") {
      //   // await showErrorDialog(context, result.toString());
      //   return result;
      // }

      return result;
    } catch (e) {
      return e.toString().replaceFirst("Exception:", "");
    }
  }

  Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Error",  style: const TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Sniglet')),
        content: Text(errorMessage,style: TextStyle(fontFamily: 'Sniglet'),),
        actions: [
          TextButton(
              child: const Text("Ok",  style: const TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Sniglet')),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              }),
        ],
      ),
    );
  }

  // Widget buildSleepTimeWidget(Function(double)? onChanged) {
  //   return Card(
  //     color: Colors.green[500],
  //     child: Padding(
  //       padding: const EdgeInsets.all(16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Text(
  //             "Sleep Time (Seconds):",
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               const Text(
  //                 "0",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               Expanded(
  //                 child: Slider(
  //                   value: _sleepTime.toDouble(),
  //                   onChanged: onChanged,
  //                   min: 0,
  //                   max: 60,
  //                   divisions: 60,
  //                   label: "$_sleepTime",
  //                 ),
  //               ),
  //               const Text(
  //                 "60",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             ],
  //           ),
  //           Text(
  //             "Request will sleep for $_sleepTime seconds",
  //             style: const TextStyle(color: Colors.yellowAccent),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }



//   Widget buildSleepTimeWidget(Function(double)? onChanged) {
//   return Card(
//     color: Colors.green[500],
//     child: Padding(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "Sleep Time (milliseconds):",
//             style: TextStyle(color: Colors.white),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 "0",
//                 style: TextStyle(color: Colors.white),
//               ),
//               Expanded(
//                 child: Column(
//                   children: [
//                     Slider(
//                       value: _sleepTime.toDouble(),
//                       onChanged: onChanged,
//                       min: 0,
//                       max: 2000,
//                       divisions: 60,
//                       label: "$_sleepTime",
//                     ),
//                   ],
//                 ),
//               ),
//               const Text(
//                 "2000",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//           Text(
//   "Request will sleep for ${_sleepTime } milliseconds",
//   style: const TextStyle(color: Colors.yellowAccent),
// ),
//         ],
//       ),
//     ),
//   );
// }

  Widget buildSleepTimeWidget(Function(double)? onChanged){
    return Card(
      color: Colors.green[500],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sleep Time (Milliseconds):",
              style: TextStyle(color: Colors.white, fontFamily: 'Sniglet'),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                   
                  "0",
                  style: TextStyle(color: Colors.white, fontFamily: 'Sniglet'),
                ),
                Expanded(
                  child: Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.yellowAccent,
                          inactiveTrackColor: Colors.white,
                          thumbColor: Colors.white,
                          overlayColor: Colors.white54,
                          valueIndicatorColor: Colors.yellowAccent,
                          valueIndicatorTextStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          trackHeight: 3,
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                          overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                        ),
                        child: Slider(
                          value: _sleepTime.toDouble(),
                          onChanged:onChanged,
                          min: 0,
                          max: 2000,
                          divisions: 60,
                          label: _sleepTime.round().toString(),
                        ),
                      ),
                      const SizedBox(height: 8),
                     
                    ],
                  ),
                ),
                const Text(
                  "2000",
                  style: TextStyle(color: Colors.white,  fontFamily: 'Sniglet'),
                ),
              ],
            ),
            const SizedBox(height: 16),
           Text.rich(
  TextSpan(
    text: "Request will sleep for ",
    style:  TextStyle(
       fontFamily: 'Sniglet',
      color: Colors.yellowAccent,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      // shadows: [
      //   Shadow(
      //     color:  Colors.greenAccent.withOpacity(0.5),
      //     offset:  Offset(1, 1),
      //     blurRadius: 1,
      //   ),
      // ],
    ),
    children: [
      TextSpan(
        text: "${_sleepTime.round()}",
        style: const TextStyle(
           fontFamily: 'Sniglet',
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
      const TextSpan(
        text: " milliseconds",
      ),
    ],
  ),
),
          ],
        ),
      ),
    );

  }

  Color _getUserCountColor(int numInvitedMembers, int connectedUsersCount) {
    if (numInvitedMembers == 0) {
      return Colors.red;
    } else if (numInvitedMembers < connectedUsersCount) {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  Widget _buildUsersCounter(int numInvitedMembers, int connectedUsersCount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: RichText(
        text: TextSpan(
          text: '$numInvitedMembers',
          style: TextStyle(
             fontFamily: 'Sniglet',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _getUserCountColor(numInvitedMembers, connectedUsersCount),
          ),
          children: [
            TextSpan(
              text: '/${connectedUsersCount}',
              style: const TextStyle(
                 fontFamily: 'Sniglet',
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget statefulBuilderWidget(BuildContext context,
StateSetter setState){

 return StatefulBuilder(
  
  builder:
                                        (BuildContext context,
                                            StateSetter setState) {



                                      return Container(
                                        width: double.infinity,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        padding: const EdgeInsets.all(20),
                                        child: Form(
                                          key: fromKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                           
                                              Visibility(
                                                  visible: !_isVisible,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const [
                                                        SizedBox(
                                                          height: 60,
                                                          width: 60,
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 6,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors
                                                                        .blue),
                                                          ),
                                                        ),
                                                        SizedBox(height: 16),
                                                        Text(
                                                            'Inviting members...',style: TextStyle( fontFamily: 'Sniglet'),),
                                                      ],
                                                    ),
                                                  )),
                                              Visibility(
                                                visible: _isVisible,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: const Color.fromARGB(
                                                        255, 245, 242, 242),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        blurRadius: 10,
                                                        spreadRadius: 1,
                                                        offset:
                                                            const Offset(0, 1),
                                                      ),
                                                    ],
                                                  ),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 12),
                                                  child: defaultFormField(
                                                    label: 'chat link',
                                                    controller:
                                                        chatLinkController,
                                                    type: TextInputType.url,
                                                    validate: (String? val) {
                                                      if (val!.isEmpty) {
                                                        return 'chat link must not be empty';
                                                      }
                                                      if (val.length < 4) {
                                                        return 'A valid link must be entered';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Visibility(
                                                visible: _isVisible,
                                                child: buildSleepTimeWidget(
                                                  (newValue) {
                                                    
                                                   
                                                 
  setState(() {
    _sleepTime =
        (newValue).round();
  });

                                                     print(_sleepTime);
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Visibility(
                                                visible: !_isVisible,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: _buildUsersCounter(
                                                      numInvitedMembers,
                                                      connectedUsersCount),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: _isVisible
                                                    ? MainAxisAlignment
                                                        .spaceEvenly
                                                    : MainAxisAlignment.center,
                                                children: [
                                                  defaultButton(
                                                      width: 120,
                                                      height: 45,
                                                      background:
                                                          Colors.green[500]!,
                                                      radius: 15,
                                                      text: 'Back',
                                                      function: () {
                                                        if (_isVisible ==
                                                            false) {
                                                        
  setState(
    () {
   users.clear();
  
      _isVisible = true;
      numInvitedMembers =
          0;
      connectedUsersCount =
          0;
    },
  );

                                                        } else {
                                                          if (Navigator.canPop(
                                                              context)) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          }
                                                        }
                                                      }),
                                                  Visibility(
                                                    visible: _isVisible,
                                                    child: Column(
                                                      children: [
                                                        const Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5)),
                                                        defaultButton(
                                                            width: 120,
                                                            height: 45,
                                                            background: Colors
                                                                .green[500]!,
                                                            radius: 15,
                                                            text:
                                                                'Send invitations',
                                                            function: () async {
                                                              if (fromKey
                                                                  .currentState!
                                                                  .validate()) {
                                                            
  setState(() {
    _isVisible =
        !_isVisible;
  });

                                                                AminoClient
                                                                    client =
                                                                    AminoClient();
                                                                var chatLink =
                                                                    chatLinkController
                                                                        .text;
                                                                var obj;
                                                                try {
                                                                  obj = await client
                                                                      .get_from_code(
                                                                          chatLink);
                                                                } catch (error) {
                                                                  if (error
                                                                      is FormatException) {
                                                                    showErrorDialog(
                                                                        context,
                                                                        "Your IP address is blocked from amino , do not spam");
                                                                  } else {
                                                                    showErrorDialog(
                                                                        context,
                                                                        error.toString().replaceFirst(
                                                                            "Exception:",
                                                                            ""));
                                                                  }
                                                                }
                                    
                                                                bool
                                                                    errorOccurred =
                                                                    false;
                                    
                                                                if (obj !=
                                                                    null) {
                                                                  var comId =
                                                                      obj.comId!;
                                                                  var chatId = obj
                                                                      .objectId!;
                                                                  await client
                                                                      .get_online_users(
                                                                          comId:
                                                                              comId)
                                                                      .then(
                                                                          (value) {
                                                                  
  setState(
      () {
    connectedUsersCount =
        value.getUserProfileCountList().userProfileCount ??
            0;
  });

                                                                  }).catchError(
                                                                          (error) {
                                                                    print(
                                                                        error);
                                                                    showErrorDialog(
                                                                        context,
                                                                        error
                                                                            .message
                                                                            .toString());
                                                                  });
                                    
                                                                  if (connectedUsersCount !=
                                                                      0) {
                                                                    print(
                                                                        "connectedUsersCount :$connectedUsersCount");
                                                                    for (var start =
                                                                            0;
                                                                        start <
                                                                            connectedUsersCount;
                                                                        start +=
                                                                            100) {
                                                                      if (errorOccurred) {
                                                                        break;
                                                                      }
                                                                      print(
                                                                          'start  $start');
                                                                      await client
                                                                          .get_online_users(
                                                                              comId:
                                                                                  comId,
                                                                              start:
                                                                                  start,
                                                                              size:
                                                                                  100)
                                                                          .then((UserProfileCountList
                                                                              onlineUsers) async {
                                                                        UserProfileList
                                                                            onlineUsersInfo =
                                                                            onlineUsers.profile;
                                    
                                                                        for (int index =
                                                                                0;
                                                                            index <
                                                                                onlineUsersInfo.nickname.length;
                                                                            index++) {
                                                                          if (errorOccurred) {
                                                                            break;
                                                                          }
                                                                          await inviteToChat(userId: onlineUsersInfo.userId[index], chatId: chatId, comId: comId).then(
                                                                              (result) {
                                                                            if (result == 'Error occurred' ||
                                                                                result == '403' ||
                                                                                result == "Invalid session. Please re-login.") {
                                                                              UserModel user = UserModel(
                                                                                status: result.toString(),
                                                                                nickname: onlineUsersInfo.nickname[index],
                                                                                icon: onlineUsersInfo.icon[index],
                                                                              );
                                                                              print(result);
                                                                              users.add(user);
                                                                              // Set the error flag to true and break out of the loop
                                                                              errorOccurred = true;
                                                                            } else {
                                                                            
  setState(() {
    numInvitedMembers++;
    print('num:$numInvitedMembers');
  });

                                                                              UserModel user = UserModel(
                                                                                status: result.toString(),
                                                                                nickname: onlineUsersInfo.nickname[index],
                                                                                icon: onlineUsersInfo.icon[index],
                                                                              );
                                                                              users.add(user);
                                                                            }
                                                                          }).catchError(
                                                                              (error) {
                                                                            print(error);
                                                                            showErrorDialog(context,
                                                                                error.message.toString());
                                                                          });
                                                                        }
                                                                      }).catchError(
                                                                              (error) {
                                                                        print(
                                                                            error);
                                                                        showErrorDialog(
                                                                            context,
                                                                            error.message.toString());
                                                                      });
                                                                    }
                                                                  }
              setState(
      () {
        numInvitedMembers =
            0;
        connectedUsersCount =
            0;
      },
    );                          
                                                                
  Navigator
      .push(
    context,
    MaterialPageRoute(
      builder:
          (context) {
      

  
        return InvitePage(
            onlineUsers:
                users);
      },
    ),
  );

                                                                }
                                                              }
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
}
}


