import UIKit

class MainController: UINavigationController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let titleView = UIImageView(image: #imageLiteral(resourceName: "crock-pod"))
    titleView.frame = CGRect(x: 0, y: 0, width: 400, height: 50)

    self.navigationItem.titleView = titleView
    titleView.contentMode = .scaleAspectFit
  }
}
