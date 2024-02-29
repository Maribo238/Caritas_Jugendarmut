import 'package:caritas_jugendarmut/FinanceplannerWidget/model.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class FinanzplanerWidget extends StatefulWidget {
  const FinanzplanerWidget({super.key});

  @override
  State<FinanzplanerWidget> createState() => _FinanzplanerWidgetState();
}

class _FinanzplanerWidgetState extends State<FinanzplanerWidget>
    with TickerProviderStateMixin {
  late FinanzplanerModel _model;
double selectedValue = 50;
double einnahmen = 0;
double ausgaben = 0;
void verrechnen() {
    setState(() {
      selectedValue= selectedValue + einnahmen - ausgaben;
      einnahmen=0;
      ausgaben=0;
      selectedValue =  double.parse(selectedValue.toStringAsFixed(2));
    });
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        //FadeEffect(
        //curve: Curves.easeInOut,
        //delay: 0.ms,
        //duration: 1000.ms,
        //begin: 0,
        //end: 1,
        //),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FinanzplanerModel());

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
  key: scaffoldKey,
  backgroundColor: Color(0xFFD5BA98),
  appBar: PreferredSize(
    preferredSize: Size.fromHeight(60), // Hier können Sie die Höhe der AppBar festlegen
    child: AppBar(
      backgroundColor: Color(0xFFD5B896),
      automaticallyImplyLeading: false,
      title: Text(
        'Finanzplaner',
        style: FlutterFlowTheme.of(context).headlineMedium.override(
          fontFamily: 'Outfit',
          color: Colors.white,
          fontSize: 22,
        ),
      ),
      actions: [],
      centerTitle: true,
      elevation: 2,
    ),
  ),
  body: SafeArea(
    top: true,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Opacity(
            opacity: 0.8,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                image: DecorationImage( 
                  image: AssetImage('hintergrund.jpeg'), // Pfad zum lokalen Hintergrundbild
                  fit: BoxFit.cover, // Anpassen des Bildes
                ),
              ),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 80),
                          child: Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                width: 6,
                              ),
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text('$selectedValue' + '€',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.w800,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white,
                                  )),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation']!),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 20, 0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.numberWithOptions(
                                          decimal: true),
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp(r'^\d+(,|\.)?(\d{1,2})?€?'))
                                      ],
                                      onChanged: (value) {// Den String bereinigen: Währungssymbol und Eurozeichen entfernen
                                      String cleanedValue = value.replaceAll('€', '').replaceAll(',', '.');


                                       // Versuche den bereinigten String in eine Dezimalzahl umzuwandeln
                                      double parsedValue = double.tryParse(cleanedValue) ?? 0.0;


                                       // Weise den Wert der Variable einnahmen zu
                                      einnahmen = parsedValue; }, 
                                      controller: _model.textController1,
                                      focusNode: _model.textFieldFocusNode1,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Einnahmen',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color: Color(0xFF097070),
                                            ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      validator: _model.textController1Validator
                                          .asValidator(context),
                                          onEditingComplete: (){
        // Hier wird die Methode verrechnen() aufgerufen
        verrechnen();
         // Die Eingabefelder leeren
  _model.textController1.text = ''; // Leert das Eingabefeld für Einnahmen
  _model.textController2.text = ''; // Leert das Eingabefeld für Ausgaben
        }
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 30, 20, 0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.numberWithOptions(
                                          decimal: true),
                                      controller: _model.textController2,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(RegExp(r'^\d+(,|\.)?(\d{1,2})?€?'))
                                      ],
                                       onChanged: (value)  {// Den String bereinigen: Währungssymbol und Eurozeichen entfernen
  String cleanedValue = value.replaceAll('€', '');
  cleanedValue=cleanedValue.replaceAll(',', '.');


  // Versuche den bereinigten String in eine Dezimalzahl umzuwandeln
  double parsedValue = double.tryParse(cleanedValue) ?? 0.0;


  // Weise den Wert der Variable einnahmen zu
  ausgaben = parsedValue; },  
                                      focusNode: _model.textFieldFocusNode2,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Ausgaben',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Readex Pro',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        alignLabelWithHint: false,
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      validator: _model.textController2Validator
                                          .asValidator(context),
                                          onEditingComplete: (){
        // Hier wird die Methode verrechnen() aufgerufen
        verrechnen();
         // Die Eingabefelder leeren
  _model.textController1.text = ''; // Leert das Eingabefeld für Einnahmen
  _model.textController2.text = ''; // Leert das Eingabefeld für Ausgaben
        }
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                   0, 20, 20, 0),
                                child: FlutterFlowIconButton(
                                  borderRadius: 20,
                                  borderWidth: 1,
                                  buttonSize: 60,
                                  fillColor: Color(0xFF097070),
                                  icon: Icon(
                                    Icons.check,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    size: 24,
                                  ),
                                   onPressed: () async {
        // Hier wird die Methode verrechnen() aufgerufen
        verrechnen();
         // Die Eingabefelder leeren
  _model.textController1.text = ''; // Leert das Eingabefeld für Einnahmen
  _model.textController2.text = ''; // Leert das Eingabefeld für Ausgaben
        }
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}
