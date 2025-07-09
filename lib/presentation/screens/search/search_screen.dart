import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:groc_shopy/helper/extension/base_extension.dart';

import '../../../core/routes/route_path.dart';
import '../../../global/model/contact.dart';
// Remove this line: import '../../../global/model/api_contact.dart';
import '../../../service/contact_api_service.dart';

import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/static_strings/static_strings.dart';

import '../home/controller/home_controller.dart';
import '../new_contact_screen/controller/contact_controller.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final HomeController homeController = Get.find<HomeController>();
  late final ContactController contactController =
      Get.find<ContactController>();
  final TextEditingController _searchController = TextEditingController();

  // Use RxList for reactive updates and make it removable
  RxList<Map<String, dynamic>> activeDefaultCallers =
      <Map<String, dynamic>>[].obs;

  // Change ApiContact to Contact
  RxList<Contact> apiContacts = <Contact>[].obs;
  var isLoadingApiContacts = false.obs;

  // Use RxList for reactive updates
  RxList<dynamic> filteredCallers = <dynamic>[].obs;

  @override
  void initState() {
    super.initState();
    _loadApiContacts();
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

  Future<void> _loadApiContacts() async {
    if (isLoadingApiContacts.value) return;

    isLoadingApiContacts.value = true;
    try {
      final contacts = await ContactApiService.getContacts(context);
      apiContacts.value = contacts;

      // Convert API contacts to default caller format with proper references
      activeDefaultCallers.value = contacts.map((contact) {
        final callerData = contact.toDefaultCallerFormat();
        callerData['apiContact'] =
            contact; // Store the original contact reference
        return callerData;
      }).toList();

      _initializeCallers();

      if (mounted) {
        _showAwesomeSnackbar(
          title: AppStrings.success.tr,
          message: 'Loaded ${contacts.length} contacts from server',
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      print('Error loading contacts: $e');
      if (mounted) {
        _showAwesomeSnackbar(
          title: AppStrings.error.tr,
          message: 'Failed to load contacts: $e',
          contentType: ContentType.failure,
        );
      }

      // Fallback to empty list
      activeDefaultCallers.value = [];
    } finally {
      isLoadingApiContacts.value = false;
    }
  }

  void _editDefaultCaller(Map<String, dynamic> caller) async {
    try {
      final apiContact = caller['apiContact'] as Contact?;
      if (apiContact != null) {
        final result = await context.push(
          RoutePath.newContactScreen.addBasePath,
          extra: {
            'apiContact': apiContact,
            'isApiContact': true,
          },
        );

        if (result == true) {
          _loadApiContacts();

          // Notify other screens that contacts have changed
          Get.find<ContactController>().notifyContactsChanged();

          _showAwesomeSnackbar(
            title: AppStrings.success.tr,
            message: 'Contact updated successfully',
            contentType: ContentType.success,
          );
        }
      }
    } catch (e) {
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: 'Failed to edit contact: $e',
        contentType: ContentType.failure,
      );
    }
  }

  void _deleteDefaultCaller(Map<String, dynamic> caller) async {
    try {
      // Change ApiContact to Contact
      final apiContact = caller['apiContact'] as Contact?;
      if (apiContact != null) {
        // Show confirmation dialog
        bool? confirmed = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete Contact'),
              content: Text('Are you sure you want to delete this contact?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            );
          },
        );

        if (confirmed == true) {
          // Use apiId instead of id
          final success = await ContactApiService.deleteContact(
              apiContact.apiId ?? 0, context);
          if (success) {
            // Remove from all lists using the correct identifier
            apiContacts.removeWhere((item) => item.apiId == apiContact.apiId);
            activeDefaultCallers.removeWhere((item) =>
                (item['apiContact'] as Contact?)?.apiId == apiContact.apiId);

            // Force refresh the filtered list
            _initializeCallers();

            // Force UI update
            setState(() {});

            _showAwesomeSnackbar(
              title: AppStrings.success.tr,
              message: 'Contact deleted successfully',
              contentType: ContentType.success,
            );
          } else {
            throw Exception('Failed to delete contact from server');
          }
        }
      }
    } catch (e) {
      print('Delete error: $e'); // Add this for debugging
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: 'Failed to delete contact: $e',
        contentType: ContentType.failure,
      );
    }
  }

  void _makeDefaultCall(Map<String, dynamic> caller) {
    try {
      final name = caller['name'] ?? 'Unknown';

      // Navigate to incoming call screen
      context.pushNamed(
        RoutePath.incomingCallScreen,
        extra: {
          'callerName': name,
          'time': 'Now',
          'callDuration': '15 sec',
        },
      );

      // _showAwesomeSnackbar(
      //   title: 'Calling...',
      //   message: 'Calling $name',
      //   contentType: ContentType.success,
      // );
    } catch (e) {
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: 'Failed to make call: $e',
        contentType: ContentType.failure,
      );
    }
  }

  void _makeCall(Contact contact) {
    try {
      final name = contact.fullName;

      // Navigate to incoming call screen
      context.pushNamed(
        RoutePath.incomingCallScreen,
        extra: {
          'callerName': name,
          'time': 'Now',
          'callDuration': '15 sec',
        },
      );

      // _showAwesomeSnackbar(
      //   title: 'Calling...',
      //   message: 'Calling $name',
      //   contentType: ContentType.success,
      // );
    } catch (e) {
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: 'Failed to make call: $e',
        contentType: ContentType.failure,
      );
    }
  }

  void _createContactFromDefault(Map<String, dynamic> caller) async {
    try {
      final result = await context.push(
        RoutePath.newContactScreen.addBasePath,
        extra: {
          'prefill': true,
          'name': caller['name'],
          'message': caller['message'],
        },
      );

      if (result == true) {
        _showAwesomeSnackbar(
          title: AppStrings.success.tr,
          message: 'Contact created successfully',
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: 'Failed to create contact: $e',
        contentType: ContentType.failure,
      );
    }
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
    // Combine active default callers and saved contacts
    filteredCallers.value = [
      ...activeDefaultCallers.value,
      ...contactController.contacts.value,
    ];
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();

    if (query.isEmpty) {
      filteredCallers.value = [
        ...activeDefaultCallers.value,
        ...contactController.contacts.value,
      ];
      return;
    }

    filteredCallers.value = [
      // Search in active default callers
      ...activeDefaultCallers.where((caller) {
        final name = (caller['name'] ?? '').toString().toLowerCase();
        return name.contains(query);
      }),
      // Search in saved contacts
      ...contactController.contacts.where((contact) {
        final name = contact.fullName.toLowerCase();
        final phone = contact.phoneNumber.toLowerCase();
        return name.contains(query) || phone.contains(query);
      }),
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
                caller['initials'] ?? 'C',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
        title: Text(
          caller['name'] ?? 'Unknown',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          caller['message'] ?? 'No message',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.call, color: Colors.green, size: 20.r),
              onPressed: () => _makeDefaultCall(caller),
              tooltip: 'Call',
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, size: 20.r),
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _editDefaultCaller(caller);
                    break;
                  case 'delete':
                    _deleteDefaultCaller(caller);
                    break;
                  case 'create_contact':
                    _createContactFromDefault(caller);
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 16.r),
                      Gap(8.w),
                      Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 16.r, color: Colors.red),
                      Gap(8.w),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
        leading: Obx(() => CircleAvatar(
              radius: 30.r,
              backgroundColor: homeController.selectedIconColor.value,
              backgroundImage:
                  contact.profileImageSource != null && !contact.isApiContact
                      ? FileImage(File(contact.profileImageSource!))
                      : null,
              child: contact.profileImageSource == null
                  ? Text(
                      contact.initials,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            )),
        title: Text(
          contact.fullName,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (contact.phoneNumber.isNotEmpty)
              Text(
                contact.phoneNumber,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            if (contact.message.isNotEmpty)
              Text(
                contact.message,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[500],
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.call, color: Colors.green, size: 20.r),
              onPressed: () => _makeCall(contact),
              tooltip: 'Call',
            ),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, size: 20.r),
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _editSavedContact(contact);
                    break;
                  case 'delete':
                    _deleteSavedContact(contact);
                    break;
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 16.r),
                      Gap(8.w),
                      Text('Edit'),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 16.r, color: Colors.red),
                      Gap(8.w),
                      Text('Delete', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Add these missing methods
  void _editSavedContact(Contact contact) async {
    try {
      final result = await context.push(
        RoutePath.newContactScreen.addBasePath,
        extra: contact,
      );

      if (result == true) {
        if (contact.isApiContact) {
          _loadApiContacts(); // Refresh if it was an API contact

          // Notify other screens that contacts have changed
          Get.find<ContactController>().notifyContactsChanged();
        }

        _showAwesomeSnackbar(
          title: AppStrings.success.tr,
          message: 'Contact updated successfully',
          contentType: ContentType.success,
        );
      }
    } catch (e) {
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: 'Failed to edit contact: $e',
        contentType: ContentType.failure,
      );
    }
  }

  void _deleteSavedContact(Contact contact) async {
    try {
      // Show confirmation dialog
      bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Contact'),
            content:
                Text('Are you sure you want to delete ${contact.fullName}?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      );

      if (confirmed == true) {
        bool success = false;

        if (contact.isApiContact) {
          // Delete API contact
          success = await ContactApiService.deleteContact(
              contact.apiId ?? 0, context);
          if (success) {
            // Remove from API lists
            apiContacts.removeWhere((item) => item.apiId == contact.apiId);
            activeDefaultCallers.removeWhere((item) =>
                (item['apiContact'] as Contact?)?.apiId == contact.apiId);
          }
        } else {
          // Delete local contact
          contactController.contacts
              .removeWhere((item) => item.uniqueId == contact.uniqueId);
          success = true;
        }

        if (success) {
          // Force refresh the filtered list
          _initializeCallers();

          // Force UI update
          setState(() {});

          _showAwesomeSnackbar(
            title: AppStrings.success.tr,
            message: 'Contact deleted successfully',
            contentType: ContentType.success,
          );
        } else {
          throw Exception('Failed to delete contact');
        }
      }
    } catch (e) {
      _showAwesomeSnackbar(
        title: AppStrings.error.tr,
        message: 'Failed to delete contact: $e',
        contentType: ContentType.failure,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // Header with title and actions
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
                  Row(
                    children: [
                      // Add refresh button for API contacts
                      Obx(() => isLoadingApiContacts.value
                          ? SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : IconButton(
                              icon: Icon(Icons.refresh,
                                  color: Colors.blue, size: 24.r),
                              onPressed: _loadApiContacts,
                              tooltip: "Refresh from server",
                            )),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.black, size: 24.r),
                        onPressed: () async {
                          try {
                            final result = await context
                                .push(RoutePath.newContactScreen.addBasePath);
                            if (result == true) {
                              _loadApiContacts(); // Refresh API contacts in search screen

                              // Notify other screens that contacts have changed
                              Get.find<ContactController>()
                                  .notifyContactsChanged();

                              _showAwesomeSnackbar(
                                title: AppStrings.success.tr,
                                message: AppStrings.contactAddedSuccessfully.tr,
                                contentType: ContentType.success,
                              );
                            }
                          } catch (e) {
                            _showAwesomeSnackbar(
                              title: AppStrings.error.tr,
                              message:
                                  AppStrings.failedToOpenNewContactScreen.tr,
                              contentType: ContentType.failure,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Search field
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: AppStrings.search.tr,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),

            // Show contact count and status
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
                      if (apiContacts.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '${apiContacts.length} from server',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      Gap(8.w),
                      if (contactController.contacts.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Colors.teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '${contactController.contacts.length} saved',
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

            // Contact list with loading state
            Expanded(
              child: Obx(() {
                if (isLoadingApiContacts.value && apiContacts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Gap(16.h),
                        Text(
                          'Loading contacts from server...',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

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
                                  ? 'No contacts found'
                                  : 'No results found',
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
                              label: Text('Add Contact'),
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
