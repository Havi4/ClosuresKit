//
//  NSTimerExtension.swift
//  ClosuresKit
//
//  Created by 卓同学 on 16/4/25.
//  Copyright © 2016年 zhuo. All rights reserved.
//

import Foundation

var CSTimerHandlerKey = "CSTimerHandlerKey"

extension NSTimer{
    
    public class func cs_scheduledTimerWithTimeInterval(timeInterval:NSTimeInterval,repeats:Bool,userInfo:NSDictionary?,mode:String=NSDefaultRunLoopMode,handler:(timer:NSTimer)->Void)-> NSTimer {
        let timer = NSTimer(timeInterval: timeInterval, target: self, selector: #selector(NSTimer.timerHandler(_:)), userInfo: userInfo, repeats: repeats)
        timer.handler=handler
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: mode)
        return timer
    }
    
    class func timerHandler(timer:NSTimer){
        timer.handler(timer: timer)
    }
    
    // MARK: - computed propery
    private var handler:(timer:NSTimer)->Void{
        get{
            return timeHandlerContainer.handler
        }
        set{
            timeHandlerContainer.handler=newValue
        }
    }
    
    private var timeHandlerContainer:NSTimerHandlerContainer{
        get{
            if let container = cs_associateValueForKey(&CSTimerHandlerKey) as? NSTimerHandlerContainer {
                return container
            }else{
                let container = NSTimerHandlerContainer()
                cs_associateValue(container, key: &CSTimerHandlerKey)
                return container
            }
        }
    }
}

class NSTimerHandlerContainer:NSObject{
    var handler:(timer:NSTimer)->Void = { _ in }
}