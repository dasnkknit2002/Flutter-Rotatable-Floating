# rotatable

Rotatable

This widget has features like rotation with one finger, bounce on click and floatation with a finger.
The package also contains gesture recognizer which supports Tap and Pan gestures and is not affected by other recognizers in UI arena.

## Usage
To use this plugin, add ```rotatable``` as a [dependency in your pubspec.yaml](https://flutter.io/platform-plugins/).

### Example
To use one finger rotation feature
```dart

class RotatableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Rotatable')),
        body: Center(
            child: Rotatable(Container(
                width: 150,
                height: 150,
                color: Colors.lightBlueAccent))));
  }
}

```

To create floating widget with finger movement
```dart

class FloatingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Floating')),
        body: Center(
            child: BouncingAvatar(Container(
                width: 150,
                height: 150,
                color: Colors.lightBlueAccent))));
  }
}

```
To create floating rotating tapable widget
```dart

class FloatingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Floating')),
        body: Center(
            child: BouncingAvatar(Container(
                width: 150,
                height: 150,
                color: Colors.lightBlueAccent))));
  }
}

```

