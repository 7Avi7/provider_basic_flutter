// import 'package:api_provider/model.dart';
// import 'package:api_provider/provider.dart';
import 'package:api_provider_searched_pet/provider.dart';
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
                : getBodyUI());
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

  getBodyUI() {
    final provider = Provider.of<PetsProvider>(context, listen: false);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              provider.search(value);
            },
            decoration: InputDecoration(
              hintText: 'Search Pets...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: Consumer(
            builder: (context, PetsProvider petsProvider, child) =>
                ListView.builder(
              itemCount: petsProvider.searchedPets.data.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                      petsProvider.searchedPets.data[index].petImage),
                ),
                title: Text(provider.searchedPets.data[index].userName),
                trailing: provider.searchedPets.data[index].isFriendly
                    ? const SizedBox()
                    : const Icon(
                        Icons.pets,
                        color: Colors.red,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
