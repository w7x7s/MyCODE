import 'package:appamino/networking/client.dart';
import 'package:appamino/models/user/user_model.dart';
import 'package:appamino/s.dart';
import 'package:appamino/shared/components/components.dart';
import 'package:appamino/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  void d() {
    setState(() {
      numInvitedMembers++;
      print('num:$numInvitedMembers');
    });
  }

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
                            content: Text('Copy successful!'),
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
                                  (context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context, setState) {
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
                                              if (users.isNotEmpty &&
                                                  !_isVisible)
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount: users.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      if (users.isEmpty) {
                                                        return Container();
                                                      }
                                                      UserModel object =
                                                          users[index];
                                                      return FutureBuilder(
                                                        future: inviteToChat(
                                                          context,
                                                          userId:
                                                              object.userId!,
                                                          chatId: object.chatId,
                                                          comId: object.comId,
                                                        ).then(
                                                            (value) => value),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .waiting) {
                                                            return const SizedBox();
                                                          }
                                                          if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                'Error: ${snapshot.error}');
                                                          } else {
                                                            if ('${snapshot.data}' !=
                                                                'OK') {
                                                              print('ok');
                                                              setState(
                                                                () {
                                                                  connectedUsersCount++;
                                                                },
                                                              );
                                                            }
                                                            return Column(
                                                              children: [
                                                                Card(
                                                                  child:
                                                                      ListTile(
                                                                    subtitle: Text(
                                                                        '${snapshot.data}'),
                                                                    title: Text(
                                                                        object.nickname ??
                                                                            ''),
                                                                    leading:
                                                                        ClipOval(
                                                                            child:
                                                                                SizedBox(
                                                                      width: 50,
                                                                      height:
                                                                          50,
                                                                      child: getImage(
                                                                          imageUrl:
                                                                              object.icon),
                                                                    )),
                                                                    trailing: '${snapshot.data}' ==
                                                                            'OK'
                                                                        ? const Icon(
                                                                            Icons
                                                                                .check,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                84,
                                                                                131,
                                                                                86))
                                                                        : const Icon(
                                                                            Icons
                                                                                .close,
                                                                            color:
                                                                                Colors.red),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 2.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        LinearGradient(
                                                                      colors: [
                                                                        Colors.green[
                                                                            500]!,
                                                                        Colors.grey[
                                                                            500]!
                                                                      ],
                                                                      begin: Alignment
                                                                          .centerLeft,
                                                                      end: Alignment
                                                                          .centerRight,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          }
                                                        },
                                                      );
                                                    },
                                                  ),
                                                )
                                              else
                                                Visibility(
                                                  visible: !_isVisible,
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      CircularProgressIndicator(
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 227, 255, 228),
                                                        backgroundColor:
                                                            Colors.grey[300],
                                                      ),
                                                      const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      10)),
                                                    ],
                                                  ),
                                                ),
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
                                                    print(newValue);
                                                    setState(() {
                                                      _sleepTime =
                                                          (newValue).round();
                                                    });
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
                                                                      },
                                                                    );
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
                                                                        "connectedUsersCount  :$connectedUsersCount ");
                                                                    for (var start =
                                                                            0;
                                                                        start <
                                                                            (connectedUsersCount);
                                                                        start +=
                                                                            100) {
                                                                      await client
                                                                          .get_online_users(
                                                                              comId:
                                                                                  comId,
                                                                              start:
                                                                                  start,
                                                                              size:
                                                                                  100)
                                                                          .then((UserProfileCountList
                                                                              onlineUsers) {
                                                                        UserProfileList
                                                                            onlineUsersInfo =
                                                                            onlineUsers.profile;
                                                                        for (int index =
                                                                                0;
                                                                            index <
                                                                                onlineUsersInfo.nickname.length;
                                                                            index++) {
                                                                          UserModel
                                                                              user =
                                                                              UserModel(
                                                                            comId:
                                                                                comId,
                                                                            chatId:
                                                                                chatId,
                                                                            userId:
                                                                                onlineUsersInfo.userId[index],
                                                                            nickname:
                                                                                onlineUsersInfo.nickname[index],
                                                                            icon:
                                                                                onlineUsersInfo.icon[index],
                                                                          );
                                                                          users.add(
                                                                              user);
                                                                        }
                                                                        setState(
                                                                            () {
                                                                          print(
                                                                              " ${users.length}");
                                                                        });
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
                                  },
                                );
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

  Future<String> inviteToChat(BuildContext context,
      {required String userId,
      required String chatId,
      required int comId}) async {
    print(_sleepTime);
    try {
      await Future.delayed(Duration(seconds: _sleepTime));
      String result = await AminoClient(sid: Sid)
          .invite_to_chat(userId: userId, chatId: chatId, comId: comId);

      if ((result == 'Error occurred' || result == '403') ||
          result == "Invalid session. Please re-login.") {
        // await showErrorDialog(context, result.toString());
        setState(() {
          users.clear();
        });
        return result;
      }

      return result;
    } catch (e) {
      setState(() {
        users.clear();
      });
      return e.toString().replaceFirst("Exception:", "");
    }
  }

  Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
              child: const Text('Ok'),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              }),
        ],
      ),
    );
  }

  Widget buildSleepTimeWidget(Function(double)? onChanged) {
    return Card(
      color: Colors.green[500],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Sleep Time (Seconds):",
              style: TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "0",
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: Slider(
                    value: _sleepTime.toDouble(),
                    onChanged: onChanged,
                    min: 0,
                    max: 60,
                    divisions: 60,
                    label: "$_sleepTime",
                  ),
                ),
                const Text(
                  "60",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Text(
              "Request will sleep for $_sleepTime seconds",
              style: const TextStyle(color: Colors.yellowAccent),
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
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color:
                _getUserCountColor(numInvitedMembers, connectedUsersCount ?? 0),
          ),
          children: [
            TextSpan(
              text: '/${connectedUsersCount ?? 0}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
