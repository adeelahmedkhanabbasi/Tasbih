//
//  HCUViewController.m
//  Tasbih
//
//  Created by Hanief Cahya on 02/08/13.
//  Copyright (c) 2013 Hanief Cahya. All rights reserved.
//

#import "HCUViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
#import "RBVolumeButtons.h"

@interface HCUViewController ()

@end

@implementation HCUViewController
@synthesize buttonStealer = _buttonStealer;
@synthesize repeatingTimer;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.amountTextField setBackgroundColor:[UIColor clearColor]];
    [self.amountTextField setBorderStyle:UITextBorderStyleLine];
    [self.amountTextField setTextColor:[UIColor sunflowerColor]];
    [self.amountTextField setFont:[UIFont boldSystemFontOfSize:30.0]];
    [self.roundLabel setTextColor:[UIColor sunflowerColor]];
    [self.sumLabel setTextColor:[UIColor sunflowerColor]];
    [self.tapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tapButton setButtonColor:[UIColor sunflowerColor]];
    [self.tapButton setCornerRadius:10.0];
    [self.resetButton setButtonColor:[UIColor redColor]];
    [self.resetButton setCornerRadius:10.0];
    
    self.amountSlider.value = 33;
    self.roundLabel.text = @"0";
    
    [self.speedSlider configureFlatSliderWithTrackColor:[UIColor whiteColor] progressColor:[UIColor sunflowerColor] thumbColor:[UIColor redColor]];
    
    self.buttonStealer = [[RBVolumeButtons alloc] init];
    self.buttonStealer.upBlock = ^{
        [self upButtonPressed:nil];
    };
    self.buttonStealer.downBlock = ^{
        [self resetButtonPressed:nil];
    };
    
    [self.buttonStealer startStealingVolumeButtonEvents];
    
    self.adView = [[MPAdView alloc] initWithAdUnitId:@"01fa527872ae400b85959920159e206a"
                                                 size:MOPUB_BANNER_SIZE];
    self.adView.delegate = self;
    CGRect frame = self.adView.frame;
    //CGSize size = [self.adView adContentViewSize];
    frame.origin.y = 0;
    self.adView.frame = frame;
    [self.view addSubview:self.adView];
    [self.adView loadAd];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)resetButtonPressed:(id)sender {
    if (self.repeatingTimer.isValid) {
        [self stopRepeatingTimer:sender];
    }
    self.roundLabel.text = @"0";
    self.sumLabel.text = @"0";
    [self.tapButton setTitle:@"0" forState:UIControlStateNormal];
}

- (IBAction)upButtonPressed:(id)sender {
    if (self.amountTextField.isFirstResponder) {
        [self.amountTextField resignFirstResponder];
    }
    
    self.sumLabel.text = [NSString stringWithFormat:@"%d",self.sumLabel.text.integerValue+1];
    
    if ([self.tapButton.titleLabel.text integerValue] < [self.amountTextField.text integerValue]) {
        [self.tapButton setTitle:[NSString stringWithFormat:@"%d",[self.tapButton.titleLabel.text integerValue]+1] forState:UIControlStateNormal];
    } else if ([self.tapButton.titleLabel.text integerValue] == [self.amountTextField.text integerValue]) {
        //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [self.tapButton setTitle:[NSString stringWithFormat:@"1"] forState:UIControlStateNormal];
        self.roundLabel.text = [NSString stringWithFormat:@"%d",[self.roundLabel.text integerValue]+1];
    }
    
    if (self.repeatingTimer.isValid) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
}

- (IBAction)sliderValueChanged:(UISlider*)sender {
    self.speedSlider.value = roundf(self.speedSlider.value);
    if (self.repeatingTimer.isValid) {
        [self stopRepeatingTimer:sender];
        [self startRepeatingTimer:sender];
    }
}

- (IBAction)playPauseButtonPressed:(id)sender {
    if (self.repeatingTimer.isValid) {
        [self stopRepeatingTimer:sender];
    } else {
        [self startRepeatingTimer:sender];
    }
}

- (IBAction)backgroundButtonPressed:(id)sender {
    if (self.amountTextField.isFirstResponder) {
        [self.amountTextField resignFirstResponder];
    }
}

- (IBAction)startRepeatingTimer:sender {
    [self.repeatingTimer invalidate];
    
    int speed = 0;
    if (self.speedSlider.value == 1) {
        speed = 3;
    } else if (self.speedSlider.value == 3) {
        speed = 1;
    } else {
        speed = self.speedSlider.value;
    }
    
    [self.tapButton setEnabled:NO];
    [self.playPauseButton setImage:[UIImage imageNamed:@"pauseButton"] forState:UIControlStateNormal];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5*speed
                                                      target:self selector:@selector(upButtonPressed:)
                                                    userInfo:[self userInfo] repeats:YES];
    self.repeatingTimer = timer;
}

- (IBAction)stopRepeatingTimer:sender{
    [self.tapButton setEnabled:YES];
    [self.playPauseButton setImage:[UIImage imageNamed:@"playButton"] forState:UIControlStateNormal];
    
    [self.repeatingTimer invalidate];
    self.repeatingTimer = nil;
}

- (NSDictionary *)userInfo{
    return @{ @"StartDate" : [NSDate date] };
}

#pragma mark - <MPAdViewDelegate>
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

@end
