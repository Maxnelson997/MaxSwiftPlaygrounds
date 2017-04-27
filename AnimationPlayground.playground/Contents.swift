//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport


let v = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
v.backgroundColor = .white

let box = UIButton(frame: CGRect(x: 150, y: 150, width: 200, height: 200))
box.transform = CGAffineTransform(scaleX: 1, y: 1)
box.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
box.layer.cornerRadius = 15
box.layer.masksToBounds = true
box.titleLabel?.numberOfLines = 2
box.titleLabel?.textAlignment = .center
box.titleLabel?.textColor = .black
box.setTitle("I'm The Box.\nClick Me To Center", for: .normal)

let updown = UIButton(frame: CGRect(x: 20, y: 10, width: v.frame.width - 40, height: 40))
updown.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
updown.layer.cornerRadius = 5
updown.layer.masksToBounds = true
updown.setTitle("Move The Box Up", for: .normal)
updown.titleLabel?.textColor = .white
updown.tag = 0

let side = UIButton(frame: CGRect(x: 20, y: v.frame.maxY - 50, width: v.frame.width - 40, height: 40))
side.backgroundColor = UIColor.blue.withAlphaComponent(0.8)
side.layer.cornerRadius = 5
side.layer.masksToBounds = true
side.setTitle("Move The Box Sideways", for: .normal)
side.titleLabel?.textColor = .white
side.tag = 0

v.addSubview(box)
v.addSubview(updown)
v.addSubview(side)

let springDampingValue:CGFloat = 20
let springVelocityValue:CGFloat = 75

func globalUpDown(sender:UIButton) {
    var location:CGFloat!
        
    location = v.frame.maxY - 50 - box.frame.height
    if updown.tag == 1 {
        print("up1")
        location = v.frame.minY + 50
        updown.tag = 0
    } else {print("uptwo");updown.tag=1;}
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: springDampingValue, initialSpringVelocity: springVelocityValue, options: .curveEaseIn, animations: {
        box.frame.origin.y = location
    }, completion: nil)
}

func globalSideways(sender:UIButton) {
    var location:CGFloat!
    location = v.frame.maxX - 20 - box.frame.width
    if side.tag == 1 {
        location = v.frame.minX + 20
        print("sideone")
        side.tag = 0
    } else {print("sidetwo");side.tag=1;}
    
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: springDampingValue, initialSpringVelocity: springVelocityValue, options: .curveEaseIn, animations: {
        box.frame.origin.x = location
    }, completion: nil)
}

func globalCenter(sender:UIButton) {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: springDampingValue, initialSpringVelocity: springVelocityValue, options: .curveEaseIn, animations: {
        box.frame.origin.x = v.frame.midX - box.frame.width/2
        box.frame.origin.y = v.frame.midY - box.frame.height/2
    }, completion: nil)
}


class ActionReceiver {
    @objc func callAnimations(s:UIButton) {
        switch s {
        case updown:
            globalUpDown(sender: s)
        case side:
            globalSideways(sender: s)
        case box:
            globalCenter(sender: s)
        default:
            break
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: springDampingValue, initialSpringVelocity: springVelocityValue, options: .curveEaseIn, animations: {
            s.transform = CGAffineTransform(scaleX: 0.45, y: 0.5)
        }, completion: { finished in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: springDampingValue, initialSpringVelocity: springVelocityValue, options: .curveEaseIn, animations: {
                s.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
        })
    }

}

let m = ActionReceiver()

updown.addTarget(m, action: #selector(m.callAnimations(s:)), for: .touchUpInside)
side.addTarget(m, action: #selector(m.callAnimations(s:)), for: .touchUpInside)
box.addTarget(m, action: #selector(m.callAnimations(s:)), for: .touchUpInside)

PlaygroundPage.current.liveView = v

