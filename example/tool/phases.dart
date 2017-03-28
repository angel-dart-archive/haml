import 'package:angel_haml/angel_haml.dart';
import 'package:builder_runner/build_runner.dart';

final PhaseGroup PHASES = new PhaseGroup.singleAction(new AngelHamlBuilder(),
    new InputSet('example', const ['views/angel_haml.yaml']));
