import UIKit
import Lottie

let isIpad = UIDevice.current.userInterfaceIdiom == .pad

class CustomTabBarController: UITabBarController {
    var firstTabbarItemImageView: UIImageView!
    var secondTabbarItemImageView: UIImageView!
    var thirdthTabbarItemImageView: UIImageView!
    var fourthTabbarItemImageView: UIImageView!
    var fifthTabbarItemImageView: UIImageView!
    
    var listImageView: [UIImageView] = []
    var listAnimation: [LottieAnimationView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = tabBar.frame
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        stackView.distribution = .fillEqually
        stackView.isUserInteractionEnabled = false
        stackView.axis = .horizontal
        tabBar.addSubview(stackView)
        
        for i in 0...4 {
            let animation = LottieAnimationView(name: "animation")
            animation.contentMode = .scaleAspectFit
            animation.loopMode = .playOnce
            animation.alpha = 0
            listAnimation.append(animation)
            animation.translatesAutoresizingMaskIntoConstraints = false
            
            let imageView = UIImageView(image: UIImage(named: "user"))
            listImageView.append(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            let contentView = UIView()
            contentView.addSubview(animation)
            contentView.addSubview(imageView)
            
//            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 2).isActive = true
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true

            animation.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
            animation.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
            animation.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
            animation.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true

            stackView.addArrangedSubview(contentView)
        }
        updateAnimation(index: 0)
    }
    
    private func animate(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.1, animations: {
            imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
    
    func updateAnimation(index: Int) {
        guard index < 5 else { return }
        _ = listImageView.map { $0.alpha = 1 }
        _ = listAnimation.map { $0.alpha = 0 }
        listImageView[index].alpha = 0.0
        listAnimation[index].alpha = 1
        listAnimation[index].play()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item.tag)
        updateAnimation(index: item.tag)
    }
}


public class KabuTabBar: UITabBar {
    
    private var kLayerFillColor: CGColor = UIColor.white.cgColor
    private let tabBarShapeLayer = CAShapeLayer()
    internal var minimalHeight: CGFloat = {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 12
        }
        return 0
    }()
    private var minimalY: CGFloat {
        get {
            return -minimalHeight
        }
    }
    var animating = false {
        didSet {
            self.isUserInteractionEnabled = !animating
        }
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if UIDevice.current.userInterfaceIdiom == .pad {
            sizeThatFits.height = 94  // Chiều cao bạn muốn thay đổi
        }
        return sizeThatFits
    }
    
    /// Controll point of wave
    private var leftPoint4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPoint4.backgroundColor = .clear
        }
    }
    private var leftPoint3 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPoint3.backgroundColor = .clear
        }
    }
    private var leftPoint2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPoint2.backgroundColor = .clear
        }
    }
    private var leftPoint1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            leftPoint1.backgroundColor = .clear
        }
    }
    private var centerPoint1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            centerPoint1.backgroundColor = .clear
        }
    }
    private var centerPoint2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            centerPoint2.backgroundColor = .clear
        }
    }
    private var rightPoint1 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            rightPoint1.backgroundColor = .clear
        }
    }
    private var rightPoint2 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            rightPoint2.backgroundColor = .clear
        }
    }
    private var rightPoint4 = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 3.0, height: 3.0)) {
        didSet {
            rightPoint4.backgroundColor = .clear
        }
    }
    
    /// Draws the receiver’s image within the passed-in rectangle.
    /// - Parameter rect: rect of view
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        self.setupTabBar()
    }
}

// MARK: - Setup Tabbar
extension KabuTabBar {
    
    func setupTabBar() {
        self.isTranslucent = true
        self.backgroundColor = UIColor.clear
        self.backgroundImage = UIImage()
        self.shadowImage = UIImage()
        self.clipsToBounds = false
        /// Shadow
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 8
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.54
        self.addSubview(leftPoint4)
        self.addSubview(leftPoint3)
        self.addSubview(leftPoint2)
        self.addSubview(leftPoint1)
        self.addSubview(centerPoint1)
        self.addSubview(centerPoint2)
        self.addSubview(rightPoint1)
        self.addSubview(rightPoint2)
        self.addSubview(rightPoint4)
        tabBarShapeLayer.frame = CGRect(x: 0.0, y: 0, width: self.bounds.width, height: self.bounds.height + 50)
        tabBarShapeLayer.actions = ["position" : NSNull(), "bounds" : NSNull(), "path" : NSNull()]
        tabBarShapeLayer.fillColor = kLayerFillColor
        self.layer.insertSublayer(tabBarShapeLayer, at: 0)
        let changeValue = UIScreen.main.bounds.width/2
        self.setDefaultlayoutControlPoints(waveHeight: minimalHeight, locationX: changeValue)
        self.updateShapeLayer()
    }
}

// MARK: - Set layer path
extension KabuTabBar {
    
    func setDefaultlayoutControlPoints(waveHeight: CGFloat, locationX: CGFloat) {
        let width = (UIScreen.main.bounds.width/CGFloat(self.items?.count ?? 0))
        leftPoint4.center = CGPoint(x: 0, y: minimalY+minimalHeight)
        rightPoint4.center = CGPoint(x: self.bounds.width, y: minimalY+minimalHeight)
        let imaginaryFrame = CGRect(x: locationX-(width/2), y: minimalY, width: width, height: minimalHeight)
        leftPoint3.center = CGPoint(x: imaginaryFrame.minX, y: imaginaryFrame.maxY)
        let topOffset: CGFloat = imaginaryFrame.width / 4
        let bottomOffset: CGFloat = imaginaryFrame.width / 4
        leftPoint2.center = CGPoint(x: imaginaryFrame.midX, y: imaginaryFrame.minY)
        leftPoint1.center = CGPoint(x: imaginaryFrame.minX + bottomOffset, y: imaginaryFrame.maxY)
        centerPoint1.center = CGPoint(x: imaginaryFrame.midX - topOffset, y: imaginaryFrame.minY)
        centerPoint2.center = CGPoint(x: imaginaryFrame.maxX, y: imaginaryFrame.maxY)
        rightPoint1.center = CGPoint(x: imaginaryFrame.midX + topOffset, y: imaginaryFrame.minY)
        rightPoint2.center = CGPoint(x: imaginaryFrame.maxX - bottomOffset, y: imaginaryFrame.maxY)
    }
    
    /// updateShapeLayer
    @objc func updateShapeLayer() {
        tabBarShapeLayer.path = getCurrentPath()
    }
    
    /// Get path
    /// - Returns: get current index path
    func getCurrentPath() -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0.0, y: UIScreen.main.bounds.height))
        bezierPath.addLine(to: CGPoint(x: 0.0, y: leftPoint4.viewCenter(usePresentationLayerIfPossible: animating).y))
        bezierPath.addLine(to: leftPoint3.viewCenter(usePresentationLayerIfPossible: animating))
        bezierPath.addCurve(
            to: leftPoint2.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint1: leftPoint1.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint2: centerPoint1.viewCenter(usePresentationLayerIfPossible: animating)
        )
        bezierPath.addCurve(
            to: centerPoint2.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint1: rightPoint1.viewCenter(usePresentationLayerIfPossible: animating),
            controlPoint2: rightPoint2.viewCenter(usePresentationLayerIfPossible: animating)
        )
        bezierPath.addLine(to: leftPoint3.viewCenter(usePresentationLayerIfPossible: animating))
        bezierPath.addLine(to: rightPoint4.viewCenter(usePresentationLayerIfPossible: animating))
        bezierPath.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height))
        bezierPath.close()
        return bezierPath.cgPath
    }
    
}

extension UIView {
    func viewCenter(usePresentationLayerIfPossible: Bool) -> CGPoint {
        if usePresentationLayerIfPossible, let presentationLayer = layer.presentation() {
            return presentationLayer.position
        }
        return center
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
    }
}
