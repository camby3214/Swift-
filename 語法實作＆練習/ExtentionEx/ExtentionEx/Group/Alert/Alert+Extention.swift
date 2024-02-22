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

extension UIAlertController {
    
    convenience init(errorTitle: String?, errorMsg: String?) {
        self.init(title: errorTitle ?? String(), message: errorMsg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        self.view.tintColor = .darkGray
        self.addAction(cancelAction)
    }
    
    func dataParsingErrorAlert() -> UIAlertController {
        let alert = UIAlertController(title: "error", message: "資料解析失敗，請工程師排查。", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        return alert
    }
}
