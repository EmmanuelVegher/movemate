import 'package:flutter/material.dart';
import 'package:movemate/utils/colors.dart';

// Dummy data model for search results
class SearchItem {
  final String title;
  final String trackingNumber;
  final String route;
  SearchItem({required this.title, required this.trackingNumber, required this.route});
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<SearchItem> _allItems = [
    SearchItem(title: 'Macbook pro M2', trackingNumber: '#NE43857340857904', route: 'Paris -> Morocco'),
    SearchItem(title: 'Summer linen jacket', trackingNumber: '#NEJ20089934122231', route: 'Barcelona -> Paris'),
    SearchItem(title: 'Tapered-fit jeans AW', trackingNumber: '#NEJ35870264978659', route: 'Colombia -> Paris'),
    SearchItem(title: 'Slim fit jeans AW', trackingNumber: '#NEJ35870264978659', route: 'Bogota -> Dhaka'),
    SearchItem(title: 'Office setup desk', trackingNumber: '#NEJ23481570754963', route: 'France -> German'),
  ];

  List<SearchItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _allItems;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems.where((item) {
        return item.title.toLowerCase().contains(query) ||
            item.trackingNumber.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          cursorColor: kAccentColor,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: kAccentColor),
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final item = _filteredItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: kPrimaryColor,
                child: Icon(Icons.inventory_2, color: Colors.white, size: 20),
              ),
              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${item.trackingNumber} • ${item.route}', style: const TextStyle(color: kMutedTextColor)),
            ),
          );
        },
      ),
    );
  }
}