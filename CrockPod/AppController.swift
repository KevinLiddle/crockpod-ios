import UIKit

class AppController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    let imageView = UIImageView(image: #imageLiteral(resourceName: "crock-pod"))
    imageView.clipsToBounds = true
    titleView.addSubview(imageView)
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false

    self.navigationItem.titleView = titleView

    let constraints = [
      NSLayoutConstraint.Attribute.top,
      NSLayoutConstraint.Attribute.bottom,
      NSLayoutConstraint.Attribute.left,
      NSLayoutConstraint.Attribute.right
      ].map { NSLayoutConstraint(
        item: imageView,
        attribute: $0,
        relatedBy: .equal,
        toItem: titleView,
        attribute: $0,
        multiplier: 1,
        constant: 0
      ) }

    titleView.addConstraints(constraints)
  }
}
