//
//  PopoverAnimator.swift
//  weiBo
//
//  Created by zijia on 2016/11/28.
//  Copyright © 2016年 zijia. All rights reserved.
//

import UIKit

class PopoverAnimatorWhileNavigation: NSObject {
    var isPresented = false
    
    var callBack : ((_ presented : Bool) -> ())?
    
    init(callBack1 :  @escaping ( _ presented : Bool) -> ()) {
        self.callBack = callBack1
    }
}

//UIViewControllerTransitioningDelegate 转场动画代理
extension PopoverAnimatorWhileNavigation : UIViewControllerTransitioningDelegate{
    
    // func presentationController 改变弹出view的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        //return UIPresentationController(presentedViewController: presented, presenting: presenting)
        // 要想改变弹出的controller 的frame， 必须自定义UIPresentationController
        
        return ZJPresentationWhileNavigationController(presentedViewController: presented, presenting: presenting)
    }
    
    //自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        callBack!(isPresented)
        return self
    }
    //自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        callBack!(isPresented)
        return self
    }
    
}

extension PopoverAnimatorWhileNavigation : UIViewControllerAnimatedTransitioning{
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        
        return 0.5
    }
    
    /// 获取`转场的上下文`:可以通过转场上下文获取弹出的View和消失的View
    // UITransitionContextFromViewKey : 获取消失的View
    // UITransitionContextToViewKey : 获取弹出的View
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animationForPresentedView(transitionContext) : animationForDismissedView(transitionContext)
    }
    
    /// 自定义弹出动画
    fileprivate func animationForPresentedView(_ transitionContext: UIViewControllerContextTransitioning) {
        // 1.获取弹出的View
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // 2.将弹出的View添加到containerView中
        transitionContext.containerView.addSubview(presentedView)
        
        // 3.执行动画
        presentedView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.2)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            presentedView.transform = CGAffineTransform.identity
            presentedView.alpha = 1.0
            }, completion: { (_) -> Void in
                // 必须告诉转场上下文你已经完成动画
                transitionContext.completeTransition(true)
        })
    }
    
    /// 自定义消失动画
    fileprivate func animationForDismissedView(_ transitionContext: UIViewControllerContextTransitioning) {
        // 1.获取消失的View
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        // 2.执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            dismissView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.00001)
            }, completion: { (_) -> Void in
                dismissView?.removeFromSuperview()
                // 必须告诉转场上下文你已经完成动画
                transitionContext.completeTransition(true)
        })
    }
}





