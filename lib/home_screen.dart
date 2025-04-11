import 'package:arapp/arview_for_3d_objects.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> model3dList = [
    {
      "model3dUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/models3d//arm_chair__furniture.glb",
      "photoUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/images//Arm%20chair.png",
      "name": "Arm Chair",
      "price": "\$129.99",
    },
    {
      "model3dUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/models3d//model_66a_-_atlantic_sturgeon.glb",
      "photoUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/images//sturgeon.png",
      "name": "Fish",
      "price": "\$59.99",
    },
    {
      "model3dUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/models3d//modern_wooden_wardrobe.glb",
      "photoUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/images//Modern%20Wooden%20Wardrobe.png",
      "name": "Modern Wooden Wardrobe",
      "price": "\$399.99",
    },
    {
      "model3dUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/models3d//bookcase.glb",
      "photoUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/images//Bookcase.png",
      "name": "Bookcase",
      "price": "\$249.99",
    },
    {
      "model3dUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/models3d//blossom_sofa_by_modenese.glb",
      "photoUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/images//Blossom%20sofa.png",
      "name": "Blossom Sofa",
      "price": "\$499.99",
    },
    {
      "model3dUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/models3d//flying_hornet.glb",
      "photoUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/images//honeybee.png",
      "name": "Flying Hornet",
      "price": "\$29.99",
    },
    {
      "model3dUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/models3d//modern_wooden_wardrobe.glb",
      "photoUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/images//Living%20room%20sofa.png",
      "name": "Living Room Sofa",
      "price": "\$349.99",
    },
    {
      "model3dUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/models3d//round_table_furniture_model.glb",
      "photoUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/images//Round%20Table%20Furniture%20Model.png",
      "name": "Round Table",
      "price": "\$199.99",
    },
    {
      "model3dUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/models3d//table___school_office_-_7_mb.glb",
      "photoUrl": "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/images//Table%20School%20office%20.png",
      "name": "School Office Table",
      "price": "\$149.99",
    },
  ];

  int _selectedIndex = 0;

  final List<String> _categories = [
    "All",
    "Furniture",
    "Decor",
    "Kitchen",
    "Bedroom",
    "Office"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "E-Sparks",
          style: TextStyle(
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 35, color: Colors.teal),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Wishlist'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner with gradient overlay
            Container(
              width: double.infinity,
              height: 180,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://glamorous-design.org/wp-content/uploads/2023/10/image-124.png",
                  ),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16, bottom: 8),
                      child: Text(
                        "NEW YEAR SALE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: Text(
                        "Up to 50% off on selected items",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Shop Now"),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Category tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: _selectedIndex == index ? Colors.teal : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          _categories[index],
                          style: TextStyle(
                            color: _selectedIndex == index ? Colors.white : Colors.grey[800],
                            fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Product grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured Products",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey[800],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "See All",
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: model3dList.length,
                itemBuilder: (context, index) {
                  final item = model3dList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => ArViewFor3dObjects(
                            name: item["name"],
                            model3dUrl: item["model3dUrl"],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(item["photoUrl"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.favorite_border,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item["name"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    item["price"],
                                    style: const TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (c) => ArViewFor3dObjects(
                                                  name: item["name"],
                                                  model3dUrl: item["model3dUrl"],
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.view_in_ar, size: 16),
                                          label: const Text("AR View"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(vertical: 12),
                                            minimumSize: const Size(0, 0),
                                            textStyle: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.add_shopping_cart, size: 16),
                                          color: Colors.black87,
                                          padding: const EdgeInsets.all(8),
                                          constraints: const BoxConstraints(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.view_in_ar), label: 'AR View'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}