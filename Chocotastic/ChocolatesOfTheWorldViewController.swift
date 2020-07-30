
import UIKit
import RxSwift
import RxCocoa

class ChocolatesOfTheWorldViewController: UIViewController {
  @IBOutlet private var cartButton: UIBarButtonItem!
  @IBOutlet private var tableView: UITableView!
  // just(_:) indicates that there won’t be any changes to the underlying value of the Observable, but that you still want to access it as an Observable value.
  let europeanChocolates = Observable.just(Chocolate.ofEurope)
  let disposeBag = DisposeBag() // to clean up any Observers you set up
}

//MARK: View Lifecycle
extension ChocolatesOfTheWorldViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Chocolate!!!"
    
    setupCartObserver()
    setupCellConfiguration()
    setupCellTapHandling()
  }
}

//MARK: Rx Setup
// reactive Observer to update the cart automatically.
private extension ChocolatesOfTheWorldViewController {
  func setupCartObserver() {
    ShoppingCart.sharedCart.chocolates.asObservable() //Grab the shopping cart’s chocolates variable as an Observable  .subscribe(onNext: to discover changes to the Observable’s value.
      .subscribe(onNext: { [unowned self] chocolates in
        self.cartButton.title = "\(chocolates.count) \u{1f36b}"
      })
      .disposed(by: disposeBag)
  }
  
  func setupCellConfiguration() {
    // The closure effectively replaces tableView(_:cellForRowAt:)
    europeanChocolates
      // Call bind(to:) to associate the europeanChocolates observable with the code that executes each row in the table view.
      .bind(to: tableView
      // By calling rx, you access the RxCocoa extensions for the relevant class.
        .rx
      // passing in the cell identifier and the class of the cell type you want to use.
        .items(cellIdentifier: ChocolateCell.Identifier,
               cellType: ChocolateCell.self)) { row, chocolate, cell in
      // Pass in a block for each new item. Information about the row, the chocolate at that row and the cell will return.
                cell.configureWithChocolate(chocolate: chocolate)
      }
      .disposed(by: disposeBag)
  }
  // another extension method RxCocoa adds to UITableView called modelSelected(_:). This returns an Observable you can use to watch information about selected model objects.
  func setupCellTapHandling() {
    tableView
      .rx
      .modelSelected(Chocolate.self) // return Observable
      // Taking that Observable, call subscribe(onNext:), passing in a closure of what should be done any time a model is selected
      .subscribe(onNext: { [unowned self] chocolate in
        let newValue =  ShoppingCart.sharedCart.chocolates.value + [chocolate]
        ShoppingCart.sharedCart.chocolates.accept(newValue)
        
        if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
          self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
        }
      })
      .disposed(by: disposeBag)
  }
}

// MARK: - SegueHandler
extension ChocolatesOfTheWorldViewController: SegueHandler {
  enum SegueIdentifier: String {
    case goToCart
  }
}
