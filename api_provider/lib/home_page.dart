import 'package:api_provider/model.dart';
import 'package:api_provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    final provider = Provider.of<PetsProvider>(context, listen: false);
    provider.getDataFromAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PetsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Provider API Call'),
        ),
        body: provider.isLoading
            ? getLoadingUI()
            : provider.error.isNotEmpty
                ? getErrorUI(provider.error)
                : getBodyUI(provider.pets));
  }

  Widget getLoadingUI() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitWaveSpinner(
            color: Colors.yellow,
            size: 80.0,
          ),
          Text('Ektu Dhoirjo Dhoren Loading Hochche....'),
        ],
      ),
    );
  }

  getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 22,
        ),
      ),
    );
  }

  getBodyUI(Pets pets) {
    return ListView.builder(
      itemCount: pets.data.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          radius: 22,
          backgroundImage: NetworkImage(pets.data[index].petImage),
        ),
        title: Text(pets.data[index].userName),
        trailing: pets.data[index].isFriendly
            ? const SizedBox()
            : const Icon(
                Icons.pets,
                color: Colors.red,
              ),
      ),
    );
  }
}
