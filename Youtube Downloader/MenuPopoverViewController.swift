//
//  DownloadViewController.swift
//  Youtube Downloader
//
//  Created by Mathias Beke on 8/11/17.
//  Copyright © 2017 Mathias Beke. All rights reserved.
//

import Cocoa
import Alamofire

class MenuPopoverViewController: NSViewController {
    
    
    @IBOutlet weak var videoUrl: NSTextField!
    var downloadUrl: String = ""
    
    @IBOutlet weak var progressbar: NSProgressIndicator!
    @IBOutlet weak var downloadButton: NSButton!
    @IBOutlet weak var message: NSTextField!
    
    
    
    //@IBOutlet weak var preview: PreviewView!
    
    
    
    @IBAction func downloadButtonClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: NSStoryboardSegue.Identifier(rawValue: "goToPreview"), sender: self)
        
        /*
        downloadButton.isHidden = true
        progressbar.isHidden = false
        
        
        let url = videoUrl.stringValue
        
        
        DispatchQueue.global(qos: .background).async {
            // This is run on the background queue
            let videoInfo = VideoInfo.getVideoInfo(url: url)
            
            self.downloadUrl = videoInfo.url
            var title = videoInfo.fulltitle
            
            
            // Escape slashes from path
            title = title.replacingOccurrences(of: "/", with: " ")

            DispatchQueue.main.async {
                // This is run on the main queue, after the previous code in outer block

                self.preview.setInfo(info: videoInfo)
                
         


                
                
                
                let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                    let suffix = Date().toString(dateFormat: "dd-MM-YY")
                    let pathComponent = "\(title) (\(suffix)).mp4"
                    var documentsURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask)[0]
                    documentsURL.appendPathComponent(pathComponent)
                    return (documentsURL, [.removePreviousFile, .createIntermediateDirectories])
                }
                
                Alamofire.download(self.downloadUrl, to: destination).downloadProgress { progress in
                    print("Download Progress: \(progress.fractionCompleted)")
                    self.progressbar.doubleValue = progress.fractionCompleted
                    }.response { response in
                        self.progressbar.isHidden = true
                        self.message.stringValue = "Downloaded: \(title)"
                        self.message.isHidden = false
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
                             self.reset()
                        })
                }
 
                
            }
        }
        */
        
        
        
        
    }
    
    
    func reset() {
        self.progressbar.isHidden = true
        self.progressbar.doubleValue = 0
        self.message.isHidden = true
        self.downloadButton.isHidden = false
        self.videoUrl.stringValue = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if segue.identifier!.rawValue == "goToPreview" {
            if let preview = segue.destinationController as? PreviewViewController {
                preview.url = videoUrl.stringValue
            }
        }
    }

    
}


extension MenuPopoverViewController {

    static func freshController() -> MenuPopoverViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "DownloadViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? MenuPopoverViewController else {
            fatalError("Why cant i find DownloadViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}