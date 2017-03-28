# haml
[![under development](https://img.shields.io/badge/version-dev-red.svg)](https://pub.dartlang.org/packages/angel_haml)
[![build status](https://travis-ci.org/angel-dart/haml.svg)](https://travis-ci.org/angel-dart/haml)

HAML view generator for Angel.

# Installation
`package:angel_haml` is actually a source code generator,
and should be a development dependency only.

In your `pubspec.yaml`:

```yaml
dev_dependencies:
  angel_haml: ^1.0.0
  build_runner: ^0.3.0
```

# Usage
To use this codegen, you must include some sort of YAML (or JSON) specification file.
By convention, use `views/angel_haml.yaml`.

Only include the options you need; the others will be automatically filled with the defaults.

Defaults:

```yaml
name: hamlViews # Name of generated function
partials: . # Directory to resolve partials from
views: * # List of filenames (no extension) to be compiled, or '*'
```

Custom example:

```yaml
partials: ./some/folder/partials
views:
  - foo
  - bar/baz
```

Example use with `package:build_runner`:

```dart
import 'package:angel_haml/angel_haml.dart';
import 'package:builder_runner/build_runner.dart';

final PhaseGroup PHASES = new PhaseGroup.singleAction(const AngelHamlBuilder(),
    new InputSet('example', const ['views/angel_haml.yaml']));
```

The generated source file will contain an Angel plug-in that automatically wires
your views for you.

```dart
import 'package:angel_common/angel_common.dart';
import 'views/angel_haml.g.dart'; // Generated sources

main() async {
    var app = new Angel();
    await app.configure(hamlViews()); // Hook up views

    // ...
    app.get('/', (req, res) => res.render('index')); // Render pre-compiled index.haml

    app.get('/invoice/:id', (String id, ResponseContext res) async {
      var invoice = await app.service('api/invoices').read(id);
      await res.render('invoice_detail', {'invoice': invoice});
      // Render pre-compiled invoice_detail.haml
    }
}
```
