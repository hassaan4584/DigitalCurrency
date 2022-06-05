#  Hi - Digital Currency


### What does the app support/contain? ###

* The main History Screen supports pagination and details page contains simple stackview and table view to display information.
* Tableviews use [UITableViewDiffableDataSource](https://developer.apple.com/documentation/uikit/uitableviewdiffabledatasource) to populate data
* A custom Loading animation to indicate network activity.
* A network layer using [Combine framework](https://developer.apple.com/documentation/combine) for making api calls.
* The app uses MVVM architecture pattern.
* A simple Observable class used for Reactive Programming.
* Coordinator class to coordinate UI navigations.
* Unit Test cases and Integration Test cases.
* Simple UITestcase.
* [SwiftLint](https://github.com/realm/SwiftLint) is used to standardize coding style
* [This](https://www.alphavantage.co/query?apikey=5WDAFC09SA7SXNBI&function=DIGITAL_CURRENCY_DAILY&market=USD&symbol=BTC) is the sample api request. The api itself is not as eyecatching from a user's perspective.

### How to run the project? ###

1. Clone the project/ Extract the zip file
2. Open the `Hi.xcodeproj` file
3. Run the project.
4. Since majority of the work is already done in `main` branch. So no need to worry about being on the right branch or not
5. Optionally, [SwiftLint](https://github.com/realm/SwiftLint) should also be installed
