//
//  HanselWrapper.swift
//  Mars
//
//  Created by Arpit Lokwani on 15/10/19.
//  Copyright © 2019 Arpit Lokwani. All rights reserved.
//

import UIKit


class HanselSyncStateListener: NSObject {
    func onHanselSynced(_ state:Bool){
        print(state)
    }

  
}

class HanselWrapper: NSObject {
    
   static func logEvent(eventName:String,properties:[AnyHashable: Any]) -> Void {
        var properties = properties
        //Check if this event is being tracked in any one of the active Hansel Interaction Maps
        //Please pass the string "ctp" for vendor if you are using Clevertap to track the event.
        if HanselTracker.isUsedInMap(eventName, vendor: "ctp",withProperties:properties as! [AnyHashable : Any]) {
            //get the data for all Interaction Maps created on hansel dashboard.
            let hanselData = HanselTracker.getHanselData(eventName, vendor: "ctp", withProperties: properties as! [AnyHashable : Any])
            for (k, v) in hanselData { properties[k] = v }
        }
        
       // CleverTap.sharedInstance()?.recordEvent(eventName, withProps: properties)
    }

}
