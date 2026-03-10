import 'package:clean_arch/commands/init_command.dart';
import 'package:clean_arch/commands/feature_command.dart';

void main(List<String> args) {

  if (args.isEmpty) {
    print("Usage:");
    print("clean_arch init");
    print("clean_arch feature <name>");
    return;
  }

  final command = args[0];

  switch (command) {

    case "init":
      runInit();
      break;

    case "feature":
      if (args.length < 2) {
        print("Please provide feature name");
        return;
      }

      final feature = args[1];
      runFeature(feature);
      break;

    default:
      print("Unknown command");
  }
}
