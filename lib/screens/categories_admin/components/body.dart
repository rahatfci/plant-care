import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/authentication/form_validation.dart';

import '../../../components/form_field.dart';
import '../../../constants.dart';
import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController nameAdd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                nameAdd.clear();
                UploadCategory uploadCategory = UploadCategory(setState);
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          scrollable: true,
                          contentPadding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20, bottom: 10),
                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                          content: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                formField(nameAdd, "Name", TextInputType.name,
                                    (value) => categoryNameValidator(value)),
                                const SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 8),
                                  ),
                                  onPressed: () {
                                    uploadCategory.showPicker(context);
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        uploadCategory.fileName == null
                                            ? "Select Image"
                                            : "File Selected",
                                        style: const TextStyle(fontSize: 16),
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
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    uploadCategory.upload(
                                        name: nameAdd.text, context: context);
                                  }
                                },
                                child: const Text('Submit')),
                          ],
                        ));
              },
              child: const Text("Add Category"),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            StreamBuilder<List<Category>>(
                stream: CategoryController.allCategory(),
                builder: (context, AsyncSnapshot<List<Category>> snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                          border: TableBorder.all(),
                          columns: const [
                            DataColumn(
                                label: Text('Name',
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
                                  DataCell(Text(e.name)),
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
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            name.text = e.name;
                                            UploadCategory uploadEditCategory =
                                                UploadCategory(setState);
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
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
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      formField(
                                                          name,
                                                          "Name",
                                                          TextInputType.name,
                                                          (value) =>
                                                              categoryNameValidator(
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
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      8),
                                                        ),
                                                        onPressed: () {
                                                          uploadEditCategory
                                                              .showPicker(
                                                                  context);
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                e.imgName,
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            14),
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
                                                          await uploadEditCategory
                                                              .edit(
                                                                  name:
                                                                      name.text,
                                                                  color:
                                                                      e.color,
                                                                  context:
                                                                      context,
                                                                  imgName:
                                                                      e.imgName,
                                                                  id: e.id);
                                                        }
                                                      },
                                                      child:
                                                          const Text('Submit')),
                                                ],
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
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: const Text(
                                                          "Are you sure to delete this item? "),
                                                      titleTextStyle:
                                                          const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  kTextColor),
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
                                                                .collection(
                                                                    "categories")
                                                                .doc(e.id)
                                                                .delete()
                                                                .then((value) {
                                                              Navigator.pop(
                                                                  context);
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  content: Text(
                                                                    "The category deleted successfully",
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
                    return const Text("something went wrong");
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ));
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<List<Category>> getData() async {
    return await FirebaseFirestore.instance
        .collection('categories')
        .get()
        .then((value) {
      return value.docs.map((e) => Category.fromJson(e.data())).toList();
    });
  }
}
