// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import '/config/_config.dart'
//     show CustomButton, TPadding, TSize, TextFormFieldComponent;
// import '/core/_core.dart'
//     show
//         BuildContextExtensions,
//         errorDialog,
//         showLoadingDialog,
//         sl,
//         successDialog;
// import '/features/_features.dart'
//     show
//         SplashScreen,
//         UserSessionCubit,
//         CategoryBloc,
//         CategoryState,
//         CreateCategoryEvent,
//         CreateCategoryParams;

// class AdminDashboardScreen extends StatefulWidget {
//   static const String routeName = '/admin/dashboard';
//   static const String name = 'AdminDashboard';
//   const AdminDashboardScreen({super.key});

//   @override
//   State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
// }

// class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _categoryName = TextEditingController();
//   final TextEditingController _categoryDescription = TextEditingController();
//   final TextEditingController _categoryImageUrl = TextEditingController();

//   @override
//   void dispose() {
//     _categoryName.dispose();
//     _categoryDescription.dispose();
//     _categoryImageUrl.dispose();
//     super.dispose();
//   }

//   Future<void> _createCategory() async {
//     if (_formKey.currentState!.validate()) {
//       final params = CreateCategoryParams(
//         name: _categoryName.text,
//         description: _categoryDescription.text,
//         imageUrl: _categoryImageUrl.text,
//       );

//       context.read<CategoryBloc>().add(CreateCategoryEvent(params: params));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Dashboard'),
//         actions: [
//           IconButton(
//             onPressed: () {
//               sl<UserSessionCubit>().logout();
//               context.go(SplashScreen.routeName);
//             },
//             icon: const Icon(Icons.logout),
//           ),
//         ],
//       ),
//       body: BlocListener<CategoryBloc, CategoryState>(
//         listener: (context, state) {
//           if (state.isLoading) {
//             showLoadingDialog(context);
//             context.pop();
//           }
//           if (state.isError) {
//             errorDialog(context, message: 'Failed to create category');
//             return;
//           } else {
//             successDialog(
//               context,
//               message: 'Category created successfully',
//               onPressed: () {
//                 _categoryName.clear();
//                 _categoryDescription.clear();
//                 _categoryImageUrl.clear();
//                 context.pop();
//               },
//             );
//           }
//         },
//         child: SafeArea(
//           child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(TPadding.p28),
//               child: Column(
//                 children: [
//                   TextFormFieldComponent(
//                     hintText: 'Category Name',
//                     labelText: 'Category Name',
//                     controller: _categoryName,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a category name';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: TSize.s16),
//                   TextFormFieldComponent(
//                     hintText: 'Category Description',
//                     labelText: 'Category Description',
//                     controller: _categoryDescription,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a category description';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: TSize.s16),
//                   TextFormFieldComponent(
//                     hintText: 'Category Image URL',
//                     labelText: 'Category Image URL',
//                     controller: _categoryImageUrl,
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter a category image url';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: TSize.s24),
//                   CustomButton(
//                     backgroundColor: context.theme.colorScheme.primary,
//                     onTap: _createCategory,
//                     text: 'Create Category',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
