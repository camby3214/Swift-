//
//  ViewController.swift
//  CameraFilter
//
//  Created by 李韋辰 on 2022/3/11.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var phtoImageView: UIImageView!
    @IBAction func applyFilterButtonPressed(){
        guard let sourceImage = self.phtoImageView.image else { return }
//        FilterService().applyFilter(to: sourceImage){ filteredImage in
//            self.phtoImageView.image = filteredImage
//        }
        FilterService().applyFilter(to: sourceImage)
            .subscribe(onNext:{ filterImage in
                DispatchQueue.main.async {
                    self.phtoImageView.image = filterImage
                }
            }).disposed(by: disposeBag)
    }
    
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController
        else{
            fatalError("Segue destination is not found")
        }
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            
            self?.updateUI(with: photo)
        }).disposed(by: disposeBag)
        
    }
    
    private func updateUI(with image : UIImage){
        self.phtoImageView.image = image
        self.applyFilterButton.isHidden = false
    }


}

