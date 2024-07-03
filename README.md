<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Flutter package to create Grid View with custom child count and responsive.

## Features

Custom GridView, Responsive GirdView

## Getting started

In the pubspec.yaml of your flutter project, add the following dependency:

```
dependencies:
  ...
  responsive_gridview: <latest_version>
```

In your library add the following import:

```
import 'package:responsive_gridview/responsive_gridview.dart';
```

```
ResponsiveGridView(
  column: 2, // 2 items per row, we can configure 1 to many
  verticalSpacing: 20, // Vertical spacing between 2 items, default is 12
  horizontalSpacing: 20, // Horizontal spacing between 2 items, default is 12
  padding: const EdgeInsets.all(8), // Overall outer padding, default is 12
  children: [
    Text("Hello"),
    Text("Flutter"),
    Image.network("www.google.com/nj65372g"),
    Text("Thank You!"),
  ]
)
```

