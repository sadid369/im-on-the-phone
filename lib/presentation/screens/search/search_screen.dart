import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:groc_shopy/core/routes/route_path.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';
import 'package:groc_shopy/presentation/screens/home/controller/home_controller.dart';
import 'package:groc_shopy/presentation/screens/new_contact_screen/controller/contact_controller.dart';
import 'package:groc_shopy/utils/app_colors/app_colors.dart';
import 'package:groc_shopy/utils/static_strings/static_strings.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import '../../../global/model/contact.dart';
import 'dart:io';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final HomeController homeController = Get.find<HomeController>();
  late final ContactController contactController;
  final TextEditingController _searchController = TextEditingController();

  // Default sample callers (these will be mixed with saved contacts)
  final List<Map<String, dynamic>> defaultCallers = [
    {
      'initials': 'M',
      'name': AppStrings.mom,
      'message': AppStrings.momWorriedMessage,
      'color': Colors.red[200],
      'isDefault': true,
    },
    {
      'initials': 'Bf',
      'name': AppStrings.bestFriend,
      'message': AppStrings.bestFriendMessage,
      'color': Colors.brown[400],
      'isDefault': true,
    },
    {
      'initials': 'D',
      'name': AppStrings.dad,
      'message': AppStrings.dadMessage,
      'color': Colors.orange[200],
      'isDefault': true,
    },
    {
      'initials': 'L',
      'name': AppStrings.love,
      'message': AppStrings.loveMessage,
      'color': Colors.green[200],
      'isDefault': true,
    },
  ];

  // Use RxList for reactive updates
  RxList<dynamic> filteredCallers = <dynamic>[].obs;

  @override
  void initState() {
    super.initState();
    // Get or create the ContactController
    contactController = Get.isRegistered<ContactController>()
        ? Get.find<ContactController>()
        : Get.put(ContactController());

    _initializeCallers();
    _searchController.addListener(_onSearchChanged);

    // Listen to contact changes
    ever(contactController.contacts, (_) {
      _initializeCallers();
      if (contactController.contacts.isNotEmpty) {
        _showAwesomeSnackbar(
          title: AppStrings.success.tr,
          message: AppStrings.contactListUpdated.tr,
          contentType: ContentType.success,
        );
      }
    });
  }

  // Show awesome snackbar
  void _showAwesomeSnackbar({
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void _initializeCallers() {
    // Combine default callers and saved contacts
    filteredCallers.value = [
      ...defaultCallers,
      ...contactController.contacts.value,
    ];
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();

    if (query.isEmpty) {
      filteredCallers.value = [
        ...defaultCallers,
        ...contactController.contacts.value,
      ];
      return;
    }

    filteredCallers.value = [
      // Search in default callers
      ...defaultCallers.where((caller) {
        final name = (caller['name'] ?? '').toString().toLowerCase();
        return name.contains(query);
      }),
      // Search in saved contacts using controller method
      ...contactController.searchContacts(query),
    ];
  }

  Widget _buildContactTile(dynamic item, int index) {
    if (item is Map<String, dynamic>) {
      // Default caller
      return _buildDefaultCallerTile(item, index);
    } else if (item is Contact) {
      // Saved contact
      return _buildSavedContactTile(item, index);
    }
    return SizedBox.shrink();
  }

  Widget _buildDefaultCallerTile(Map<String, dynamic> caller, int index) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        elevation: 0,
        child: ListTile(
          tileColor: AppColors.backgroundColor,
          leading: Obx(() => CircleAvatar(
                radius: 30.r,
                backgroundColor: homeController.selectedIconColor.value,
                child: Text(
                  caller['initials'],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              )),
          title: Text(
            (caller['name'] ?? ''), // ADD .tr here
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          subtitle: Text(
            (caller['message'] ?? ''), // ADD .tr here
            style: TextStyle(fontSize: 13.sp),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(8.w),
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, size: 20.r),
                onSelected: (value) =>
                    _handleUnifiedAction(value, caller: caller),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'call',
                    child: Row(
                      children: [
                        Icon(Icons.phone, size: 16.r, color: Colors.green),
                        Gap(8.w),
                        Text(AppStrings.call.tr),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 16.r, color: Colors.blue),
                        Gap(8.w),
                        Text(AppStrings.edit.tr),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'details',
                    child: Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 16.r, color: Colors.blue),
                        Gap(8.w),
                        Text(AppStrings.details.tr),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 16.r, color: Colors.red),
                        Gap(8.w),
                        Text(AppStrings.delete.tr,
                            style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            // Handle default caller tap - FIXED: Added .tr
            _showCallerDialog(caller['name'], caller['message']);
          },
        ));
  }

  Widget _buildSavedContactTile(Contact contact, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
        ),
      ),
      elevation: 0,
      child: ListTile(
        tileColor: AppColors.backgroundColor,
        leading: GestureDetector(
          onTap: () => _showContactImageDialog(contact),
          child: Hero(
            tag: 'contact_image_${contact.id}',
            child: contact.profileImagePath != null
                ? CircleAvatar(
                    radius: 30.r,
                    backgroundImage: FileImage(File(contact.profileImagePath!)),
                  )
                : CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.teal,
                    child: Text(
                      contact.firstName.isNotEmpty
                          ? contact.firstName[0].toUpperCase()
                          : 'C',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
          ),
        ),
        title: Text(
          contact.fullName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.sp,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.phoneNumber,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
            if (contact.message.isNotEmpty)
              Text(
                contact.message,
                style: TextStyle(fontSize: 13.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, size: 20.r),
          onSelected: (value) => _handleUnifiedAction(value, contact: contact),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'call',
              child: Row(
                children: [
                  Icon(Icons.phone, size: 16.r, color: Colors.green),
                  Gap(8.w),
                  Text(AppStrings.call.tr),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 16.r, color: Colors.blue),
                  Gap(8.w),
                  Text(AppStrings.edit.tr),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'details',
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16.r, color: Colors.blue),
                  Gap(8.w),
                  Text(AppStrings.details.tr),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 16.r, color: Colors.red),
                  Gap(8.w),
                  Text(AppStrings.delete.tr,
                      style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          _showContactDialog(contact);
        },
      ),
    );
  }

  void _showContactImageDialog(Contact contact) {
    if (contact.profileImagePath != null) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              child: Hero(
                tag: 'contact_image_${contact.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.file(
                    File(contact.profileImagePath!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void _handleUnifiedAction(String action,
      {Map<String, dynamic>? caller, Contact? contact}) {
    print('DEBUG: _handleUnifiedAction called with action: $action'); // Debug

    switch (action) {
      case 'call':
        print('DEBUG: Call action selected'); // Debug
        if (caller != null) {
          print('DEBUG: Calling _makeDefaultCall'); // Debug
          _makeDefaultCall(caller);
        } else if (contact != null) {
          print('DEBUG: Calling _makeCall'); // Debug
          _makeCall(contact);
        }
        break;

      case 'edit':
        if (caller != null) {
          _editDefaultCaller(caller);
        } else if (contact != null) {
          _editContact(contact);
        }
        break;

      case 'details':
        if (caller != null) {
          _showCallerDialog(
              caller['name'].toString(), caller['message'].toString());
        } else if (contact != null) {
          _showContactDialog(contact);
        }
        break;

      case 'delete':
        if (caller != null) {
          _deleteDefaultCaller(caller);
        } else if (contact != null) {
          _showDeleteConfirmation(contact);
        }
        break;
    }
  }

  void _makeDefaultCall(Map<String, dynamic> caller) {
    print(
        'DEBUG: _makeDefaultCall called with caller: ${caller['name']}'); // Debug

    // Navigate to incoming call screen
    Future.delayed(Duration(seconds: 1), () {
      print('DEBUG: Attempting to navigate to incoming call screen'); // Debug
      try {
        context.push(
          RoutePath.incomingCallScreen.addBasePath,
          extra: {
            'callerName': caller['name'],
            'time': DateTime.now().toString(),
            'callDuration': '0:00',
          },
        );
        print('DEBUG: Navigation call completed'); // Debug
      } catch (e) {
        print('DEBUG: Navigation error: $e'); // Debug
      }
    });
  }

  void _createContactFromDefault(Map<String, dynamic> caller) async {
    try {
      // Navigate to new contact screen with pre-filled data
      final result = await context.push(
        RoutePath.newContactScreen.addBasePath,
        extra: {
          'prefill': true,
          'name': caller['name'].tr,
          'message': caller['message'].tr,
        },
      );

      if (result == true) {
        _showAwesomeSnackbar(
          title: AppStrings.success.tr,
          message: AppStrings.contactCreatedFromTemplate.tr,
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: AppStrings.failedToCreateContact.tr,
        contentType: ContentType.failure,
      );
    }
  }

  void _makeCall(Contact contact) {
    print('DEBUG: _makeCall called with contact: ${contact.fullName}'); // Debug

    _showAwesomeSnackbar(
      title: AppStrings.calling.tr,
      message: '${AppStrings.calling.tr} ${contact.fullName}...',
      contentType: ContentType.help,
    );

    // Navigate to incoming call screen
    Future.delayed(Duration(seconds: 1), () {
      print(
          'DEBUG: Attempting to navigate to incoming call screen for contact'); // Debug
      try {
        context.push(
          RoutePath.incomingCallScreen.addBasePath,
          extra: {
            'callerName': contact.fullName,
            'time': DateTime.now().toString(),
            'callDuration': '0:00',
          },
        );
        print('DEBUG: Navigation call completed for contact'); // Debug
      } catch (e) {
        print('DEBUG: Navigation error for contact: $e'); // Debug
      }
    });
  }

  void _editContact(Contact contact) async {
    try {
      final result = await context.push(
        RoutePath.newContactScreen.addBasePath,
        extra: contact, // Pass contact for editing
      );

      // Show feedback based on result
      if (result == true) {
        _showAwesomeSnackbar(
          title: AppStrings.success.tr,
          message: AppStrings.contactUpdatedSuccessfully.tr,
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: AppStrings.failedToOpenEditScreen.tr,
        contentType: ContentType.failure,
      );
    }
  }

  void _showDeleteConfirmation(Contact contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange, size: 24.r),
            Gap(8.w),
            Text(
              AppStrings.deleteContact.tr,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          AppStrings.deleteContactConfirmation.tr
              .replaceAll('{name}', contact.fullName),
          style: TextStyle(fontSize: 16.sp, color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[600],
            ),
            child: Text(AppStrings.cancel.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteContact(contact);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(AppStrings.delete.tr),
          ),
        ],
      ),
    );
  }

  void _deleteContact(Contact contact) async {
    try {
      await contactController.deleteContact(context, contact);
      _showAwesomeSnackbar(
        title: AppStrings.success.tr,
        message: AppStrings.contactDeletedSuccessfully.tr,
        contentType: ContentType.success,
      );
    } catch (e) {
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: AppStrings.failedToDeleteContact.tr,
        contentType: ContentType.failure,
      );
    }
  }

  void _showCallerDialog(String name, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            Icon(Icons.person, color: AppColors.primary, size: 24.r),
            Gap(8.w),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black87,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[600],
            ),
            child: Text(AppStrings.close.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _makeDefaultCallFromDialog(name);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(AppStrings.call.tr),
          ),
        ],
      ),
    );
  }

  // Add this new method to handle the call navigation
  void _makeDefaultCallFromDialog(String callerName) {
    _showAwesomeSnackbar(
      title: AppStrings.calling.tr,
      message: '${AppStrings.calling.tr} $callerName...',
      contentType: ContentType.help,
    );

    // Navigate to incoming call screen with a slight delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        try {
          context.push(
            RoutePath.incomingCallScreen.addBasePath,
            extra: {
              'callerName': callerName,
              'time': DateTime.now().toString(),
              'callDuration': '0:00',
            },
          );
        } catch (e) {
          print('Navigation error: $e');
          _showAwesomeSnackbar(
            title: AppStrings.error.tr,
            message: 'Failed to start call',
            contentType: ContentType.failure,
          );
        }
      }
    });
  }

  void _showContactDialog(Contact contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            contact.profileImagePath != null
                ? CircleAvatar(
                    radius: 16.r,
                    backgroundImage: FileImage(File(contact.profileImagePath!)),
                  )
                : CircleAvatar(
                    radius: 16.r,
                    backgroundColor: AppColors.primary,
                    child: Text(
                      contact.firstName.isNotEmpty
                          ? contact.firstName[0].toUpperCase()
                          : 'C',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            Gap(8.w),
            Expanded(
              child: Text(
                contact.fullName,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.phone, size: 16.r, color: AppColors.primary),
                Gap(8.w),
                Text(
                  contact.phoneNumber,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                ),
              ],
            ),
            if (contact.message.isNotEmpty) ...[
              Gap(8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.message, size: 16.r, color: AppColors.primary),
                  Gap(8.w),
                  Expanded(
                    child: Text(
                      contact.message,
                      style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[600],
            ),
            child: Text(AppStrings.close.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _makeCall(contact);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(AppStrings.call.tr),
          ),
        ],
      ),
    );
  }

  void _editDefaultCaller(Map<String, dynamic> caller) async {
    try {
      // Convert default caller to contact for editing
      final result = await context.push(
        RoutePath.newContactScreen.addBasePath,
        extra: {
          'prefill': true,
          'name': caller['name'].tr,
          'message': caller['message'].tr,
          'isEdit': true,
        },
      );

      if (result == true) {
        _showAwesomeSnackbar(
          title: AppStrings.success.tr,
          message: AppStrings.templateEditedAndSaved.tr,
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: AppStrings.failedToEditTemplate.tr,
        contentType: ContentType.failure,
      );
    }
  }

  void _deleteDefaultCaller(Map<String, dynamic> caller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: AppColors.backgroundColor,
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.orange, size: 24.r),
            Gap(8.w),
            Text(
              AppStrings.deleteTemplate.tr,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          AppStrings.deleteTemplateConfirmation.tr
              .replaceAll('{name}', caller['name'].toString()),
          style: TextStyle(fontSize: 16.sp, color: Colors.black87),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[600],
            ),
            child: Text(AppStrings.cancel.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _performDeleteDefaultCaller(caller);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(AppStrings.delete.tr),
          ),
        ],
      ),
    );
  }

  void _performDeleteDefaultCaller(Map<String, dynamic> caller) {
    // Since default callers are hardcoded, we'll just show a message
    _showAwesomeSnackbar(
      title: AppStrings.info.tr,
      message: AppStrings.cannotDeleteDefaultTemplate.tr,
      contentType: ContentType.warning,
    );
  }

  void _duplicateContact(Contact contact) async {
    try {
      // Navigate to new contact screen with pre-filled data from existing contact
      final result = await context.push(
        RoutePath.newContactScreen.addBasePath,
        extra: {
          'prefill': true,
          'firstName': contact.firstName,
          'lastName': contact.lastName,
          'phone': contact.phoneNumber,
          'message': contact.message,
          'isDuplicate': true,
        },
      );

      if (result == true) {
        _showAwesomeSnackbar(
          title: AppStrings.success.tr,
          message: AppStrings.contactDuplicated.tr,
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: AppStrings.failedToDuplicateContact.tr,
        contentType: ContentType.failure,
      );
    }
  }

  void _shareContact(Contact contact) {
    final contactInfo = '''
Contact: ${contact.fullName}
Phone: ${contact.phoneNumber}
${contact.message.isNotEmpty ? 'Message: ${contact.message}' : ''}
''';

    _showAwesomeSnackbar(
      title: AppStrings.sharing.tr,
      message: '${AppStrings.sharing.tr} ${contact.fullName}',
      contentType: ContentType.help,
    );

    // Here you would implement actual sharing functionality
    // For example: Share.share(contactInfo);
    print('Sharing contact: $contactInfo');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.caller.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.black, size: 24.r),
                    onPressed: () async {
                      try {
                        final result = await context
                            .push(RoutePath.newContactScreen.addBasePath);
                        if (result == true) {
                          _showAwesomeSnackbar(
                            title: AppStrings.success.tr,
                            message: AppStrings.contactAddedSuccessfully.tr,
                            contentType: ContentType.success,
                          );
                        }
                      } catch (e) {
                        _showAwesomeSnackbar(
                          title: AppStrings.error.tr,
                          message: AppStrings.failedToOpenNewContactScreen.tr,
                          contentType: ContentType.failure,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  prefixIcon: Icon(Icons.search, size: 22.r),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, size: 20.r),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged();
                            _showAwesomeSnackbar(
                              title: AppStrings.searchCleared.tr,
                              message: AppStrings.showingAllContacts.tr,
                              contentType: ContentType.help,
                            );
                          },
                        )
                      : null,
                  hintText: AppStrings.search.tr,
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(fontSize: 16.sp),
                onChanged: (value) {
                  if (value.isNotEmpty && filteredCallers.isEmpty) {
                    Future.delayed(Duration(milliseconds: 500), () {
                      if (_searchController.text.isNotEmpty &&
                          filteredCallers.isEmpty) {
                        _showAwesomeSnackbar(
                          title: AppStrings.noResults.tr,
                          message: AppStrings.tryDifferentSearchTerm.tr,
                          contentType: ContentType.warning,
                        );
                      }
                    });
                  }
                },
              ),
            ),

            // Show contact count
            Obx(() => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Text(
                        '${filteredCallers.length} ${AppStrings.contacts.tr}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      Spacer(),
                      if (contactController.contacts.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '${contactController.contacts.length} ${AppStrings.saved.tr}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.teal,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                )),

            Gap(8.h),

            // Contact list
            Expanded(
              child: Obx(() {
                print(
                    'Contacts count: ${contactController.contacts.length}'); // Debug print
                print(
                    'Filtered callers count: ${filteredCallers.length}'); // Debug print

                return filteredCallers.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64.r,
                              color: Colors.grey[400],
                            ),
                            Gap(16.h),
                            Text(
                              _searchController.text.isEmpty
                                  ? AppStrings.noContactsYet.tr
                                  : AppStrings.noResultsFound.tr,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            Gap(8.h),
                            ElevatedButton.icon(
                              onPressed: () {
                                context.push(
                                    RoutePath.newContactScreen.addBasePath);
                              },
                              icon: Icon(Icons.add),
                              label: Text(AppStrings.addFirstContact.tr),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredCallers.length,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemBuilder: (context, index) {
                          return _buildContactTile(
                              filteredCallers[index], index);
                        },
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
