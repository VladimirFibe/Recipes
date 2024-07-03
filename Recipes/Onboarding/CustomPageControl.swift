import UIKit

class CustomPageControl: UIPageControl {

    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        pageIndicatorTintColor = .clear // Прозрачный цвет для стандартных точек
        currentPageIndicatorTintColor = .clear // Прозрачный цвет для стандартных точек
        updateDots()
    }

    private func updateDots() {
        let dotSize = CGSize(width: 8, height: 8) // Установите размер точки
        for (index, subview) in subviews.enumerated() {
            let imageView: UIImageView
            if let existingImageView = subview as? UIImageView {
                imageView = existingImageView
            } else {
                imageView = UIImageView(frame: CGRect(origin: .zero, size: dotSize))
                imageView.contentMode = .center
                subview.addSubview(imageView)
            }

            let imageName = currentPage == index ? "currentDotImage" : "defaultDotImage"
            imageView.image = UIImage(named: imageName)
        }

        // Обеспечиваем правильное количество точек
        let numberOfDotsToShow = min(numberOfPages, 3)
        var startDotIndex: Int
        var endDotIndex: Int

        if currentPage == 0 {
            startDotIndex = 0
            endDotIndex = numberOfDotsToShow - 1
        } else if currentPage == numberOfPages - 1 {
            startDotIndex = numberOfPages - numberOfDotsToShow
            endDotIndex = numberOfPages - 1
        } else {
            startDotIndex = currentPage - 1
            endDotIndex = currentPage + 1
        }

        if startDotIndex <= endDotIndex {
            for (index, subview) in subviews.enumerated() {
                subview.isHidden = !(startDotIndex...endDotIndex).contains(index)
            }
        }
    }
}
