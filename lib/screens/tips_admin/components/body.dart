import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/authentication/form_validation.dart';
import 'package:plant_watch/components/form_field.dart';
import 'package:plant_watch/controllers/tips_controller.dart';

import '../../../constants.dart';
import '../../../models/tips_model.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  static String imageName = "Select Image";
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController titleAdd = TextEditingController();
  TextEditingController descriptionAdd = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                titleAdd.clear();
                descriptionAdd.clear();
                UploadTips uploadTip = UploadTips();
                Body.imageName = "Select Image";
                showDialog(
                    context: context,
                    builder: (context) => StatefulBuilder(
                          builder: (context, setState) => AlertDialog(
                            scrollable: true,
                            contentPadding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20, bottom: 10),
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            content: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  formField(
                                      titleAdd,
                                      "Title",
                                      TextInputType.name,
                                      (value) => productNameValidator(value)),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  formField(
                                      descriptionAdd,
                                      "Description",
                                      TextInputType.text,
                                      (value) =>
                                          productDescriptionValidator(value)),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 8),
                                    ),
                                    onPressed: () {
                                      uploadTip.showPicker(context, setState);
                                      setState(() {});
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            Body.imageName,
                                            textAlign: TextAlign.center,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel')),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: kPrimaryColor),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      await uploadTip.upload(
                                        title: titleAdd.text,
                                        description: descriptionAdd.text,
                                        context: context,
                                      );
                                    }
                                  },
                                  child: const Text('Submit')),
                            ],
                          ),
                        ));
              },
              child: const Text("Add Tip"),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            StreamBuilder<List<Tip>>(
              stream: TipsController.allTip(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        border: TableBorder.all(),
                        columns: const [
                          DataColumn(
                              label: Text('Title',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Image',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Actions',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                        ],
                        rows: snapshot.data!
                            .map(
                              (e) => DataRow(cells: [
                                DataCell(Text(e.title)),
                                DataCell(CachedNetworkImage(
                                  imageUrl: e.imgPath,
                                  width: 60,
                                  progressIndicatorBuilder:
                                      (BuildContext context, String url,
                                              DownloadProgress progress) =>
                                          Center(
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(
                                          color: kPrimaryColor,
                                          value: progress.progress),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: kPrimaryColor,
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Expanded(
                                        child: Text(
                                          error.toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 10,
                                              overflow: TextOverflow.fade),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.amber.shade700,
                                          size: 30,
                                        ),
                                        onPressed: () {
                                          UploadTips uploadEditTip =
                                              UploadTips();
                                          title.text = e.title;
                                          description.text = e.description;
                                          Body.imageName = e.imgName;
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                StatefulBuilder(
                                              builder: (context, setState) =>
                                                  AlertDialog(
                                                scrollable: true,
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 20,
                                                        bottom: 10),
                                                actionsAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                content: Form(
                                                  key: formKey,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        formField(
                                                            title,
                                                            "Title",
                                                            TextInputType.name,
                                                            (value) =>
                                                                carouselTitleValidator(
                                                                    value)),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        formField(
                                                            description,
                                                            "Description",
                                                            TextInputType.text,
                                                            (value) =>
                                                                carouselDescriptionValidator(
                                                                    value)),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary:
                                                                kPrimaryColor,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        14,
                                                                    horizontal:
                                                                        8),
                                                          ),
                                                          onPressed: () {
                                                            uploadEditTip
                                                                .showPicker(
                                                                    context,
                                                                    setState);
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  Body.imageName,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  kPrimaryColor),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child:
                                                          const Text('Cancel')),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary:
                                                                  kPrimaryColor),
                                                      onPressed: () async {
                                                        if (formKey
                                                            .currentState!
                                                            .validate()) {
                                                          await uploadEditTip
                                                              .edit(
                                                                  id: e.id,
                                                                  title: title
                                                                      .text,
                                                                  description:
                                                                      description
                                                                          .text,
                                                                  context:
                                                                      context,
                                                                  imgName: e
                                                                      .imgName);
                                                        }
                                                      },
                                                      child:
                                                          const Text('Submit')),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          size: 30,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: const Text(
                                                        "Are you sure to delete this item? "),
                                                    titleTextStyle:
                                                        const TextStyle(
                                                            fontSize: 18,
                                                            color: kTextColor),
                                                    titlePadding:
                                                        const EdgeInsets.only(
                                                            top: 15,
                                                            left: 15,
                                                            right: 15),
                                                    actions: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kPrimaryColor,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      8),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            "Cancel"),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              kPrimaryColor,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      8),
                                                        ),
                                                        onPressed: () async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection("tip")
                                                              .doc(e.id)
                                                              .delete()
                                                              .then(
                                                                  (value) async {
                                                            Navigator.pop(
                                                                context);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        700),
                                                                content: Text(
                                                                  "The tip deleted successfully",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                backgroundColor:
                                                                    kPrimaryColor,
                                                              ),
                                                            );
                                                            final ref =
                                                                FirebaseStorage
                                                                    .instance
                                                                    .ref()
                                                                    .child(
                                                                        'images/tips/${e.imgName}');
                                                            await ref.delete();
                                                          });
                                                        },
                                                        child: const Text(
                                                            "Delete"),
                                                      ),
                                                    ],
                                                  ));
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            )
                            .toList()),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
