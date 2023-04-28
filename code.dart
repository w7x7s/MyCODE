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
                                                            return users
                                                                    .isNotEmpty
                                                                ? Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      CircularProgressIndicator(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            227,
                                                                            255,
                                                                            228),
                                                                        backgroundColor:
                                                                            Colors.grey[300],
                                                                      ),
                                                                      Padding(
                                                                          padding:
                                                                              EdgeInsets.symmetric(vertical: 10)),
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            2.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          gradient:
                                                                              LinearGradient(
                                                                            colors: [
                                                                              Colors.green[500]!,
                                                                              Colors.grey[500]!
                                                                            ],
                                                                            begin:
                                                                                Alignment.centerLeft,
                                                                            end:
                                                                                Alignment.centerRight,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                : SizedBox();
                                                          }
                                                          if (snapshot
                                                              .hasError) {
                                                            return Text(
                                                                'Error: ${snapshot.error}');
                                                          } else {
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
                                                                          object
                                                                              .icon),
                                                                    )),
                                                                    trailing: '${snapshot.data}' ==
                                                                            'OK'
                                                                        ? const Icon(
                                                                            Icons
                                                                                .check,
                                                                            color: Colors
                                                                                .green)
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
                                                const Text(''),
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
                                                                      null) {
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

                                                                          setState(
                                                                              () {
                                                                            print("user.nickname ${user.nickname}");
                                                                            users.add(user);
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
