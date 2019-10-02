# QmlScaffold

QmlScaffold is a collection of QML components to easily create desktop and mobile apps.

## Test

To run the tests using `Qt Creator` it's necessary to modify the run
configuration to manually add the import paths:

1. In Qt Creator click on `Projects` on the left sidebar;
2. In the `Command line argument` field of the run configuration of
the `Desktop` kit add the following:

```sh
-import %{sourceDir}/../qml -input %{sourceDir}/../qml
```

Alternatively it is possible to a custom executable configuration to
run `make check`, which will automatically pick up the `IMPORTPATH`
defined in [test.pro](test.pro).
