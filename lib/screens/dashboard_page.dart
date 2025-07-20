import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litshelf2/screens/view_users_page.dart';
import 'package:shimmer/shimmer.dart';
import 'manage_account_page.dart';
import 'ebook_list_page.dart';
import '../services/firestore_service.dart';
import 'profile_page.dart';
import 'add_book_page.dart';
import 'author_books_section.dart';

class DashboardPage extends StatefulWidget {
  final String role;
  final bool isDarkMode;
  final void Function(bool) onToggleDarkMode;

  const DashboardPage({
    super.key,
    required this.role,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final PageController _pageController = PageController();
  final FirestoreService _firestoreService = FirestoreService();
  final User? _currentUser = FirebaseAuth.instance.currentUser;

  String _userRole = 'user';
  bool _isLoadingRole = true;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    try {
      if (_currentUser == null) {
        setState(() => _isLoadingRole = false);
        return;
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(_currentUser.uid)
          .get();

      setState(() {
        _userRole = (userDoc.data()?['role'] as String?)?.toLowerCase() ?? 'user';
        _isLoadingRole = false;
      });
    } catch (e) {
      setState(() {
        _userRole = 'user'; // Default to user role on error
        _isLoadingRole = false;
      });
    }
  }

  void _onItemTapped(int index) {
    // HCI: Smooth transitions for better perceived performance and user flow.
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic, // Slightly more modern curve
    );
  }

  // New method to navigate to the "Discover" (EbookListPage) tab
  void _navigateToExplore() {
    int exploreIndex = 1; // Assuming 'Discover' (EbookListPage) is at index 1
    _onItemTapped(exploreIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // HCI: Clear and concise titles for navigation.
  static const List<String> _pageTitles = ['Home', 'Discover', 'Profile'];
  static const List<String> _librarianTitles = ['Home', 'Discover', 'Accounts', 'Profile'];

  @override
  Widget build(BuildContext context) {
    // HCI: Provide immediate feedback during loading.
    if (_isLoadingRole) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                "Loading your profile...",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      );
    }

    // Determine the list of pages based on user role
    final List<Widget> pages;
    final List<BottomNavigationBarItem> bottomNavItems;

    if (_userRole == 'librarian') {
      pages = [
        _DashboardHomeView(
          firestoreService: _firestoreService,
          currentUser: _currentUser,
          onNavigateToExplore: _navigateToExplore, // Pass callback
        ),
        const EbookListPage(),
        const ManageAccountPage(),
        ProfilePage(
          isDarkMode: widget.isDarkMode,
          onToggleDarkMode: widget.onToggleDarkMode,
        ),
      ];
      bottomNavItems = const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          activeIcon: Icon(Icons.explore_rounded),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt_outlined), // More descriptive icon for accounts
          activeIcon: Icon(Icons.people_alt_rounded),
          label: 'Accounts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ];
    } else {
      pages = [
        _DashboardHomeView(
          firestoreService: _firestoreService,
          currentUser: _currentUser,
          onNavigateToExplore: _navigateToExplore, // Pass callback
        ),
        const EbookListPage(),
        ProfilePage(
          isDarkMode: widget.isDarkMode,
          onToggleDarkMode: widget.onToggleDarkMode,
        ),
      ];
      bottomNavItems = const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          activeIcon: Icon(Icons.explore_rounded),
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          activeIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        // HCI: Use animated opacity for title change for a smoother feel.
        title: AnimatedOpacity(
          opacity: _isLoadingRole ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: Text(
            (_userRole == 'librarian' ? _librarianTitles : _pageTitles)[_selectedIndex],
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent, // AppBar blends with background
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [
          // HCI: Only show relevant actions based on role.
          if (_userRole == 'librarian')
            IconButton(
              icon: const Icon(Icons.group_add_outlined), // More specific icon for user management
              tooltip: 'Manage Users', // HCI: Clear tooltip
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ViewUsersPage()),
                );
              },
            ),
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
            onPressed: () => widget.onToggleDarkMode(!widget.isDarkMode),
            tooltip: 'Toggle Theme', // HCI: Clear tooltip
          ),
          const SizedBox(width: 8), // Add some spacing to the right
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
        children: pages,
      ),
      bottomNavigationBar: _buildFloatingNavBar(context, bottomNavItems),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: (!_isLoadingRole && (_userRole == 'author' || _userRole == 'librarian'))
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AddBookPage()),
                );
              },
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, // Use a distinct color for primary action
              foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              icon: const Icon(Icons.add_circle_outline_rounded), // More inviting add icon
              label: Text(
                'Add Book',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold, // Make text bolder
                      color: Theme.of(context).colorScheme.onTertiaryContainer, // Ensure text color is consistent
                    ),
              ),
            )
          : null,
    );
  }

  Widget _buildFloatingNavBar(BuildContext context, List<BottomNavigationBarItem> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerHighest, // Use a slightly elevated surface color
        borderRadius: BorderRadius.circular(32), // More rounded
        elevation: 10, // Increased elevation for a floating effect
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              // HCI: Prevent navigation to a non-existent index if role changes dynamically.
              if (index < items.length) {
                _onItemTapped(index);
              }
            },
            backgroundColor: Colors.transparent, // Make background transparent to show Material color
            elevation: 0,
            showSelectedLabels: true, // HCI: Show labels for clarity
            showUnselectedLabels: false, // Keep unselected labels hidden to reduce clutter
            selectedItemColor: Theme.of(context).colorScheme.primary, // Stronger accent for selected
            unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant, // More muted for unselected
            type: BottomNavigationBarType.fixed,
            items: items, // Use dynamic items
          ),
        ),
      ),
    );
  }
}

class _DashboardHomeView extends StatelessWidget {
  final FirestoreService firestoreService;
  final User? currentUser;
  final VoidCallback onNavigateToExplore; // New callback

  const _DashboardHomeView({
    required this.firestoreService,
    required this.currentUser,
    required this.onNavigateToExplore, // Initialize callback
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final userRole = (snapshot.data?.data() as Map<String, dynamic>?)?['role'] as String? ?? 'user';
        final isAuthor = userRole.toLowerCase() == 'author';
        final isLibrarian = userRole.toLowerCase() == 'librarian';

        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WelcomeHeader(userName: currentUser?.displayName),
                const SizedBox(height: 24),
                if (isLibrarian) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Manage Users 👥",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ManageAccountPage(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "All Books 📚",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: EbookListPage(),
                  ),
                ] else if (isAuthor) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Your Books 📚",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AuthorBooksSection(
                    firestoreService: firestoreService,
                    userId: currentUser?.uid,
                  ),
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "Your Wishlist ⭐️",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _WishlistSection(
                    firestoreService: firestoreService,
                    userId: currentUser?.uid,
                    onNavigateToExplore: onNavigateToExplore,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  final String? userName;

  const _WelcomeHeader({this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 8.0), // Adjust padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, ${userName ?? 'Reader'} 👋', // HCI: Personalization, use a default if name is null
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground, // Use onBackground for main text
                ),
          ),
          const SizedBox(height: 4),
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userName != null ? FirebaseAuth.instance.currentUser?.uid : null)
                .snapshots(),
            builder: (context, snapshot) {
              final userRole = (snapshot.data?.data() as Map<String, dynamic>?)?['role'] as String? ?? 'user';
              final isAuthor = userRole.toLowerCase() == 'author';
              final isLibrarian = userRole.toLowerCase() == 'librarian';
              
              String message;
              if (isLibrarian) {
                message = "Manage and oversee the library system";
              } else if (isAuthor) {
                message = "Share your literary works with the world!";
              } else {
                message = "What do you want to read today?";
              }
              
              return Text(
                message,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WishlistSection extends StatelessWidget {
  final FirestoreService firestoreService;
  final String? userId;
  final VoidCallback onNavigateToExplore; // New callback

  const _WishlistSection({
    required this.firestoreService,
    this.userId,
    required this.onNavigateToExplore, // Initialize callback
  });

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      // HCI: Clear instructions if not logged in.
      return const Center(
          child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Text(
          "Please log in to see your wishlist and save books for later.",
          textAlign: TextAlign.center,
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ));
    }

    return StreamBuilder<List<String>>(
      stream: firestoreService.getUserWishlist(userId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _WishlistShimmerLoader(); // HCI: Shimmer for loading state
        }
        if (snapshot.hasError) {
          // HCI: More user-friendly error message.
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              'Failed to load wishlist. Please try again later. Error: ${snapshot.error}',
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ));
        }
        final wishlistIds = snapshot.data;
        if (wishlistIds == null || wishlistIds.isEmpty) {
          return _EmptyWishlist(onNavigateToExplore: onNavigateToExplore); // Pass callback
        }

        return StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getEbooksByIds(wishlistIds),
          builder: (context, bookSnapshot) {
            if (bookSnapshot.connectionState == ConnectionState.waiting) {
              return const _WishlistShimmerLoader();
            }
            if (bookSnapshot.hasError) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Failed to load books. Please check your internet connection. Error: ${bookSnapshot.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ));
            }
            if (!bookSnapshot.hasData || bookSnapshot.data!.docs.isEmpty) {
              return _EmptyWishlist(onNavigateToExplore: onNavigateToExplore); // Pass callback
            }

            final ebooks = bookSnapshot.data!.docs;
            return ListView.builder(
              itemCount: ebooks.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // Contained within parent's scroll
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final ebook = ebooks[index];
                // Crucial: Use a UniqueKey for each Dismissible to ensure it works correctly
                return _WishlistCard(
                  key: ValueKey(ebook.id), // Use ValueKey with ebook.id for unique identification
                  ebook: ebook,
                  userId: userId!,
                  firestoreService: firestoreService, // Pass firestoreService down
                );
              },
            );
          },
        );
      },
    );
  }
}

class _WishlistCard extends StatelessWidget {
  final DocumentSnapshot ebook;
  final String userId;
  final FirestoreService firestoreService; // Add FirestoreService here

  const _WishlistCard({
    super.key, // Ensure key is passed to super
    required this.ebook,
    required this.userId,
    required this.firestoreService, // Initialize FirestoreService
  });

  @override
  Widget build(BuildContext context) {
    final data = ebook.data() as Map<String, dynamic>;
    final title = data['title'] ?? 'No Title';
    final author = data['author'] ?? 'Unknown Author';
    final coverUrl = data['coverUrl'];

    return Dismissible(
      key: key!, // Use the key passed from the parent for Dismissible
      direction: DismissDirection.endToStart, // Only allow swipe from right to left
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Theme.of(context).colorScheme.errorContainer, // Material 3 error color for background
        child: Icon(
          Icons.delete_sweep_rounded, // A strong delete icon
          color: Theme.of(context).colorScheme.onErrorContainer,
          size: 36, // Slightly larger icon
        ),
      ),
      confirmDismiss: (direction) async {
        // Show confirmation dialog before actual deletion
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Remove from Wishlist?'),
            content: Text('Are you sure you want to remove "$title" from your wishlist?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false), // User cancels
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true), // User confirms
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                ),
                child: const Text('Remove'),
              ),
            ],
          ),
        );
        return confirmed ?? false; // Return true if confirmed, false otherwise
      },
      onDismissed: (direction) async {
        // Perform deletion after confirmation
        try {
          await firestoreService.toggleWishlist(userId, ebook.id, false);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('"$title" removed from wishlist.', style: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer)),
                backgroundColor: Theme.of(context).colorScheme.tertiaryContainer, // A neutral success color
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        } catch (e) {
          debugPrint('Error removing from wishlist: $e');
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to remove "$title". Please try again.', style: TextStyle(color: Theme.of(context).colorScheme.onError)),
                backgroundColor: Theme.of(context).colorScheme.error,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
          // If deletion fails, you might want to re-add the item to the list
          // This would require a mechanism to update the parent state.
          // For simplicity, we'll let the StreamBuilder re-fetch the correct state.
        }
      },
      child: Card(
        elevation: 6, // Slightly more prominent card
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8), // Increased margin for spacing
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)), // More rounded corners
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            // HCI: User feedback on tap
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Opening "$title"...', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                duration: const Duration(seconds: 1), // Short duration
                behavior: SnackBarBehavior.floating,
              ),
            );
            // Navigate to book details or reader page
            // Navigator.push(context, MaterialPageRoute(builder: (_) => BookDetailsPage(ebookId: ebook.id)));
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Increased padding inside card
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align content to top
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: coverUrl != null && coverUrl.isNotEmpty
                      ? Image.network(
                          coverUrl,
                          width: 80, // Slightly larger image
                          height: 120, // Slightly larger image
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Shimmer.fromColors( // HCI: Shimmer for image loading
                              baseColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                              highlightColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                              child: Container(
                                width: 80,
                                height: 120,
                                color: Colors.white,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            // HCI: Clear fallback for image loading errors
                            return Container(
                              width: 80,
                              height: 120,
                              color: Theme.of(context).colorScheme.surfaceVariant,
                              child: Icon(
                                Icons.broken_image_rounded,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                size: 40,
                              ),
                            );
                          },
                        )
                      : Container(
                          width: 80,
                          height: 120,
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          child: Icon(
                            Icons.book_rounded,
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                            size: 40, // Larger icon for placeholder
                          ),
                        ),
                ),
                const SizedBox(width: 18), // Increased spacing
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6), // Increased spacing
                      Text(
                        author,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8), // Spacing before potential action buttons
                    ],
                  ),
                ),
                // Removed the favorite icon as swipe-to-delete replaces it for removal
                // Align(
                //   alignment: Alignment.topRight, // Align icon to top right
                //   child: IconButton(
                //     icon: const Icon(Icons.favorite, color: Colors.redAccent), // Keep consistency with heart icon
                //     tooltip: 'Remove from Wishlist', // HCI: Clear tooltip
                //     onPressed: () {
                //       // Confirmation dialog for destructive action
                //       showDialog(
                //         context: context,
                //         builder: (dialogContext) => AlertDialog(
                //           title: const Text('Remove from Wishlist?'),
                //           content: Text('Are you sure you want to remove "$title" from your wishlist?'),
                //           actions: [
                //             TextButton(
                //               onPressed: () => Navigator.of(dialogContext).pop(),
                //               child: const Text('Cancel'),
                //             ),
                //             FilledButton( // HCI: Emphasize primary action
                //               onPressed: () {
                //                 FirestoreService().toggleWishlist(userId, ebook.id, false);
                //                 ScaffoldMessenger.of(context).showSnackBar(
                //                   SnackBar(
                //                     content: Text('"$title" removed from wishlist.'),
                //                     backgroundColor: Theme.of(context).colorScheme.tertiary,
                //                   ),
                //                 );
                //                 Navigator.of(dialogContext).pop();
                //               },
                //               child: const Text('Remove'),
                //             ),
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WishlistShimmerLoader extends StatelessWidget {
  const _WishlistShimmerLoader();

  @override
  Widget build(BuildContext context) {
    // HCI: Consistent shimmer effect for all loading states.
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
      highlightColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      period: const Duration(milliseconds: 1500), // Slower shimmer for more natural feel
      child: ListView.builder(
        itemCount: 3, // Show a few shimmer cards
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (_, __) => Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white, // Placeholder color for shimmer effect
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 120, // Shorter width for second line of text
                        height: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// BookCard implementation moved to book_card.dart
}

class AuthorBooksSection extends StatelessWidget {
  final FirestoreService firestoreService;
  final String? userId;

  const AuthorBooksSection({
    super.key,
    required this.firestoreService,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Container(
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
          ),
        ),
        child: Center(
          child: Text(
            "Please log in to view your uploaded books.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return StreamBuilder<List<Book>>(
      stream: firestoreService.getBooksByAuthor(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _WishlistShimmerLoader();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error loading uploaded books.'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text("You haven't uploaded any books yet."),
          ));
        }

        final books = snapshot.data!;
        return ListView.builder(
          itemCount: books.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            final book = books[index];
            return _BookCard(
              key: ValueKey(book.id),
              title: book.title,
              author: book.author,
              description: book.description,
              coverUrl: book.coverUrl,
              bookId: book.id,
              onEdit: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditBookPage(
                    bookId: book.id,
                    currentTitle: book.title,
                    currentAuthor: book.author,
                    currentDescription: book.description,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}


class _EmptyWishlist extends StatelessWidget {
  final VoidCallback onNavigateToExplore; // New field for the callback

  const _EmptyWishlist({
    required this.onNavigateToExplore, // Require the callback
  });

  @override
  Widget build(BuildContext context) {
    // HCI: Friendly and actionable empty state.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant, // Use surfaceVariant for background
        borderRadius: BorderRadius.circular(24), // More rounded
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.5), // Subtle border
          width: 0.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_add_outlined, // A more direct icon for adding to wishlist
            size: 64, // Slightly larger icon
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 20), // Increased spacing
          Text(
            "Your Wishlist is Empty!",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12), // Increased spacing
          Text(
            "Explore our collection and tap the heart icon on any book to add it here and save for later.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon( // HCI: Actionable button to guide user
            onPressed: onNavigateToExplore, // Call the passed callback
            icon: const Icon(Icons.search_rounded),
            label: const Text('Discover Books'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.primary,
              side: BorderSide(color: Theme.of(context).colorScheme.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}