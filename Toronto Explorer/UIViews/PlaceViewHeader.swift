//
//  PlaceViewHeader.swift
//  PlaceViewHeader
//
//  Created by Mikhail Udotov on 2021-09-14.
//

import SwiftUI

struct PlaceViewHeader: UIViewControllerRepresentable {
    
    let place: Place
    
    init(place: Place) {
        self.place = place
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let pageVC = PlaceViewHeaderController(images: place.photos)
        return pageVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIViewController
    
    
}

class PlaceViewHeaderController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    lazy var allControllers: [UIViewController] = []
    
    init(images: [String]) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        self.dataSource = self
        self.delegate = self
        
        allControllers = images.map { imageName in
            let imageController = UIHostingController(rootView: URLImage(imageName))
            imageController.view.clipsToBounds = true
            return imageController
        }
        guard let firstController = allControllers.first else {return}
        setViewControllers([firstController], direction: .forward, animated: true, completion: nil)
        
        UIPageControl.appearance().pageIndicatorTintColor = .gray
        UIPageControl.appearance().currentPageIndicatorTintColor = .orange
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return allControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
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
