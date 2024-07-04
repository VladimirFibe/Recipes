import UIKit

class CustomPageControl: UIPageControl {

    override var currentPage: Int {
        didSet {
            setup()
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

    // Настройка начальных параметров
    private func setup() {
        // Прозрачный цвет для стандартных точек
        pageIndicatorTintColor = .clear
        // Прозрачный цвет для текущей точки
        currentPageIndicatorTintColor = .clear
        updateDots()
    }

    // Метод для обновления точек
    private func updateDots() {
        let dotSize = CGSize(width: 8, height: 8) // Устанавливаем размер точки
        
        // Обходим все подвиды и устанавливаем изображения точек
        for (index, subview) in subviews.enumerated() {
            let imageView: UIImageView
            if let existingImageView = subview as? UIImageView {
                imageView = existingImageView
            } else {
                imageView = UIImageView(frame: CGRect(origin: .zero, size: dotSize))
                imageView.contentMode = .center
                subview.addSubview(imageView)
            }

            // Устанавливаем изображение для текущей или стандартной точки
            let imageName = currentPage == index ? "currentDotImage" : "defaultDotImage"
            imageView.image = UIImage(named: imageName)
        }
        
        // Ограничиваем количество видимых точек максимум до 3
        let numberOfDotsToShow = min(numberOfPages, 3)
        var startDotIndex: Int
        var endDotIndex: Int
        
        // Определяем диапазон видимых точек в зависимости от текущей страницы
        if currentPage == 0 {
            startDotIndex = 0
            endDotIndex = numberOfDotsToShow - 1
        } else if currentPage == numberOfPages - 1 {
            startDotIndex = numberOfPages - numberOfDotsToShow
            endDotIndex = numberOfDotsToShow - 1
        } else {
            startDotIndex = currentPage - 1
            endDotIndex = currentPage + 1
        }
        
        // Скрываем или показываем точки в зависимости от их индекса
        if startDotIndex <= endDotIndex {
            for (index, subview) in subviews.enumerated() {
                subview.isHidden = !(startDotIndex...endDotIndex).contains(index)
            }
        }
    }
}
