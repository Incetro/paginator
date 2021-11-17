<H1 align="center">Paginator</H1>

<p align="center">
<a href="https://cocoapods.org/pods/incetro-paginator"><img alt="Version" src="https://img.shields.io/cocoapods/v/incetro-paginator.svg?style=flat"></a> 
<a href="https://github.com/Incetro/paginator/blob/master/LICENSE"><img alt="Liscence" src="https://img.shields.io/cocoapods/l/incetro-paginator.svg?style=flat"></a> 
<a href="https://developer.apple.com/"><img alt="Platform" src="https://img.shields.io/badge/platform-iOS-green.svg"/></a> 
<a href="https://developer.apple.com/swift"><img alt="Swift4.2" src="https://img.shields.io/badge/language-Swift5.0-orange.svg"/></a>
</p>

## Description
This library is an API responses pagination wrapper.

- [Usage](#Usage)
- [Example](#Example)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Authors](#license)

## Usage <a name="Usage"></a>

To use a *Paginator*, all you will need is to import `Paginator` module into your swift file:

```swift
import Paginator
```

## Example <a name="Example"></a>

### Interactor
Create paginator instance:

```swift
/// Paginator instance
let paginator = Paginator<YourTargetPlainObject>(pageSize: 20)
```
And configure it:

```swift
/// Setup paginator
func setupPaginator() {
    paginator.fetchHandler = { [weak self] paginator, page, pageSize in
        guard let self = self else { return }
        self.someService
            .obtain(entityID: self.entityID, page: page, pageSize: pageSize)
            .async()
            .success { result in
                paginator.received(results: result.array, total: result.pagination.totalCount)
            }
            .failure(paginator.failed)
    }
    paginator.resultsHandler = { [weak self] _, entities in
        self?.output?.obtainEntitiesSuccess(entities: entities)
    }
    paginator.completionHandler = { [weak self] _ in
        self?.output?.pagintaionHasBeenCompleted()
    }
}
```

### Service
Here you need to create a method for obtaining the necessary data using a PaginatedResponsePlainObject:

```swift
/// Obatain target entities
func obtain(entityID: Int, page: Int, pageSize: Int) -> ServiceCall<PaginatedResponsePlainObject<YourTargetPlainObject>> {
    createCall { () -> Result<PaginatedResponsePlainObject<YourTargetPlainObject>, Error> in
        let request = HTTPRequest(
            httpMethod: .get,
            endpoint: ".../\(entityID)/entities",
            base: self.baseRequest
        )
        let result = self.transport.send(request: request)
        switch result {
        case .success(let response):
            let result = try response.body.unwrap().decoded() as PaginatedResponsePlainObject<YourTargetPlainObject>
            return .success(result)
        case .failure(let error):
            return .failure(error)
        }
    }
}
```


## Requirements
- iOS 12.0+
- WatchOS 4.0+
- OSX 10.9+
- Xcode 9.0
- Swift 5.0

## Communication

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.


## Installation <a name="installation"></a>

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To install it using [CocoaPods](https://cocoapods.org), simply add the following line to your Podfile:

```ruby
use_frameworks!

target "<Your Target Name>" do
pod "incetro-paginator", :git => "https://github.com/Incetro/incetro-paginator", :tag => "[1.0.0]"
end
```
Then, run the following command:

```bash
$ pod install
```
### Manually

If you prefer not to use any dependency managers, you can integrate *Paginator* into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

  ```bash
  $ git init
  ```

- Add *Paginator* as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

  ```bash
  $ git submodule add https://github.com/incetro/incetro-paginator.git
  ```

- Open the new `paginator` folder, and drag the `Paginator.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `Paginator.xcodeproj ` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `Paginator.xcodeproj ` folders each with two different versions of the `Paginator.framework` nested inside a `Products` folder.

- Select the `Paginator.framework`.

    > You can verify which one you selected by inspecting the build log for your project. The build target for `Nio` will be listed as either `Paginator iOS`.

- And that's it!

  > The `Paginator.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.
  


## Authors <a name="authors"></a>

incetro: incetro@ya.ru, Gasol: 1ezya007@gmail.com


## License <a name="license"></a>

*Validator* is available under the MIT license. See the LICENSE file for more info.