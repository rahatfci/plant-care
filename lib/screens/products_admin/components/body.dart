import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_watch/authentication/form_validation.dart';
import 'package:plant_watch/components/form_field.dart';
import 'package:plant_watch/controllers/product_controller.dart';

import '../../../constants.dart';
import '../../../models/product_model.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController price = TextEditingController();

  TextEditingController nameAdd = TextEditingController();
  TextEditingController descriptionAdd = TextEditingController();
  TextEditingController quantityAdd = TextEditingController();
  TextEditingController discountAdd = TextEditingController();
  TextEditingController categoryAdd = TextEditingController();
  TextEditingController priceAdd = TextEditingController();

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
                UploadProduct uploadProduct = UploadProduct(setState);
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
                                    quantityAdd,
                                    "Quantity",
                                    TextInputType.number,
                                    (value) => productQuantityValidator(value)),
                                const SizedBox(
                                  height: 15,
                                ),
                                formField(
                                    categoryAdd,
                                    "Category",
                                    TextInputType.text,
                                    (value) => productCategoryValidator(value)),
                                const SizedBox(
                                  height: 15,
                                ),
                                formField(
                                    priceAdd,
                                    "Price",
                                    TextInputType.number,
                                    (value) => productPriceValidator(value)),
                                const SizedBox(
                                  height: 15,
                                ),
                                formField(
                                    discountAdd,
                                    "Discount",
                                    TextInputType.number,
                                    (value) => productDiscountValidator(value)),
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
                                    uploadProduct.showPicker(context);
                                    setState(() {});
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        uploadProduct.fileName == null
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
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await uploadProduct.upload(
                                        name: nameAdd.text,
                                        description: descriptionAdd.text,
                                        quantity: int.parse(quantityAdd.text),
                                        discount: discountAdd.text,
                                        price: priceAdd.text,
                                        category: categoryAdd.text,
                                        context: context);
                                  }
                                },
                                child: const Text('Submit')),
                          ],
                        ));
              },
              child: const Text("Add Product"),
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            StreamBuilder<List<Product>>(
              stream: ProductController.allProduct(),
              builder: (context, snapshot) {
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
                              label: Text('Category',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Quantity',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Discount',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          DataColumn(
                              label: Text('Price',
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
                                DataCell(Text(e.category)),
                                DataCell(Text(e.quantity.toString())),
                                DataCell(Text(e.discount)),
                                DataCell(Text(e.price)),
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
                                          UploadProduct uploadEditProduct =
                                              UploadProduct(setState);
                                          name.text = e.name;
                                          description.text = e.description;
                                          quantity.text = e.quantity.toString();
                                          discount.text = e.discount;
                                          price.text = e.price;
                                          category.text = e.category;
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
                                                  MainAxisAlignment.spaceEvenly,
                                              content: Form(
                                                key: formKey,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      formField(
                                                          name,
                                                          "Name",
                                                          TextInputType.name,
                                                          (value) =>
                                                              productNameValidator(
                                                                  value)),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      formField(
                                                          description,
                                                          "Description",
                                                          TextInputType.text,
                                                          (value) =>
                                                              productDescriptionValidator(
                                                                  value)),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      formField(
                                                          quantity,
                                                          "Quantity",
                                                          TextInputType.number,
                                                          (value) =>
                                                              productQuantityValidator(
                                                                  value)),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      formField(
                                                          category,
                                                          "Category",
                                                          TextInputType.text,
                                                          (value) =>
                                                              productCategoryValidator(
                                                                  value)),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      formField(
                                                          price,
                                                          "Price",
                                                          TextInputType.number,
                                                          (value) =>
                                                              productPriceValidator(
                                                                  value)),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      formField(
                                                          discount,
                                                          "Discount",
                                                          TextInputType.number,
                                                          (value) =>
                                                              productDiscountValidator(
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
                                                          uploadEditProduct
                                                              .showPicker(
                                                                  context);
                                                          setState(() {});
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
                                                                            16),
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
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        await uploadEditProduct
                                                            .edit(
                                                                id: e.id,
                                                                name: name.text,
                                                                description:
                                                                    description
                                                                        .text,
                                                                quantity:
                                                                    int.parse(
                                                                        quantity
                                                                            .text),
                                                                discount:
                                                                    discount
                                                                        .text,
                                                                price:
                                                                    price.text,
                                                                imgName:
                                                                    e.imgName,
                                                                category:
                                                                    category
                                                                        .text,
                                                                context:
                                                                    context);
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
                                                                  "products")
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
                                                                  "The product deleted successfully",
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
