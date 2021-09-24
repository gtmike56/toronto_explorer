//
//  ImagesCarouselView.swift
//  ImagesCarouselView
//
//  Created by Mikhail Udotov on 2021-09-18.
//

import SwiftUI

struct ImagesCarouselView: UIViewControllerRepresentable {
    
    let place: Place
    let selectedImageIndex: Int
    
    init(place: Place, selectedImageIndex: Int) {
        self.place = place
        self.selectedImageIndex = selectedImageIndex
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let pageVC = ImagesCarouselController(images: place.photos, selectedImageIndex: selectedImageIndex)
        return pageVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
    
}

class ImagesCarouselController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var allControllers: [UIViewController] = []
    var selectedImageIndex: Int
    
    init(images: [String], selectedImageIndex: Int) {
        
        self.selectedImageIndex = selectedImageIndex

        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.dataSource = self
        self.delegate = self
                
        allControllers = images.map { imageName in
            let imageController = UIHostingController(rootView: ZStack {
                Color.black
                
                URLImage(imageName).scaledToFit()
            })
            imageController.view.clipsToBounds = true
            return imageController
        }
        if selectedImageIndex < allControllers.count {
            setViewControllers([allControllers[selectedImageIndex]], direction: .forward, animated: true, completion: nil)
        }
        
        UIPageControl.appearance().pageIndicatorTintColor = .gray
        UIPageControl.appearance().currentPageIndicatorTintColor = .orange
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return allControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return selectedImageIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = allControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if index == 0 {
            return nil
        }
        
        return allControllers[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = allControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if index == allControllers.count-1 {
            return nil
        }
        
        return allControllers[index+1]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

