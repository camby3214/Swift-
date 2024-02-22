//
//  myAlert.swift
//  CustomAlert
//
//  Created by 李韋辰 on 2023/6/2.
//

import Foundation
import UIKit

protocol CoustomAlertDelegate: AnyObject {
    func confirmAction()
}

class CustomAlert {
    
    weak var delegate: CoustomAlertDelegate?
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    // 定義黑色背景，型別為UIView
    let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    
    let alertView: UIView = {
        let alert = UIView()
        alert.layer.masksToBounds = true
        alert.backgroundColor = .white
        alert.layer.cornerRadius = 13
        return alert
    }()
    //宣告一個名為mytargetView的UIView，取得ViewController.view
    var myTargetView: UIView?
    
    func showAlert(with title: String, message: String,on ViewController: UIViewController,
                   backgroundImg: String,
                   crossImg: String,
                   logoImg: String){
        guard let targetView = ViewController.view else{
            return
        }
        
        myTargetView = targetView
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
       
        alertView.frame = CGRect(x: (UIScreen.main.bounds.width - UIScreen.main.bounds.width*0.7)/2, y: -300,
                                 width: UIScreen.main.bounds.width*0.7,
                                 height: UIScreen.main.bounds.width*0.65)
        // 設定alertView背景
        let backgroundImage = UIImage(named: backgroundImg)

        if let backgroundImage = backgroundImage {
            let backgroundView = UIImageView(image: backgroundImage)
            backgroundView.contentMode = .scaleAspectFill
            backgroundView.frame = alertView.bounds
            alertView.addSubview(backgroundView)
        }
        alertView.backgroundColor = UIColor(patternImage: backgroundImage!)
        
        //標題
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.size.width, height: 21))
        titleLabel.center.y = alertView.frame.height/2.6
        if message == "" {
            titleLabel.center.y = alertView.frame.height/2.2
        }
        //標題文字為傳入的引數”title”之內容
        titleLabel.text = title
        titleLabel.font = titleLabel.font.withSize(18)
        
        //標題文字置中對齊
        titleLabel.textAlignment = .center
        //將標題titleLabel加入alertView中
        alertView.addSubview(titleLabel)
        //資訊
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.size.width, height: 19))
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.center.y = titleLabel.center.y + 30
        //設定 messageLabel的文字顏色
        messageLabel.textColor = UIColor(red: 102/255, green: 102/255, blue: 108/255, alpha: 1)
        messageLabel.font = messageLabel.font.withSize(16)
        messageLabel.textAlignment = .center
        // messageLabel.addCharacterSpacing(kernValue: 5.2)
        //將資訊messageLabel加入alertView中
        alertView.addSubview(messageLabel)
        //關閉按鈕
        let button = UIButton(frame: CGRect(x:alertView.frame.size.width - 40, y: 10, width:30, height: 30))
        //設定按鈕圖示
        button.setImage(UIImage(named: crossImg), for: .normal)
        button.tintColor = .black
        //按下button呼叫dismissAlert函式關閉該彈出視窗
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        //設定button的tag為100
        button.tag = 100
        alertView.addSubview(button)
        //新增按鈕
        let add_event = UIButton(frame: CGRect(x: 0,
                                               y: 0,
                                               width: 170,
                                               height: 37))
        add_event.setTitle("重新開始", for: .normal)
        add_event.center = CGPoint(x: alertView.frame.size.width * 0.5,
                                   y: alertView.frame.size.height/1.3)
        add_event.layer.cornerRadius = 7
        //   add_event.addTextSpacing(spacing: 5.2)
        add_event.setTitleColor(.white, for: .normal)
        add_event.backgroundColor = UIColor(red: 56/255, green: 83/255, blue: 143/255, alpha: 1)
        //按下add_event呼叫showAlert_T函式切換至下一頁
        add_event.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        alertView.addSubview(add_event)
        //小水晶圖圖片
        let alert_s = UIImageView(frame: CGRect(x: 0, y: 8, width: 60, height: 60))
        alert_s.image = UIImage(named: logoImg)
        alert_s.center.x = alertView.frame.size.width*0.5
        alertView.addSubview(alert_s)
        //設定彈出視窗載入動畫
        UIView.animate(withDuration: 0.25, animations: {
            //載入黑色背景，時間：0.25秒
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        },completion: { done in
            //上一個動畫完成後
            if done{
                UIView.animate(withDuration: 0.25,animations: {
                    //載入alertView，時間：0.25秒
                    //方式：將alertView位置設回視窗中央，製造滑入效果
                    self.alertView.center = targetView.center
                })
            }
        })
    }
    
    
    @objc func confirmAction() {
        delegate?.confirmAction()
        dismissAlert()
    }
    
    @objc func dismissAlert() {
        guard let targetView = myTargetView else {
            return
        }
        UIView.animate(withDuration: 0.25,
                       animations: {
            //改alertView Y軸位置讓alertView滑出螢幕
            self.alertView.frame = CGRect(x: (UIScreen.main.bounds.width - UIScreen.main.bounds.width*0.7)/2, y:targetView.frame.size.height, width: UIScreen.main.bounds.width*0.7, height: UIScreen.main.bounds.width*0.65)
            
        },completion: { done in
            if done{
                UIView.animate(withDuration: 0.25,animations: {
                    //先設定黑色背景透明度為0
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    if done{
                        //再清除UIView
                        //移除新增至alertView裡的所有物件
                        for child : UIView in self.alertView.subviews as [UIView]{
                            child.removeFromSuperview()
                        }
                        //移除alertview
                        self.alertView.removeFromSuperview()
                        //移除黑色背景backgroundView
                        self.backgroundView.removeFromSuperview()
                    }
                })
            }
        })
    }
}
