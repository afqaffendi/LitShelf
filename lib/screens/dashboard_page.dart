import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litshelf2/screens/view_users_page.dart';
import 'package:shimmer/shimmer.dart';
import 'manage_account_page.dart';

import 'ebook_list_page.dart';
import 'firestore_service.dart';
import 'profile_page.dart';
import 'add_book_page.dart';

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
        _userRole = 'user';
        _isLoadingRole = false;
      });
    }
  }

  void _onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  static const List<String> _pageTitles = ['Home', 'Discover', 'Profile'];
  static const List<String> _librarianTitles = ['Home', 'Discover', 'Accounts', 'Profile'];
  
  @override
  Widget build(BuildContext context) {
    if (_isLoadingRole) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
  (_userRole == 'librarian' ? _librarianTitles : _pageTitles)[_selectedIndex],
),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        actions: [

          if (_userRole == 'librarian')
  IconButton(
    icon: const Icon(Icons.supervisor_account),
    tooltip: 'View All Users',
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ViewUsersPage()),
      );
    },
  ),

          IconButton(
            icon: Icon(
              widget.isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
            onPressed: () => widget.onToggleDarkMode(!widget.isDarkMode),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _selectedIndex = index);
        },
children: _userRole == 'librarian'
    ? [
        _DashboardHomeView(
          firestoreService: _firestoreService,
          currentUser: _currentUser,
        ),
        const EbookListPage(),
        const ManageAccountPage(), // add this line
        ProfilePage(
          isDarkMode: widget.isDarkMode,
          onToggleDarkMode: widget.onToggleDarkMode,
        ),
      ]
    : [
        _DashboardHomeView(
          firestoreService: _firestoreService,
          currentUser: _currentUser,
        ),
        const EbookListPage(),
        ProfilePage(
          isDarkMode: widget.isDarkMode,
          onToggleDarkMode: widget.onToggleDarkMode,
        ),
      ],

      ),
      bottomNavigationBar: _buildFloatingNavBar(context),
      floatingActionButton: (!_isLoadingRole && (_userRole == 'author' || _userRole == 'librarian'))

    ? FloatingActionButton.extended(
        onPressed: () {
          // Ensure AddBookPage is imported if it's not already
          // import 'package:litshelf2/screens/add_book_page.dart'; // Example path
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddBookPage()),
          );
        },
        // Enhanced Design Properties
        backgroundColor: Theme.of(context).colorScheme.secondary, // Or primary, depending on desired accent
        foregroundColor: Theme.of(context).colorScheme.onSecondary, // Text/icon color for contrast
        elevation: 8.0, // A bit more elevation for a pronounced floating effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0), // Slightly more rounded corners
        ),
        icon: const Icon(Icons.add_rounded), // Using a filled/rounded icon for modern look
        label: Text(
          'Add Book',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold, // Make text bolder
                color: Theme.of(context).colorScheme.onSecondary, // Ensure text color is consistent
              ),
        ),
      )
    : null,
    );
  }

  Widget _buildFloatingNavBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          type: BottomNavigationBarType.fixed,
          items: const [
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
          ],
        ),
      ),
    );
  }
}

class _DashboardHomeView extends StatelessWidget {
  final FirestoreService firestoreService;
  final User? currentUser;

  const _DashboardHomeView({
    required this.firestoreService,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _WelcomeHeader(userName: currentUser?.displayName),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              "Your Wishlist ⭐️",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          _WishlistSection(
            firestoreService: firestoreService,
            userId: currentUser?.uid,
          ),
        ],
      ),
    );
  }
}

class _WelcomeHeader extends StatelessWidget {
  final String? userName;

  const _WelcomeHeader({this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, ${userName ?? 'Reader'} 👋',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            "What do you want to read today?",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
          ),
        ],
      ),
    );
  }
}

class _WishlistSection extends StatelessWidget {
  final FirestoreService firestoreService;
  final String? userId;

  const _WishlistSection({
    required this.firestoreService,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Center(child: Text("Please log in to see your wishlist."));
    }

    return StreamBuilder<List<String>>(
      stream: firestoreService.getUserWishlist(userId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _WishlistShimmerLoader();
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final wishlistIds = snapshot.data;
        if (wishlistIds == null || wishlistIds.isEmpty) {
          return const _EmptyWishlist();
        }

        return StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getEbooksByIds(wishlistIds),
          builder: (context, bookSnapshot) {
            if (bookSnapshot.connectionState == ConnectionState.waiting) {
              return const _WishlistShimmerLoader();
            }
            if (bookSnapshot.hasError) {
              return Center(child: Text('Error loading books: ${bookSnapshot.error}'));
            }
            if (!bookSnapshot.hasData || bookSnapshot.data!.docs.isEmpty) {
              return const _EmptyWishlist();
            }

            final ebooks = bookSnapshot.data!.docs;
            return ListView.builder(
              itemCount: ebooks.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final ebook = ebooks[index];
                return _WishlistCard(ebook: ebook, userId: userId!);
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

  const _WishlistCard({
    required this.ebook,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final data = ebook.data() as Map<String, dynamic>;
    final title = data['title'] ?? 'No Title';
    final author = data['author'] ?? 'Unknown Author';
    final coverUrl = data['coverUrl'];

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Tapped on $title')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: coverUrl != null && coverUrl.isNotEmpty
                    ? Image.network(
                        coverUrl,
                        width: 70,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 70,
                        height: 100,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        child: Icon(
                          Icons.book_rounded,
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                          size: 30,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      author,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.redAccent),
                onPressed: () {
                  FirestoreService().toggleWishlist(userId, ebook.id, false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('"$title" removed from wishlist.')),
                  );
                },
              ),
            ],
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
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (_, __) => Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 16),
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
                        width: 100,
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

class _EmptyWishlist extends StatelessWidget {
  const _EmptyWishlist();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border_rounded,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          const Text(
            "Your Wishlist is Empty",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "Tap the heart on any book to add it here for later.",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}