import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  final nameController = TextEditingController(text: 'Hasib');
  final urlController = TextEditingController(text: 'https://www.google.com/');
  final numberController = TextEditingController(text: '01849945526');

  final GlobalKey<FormState> _addPortalformKey = GlobalKey<FormState>();

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
            child: Card(
              elevation: 10,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final data = PortalModel(
                    portalName:
                        context.watch<DataProvider>().portals[index].portalName,
                    portalUrl:
                        context.watch<DataProvider>().portals[index].portalUrl,
                    phoneNumber: context
                        .watch<DataProvider>()
                        .portals[index]
                        .phoneNumber,
                  );
                  return _buildCard(portalData: data);
                },
                itemCount: context.watch<DataProvider>().portals.length,
                padding: const EdgeInsets.all(8),
              ),
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
                StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('user').snapshots(),
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
                            snapshot.requireData.docs.first.get('username'),
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            snapshot.requireData.docs.first.get('email'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required PortalModel portalData,
  }) {
    return Card(
      child: ListTile(
        title: Text(portalData.portalName),
        subtitle: Text(portalData.portalUrl),
        leading: FutureBuilder<String>(
          initialData: '',
          future: context.read<DataProvider>().getFavcicoUrl(
                url: portalData.portalUrl,
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
            path: portalData.phoneNumber,
          ),
          builder: (context, followLink) => GestureDetector(
            onTap: followLink,
            child: const Icon(Icons.phone),
          ),
        ),
      ),
    );
  }
}
