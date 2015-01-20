// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
library static_init.static_init_type_filter_test;

import 'package:static_init/static_init.dart';
import 'package:unittest/unittest.dart';
import 'package:unittest/compact_vm_config.dart';

// Initializers will mess with this value, and it gets reset to 0 at the
// start of every test.
var total;

main() {
  useCompactVMConfiguration();

  setUp(() {
    total = 0;
  });

  test('filter option limits which types of annotations will be ran', () {
    return run(typeFilter: const [_Adder]).then((_) {
      expect(total, 2);
    }).then((_) => run(typeFilter: const [_Subtractor])).then((_) {
      expect(total, 0);
    }).then((_) => run(typeFilter: const [_Adder])).then((_) {
      // Sanity check, future calls should be no-ops
      expect(total, 0);
    }).then((_) => run(typeFilter: const [_Subtractor])).then((_) {
      expect(total, 0);
    });
  });
}

@adder
a() {}
@subtractor
b() {}
@adder
@subtractor
c() {}

// Static Initializer that increments `total` by one.
class _Adder implements StaticInitializer<dynamic> {
  const _Adder();

  @override
  initialize(_) => total++;
}
const adder = const _Adder();

// Static Initializer that decrements `total` by one.
class _Subtractor implements StaticInitializer<dynamic> {
  const _Subtractor();

  @override
  initialize(_) => total--;
}
const subtractor = const _Subtractor();
