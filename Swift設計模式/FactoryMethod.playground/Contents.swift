import Foundation
import CoreGraphics

// 定義訓練營助手協議
protocol TrainingCampHelper {
    func trainAdventurer() // 訓練冒險者方法
    func weapon() // 獲取武器方法
    func armor() // 獲取防具方法
}

// 訓練營基類，實現了 TrainingCampHelper 協議
class TrainingCamp: TrainingCampHelper {
    func trainAdventurer() {
        // 訓練冒險者方法實現
        let adventurerInformation = CGRect(x: 0, y: 0, width: 80, height: 180)
        print("資料：\(adventurerInformation)") // 印出冒險者信息
    }
    
    func armor() {
        // 獲取防具方法實現
        print("防具") // 印出防具
    }
    
    func weapon() {
        // 獲取武器方法實現
        print("武器") // 印出武器
    }
}

// 弓箭手訓練營，繼承自訓練營基類
class ArcherTrainingCamp: TrainingCamp {
    override func trainAdventurer() {
        super.trainAdventurer() // 調用父類的訓練冒險者方法
        let archerInformation = CGRect(x: 0, y: 0, width: 60, height: 170)
        print("弓箭手資料：\(archerInformation)") // 印出弓箭手信息
    }
    override func weapon() {
        // 獲取武器方法實現，弓箭手使用箭作為武器
        print("箭") // 印出箭
    }
    override func armor() {
        // 獲取防具方法實現，弓箭手使用布甲作為防具
        print("布甲") // 印出布甲
    }
}

// 戰士訓練營，繼承自訓練營基類
class WarriorTrainingCamp: TrainingCamp {
    override func trainAdventurer() {
        super.trainAdventurer() // 調用父類的訓練冒險者方法
        let warriorInformation = CGRect(x: 0, y: 0, width: 90, height: 190)
        print("戰士資料：\(warriorInformation)") // 印出戰士信息
    }
    override func weapon() {
        // 獲取武器方法實現，戰士使用劍作為武器
        print("劍") // 印出劍
    }
    override func armor() {
        // 獲取防具方法實現，戰士使用重甲作為防具
        print("重甲") // 印出重甲
    }
}

// 定義勇敢者類型枚舉
enum Brave {
    case archer // 弓箭手
    case warrior // 戰士
}

// 冒險者工廠類
class AdventurerFactory {
    // 創建冒險者方法，根據勇敢者類型枚舉創建相應的訓練營實例
    func create(brave: Brave) -> TrainingCamp {
        switch brave {
        case .archer:
            let archer = ArcherTrainingCamp() // 創建弓箭手訓練營實例
            return archer
        case .warrior:
            let warrior = WarriorTrainingCamp() // 創建戰士訓練營實例
            return warrior
        }
    }
}

// 創建冒險者工廠實例
var adventurerFactory = AdventurerFactory()
// 使用工廠創建弓箭手並獲取其武器
adventurerFactory.create(brave: .archer).weapon()
