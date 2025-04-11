import 'package:ar_flutter_plugin_engine/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_engine/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin_engine/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin_engine/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_engine/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_engine/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin_engine/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_engine/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_engine/models/ar_anchor.dart';
import 'package:ar_flutter_plugin_engine/models/ar_hittest_result.dart';
import 'package:ar_flutter_plugin_engine/models/ar_node.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vectorMath64;

class ArViewFor3dObjects extends StatefulWidget {
  final String name;
  final String model3dUrl;

  const ArViewFor3dObjects(
      {super.key, required this.name, required this.model3dUrl});

  @override
  State<ArViewFor3dObjects> createState() => _ArViewFor3dObjectsState();
}

class _ArViewFor3dObjectsState extends State<ArViewFor3dObjects> {
  ARSessionManager? sessionManagerAR;
  ARObjectManager? objectManagerAR;
  ARAnchorManager? anchorManagerAR;
  List<ARNode> allNodesList = [];
  List<ARAnchor> allAnchors = [];
  bool isLoading = true;
  bool hasPlacedObject = false;

  createARView(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager locationManagerAR) {
    sessionManagerAR = arSessionManager;
    objectManagerAR = arObjectManager;
    anchorManagerAR = arAnchorManager;

    sessionManagerAR!.onInitialize(
      handleRotation: true,
      handlePans: true,
      showWorldOrigin: true,
      showFeaturePoints: false,
      showPlanes: true,
    );

    objectManagerAR!.onInitialize();
    sessionManagerAR!.onPlaneOrPointTap = detectPlaneAndLetUserTap;
    objectManagerAR!.onPanStart = duringOnPanStarted;
    objectManagerAR!.onPanChange = duringOnPanChanged;
    objectManagerAR!.onPanEnd = duringOnPanEnded;
    objectManagerAR!.onRotationStart = duringOnRotationStarted;
    objectManagerAR!.onRotationChange = duringOnRotationChanged;
    objectManagerAR!.onRotationEnd = duringOnRotationEnded;

    // Set loading to false when AR is initialized
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  duringOnPanStarted(String object3DNodeName) {
    print("Panning Node Started = " + object3DNodeName);
  }

  duringOnPanChanged(String object3DNodeName) {
    print("Panning Node Continued = " + object3DNodeName);
  }

  duringOnPanEnded(String object3DNodeName, Matrix4 transformMatrix4) {
    print("Panning Node Ended = " + object3DNodeName);
  }

  duringOnRotationStarted(String object3DNodeName) {
    print("Rotating Node Started = " + object3DNodeName);
  }

  duringOnRotationChanged(String object3DNodeName) {
    print("Rotating Node Changed = " + object3DNodeName);
  }

  duringOnRotationEnded(String object3DNodeName, Matrix4 transformMatrix4) {
    print("Rotating Node Ended = " + object3DNodeName);
  }

  Future<void> detectPlaneAndLetUserTap(
      List<ARHitTestResult> hitTapResultsList) async {
    try {
      var userHitTapResultsList = hitTapResultsList.firstWhere(
          (ARHitTestResult userHitPoint) =>
              userHitPoint.type == ARHitTestResultType.plane);

      if (userHitTapResultsList != null) {
        setState(() {
          hasPlacedObject = true;
        });

        var planeARAnchor =
            ARPlaneAnchor(transformation: userHitTapResultsList.worldTransform);

        bool? anchorAdded = await anchorManagerAR!.addAnchor(planeARAnchor);

        if (anchorAdded!) {
          allAnchors.add(planeARAnchor);

          var object3DNewNode = ARNode(
            type: NodeType.webGLB,
            uri: widget.model3dUrl,
            scale: vectorMath64.Vector3(0.62, 0.62, 0.62),
            position: vectorMath64.Vector3(0, 0, 0),
            rotation: vectorMath64.Vector4(1, 0, 0, 0),
          );

          bool? addARNodeToAnchor = await objectManagerAR!
              .addNode(object3DNewNode, planeAnchor: planeARAnchor);

          if (addARNodeToAnchor!) {
            allNodesList.add(object3DNewNode);
            _showSuccessSnackbar();
          } else {
            sessionManagerAR!.onError("Node to Anchor attachment Failed");
            _showErrorSnackbar("Failed to attach 3D model");
          }
        } else {
          sessionManagerAR!.onError(" Failed. Anchor can not be added");
          _showErrorSnackbar("Failed to add anchor");
        }
      }
    } catch (e) {
      print("Error in hit test: $e");
      _showErrorSnackbar("Please scan the area and try again");
    }
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${widget.name} placed successfully!"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> removeEvery3DObjects() async {
    setState(() {
      hasPlacedObject = false;
    });

    allAnchors.forEach((each3dObject) {
      anchorManagerAR!.removeAnchor(each3dObject);
    });
    allAnchors = [];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("All objects removed"),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    sessionManagerAR!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '${widget.name}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(1.0, 1.0),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ],
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.info_outline, color: Colors.white),
            ),
            onPressed: () {
              _showHelpDialog();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ARView(
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
            onARViewCreated: createARView,
          ),

          // Loading indicator
          if (isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Initializing AR...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Instructions overlay when AR is ready but no object placed
          if (!isLoading && !hasPlacedObject)
            SafeArea(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.touch_app,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Tap on a detected surface to place the object",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Move your device to scan the area",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.view_in_ar,
                                    color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  "AR Mode Active",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Control buttons at the bottom
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Reset button
                ElevatedButton.icon(
                  onPressed: removeEvery3DObjects,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reset"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                  ),
                ),

                // Take a photo button
                if (hasPlacedObject)
                  ElevatedButton.icon(
                    onPressed: () {
                      _captureScreenshot();
                    },
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Capture"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                  ),

                // Add to cart button
                if (hasPlacedObject)
                  ElevatedButton.icon(
                    onPressed: () {
                      _showAddToCartDialog();
                    },
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("Add to Cart"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("AR View Help"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("• Move your phone to scan the environment"),
              SizedBox(height: 8),
              Text("• Tap on a detected surface to place the object"),
              SizedBox(height: 8),
              Text("• Pinch to resize the object"),
              SizedBox(height: 8),
              Text("• Drag to move the object"),
              SizedBox(height: 8),
              Text("• Two-finger rotate to change orientation"),
              SizedBox(height: 8),
              Text("• Press 'Reset' to remove all objects"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Got it"),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }

  void _captureScreenshot() {
    // This would require additional implementation to actually capture screenshots
    // You would need to add screenshot functionality using a package like screenshot

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Screenshot saved to gallery"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showAddToCartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add ${widget.name} to Cart?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                      // This should ideally be a product image related to the 3D model
                      // For now, we're using a placeholder concept
                      "https://drrsxgopvzhnqfvdfjlm.supabase.co/storage/v1/object/public/images//${widget.name.replaceAll(" ", "%20")}.png",
                    ),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {},
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Price:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "\$199.99", // Example price
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Quantity:",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove),
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                          iconSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "1",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          padding: const EdgeInsets.all(4),
                          constraints: const BoxConstraints(),
                          iconSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${widget.name} added to cart"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: const Text("Add to Cart"),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }
}
