import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ixtask/ui/Bloc_News/news_bloc.dart';
import 'package:ixtask/ui/responsive-ui/ui_components/InfoWidget.dart';
import 'package:ixtask/api/ApiManager.dart';
import 'package:ixtask/ui/widget/NewsListViewBuilder.dart';

import '../../../generated/l10n.dart';
import '../../widget/Custom_Button.dart';
import '../../widget/Custom_textfield.dart';
import '../../widget/News_List_view.dart';
import '../../../data/news/models/ActicleModel.dart';
import '../Setting/Setting.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<NewsBloc>(context).add(NewsListStarted("general"));
  }
  void _search(String query){
      BlocProvider.of<NewsBloc>(context).add(NewsListSearch(query.trim()));
  }
  TextEditingController inputController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(buildWhen: (previousState, state) {
      return true;
    }, builder: (context, state) {
      if (state is LoadingNewsState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is NewsErrorState) {
        return Text(state.error);
      }
      return InfoWidget(builder: (context, deviceInfo) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Custom_TextFormField(
                    hinitText: S.of(context).Search,
                    prefixIcon: Icon(Icons.search),
                    controller: inputController,
                    onchanged: _search,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: NewsListView(
                    articles: (state as LoadedState).articleModel,
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: S.of(context).titlelanguage,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChangeLanguage()));
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
