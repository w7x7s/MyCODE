scaffoldKey.currentState!.showBottomSheet(
                                    (BuildContext trx) {
                                  return StatefulBuilder(builder:
                                      (BuildContext ctx, StateSetter setState) {
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
                                                                  Colors.blue),
                                                        ),
                                                      ),
                                                      SizedBox(height: 16),
                                                      Text(
                                                        'Inviting members...',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Sniglet'),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            Visibility(
                                              visible: _isVisible,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                  if (mounted) {
                                                    setState(() {
                                                      _sleepTime =
                                                          (newValue).round();
                                                    });
                                                  }

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
                                                      if (_isVisible == false) {
                                                        if (mounted) {
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
                                                        }
                                                      } else {
                                                        if (Navigator.canPop(
                                                            ctx)) {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                          users.clear();
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
                                                              if (mounted) {
                                                                setState(() {
                                                                  _isVisible =
                                                                      !_isVisible;
                                                                });
                                                              }

                                                              AminoClient
                                                                  client =
                                                                  AminoClient();
                                                              var chatLink =
                                                                  chatLinkController
                                                                      .text;
                                                              FromCode? obj;
                                                              try {
                                                                obj = await client
                                                                    .getFromCode(
                                                                        chatLink);
                                                                print(await obj
                                                                    .json);
                                                              } on InvalidLinkException catch (error) {
                                                                print(
                                                                    'sdsadsa');
                                                                await showErrorDialog(
                                                                    title:
                                                                        "Invalid Link!",
                                                                    context:
                                                                        context,
                                                                    errorMessage: error
                                                                        .message
                                                                        .toString());
                                                                if (Navigator
                                                                    .canPop(
                                                                        context)) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  users.clear();
                                                                }
                                                              } on FormatException catch (error) {
                                                                await showErrorDialog(
                                                                    context:
                                                                        context,
                                                                    errorMessage:
                                                                        "Your IP address is blocked from amino , do not spam");
                                                                if (Navigator
                                                                    .canPop(
                                                                        context)) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  users.clear();
                                                                }
                                                              } catch (error) {
                                                                print(error);
                                                                await showErrorDialog(
                                                                    context:
                                                                        context,
                                                                    errorMessage: error
                                                                        .toString()
                                                                        .replaceFirst(
                                                                            "Exception:",
                                                                            ""));
                                                                if (Navigator
                                                                    .canPop(
                                                                        context)) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  users.clear();
                                                                }
                                                              }

                                                              bool
                                                                  errorOccurred =
                                                                  false;

                                                              if (obj != null) {
                                                                if (users
                                                                    .isNotEmpty) {
                                                                  users.clear();
                                                                }
                                                                var comId =
                                                                    obj.comId!;
                                                                var chatId = obj
                                                                    .objectId!;
                                                                print(comId);
                                                                bool access = await client
                                                                    .getOnlineUsers(
                                                                        comId:
                                                                            comId)
                                                                    .then(
                                                                        (value) {
                                                                  if (mounted) {
                                                                    setState(
                                                                        () {
                                                                      connectedUsersCount =
                                                                          value.getUserProfileCountList().userProfileCount ??
                                                                              0;
                                                                    });
                                                                  }
                                                                  if (connectedUsersCount ==
                                                                      0) {
                                                                    return false;
                                                                  }
                                                                  print(
                                                                      connectedUsersCount);
                                                                  return true;
                                                                }).catchError(
                                                                        (error) {
                                                                  print(error);
                                                                  showErrorDialog(
                                                                      context:
                                                                          ctx,
                                                                      errorMessage:
                                                                          error.message.toString() +
                                                                              '0');
                                                                  return false;
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
                                                                        .getOnlineUsers(
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
                                                                          onlineUsers
                                                                              .profile;

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
                                                                            UserModel
                                                                                user =
                                                                                UserModel(
                                                                              status: result.toString(),
                                                                              nickname: onlineUsersInfo.nickname[index],
                                                                              icon: onlineUsersInfo.icon[index],
                                                                            );
                                                                            print(result);
                                                                            users.add(user);

                                                                            errorOccurred =
                                                                                true;
                                                                          } else {
                                                                            if (result ==
                                                                                "OK") {
                                                                              if (mounted) {
                                                                                setState(() {
                                                                                  numInvitedMembers++;
                                                                                  print('num:$numInvitedMembers');
                                                                                });
                                                                              }
                                                                            }

                                                                            UserModel
                                                                                user =
                                                                                UserModel(
                                                                              status: result.toString(),
                                                                              nickname: onlineUsersInfo.nickname[index],
                                                                              icon: onlineUsersInfo.icon[index],
                                                                            );
                                                                            users.add(user);
                                                                          }
                                                                        }).catchError(
                                                                            (error) {
                                                                          print(
                                                                              error);
                                                                          showErrorDialog(
                                                                              context: context,
                                                                              errorMessage: error.message.toString() + '1');
                                                                        });
                                                                      }
                                                                    }).catchError(
                                                                            (error) {
                                                                      print(
                                                                          error);
                                                                      showErrorDialog(
                                                                          context:
                                                                              context,
                                                                          errorMessage:
                                                                              error.message.toString() + '2');
                                                                    });
                                                                  }
                                                                  if (mounted) {
                                                                    setState(
                                                                      () {
                                                                        print(
                                                                            numInvitedMembers);
                                                                      },
                                                                    );
                                                                  }
                                                                }

                                                                if (mounted) {
                                                                  setState(
                                                                    () {
                                                                      numInvitedMembers =
                                                                          numInvitedMembers;
                                                                      _isVisible =
                                                                          !_isVisible;
                                                                      numInvitedMembers =
                                                                          0;
                                                                      connectedUsersCount =
                                                                          0;
                                                                    },
                                                                  );
                                                                }

                                                                if (access) {
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
                                                              } else {}
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
                                }, enableDrag: false);
