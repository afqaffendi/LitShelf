import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'firestore_service.dart'; // Make sure this file exists and is correctly implemented
// import 'review_dialog.dart'; // REMOVED: No longer needed as reviews are removed

class EbookListPage extends StatefulWidget {
  const EbookListPage({super.key});

  @override
  _EbookListPageState createState() => _EbookListPageState();
}

class _EbookListPageState extends State<EbookListPage> {
  final FirestoreService _firestoreService = FirestoreService();
  String searchQuery = '';
  String selectedGenre = 'All';
  bool showOnlyFavorites = false;
  bool showOnlyWishlist = false; // NEW: State for wishlist filter

  List<String> _userFavorites = [];
  List<String> _userWishlist = []; // NEW: State for user's wishlist
  bool _isLoadingUserData = true; // Consolidated loading state for favorites and wishlist
  late final String userId;

  final List<String> genres = [
    'All',
  ];

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userId = user.uid;
      _loadUserCollections();
    } else {
      setState(() {
        _isLoadingUserData = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You must be logged in to view eBooks.')),
        );
      });
    }
  }

  void _loadUserCollections() {
    // Listen to the stream for real-time updates to favorites
    _firestoreService.getUserFavorites(userId).listen((favs) {
      if (mounted) {
        setState(() {
          _userFavorites = favs;
          // Only set loading to false after both favorites and wishlist are loaded
          if (!_isLoadingUserData) { // Prevent unnecessary re-build if wishlist isn't loaded yet
            _isLoadingUserData = false;
          }
        });
      }
    }, onError: (error) {
      debugPrint('Error loading user favorites: $error');
      if (mounted) {
        setState(() {
          _isLoadingUserData = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading favorites: $error')),
      );
    });

    // NEW: Listen to the stream for real-time updates to wishlist
    _firestoreService.getUserWishlist(userId).listen((wishlistItems) {
      if (mounted) {
        setState(() {
          _userWishlist = wishlistItems;
          // Only set loading to false after both favorites and wishlist are loaded
          if (_userFavorites.isNotEmpty || _userWishlist.isNotEmpty || mounted) { // Simple check, could be more robust
             _isLoadingUserData = false;
          }
        });
      }
    }, onError: (error) {
      debugPrint('Error loading user wishlist: $error');
      if (mounted) {
        setState(() {
          _isLoadingUserData = false;
        });
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading wishlist: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return const Center(child: Text("Please log in to see eBooks."));
    }

    if (_isLoadingUserData) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        // --- Search Bar and Filters ---
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                onChanged: (val) {
                  setState(() {
                    searchQuery = val.trim().toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search Books',
                  hintText: 'Title, Author, or Genre',
                  prefixIcon: const Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.7),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Segmented Button for Genres
                    SegmentedButton<String>(
                      segments: genres
                          .map((genre) => ButtonSegment<String>(
                                value: genre,
                                label: Text(genre, style: const TextStyle(fontSize: 13)),
                              ))
                          .toList(),
                      selected: {selectedGenre},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() {
                          selectedGenre = newSelection.first;
                        });
                      },
                      style: SegmentedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.7),
                        selectedBackgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        selectedForegroundColor: Theme.of(context).colorScheme.primary,
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      ),
                    ),
                    const SizedBox(width: 8), // Gap between genre and favorites
                    // Favorites Filter Chip
                    FilterChip(
                      label: const Text('Favorites', style: TextStyle(fontSize: 13)),
                      avatar: Icon(
                        showOnlyFavorites ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        color: showOnlyFavorites ? Theme.of(context).colorScheme.primary : null,
                      ),
                      selected: showOnlyFavorites,
                      onSelected: (bool selected) {
                        setState(() {
                          showOnlyFavorites = selected;
                          if (selected) showOnlyWishlist = false; // Only one filter active at a time
                        });
                      },
                      checkmarkColor: Theme.of(context).colorScheme.primary,
                      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      backgroundColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.7),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      side: BorderSide.none,
                    ),
                    const SizedBox(width: 8), // Gap between filters
                    // NEW: Wishlist Filter Chip
                    FilterChip(
                      label: const Text('Wishlist', style: TextStyle(fontSize: 13)),
                      avatar: Icon(
                        showOnlyWishlist ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                        color: showOnlyWishlist ? Theme.of(context).colorScheme.primary : null,
                      ),
                      selected: showOnlyWishlist,
                      onSelected: (bool selected) {
                        setState(() {
                          showOnlyWishlist = selected;
                          if (selected) showOnlyFavorites = false; // Only one filter active at a time
                        });
                      },
                      checkmarkColor: Theme.of(context).colorScheme.primary,
                      selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      backgroundColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.7),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      side: BorderSide.none,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // --- Ebook List ---
        Expanded(
          child: _buildEbookList(),
        ),
      ],
    );
  }

  Widget _buildEbookList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestoreService.getEbooks(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _EbookListSkeleton();
        }

        final docs = snapshot.data!.docs;

        final filtered = docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final title = (data['title'] ?? '').toLowerCase();
          final author = (data['author'] ?? '').toLowerCase();
          final genre = (data['genre'] ?? '').toLowerCase();
          final ebookId = doc.id;

          final matchesSearch =
              searchQuery.isEmpty || title.contains(searchQuery) || author.contains(searchQuery) || genre.contains(searchQuery);

          final matchesGenre = selectedGenre == 'All' || genre == selectedGenre.toLowerCase();

          final matchesFavorites = !showOnlyFavorites || _userFavorites.contains(ebookId);
          final matchesWishlist = !showOnlyWishlist || _userWishlist.contains(ebookId); // NEW: Wishlist filter

          return matchesSearch && matchesGenre && matchesFavorites && matchesWishlist; // Combine all filters
        }).toList();

        if (filtered.isEmpty) {
          String message = "No eBooks found.";
          String details = "Try adjusting your search or filters.";
          if (showOnlyFavorites) {
            message = "No Favorites Found";
            details = "You haven't added any eBooks to your favorites, or none match your current filters.";
          } else if (showOnlyWishlist) { // NEW: Wishlist empty state
            message = "No Wishlist Items";
            details = "You haven't added any eBooks to your wishlist, or none match your current filters.";
          } else if (searchQuery.isNotEmpty) {
            message = "No Matching Books";
            details = "No books match your search query.";
          } else if (selectedGenre != 'All') {
            message = "No Books in This Genre";
            details = "There are no books listed for the '${selectedGenre}' genre.";
          }

          return _EmptyState(
            icon: Icons.menu_book_rounded,
            message: message,
            details: details,
          );
        }

        return ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final ebookId = filtered[index].id;

            return StreamBuilder<DocumentSnapshot>(
              stream: _firestoreService.getEbook(ebookId),
              builder: (context, ebookSnap) {
                if (!ebookSnap.hasData || !ebookSnap.data!.exists) {
                  return const SizedBox();
                }

                final data = ebookSnap.data!.data() as Map<String, dynamic>;

                final title = data['title'] ?? 'No Title';
                final author = data['author'] ?? 'Unknown Author';
                final genre = data['genre'] ?? 'N/A';
                final description = data['description'] ?? 'No description available.';
                final avgRating = (data['averageRating'] ?? 0.0).toDouble();
                final ratingCount = (data['ratingCount'] ?? 0);
                final isFavorite = _userFavorites.contains(ebookId);
                final isInWishlist = _userWishlist.contains(ebookId); // NEW: Check if in wishlist

                // Ebook Card with Expansion and Actions
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ExpansionTile(
                        key: PageStorageKey(ebookId),
                        title: Text(
                          title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$author • $genre',
                              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.star_rounded, color: Colors.amber[700], size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  avgRating.toStringAsFixed(1),
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                ),
                                const SizedBox(width: 8),
                                Text('($ratingCount reviews)'), // Kept for display, but review functionality removed
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            color: isFavorite ? Colors.redAccent : Colors.grey,
                          ),
                          onPressed: () async {
                            await _firestoreService.toggleFavorite(userId, ebookId);
                            ScaffoldMessenger.of(context).showSnackBar( // Provide feedback
                              SnackBar(
                                content: Text(isFavorite ? '"$title" removed from favorites!' : '"$title" added to favorites!'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(description, style: const TextStyle(fontSize: 14, height: 1.4)),
                                const SizedBox(height: 16),
                                // Action Buttons (Wishlist remains, Review is removed)
                                Align( // Align the buttons to the end
                                  alignment: Alignment.bottomRight,
                                  child: Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: [
                                      OutlinedButton.icon(
                                        onPressed: () async {
                                          await _firestoreService.toggleWishlist(userId, ebookId, true); // Simplified toggle
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  isInWishlist ? '"$title" removed from wishlist!' : '"$title" added to wishlist!'),
                                              duration: const Duration(seconds: 1),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          isInWishlist ? Icons.bookmark_rounded : Icons.bookmark_add_rounded,
                                          color: isInWishlist ? Theme.of(context).colorScheme.primary : null,
                                        ),
                                        label: Text(isInWishlist ? "In Wishlist" : "Add to Wishlist"),
                                      ),
                                      // REMOVED: FilledButton for "Review"
                                      // FilledButton.icon(
                                      //   onPressed: () {
                                      //     showDialog(
                                      //       context: context,
                                      //       builder: (_) => ReviewDialog(ebookId: ebookId, title: title),
                                      //     );
                                      //   },
                                      //   icon: const Icon(Icons.rate_review_rounded),
                                      //   label: const Text("Review"),
                                      // ),
                                    ],
                                  ),
                                ),
                                // REMOVED: User Reviews section
                                // const SizedBox(height: 16),
                                // const Text('User Reviews:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                // const SizedBox(height: 8),
                                // StreamBuilder<QuerySnapshot>(
                                //   stream: _firestoreService.getReviews(ebookId),
                                //   builder: (context, reviewSnap) {
                                //     if (reviewSnap.hasError) return const Text('Error loading reviews.');
                                //     if (reviewSnap.connectionState == ConnectionState.waiting) {
                                //       return const Center(child: CircularProgressIndicator());
                                //     }
                                //     final reviews = reviewSnap.data!.docs;
                                //     if (reviews.isEmpty) return const Text('No reviews yet. Be the first!');
                                //     return ListView.builder(
                                //       shrinkWrap: true,
                                //       physics: const NeverScrollableScrollPhysics(),
                                //       itemCount: reviews.length,
                                //       itemBuilder: (context, idx) {
                                //         final review = reviews[idx].data() as Map<String, dynamic>;
                                //         return Card(
                                //           margin: const EdgeInsets.only(bottom: 8.0),
                                //           color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                                //           child: Padding(
                                //             padding: const EdgeInsets.all(8.0),
                                //             child: Column(
                                //               crossAxisAlignment: CrossAxisAlignment.start,
                                //               children: [
                                //                 Row(
                                //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //                   children: [
                                //                     Text(
                                //                       review['userName'] ?? 'Anonymous',
                                //                       style: const TextStyle(fontWeight: FontWeight.bold),
                                //                     ),
                                //                     Row(
                                //                       children: [
                                //                         Icon(Icons.star, color: Colors.amber[400], size: 16),
                                //                         Text('${review['rating']}/5'),
                                //                       ],
                                //                     ),
                                //                   ],
                                //                 ),
                                //                 const SizedBox(height: 4),
                                //                 Text(review['text'] ?? ''),
                                //               ],
                                //             ),
                                //           ),
                                //         );
                                //       },
                                //     );
                                //   },
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

// --- Skeleton Loader (remains unchanged) ---
class _EbookListSkeleton extends StatelessWidget {
  const _EbookListSkeleton();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      highlightColor: Theme.of(context).colorScheme.surfaceContainer,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        itemBuilder: (_, __) => Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 250, height: 20, color: Colors.white),
                const SizedBox(height: 8),
                Container(width: 180, height: 16, color: Colors.white),
                const SizedBox(height: 8),
                Container(width: 100, height: 14, color: Colors.white),
                const SizedBox(height: 16),
                Container(width: double.infinity, height: 14, color: Colors.white),
                const SizedBox(height: 6),
                Container(width: double.infinity * 0.8, height: 14, color: Colors.white),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(width: 80, height: 36, color: Colors.white, margin: const EdgeInsets.only(right: 8)),
                    Container(width: 80, height: 36, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Empty State Widget (remains unchanged) ---
class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String details;

  const _EmptyState({
    required this.icon,
    required this.message,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: Theme.of(context).colorScheme.primary.withOpacity(0.7)),
            const SizedBox(height: 24),
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              details,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}