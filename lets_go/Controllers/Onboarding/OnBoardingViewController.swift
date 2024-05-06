//
//  OnBoardingViewController.swift
//  lets_go
//
//  Created by Ishan Singla on 25/04/24.
//

import UIKit

class OnBoardingsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBAction func skipButtonAction(_ sender: Any) {
        navigateLogin()
    }
    
    @IBAction func TempLogin(_ sender: Any) {
        print("Temp Login")
        let storyboard = UIStoryboard(name: "AuthorisedApp", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AuthorisedApp") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    @IBOutlet weak var collection: UICollectionView!
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setImage(UIImage(named: "progress3"), for: .normal)
            } else if currentPage == slides.count - 2 {
                nextButton.setImage(UIImage(named: "progress2"), for: .normal)
            }
            else {
                nextButton.setImage(UIImage(named: "progress1"), for: .normal)            }
        }
    }
    
    var slides: [OnboardingSlide] = [
        OnboardingSlide(
            title: "Travel safe with your colleague",
            description: "Travel safe with your college student or faculty ",
            image: #imageLiteral(resourceName: "slide1")
        ),
        OnboardingSlide(
            title: "At anytime",
            description: "Book ride anytime after college / offer colleague a ride",
            image: #imageLiteral(resourceName: "slide2")
        ),
        OnboardingSlide(
            title: "Book your Ride",
            description: "Get rides to / from college hassle-free ",
            image: #imageLiteral(resourceName: "slide3")
        )
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
    }

    @IBAction func next(_ sender: Any) {
        // Check if the user is on the last slide
        if currentPage == slides.count - 1 {
            navigateLogin()
        } else {
            // Scroll to the next slide
            currentPage += 1
            let index = IndexPath(item: currentPage, section: 0)
            collection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
    }
    
    func navigateLogin() {
        let vc = storyboard?.instantiateViewController(identifier: "LoginNC") as! UINavigationController
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell {
            print(slides[indexPath.row])
            cell.setup(slides[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Get the size of the collection view
        let size = collectionView.frame.size
        // Create a cell size
        let width = size.width
        let height = size.height
        // Return the cell size
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Get the current page based on the scroll offset
        let width = scrollView.frame.size.width
        currentPage =  Int( scrollView.contentOffset.x / width)
        // Set the current page
    }
    
    
}

