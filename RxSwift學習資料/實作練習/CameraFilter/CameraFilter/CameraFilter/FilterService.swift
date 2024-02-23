//
//  FilterService.swift
//  CameraFilter
//
//  Created by 李韋辰 on 2022/3/15.
//

import Foundation
import UIKit
import CoreImage
import RxSwift

class FilterService {
    private var context: CIContext
    
    init(){
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            
            self.applyFilter(to: inputImage){ filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
    
    private func applyFilter(to inputImage:UIImage,completion: @escaping((UIImage) -> ())){
        //選擇濾鏡並設定參數
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        //將圖片套用濾鏡
        if let sourceImage = CIImage(image: inputImage){
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent){
                let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
        
        
    }
}
