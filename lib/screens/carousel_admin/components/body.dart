import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/authentication/form_validation.dart';
import 'package:plant_watch/components/form_field.dart';
import 'package:plant_watch/controllers/carousel_controller.dart';

import '../../../constants.dart';
import '../../../models/carousel_model.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  static String imageName = "Select Image";
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController link = TextEditingController();

  TextEditingController titleAdd = TextEditingController();
  TextEditingController descriptionAdd = TextEditingController();
  TextEditingController linkAdd = TextEditingController();

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
                linkAdd.clear();
                Body.imageName = "Select Image";
                UploadCarousel uploadCarousel = UploadCarousel();
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
                                  formField(
                                      linkAdd,
                                      "Link",
                                      TextInputType.url,
                                      (value) =>
                                          productQuantityValidator(value)),
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
                                      uploadCarousel.showPicker(
                                          context, setState);
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
                                      await uploadCarousel.upload(
                                        title: titleAdd.text,
                                        description: descriptionAdd.text,
                                        link: linkAdd.text,
                                        context: context,
                                      );
                                    }
                                  },
                                  child: const Text('Submit')),
                            ],
                          ),
                        ));
              },
              child: const Text("Add Carousel"),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            StreamBuilder<List<CarouselCustom>>(
              stream: CarouselControllerCustom.allCarousel(),
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
                              label: Text('Link',
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
                                DataCell(Text(e.link)),
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
                                          UploadCarousel uploadEditCarousel =
                                              UploadCarousel();
                                          title.text = e.title;
                                          description.text = e.description;
                                          link.text = e.link;
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
                                                        formField(
                                                            link,
                                                            "Link",
                                                            TextInputType.url,
                                                            (value) =>
                                                                carouselLinkValidator(
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
                                                            uploadEditCarousel
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
                                                          await uploadEditCarousel
                                                              .edit(
                                                                  id: e.id,
                                                                  title: title
                                                                      .text,
                                                                  description:
                                                                      description
                                                                          .text,
                                                                  link:
                                                                      link.text,
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
                                                              .collection(
                                                                  "carousel")
                                                              .doc(e.id)
                                                              .delete()
                                                              .then((value) {
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
                                                                  "The carousel deleted successfully",
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
                                                            //FirebaseFirestore.instance.collection('cart')
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
