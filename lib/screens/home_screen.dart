import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internshala/services/internship_service.dart';
import '../components/dashboard.dart';
import '../models/internship_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Internship>> futureInternships = Future.value([]);
  Map<String, dynamic> filters = {};
  List<String> profiles = [];
  List<String> cities = [];
  List<String> durations = [];
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchInternships();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }

  void fetchInternships() async {
    final internships = await InternshipService.fetchInternships();
    setState(() {
      futureInternships = Future.value(internships);
      _extractFilterOptions(internships);
    });
  }

  void _extractFilterOptions(List<Internship> internships) {
    profiles = internships.map((i) => i.title).toSet().toList();
    cities = internships.map((i) => i.location).toSet().toList();
    durations = internships.map((i) => i.duration).toSet().toList();
  }

  void applyFilters(Map<String, dynamic> newFilters) {
    setState(() {
      filters = newFilters;
    });
    fetchInternships();
  }

  List<Internship> filterInternships(List<Internship> internships) {
    if (filters.isNotEmpty) {
      if (filters['profile'] != null && filters['profile'].isNotEmpty) {
        internships = internships
            .where(
                (internship) => internship.title.contains(filters['profile']))
            .toList();
      }
      if (filters['city'] != null && filters['city'].isNotEmpty) {
        internships = internships
            .where(
                (internship) => internship.location.contains(filters['city']))
            .toList();
      }
      if (filters['duration'] != null && filters['duration'].isNotEmpty) {
        internships = internships
            .where((internship) =>
                internship.duration.contains(filters['duration']))
            .toList();
      }
    }
    if (searchQuery.isNotEmpty) {
      internships = internships
          .where((internship) => internship.title
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }
    return internships;
  }

  void _showFilterDialog() {
    String profile = '';
    String city = '';
    String duration = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Internships'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Profile'),
                items: profiles.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  profile = value ?? '';
                },
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'City'),
                items: cities.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  city = value ?? '';
                },
              ),
              DropdownButtonFormField<String>(
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Duration'),
                items: durations.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  duration = value ?? '';
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                applyFilters({
                  'profile': profile,
                  'city': city,
                  'duration': duration,
                });
                Navigator.of(context).pop();
              },
              child: const Text('Search'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                    backgroundImage: AssetImage("assets/pfp.jpg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade600)),
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Icon(
                                CupertinoIcons.bell,
                                color: Colors.grey.shade600,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade600)),
                            ),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Icon(
                                CupertinoIcons.line_horizontal_3,
                                color: Colors.grey.shade600,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 23.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(
                      "Let's find you an Internship!",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: _showFilterDialog,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      height: 60,
                      width: 60,
                      child: Icon(Icons.filter_list_alt, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            dashboard(),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              height: 1,
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: FutureBuilder<List<Internship>>(
                future: futureInternships,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No internships found'));
                  } else {
                    List<Internship> filteredInternships =
                        filterInternships(snapshot.data!);
                    return ListView.builder(
                      itemCount: filteredInternships.length,
                      itemBuilder: (context, index) {
                        final internship = filteredInternships[index];
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  height:
                                      MediaQuery.of(context).size.height * .16,
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                            const Positioned(
                                right: 70,
                                top: 25,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage('assets/is.png'),
                                )),
                            Positioned(
                                top: 30,
                                left: 70,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                200,
                                        child: Text(
                                          maxLines: 1,
                                          internship.title,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        )),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                200,
                                        child: Text(
                                          '${internship.companyName} ',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        )),
                                  ],
                                )),
                            Positioned(
                              top: 80,
                              left: 70,
                              child: Text(internship.location),
                            ),
                            Positioned(
                              bottom: 25,
                              left: 70,
                              child: Text(internship.duration),
                            ),
                            Positioned(
                              //title: Text(internship.title),
                              bottom: 25,
                              right: 70,
                              child: Text(
                                internship.stipend,
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
