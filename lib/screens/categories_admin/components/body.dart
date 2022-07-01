import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                UploadCategory uploadCategory = UploadCategory(setState);
                showDialog(
                    context: context,
                    builder: (context) => Center(
                          child: Card(
                            margin: const EdgeInsets.all(10),
                            elevation: 10,
                            child: Form(
                              key: formKey,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      style: const TextStyle(fontSize: 18),
                                      cursorColor: kPrimaryColor,
                                      keyboardType: TextInputType.name,
                                      controller: nameAdd,
                                      decoration: InputDecoration(
                                        focusColor: kPrimaryColor,
                                        labelText: "Name",
                                        labelStyle: const TextStyle(
                                            fontSize: 16, color: kPrimaryColor),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              width: 2.5, color: kTextColor),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              width: 2.5, color: kPrimaryColor),
                                        ),
                                      ),
                                    ),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            uploadCategory.fileName == null
                                                ? "Select Image"
                                                : "File Selected",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
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
                                              uploadCategory.upload(
                                                  name: nameAdd.text,
                                                  context: context);
                                            },
                                            child: const Text('Submit')),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                                  DataCell(Image.network(
                                    e.imgPath,
                                    width: 60,
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
                                                builder: (context) => Center(
                                                      child: Card(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        elevation: 10,
                                                        child: Form(
                                                          key: formKey,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        12,
                                                                    vertical:
                                                                        20),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                TextFormField(
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                  cursorColor:
                                                                      kPrimaryColor,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .name,
                                                                  controller:
                                                                      name,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    focusColor:
                                                                        kPrimaryColor,
                                                                    labelText:
                                                                        "Name",
                                                                    labelStyle: const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color:
                                                                            kPrimaryColor),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      borderSide: const BorderSide(
                                                                          width:
                                                                              2.5,
                                                                          color:
                                                                              kTextColor),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      borderSide: const BorderSide(
                                                                          width:
                                                                              2.5,
                                                                          color:
                                                                              kPrimaryColor),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    primary:
                                                                        kPrimaryColor,
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            10,
                                                                        horizontal:
                                                                            8),
                                                                  ),
                                                                  onPressed:
                                                                      () {
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
                                                                        child:
                                                                            Text(
                                                                          e.imgName,
                                                                          style:
                                                                              const TextStyle(fontSize: 18),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary:
                                                                                kPrimaryColor),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child: const Text(
                                                                            'Cancel')),
                                                                    ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                            primary:
                                                                                kPrimaryColor),
                                                                        onPressed:
                                                                            () async {
                                                                          await uploadEditCategory.edit(
                                                                              name: name.text,
                                                                              context: context,
                                                                              imgName: e.imgName,
                                                                              id: e.id);
                                                                        },
                                                                        child: const Text(
                                                                            'Submit')),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ));
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