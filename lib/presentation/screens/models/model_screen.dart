import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/api/constants.dart';
import '../../../domain/model/profile/profile_entity.dart';
import '../../bloc/models/list_models_bloc.dart';
import '../../bloc/models/list_models_screen_state.dart';
import '../profile/show_profile_model_screen.dart';

class ModelsScreen extends StatefulWidget {
  // final int albumId;
  const ModelsScreen({Key? key}) : super(key: key);

  @override
  State<ModelsScreen> createState() => ModelsScreenState();
}

class ModelsScreenState extends State<ModelsScreen> {
  late ListModelsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ListModelsBloc()..add(const ListModelsFetched());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // bloc.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  final _scrollController = ScrollController();
  late final double _screenHeight;
  // final _expandedIndices = <int>{};

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<ListModelsBloc, ListModelsScreenState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.status == ListModelScreenStatus.errorState ||
            state.status == ListModelScreenStatus.errorLocal) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Ошибка")));
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case ListModelScreenStatus.loading:
            // case ListModelScreenStatus.initial:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ListModelScreenStatus.success:
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GridView.custom(
                controller: _scrollController,
                shrinkWrap: true,
                gridDelegate: SliverWovenGridDelegate.count(
                  crossAxisCount: 2,
                  pattern: [
                    const WovenGridTile(1),
                    const WovenGridTile(
                      6 / 7,
                      crossAxisRatio: 0.95,
                      alignment: AlignmentDirectional.centerEnd,
                    ),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                    (context, index) => index >= state.data.length
                        ? const Center(child: CircularProgressIndicator())
                        : ItemModel(model: state.data[index]),
                    childCount: state.hasReachedMax
                        ? state.data.length
                        : state.data.length + 2),
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }

  void _onScroll() {
    // if (_isBottom) context.read<PhotosBloc>().add(PhotosFetched());
  }

// при таком порядке загрузит только доплнительный экран про запас
  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return (maxScroll - currentScroll) < (_screenHeight);
  }
}

class ItemModel extends StatelessWidget {
  ProfileEntity model;

  ItemModel({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowProfileModelScreen(
                    profileId: model.id ?? 0, isEdit: false)),
          ),
          child: Stack(
            children: <Widget>[
              SizedBox.expand(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // Image border

                  child: Image.network(
                    model.photo ??
                        (ApiConstants.BASE_URL_IMAGE +
                            "/media/" +
                            model.profilePhotos![0]) ??
                        "https://i.pinimg.com/736x/fe/2c/ae/fe2cae92572f1ef7d734f61aba9c6336.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      // color: Colors.black.withOpacity(.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.name ?? '',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/ic_location.svg",
                                width: 12,
                                height: 13,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  model.city ?? "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: "GloryRegular",
                                      fontSize: 13),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
