//
//  ViewController.swift
//  cassini
//
//  Created by Siddique on 28/12/17.
//  Copyright © 2017 Siddique. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    var imageURL: URL?{
        didSet{
            imageView.image = nil
            if view.window != nil{
                fetchImage()
            }
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil{
                fetchImage()
            }
    }
    @IBOutlet weak var imageView: UIImageView!
   
    private func fetchImage(){
        if let url = imageURL{
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents{
                imageView.image = UIImage(data: imageData)
            }
        }
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil{
            imageURL = DemoURLs.stanford
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
        }
    }
}

