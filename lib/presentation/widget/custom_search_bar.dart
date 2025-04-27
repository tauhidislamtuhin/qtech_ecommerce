import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product/product_bloc.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: state.showCount
                        ? MediaQuery.sizeOf(context).width * 0.80
                        : MediaQuery.sizeOf(context).width - 20,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextFormField(
                      controller: _controller,
                      textAlign: TextAlign.left,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: "Search Anything",
                        hintStyle:
                            TextStyle(color: Colors.black.withOpacity(0.5)),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 35,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      style: TextStyle(color: Colors.black),
                      /*onChanged: (value) {
                  context.read<ProductBloc>().add(SearchProducts(value));
                },*/
                      onFieldSubmitted: (value) {
                        context.read<ProductBloc>().add(SearchProducts(value));
                        if (value.isEmpty) {
                          context.read<ProductBloc>().add(LoadProducts());
                        } else {
                          context.read<ProductBloc>().add(ShowCount());
                        }
                      },
                    ),
                  ),
                  state.showCount
                      ? IconButton(
                          icon: const Icon(
                            Icons.filter_list,
                            size: 35,
                          ),
                          onPressed: () {
                            showSortBottomSheet(context);
                          },
                        )
                      : const SizedBox()
                ],
              ),
              state.showCount
                  ? Container(
                      margin: EdgeInsets.all(10),
                      color: Color(0XFFF9FAFB),
                      width: double.infinity,
                      child: Text("${state.products.length} Items",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                    )
                  : const SizedBox()
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

void showSortBottomSheet(BuildContext context) {
  final blocContext = context;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bottomSheetContext) {
      return Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(right: 0, left: 15),
              title: const Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                  fontFamily: 'Roboto',
                ),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.pop(bottomSheetContext);
                  },
                  icon: Icon(Icons.close_rounded)),
            ),
            ListTile(
              title: const Text('Price - High to Low'),
              onTap: () {
                blocContext
                    .read<ProductBloc>()
                    .add(SortProducts(SortOption.highToLow));
                Navigator.pop(bottomSheetContext);
              },
            ),
            ListTile(
              title: const Text('Price - Low to High'),
              onTap: () {
                blocContext
                    .read<ProductBloc>()
                    .add(SortProducts(SortOption.lowToHigh));
                Navigator.pop(bottomSheetContext);
              },
            ),
            ListTile(
              title: const Text('Rating'),
              onTap: () {
                blocContext
                    .read<ProductBloc>()
                    .add(SortProducts(SortOption.rating));
                Navigator.pop(bottomSheetContext);
              },
            ),
          ],
        ),
      );
    },
  );
}
