//
//  DownUpGestureRecognizer.swift
//  CustomGestureRecognizer
//
//  Created by Jon Manning on 16/01/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit

// BEGIN recognizer
class DownUpGestureRecognizer: UIGestureRecognizer {
    
    // Represents the two phases that the gesture can be in:
    // moving down, or moving up after having moved down
    enum DownUpGesturePhase : CustomStringConvertible {
        case MovingDown, MovingUp
        
        // The 'Printable' protocol above means that this type
        // can be turned into a string. 
        // This means you can say "\(somePhase)" and it will
        // turn into the right string
        // The following property adds support for this.
        var description: String {
            get {
                switch self {
                case .MovingDown:
                    return "Moving Down"
                case .MovingUp:
                    return "Moving Up"
                }
            }
        }
    }
    
    var phase : DownUpGesturePhase = .MovingDown
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent!) {
            
        self.phase = .MovingDown
        
        if self.numberOfTouches > 1 {
            
            // If there's more than one touch, this is not the type of gesture
            // we're looking for, so fail immediately
            self.state = .failed
        } else {
            
            // Else, this touch could possible turn into a down-up gesture
            self.state = .possible
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>,
                               with event:UIEvent) {
            
        // We know we only have one touch, beacuse touchesBegan will stop
        // recognizing when more than one touch is detected
        let touch = touches.first! as! UITouch
        
        // Get the current and previous position of the touch
        let position = touch.location(in: touch.view)
        let lastPosition = touch.previousLocation(in: touch.view)
        
        // If the state is Possible, and the touch has moved down, the
        // gesture has Begun
        if self.state == .possible {
            if position.y > lastPosition.y {
                self.state = .began
            }
        }
        
        // If the state is Began or Changed, and the touch has moved, the
        // gesture will change state
        if self.state == .began ||
            self.state == .changed {
            
            // If the phase of the gesture is MovingDown, and the touch moved
            // down, the gesture has Changed
            if self.phase == .MovingDown && position.y >
                lastPosition.y {
                self.state = .changed
            }
            // If the phase of the gesture is MovingDown, and the touch moved
            // up, the gesture has Changed also, change the phase to MovingUp
            if self.phase == .MovingDown && position.y <
                lastPosition.y {
                    self.phase = .MovingUp
                self.state = .changed
            }
            // If the phase of the gesture is MovingUp, and the touch moved
            // down, then the gesture has Failed
            if self.phase == .MovingUp && position.y >
                lastPosition.y {
                self.state = .failed
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>,
                               with event: UIEvent!) {
            
        // We know that there's only one touch.
        
        // If the touch ends while the phase is MovingUp, the gesture has
        // Ended. If the touch ends while the phase is MovingDown, the gesture
        // has Failed.
        
        if self.phase == .MovingDown {
            self.state = .failed
        } else if self.phase == .MovingUp {
            self.state = .ended
        }
    }
   
}
// END recognizer

