//
//  OnboardingViewController.swift
//  Recipes
//
//  Created by Валентина Попова on 03.07.2024.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    
    public var pages = [UIViewController]()
    private let initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Настройка, стилизация и компоновка
private extension OnboardingViewController {
    func setup() {
        dataSource = self
        delegate = self
        
        // Создание страниц онбординга
        let page1 = ContentViewController(
            imageName: "onboarding1",
            buttonText: "Continue",
            showSkipButton: true,
            whiteText: "Recipes from all",
            colorText: " over the World",
            pageIndex: 0,
            delegate: self
        )
        
        let page2 = ContentViewController(
            imageName: "onboarding2",
            buttonText: "Continue",
            showSkipButton: true,
            whiteText: "Recipes with",
            colorText: " each and every detail",
            pageIndex: 1,
            delegate: self
        )
        
        let page3 = ContentViewController(
            imageName: "onboarding3",
            buttonText: "Start cooking",
            showSkipButton: false,
            whiteText: "Cook it now or",
            colorText: " save it for later",
            pageIndex: 2,
            delegate: self
        )
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        // Установка начальной страницы
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    // Метод для получения предыдущей страницы
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        return currentIndex == 0 ? nil : pages[currentIndex - 1]
    }
    
    // Метод для получения следующей страницы
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        return currentIndex < pages.count - 1 ? pages[currentIndex + 1] : nil
    }
}

// MARK: - UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    // Метод, вызываемый при завершении анимации перехода между страницами
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let viewControllers = pageViewController.viewControllers, let _ = pages.firstIndex(of: viewControllers[0]) else { return }
    }
}

// MARK: - ContentViewControllerDelegate
extension OnboardingViewController: ContentViewControllerDelegate {
    // Метод, вызываемый при нажатии на кнопку действия на странице онбординга
    func didTapActionButton(on viewController: ContentViewController) {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return }
        let nextIndex = currentIndex + 1
        if nextIndex < pages.count {
            setViewControllers([pages[nextIndex]], direction: .forward, animated: true, completion: nil)
            updateIndicator(forPage: nextIndex)
        } else {
            navigateToTrending()
        }
    }
    
    // Метод, вызываемый при нажатии на кнопку пропуска
    func didTapSkipButton(on viewController: ContentViewController) {
        let lastPageIndex = pages.count - 1
        setViewControllers([pages[lastPageIndex]], direction: .forward, animated: true, completion: nil)
        updateIndicator(forPage: lastPageIndex)
    }
    
    // Метод для перехода к экрану Trending
    private func navigateToTrending() {
        let createRecipeVC = CreateRecipeViewController()
        createRecipeVC.modalPresentationStyle = .fullScreen
        present(createRecipeVC, animated: true, completion: nil)
    }
    
    // Метод для обновления индикатора страниц
    private func updateIndicator(forPage index: Int) {
        for case let page as ContentViewController in pages {
            page.updatePageIndicator(forPage: index)
        }
    }
    
    // Метод для перехода на конкретную страницу по индикатору
    func didTapPageIndicator(at index: Int) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
        updateIndicator(forPage: index)
    }
}
