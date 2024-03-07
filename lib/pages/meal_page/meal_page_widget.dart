import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'meal_page_model.dart';
export 'meal_page_model.dart';

class MealPageWidget extends StatefulWidget {
  const MealPageWidget({super.key});

  @override
  State<MealPageWidget> createState() => _MealPageWidgetState();
}

class _MealPageWidgetState extends State<MealPageWidget> {
  late MealPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MealPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, 0.0),
            child: FutureBuilder<List<ListOfMealsRow>>(
              future: SQLiteManager.instance.listOfMeals(),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                final columnListOfMealsRowList = snapshot.data!;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: List.generate(columnListOfMealsRowList.length,
                      (columnIndex) {
                    final columnListOfMealsRow =
                        columnListOfMealsRowList[columnIndex];
                    return Text(
                      valueOrDefault<String>(
                        columnListOfMealsRow.mealName,
                        'Tajine',
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium,
                    );
                  }),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
