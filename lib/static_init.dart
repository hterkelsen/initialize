// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library static_init;

// The transformer will replace this with a static_loader.
import 'src/mirror_loader.dart';
import 'dart:async';

part 'src/init_method.dart';
part 'src/static_initializer.dart';

/// Executes initializers in every library discovered by crawling Dart imports,
/// exports, and part directives.
Future run({List<Type> typeFilter, InitializerFilter customFilter}) =>
    new StaticInitializationCrawler(typeFilter, customFilter).run();