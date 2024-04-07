//
//  ActivityItemSource.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 07.04.2024.
//  Title and Description ShareSheet - https://forums.developer.apple.com/forums/thread/687916?answerId=684540022#684540022
//

import LinkPresentation

class ActivityItemSource: NSObject, UIActivityItemSource {
    
    var title: String
    var text: String
    
    init(title: String, text: String) {
        self.title = title
        self.text = text
        super.init()
    }

    
}


extension ActivityItemSource {
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return text
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return title
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = title
        metadata.iconProvider = NSItemProvider(object: UIImage(named: "AppIcon")!)
        metadata.originalURL = URL(fileURLWithPath: text)
        return metadata
    }
    
    
}
