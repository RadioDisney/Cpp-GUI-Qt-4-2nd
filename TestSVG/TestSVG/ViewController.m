//
//  ViewController.m
//  TestSVG
//
//  Created by 胡珣珣 on 2017/8/31.
//  Copyright © 2017年 胡珣珣. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    m = 1;
    n = 1;
    markColor = @"#bbc27b";
    originalColor = @"#000000";
    
    webView = [[WKWebView alloc]init];
    [self.view addSubview:webView];
//    webView.UIDelegate = self;
//    webView.navigationDelegate = self;

    
    
    // Do any additional setup after loading the view, typically from a nib.
    docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *htmlPath = [NSString stringWithFormat:@"%@/%@", docDir,  @"score_svg.html"];
    NSString *jsPath = [NSString stringWithFormat:@"%@/%@", docDir, @"score_svg.js"];
    
    NSURL *fileURL = [NSURL fileURLWithPath:htmlPath];
    NSURL *baseURL = [NSURL fileURLWithPath:docDir];
    [webView loadFileURL:fileURL allowingReadAccessToURL:baseURL];
    
//    NSError *error;
//    [webView loadHTMLString:[NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:&error] baseURL:baseURL];
    
    [webView setFrame:self.view.bounds];

    timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(show) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)OnTouchUp:(id)sender
{
    NSLog(@"%f x %f", webView.frame.size.width, webView.frame.size.height);
}

- (void) show
{

    if (last_n != n)
    {
        NSString *jsCode = [NSString stringWithFormat:@"changeNoteColor (%d, %d, '%@')", last_m, last_n, originalColor];
        [webView evaluateJavaScript:jsCode completionHandler:^(id _Nullable response, NSError* _Nullable error) {
            NSLog(@"%@|%@", response, error);}];
    }
    NSString *jsCode = [NSString stringWithFormat:@"changeNoteColor (%d, %d, '%@')", m, n, markColor];
    [webView evaluateJavaScript:jsCode completionHandler:^(id _Nullable response, NSError* _Nullable error) {
        NSLog(@"%@|%@", response, error);}];

    last_m = m;
    last_n = n;

    if (n == 4)
    {
        n = 1;
        if (m == 8)
        {
            m = 1;
        }
        else
        {
            m++;
        }
    }
    else
    {
        n++;
    }
}

- (void)viewDidLayoutSubviews
{
    [webView setFrame:self.view.bounds];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
