import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:recase/recase.dart';
import 'package:yaml/yaml.dart';

ArgResults argResults;
// base path for screen files
const String BASE_PATH = 'lib/ui/screens';
// name of the current root package
String packageName;
// path to new screen directory
String pathToScreen;

void main(List<String> arguments) async {
  exitCode = 0;

  // set with current package name
  packageName = await getCurrentPackageName();

  // absolute path to flutter_mvvm library
  final String libraryPath =
      path.join(path.dirname(Platform.script.toFilePath()), '../lib');

  if (packageName != null) {
    final parser = ArgParser()
      ..addOption('uiPath', defaultsTo: 'lib/ui/screens', abbr: 'p');
    argResults = parser.parse(arguments);

    final String uiPath = argResults['uiPath'];

    // required name of the directory
    final String name = argResults.rest
        .firstWhere((String param) => param != null, orElse: () => null);

    // check if name is provided
    if (name == null) {
      stderr.writeln('error: screen name is required. e.g flutter pub run '
          'flutter_mvvm example');
      exitCode = 2;
    } else {
      pathToScreen = '$uiPath/${name.snakeCase}';

      // check if directory with same name already exits
      if (await Directory(pathToScreen).exists()) {
        stderr.writeln('error: Direcotry $pathToScreen already exists.');
        exitCode = 2;
      } else {
        // generate files
        await copyAndRenameTemplate(
            Directory('$libraryPath/template'), Directory(pathToScreen), name);
      }
    }
  }
}

Future<String> getCurrentPackageName() async {
  // look for pubspec.yaml file and read name
  if (await File('pubspec.yaml').exists()) {
    File pubSpec = File('pubspec.yaml');
    Map yaml = loadYaml(pubSpec.readAsStringSync());

    return 'package:${yaml['name']}';
  } else {
    stderr.writeln('error: no pubspec.yaml file found.');
    exitCode = 2;
  }
  return null;
}

Future<void> copyAndRenameTemplate(
    Directory source, Directory destination, String name) async {
  await for (var entity in source.list(recursive: false)) {
    // create Directory in new Path
    if (entity is Directory) {
      var newDirectory = Directory(
          path.join(destination.absolute.path, path.basename(entity.path)));
      await newDirectory.create(recursive: true);
      await copyAndRenameTemplate(entity.absolute, newDirectory, name);
      stdout.writeln('${entity.path} created.');
    } else if (entity is File) {
      // copy file content and replace all "Template" with new name
      File file = File(path.join(destination.path,
          path.basename(entity.path.replaceAll('template', name.snakeCase))));
      await file.replaceAll('Template', name.pascalCase, copyFrom: entity);
      await file.replaceAll('package:flutter_mvvm/template',
          '$packageName${pathToScreen.replaceFirst('lib', '')}');
      await file.replaceAll('template', '${name.snakeCase}');
      stdout.writeln('${entity.path} created.');
    }
  }
}

extension ReplaceTemplate on File {
  Future<void> replaceAll(Pattern from, String to, {File copyFrom}) async {
    File file = copyFrom != null ? copyFrom : this;
    final String content = await file.readAsString();
    await this.writeAsString('');
    await this.writeAsString(
      content.replaceAll(from, to),
      mode: FileMode.writeOnlyAppend,
    );
  }
}
