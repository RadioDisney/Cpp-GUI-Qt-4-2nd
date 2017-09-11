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
    markNoteColor = @"#0395da";
    markMeasureColor = @"#fbe7bf";
    originalNoteColor = @"#000000";
    originalMeasureColor = @"#ffffff";
    
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
    [webView.configuration.userContentController addScriptMessageHandler:self name:@"onClick"];
    
    
    [webView setFrame:self.view.bounds];

    timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(show) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    [self playMidi];
}

- (void)playMidi
{
    NSString *midiPath = [NSString stringWithFormat:@"%@/%@", docDir,  @"song.mid"];
    NSURL *midiUrl = [NSURL fileURLWithPath:midiPath];
    MusicPlayer player = NULL;
    NewMusicPlayer(&player);
    MusicSequence sequence = NULL;
    NewMusicSequence(&sequence);
    MusicSequenceFileLoad(sequence, (__bridge CFURLRef)midiUrl, kMusicSequenceFile_MIDIType, kMusicSequenceLoadSMF_ChannelsToTracks);
    MusicPlayerSetSequence(player, sequence);
    MusicPlayerStart(player);
}

- (IBAction)OnTouchUp:(id)sender
{
    NSLog(@"%f x %f", webView.frame.size.width, webView.frame.size.height);
}

- (void) show
{
    if (n==1)
    {
        NSString *jsCode = [NSString stringWithFormat:@"changeMeasureColor (%d, '%@')", m, markMeasureColor];
        [webView evaluateJavaScript:jsCode completionHandler:^(id _Nullable response, NSError* _Nullable error) {
            NSLog(@"%@|%@", response, error);}];
    }
    
    NSString *jsCode = [NSString stringWithFormat:@"changeNoteColor (%d, %d, '%@')", m, n, markNoteColor];
    [webView evaluateJavaScript:jsCode completionHandler:^(id _Nullable response, NSError* _Nullable error) {
        NSLog(@"%@|%@", response, error);}];
    
    if (last_n != n)
    {
        NSString *jsCode = [NSString stringWithFormat:@"changeNoteColor (%d, %d, '%@')", last_m, last_n, originalNoteColor];
        [webView evaluateJavaScript:jsCode completionHandler:^(id _Nullable response, NSError* _Nullable error) {
            NSLog(@"%@|%@", response, error);}];
    }
    
    if (n==1)
    {
        if (last_m != m)
        {
            NSString *jsCode = [NSString stringWithFormat:@"changeMeasureColor (%d, '%@')", last_m, originalMeasureColor];
            [webView evaluateJavaScript:jsCode completionHandler:^(id _Nullable response, NSError* _Nullable error) {
                NSLog(@"%@|%@", response, error);}];
        }
    }

    last_m = m;
    last_n = n;
    
    if (is_clicked)
    {
        is_clicked = false;
        m = click_m;
        n = 1;
    }
    else if (n == 4)
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

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"%@", message.name);

    if ([message.name isEqualToString:@"onClick"])
    {
        NSString *measureString = [NSString stringWithFormat:@"%@", message.body];
        click_m = [measureString intValue];
        is_clicked = true;
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
