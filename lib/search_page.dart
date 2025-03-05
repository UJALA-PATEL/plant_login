
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> recentSearches = [
    "Ficus Plant",
    "Aloe Vera",
    "Cactus",
    "Bonsai Tree",
    "Money Plant"
  ]; // Initial recent searches

  TextEditingController searchController = TextEditingController();

  void clearRecentSearches() {
    setState(() {
      recentSearches.clear();
    });
  }

  void onSearch(String query) {
    if (query.isNotEmpty) {
      setState(() {
        // Add the query to recent searches if it's not already there
        if (!recentSearches.contains(query)) {
          recentSearches.insert(0, query);
        }
        searchController.clear(); // Clear search bar after searching
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search for plants...",
                        border: InputBorder.none,
                      ),
                      onSubmitted: onSearch, // Perform search on submit
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 20),

            // Recent Searches Header with "Clear All"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Searches",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: clearRecentSearches,
                  child: Text(
                    "Clear All",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),

            // Recent Searches List
            Expanded(
              child: recentSearches.isEmpty
                  ? Center(
                child: Text(
                  "No recent searches",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.history, color: Colors.grey),
                    title: Text(recentSearches[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          recentSearches.removeAt(index); // Remove specific search
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
