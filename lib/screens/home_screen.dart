import 'package:backgroung_remover_app/screens/view_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/cubit.dart';
import '../controller/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Home Screen'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (cubit.pickedImage == null)
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Center(
                        child: Text('No Image Selected'),
                      ),
                    ),
                  if (cubit.pickedImage != null) Image.file(cubit.pickedImage!),
                  const SizedBox(
                    height: 10,
                  ),
                  if (cubit.pickedImage == null)
                    Center(
                      child: MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          cubit.dialogBuilder(context);
                        },
                        child: const Text('Pick image'),
                      ),
                    ),
                  if (cubit.pickedImage != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            cubit.dialogBuilder(context);
                          },
                          child: const Text('Pick image'),
                        ),
                        state is NewImageLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : MaterialButton(
                                color: Colors.blue,
                                onPressed: () {
                                  cubit.uploadImage().then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ImageViewScreen(
                                                    cubit.newImage!)));
                                  });
                                },
                                child: const Text('Get new image'),
                              ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
