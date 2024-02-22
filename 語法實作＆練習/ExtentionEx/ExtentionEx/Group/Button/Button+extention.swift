// 
// Copyright 2022 New Vector Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import UIKit

extension UIButton {
    
    convenience init(font: UIFont, normalColor: UIColor, normalText: String, selectColor: UIColor, selectText: String) {
        self.init()
        self.setTitle(normalText, for: .normal)
        self.setTitle(selectText, for: .selected)
        self.setTitleColor(normalColor, for: .normal)
        self.setTitleColor(selectColor, for: .selected)
        self.titleLabel?.font = font
    }
    
    
    
    func setPGButton(button: UIButton, font: UIFont, text: String, textColor: UIColor) {
        
        let attributesSender: [NSAttributedString.Key: Any] = [ .font: UIFont.PGtextBold16()]
        
        let senderTitle = NSAttributedString(string: text, attributes: attributesSender)
        
        button.setAttributedTitle(senderTitle, for: .normal)
        button.setAttributedTitle(senderTitle, for: .selected)
        button.layer.cornerRadius = 10
        button.showsTouchWhenHighlighted = true
    }
    
    

    
}
