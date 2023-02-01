# LazyContainer

[![CI Status](https://img.shields.io/travis/cookie777/LazyContainer.svg?style=flat)](https://travis-ci.org/cookie777/LazyContainer)
[![Version](https://img.shields.io/cocoapods/v/LazyContainer.svg?style=flat)](https://cocoapods.org/pods/LazyContainer)
[![License](https://img.shields.io/cocoapods/l/LazyContainer.svg?style=flat)](https://cocoapods.org/pods/LazyContainer)
[![Platform](https://img.shields.io/cocoapods/p/LazyContainer.svg?style=flat)](https://cocoapods.org/pods/LazyContainer)


## 👀 TL;DR
`LazyContainer` is a simple library for lazy initialization of classes and structs.

### Features:

- `Builder` class for registering and lazily initializing a single class or struct.
- `LazyContainer` class for managing multiple Builder classes as a dependency manager or service locator.

---

## 🔥 Motivation

App setups are often implemented in `AppDelegate` or `SceneDelegate` at launch, which is appropriate for crucial configurations. However, some configurations **may not be immediately necessary** and can be constructed when they are actually used. Heavy setup can **also slow down app launch and affect testing and previewing**. All initializations in `AppDelegate` are also called during unit-tests and SwiftUI Previews, causing unnecessary overhead.


## 🤔 So how can we solve this?
To improve this issue, we can use **lazy loading**. By delaying the execution of expensive operations until they are required, we can **save time and memory**. `LazyContainer` makes it easy to achieve this efficiently.

## 🚀 Features & Usage
What can this library do? It consists of two main classes, `Builder` and `LazyContainer`.

### 1. `Builder`:
#### Register
The `Builder` class allows you to register a single class or struct and initialize it lazily later.

Using the `Builder` class is easy. You simply call the `Builder` and pass a closure that declares the class.

```swift
  let builder = Builder { YourClass() }
  // or
  let secondBuilder = Builder {
    let yourClass = YourClass()
    return yourClass
  }

```
#### Resovle
You can access the registered instance by reading the `dependency` from the builder. The first time you read the `dependency`, the class will be instantiated. Subsequent reads will return the cached instance.

```swift
  // first time: instantiate YourClass()
  let yourClass = builder.dependency

  // subsequent times: return cached YourClass()
  let anotherClass = builder.dependency

```

### 2. `LazyContainer`:
#### Basic
LazyContainer is a Swift class that manages multiple `Builder` classes as a service locator or DI container. It has two main features: `register` and `resolve`. This allows you to register a `Builder` or closure and later resolve it by inferring the type.

```swift
let lazyContainer = LazyContainer()
let builder = Builder {
    YourClass()
}
// Register
lazyContainer.register(builder)

// Resolve
let yourClass: YourClass = lazyContainer.resolve()
```
#### Optional
If you want to resolve services safely, use `resolveOptional()` instead of `resolve()`. The `resolveOptional()` returns an optional value, so you can check if a service is registered before trying to access it.

```swift
let yourClass: YourClass? = lazyContainer.resolveOptional()
if let yourClass = yourClass {
    // Use yourClass
} else {
    // No service is registered
}
```
This avoids the `fatalError` that would occur if you tried to access an unregistered service using `resolve()`.

#### Closure
You can also register services using a closure. 
```Swift
lazyContainer.register { _ in
    YourClass()
}
```

#### Dependency graph
The container itself is passed as a parameter to the closure, allowing you to access other dependencies easily. This makes it easy to manage dependencies and avoid "dependency hell."

```swift
lazyContainer.register { _ in
    ServiceD()
}
lazyContainer.register { container in
    ServiceC(serviceD: container.resolve())
}
lazyContainer.register { container in
    ServiceB(serviceD: container.resolve())
}
lazyContainer.register { container in
    ServiceA(serviceB: container.resolve(), serviceC: container.resolve())
}

let serviceA: ServiceA = container.resolve() 
// Service D -> Service B -> Service C -> Service A is created
```

For example, when you resolve `ServiceA`, it will try to resolve its dependencies `ServiceB` and `ServiceC`, which in turn try to resolve their shared dependency `ServiceD`. Once `ServiceD` is created, `ServiceB` and `ServiceC` can be constructed, and finally `ServiceA` is initialized.

The great thing about this approach is that if `ServiceC` tries to resolve `ServiceD` Dagain, it will return the cached instance that was already created for `ServiceB`.

See more details in the [Example project](./Example).


## ⬇ Installation

LazyContainer is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LazyContainer'
```

## ☑️ Requirements

The library is compatible with iOS 10 and above.
The Example project uses SwiftUI, and requires iOS 13 or higher to run.

## 🙂 Author & Contribution

cookie777, takayuki-contact@gmail.com

## 💳 License

LazyContainer is available under the MIT license. See the LICENSE file for more info.
