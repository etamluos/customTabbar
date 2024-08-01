import UIKit
import Lottie

class SecondViewController: UIViewController {
    @IBOutlet weak var animationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animation = LottieAnimationView(name: "animation")
        animation.frame = animationView.bounds
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.play()
        animationView.addSubview(animation)
    }
}
