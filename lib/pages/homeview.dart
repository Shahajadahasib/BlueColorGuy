import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';

import '../auth/auth.dart';
import '../model/portalmodel.dart';
import '../provider/dataprovider.dart';

class Homeviews extends StatefulWidget {
  const Homeviews({super.key});

  @override
  State<Homeviews> createState() => _HomeviewsState();
}

class _HomeviewsState extends State<Homeviews> {
  final nameController = TextEditingController();
  final urlController = TextEditingController();
  final numberController = TextEditingController();

  final GlobalKey<FormState> _addPortalformKey = GlobalKey<FormState>();
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => FlutterNativeSplash.remove(),
    );
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    urlController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Image(
          height: 70,
          image: AssetImage('assets/images/logo2.jpg'),
        ),
      ),
      body: Column(
        children: [
          Link(
            target: LinkTarget.defaultTarget,
            uri: Uri.parse("https://bluecollarguy.ca/"),
            builder: (context, followLink) => InkWell(
              onTap: followLink,
              child: Row(
                children: [
                  SizedBox(
                    height: size.height / 12,
                    width: size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Image(
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                        ),
                        Text(
                          "Check Latest Deals",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('portals')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];

                    return _buildCard(
                      onLongTap: () async {
                        await FirebaseFirestore.instance
                            .runTransaction((Transaction myTransaction) async {
                          await myTransaction.delete(data.reference);
                        });
                        Navigator.pop(context);
                      },
                      portalName: data['name'],
                      portalUrl: data['portalUrl'],
                      phoneNumber: data['phoneNumber'],
                    );
                  },
                );
              },
            ),
          ),
          Link(
            target: LinkTarget.defaultTarget,
            uri: Uri.parse("https://myprofreelancer.com/"),
            builder: (context, followLink) => InkWell(
              onTap: followLink,
              child: Stack(
                children: [
                  Container(
                    height: size.height / 12,
                    width: size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/myprofreelancer-Logo.png'),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 10,
                    top: 8,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: SingleChildScrollView(
                child: Form(
                  key: _addPortalformKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Add Portal',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Enter Portal Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: RequiredValidator(
                            errorText: 'Portal Name is required'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: urlController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.url,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Paste you Url",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator:
                            RequiredValidator(errorText: 'Url is required'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: numberController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        validator:
                            RequiredValidator(errorText: 'Number is required'),
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: "Enter Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    nameController.clear();
                    urlController.clear();
                    numberController.clear();
                  },
                  child: const Text(
                    "Clear",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (_addPortalformKey.currentState!.validate()) {
                      final data = PortalModel(
                        portalName: nameController.text.trim(),
                        portalUrl: urlController.text.trim(),
                        phoneNumber: numberController.text.trim(),
                      );
                      context.read<DataProvider>().addData(
                            portalModel: data,
                          );
                      nameController.clear();
                      urlController.clear();
                      numberController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    "Done",
                  ),
                ),
              ],
            ),
          );
        },
        child: const Icon(
          Icons.add_circle,
          size: 34,
        ),
      ),
      drawer: Drawer(
        elevation: 10,
        backgroundColor: Colors.black,
        width: size.width / 1.5,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Image(
                  image: AssetImage('assets/images/logo2.jpg'),
                ),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('user')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListTile(
                      title: Column(
                        children: [
                          Text(
                            snapshot.requireData.get('username'),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.requireData.get('email'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      authService.signOut();
                    },
                    child: const ListTile(
                      title: Center(child: Text('Log Out')),
                    ),
                  ),
                ),
                Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Confirm Account Deletion'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Text(
                                        'Are you sure you want to delete your account?'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        'Once account is deleted it can\'t be undone!'),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Cancel",
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await authService.deleteAccount();
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Confirm",
                                    ),
                                  ),
                                ],
                              ));
                    },
                    child: const ListTile(
                      title: Center(child: Text('Delete Account')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String portalName,
    required String portalUrl,
    required String phoneNumber,
    required Function onLongTap,
  }) {
    String url = '';
    if (portalUrl.startsWith('https://')) {
      url = portalUrl;
    } else {
      url = 'https://$portalUrl';
    }
    return Link(
      target: LinkTarget.defaultTarget,
      uri: Uri.parse(url),
      builder: (context, followLink) => GestureDetector(
        onLongPress: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Confirm Portal Deletion'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Are you sure you want to delete the portal?'),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Once portal is deleted it can\'t be undone!'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          onLongTap();
                        },
                        child: const Text(
                          "Confirm",
                        ),
                      ),
                    ],
                  ));
        },
        onTap: followLink,
        child: Card(
          child: ListTile(
            title: Text(portalName),
            subtitle: Text(portalUrl),
            leading: FutureBuilder<String>(
              initialData: '',
              future: context.read<DataProvider>().getFavcicoUrl(
                    url: portalUrl,
                  ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  return CachedNetworkImage(
                    placeholder: (context, url) => const SizedBox(
                      height: 32,
                      width: 32,
                      child: CircularProgressIndicator(),
                    ),
                    imageUrl: snapshot.data!,
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error_outline,
                      size: 32,
                    ),
                  );
                }

                return const Icon(
                  Icons.language_outlined,
                  size: 32,
                );
              },
            ),
            trailing: Link(
              target: LinkTarget.defaultTarget,
              uri: Uri(
                scheme: 'tel',
                path: phoneNumber,
              ),
              builder: (context, followLink) => GestureDetector(
                onTap: followLink,
                child: const Icon(Icons.phone),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
