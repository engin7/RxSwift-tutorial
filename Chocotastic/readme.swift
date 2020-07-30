/// TODO
// Change the CartViewController to use a reactive table view (instead of a label) to display the contents of the cart.
// Allow the user to add or remove chocolates directly from the cart, automatically updating the price.
// Now that you’ve gotten a taste of Rx programming, here are a few more resources to help you continue learning:
//
// RxSwift Slack
// RxSwift’s Getting Started guide
// Max Alexander’s talk on Rx at Realm
// Finally, our own Marin Todorov has a great blog about his adventures in Reactive programming called rx_marin. Check it out!


//RxSwift framework
//
//
//Opposite of reactive is imperative
//
//code updates reflect changes automatically, That’s the idea of reactive programming.
//
//You can achieve this in Swift through Key-Value Observation and using didSet, but it can be cumbersome to set up.
//
//RxSwift is a framework for interacting with the Swift programming language, while RxCocoa is a framework that makes Cocoa APIs used in iOS and OS X easier to use with reactive techniques.
//
//The DisposeBag is an additional tool RxSwift provides to help deal with ARC and memory management.
//Without a DisposeBag, you’d get one of two results. Either the Observer would create a retain cycle, hanging on to what it’s observing indefinitely, or it could be deallocated, causing a crash.
//Ensure the observer’s disposal in the disposeBag
//
//Sometimes, calling just(_:) is an indication that using reactive programming might be overkill. After all, if a value never changes, why use a programming technique designed to react to changes? In this example, you’re using it to set up reactions of table view cells that will change. However, it’s a good idea to look carefully at how you’re using Rx. Just because you have a hammer doesn’t mean every problem is a nail. :]
//
//Since a user might type quickly, running validation for every key press could be computationally expensive and lead to a lagging UI. Instead, debounce or throttle how quickly the user’s input moves through a validation process. This means you’ll only validate the input at the throttle interval rather than every time it changes. This way, fast typing won’t grind your whole app to a halt.
//
//
