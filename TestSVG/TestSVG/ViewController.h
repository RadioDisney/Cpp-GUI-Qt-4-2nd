//
//  ViewController.h
//  TestSVG
//
//  Created by 胡珣珣 on 2017/8/31.
//  Copyright © 2017年 胡珣珣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>


@interface ViewController : UIViewController<WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>
{
    @public WKWebView *webView;
    int last_m, last_n; // 记录上一次的小节、音符序号
    int m,n;    // 小节、音符
    int click_m;
    Boolean is_clicked;
    NSString *docDir;
    
    NSString *originalNoteColor;
    NSString *originalMeasureColor;
    NSString *markNoteColor;
    NSString *markMeasureColor;
    
    NSTimer *timer;
}
- (IBAction)OnTouchUp:(id)sender;
@end

