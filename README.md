# trustchain-gui
Flutter front-end for Trustchain

### Testing
Run macos core integration tests with:
```
flutter test integration_test -d macos --exclude-tags requires-ion-server
```

Run macos full test set requiring running ion server with:
```
flutter test integration_test -d macos
```

Note: IDE test environments (eg. VSCode testing with the testing tab or inline `Run` buttons on test files) are unlikely to run with the required `TRUSTCHAIN_DATA` and `TRUSTCHAIN_CONFIG` environment variables or the correct permissions to access the directories specified by them, so tests may *not* run correctly.
