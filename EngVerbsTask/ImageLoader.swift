//
//  ImageLoader.swift
//  EngVerbsTask
//
//  Created by Alexandr Lobanov on 7/22/16.
//  Copyright © 2016 Alexandr Lobanov. All rights reserved.
//

import UIKit

class ImageLoader: NSObject {
    class  func downloadThumbImage(url: String, imageView: UIImageView) {
        let url = NSURL(string: url)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (responseData, responseUrl, error) -> Void in
            if let data = responseData{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    imageView.image = UIImage(data: data)
                })
            }
        }
        task.resume()
    }
}
