//
//  HCUViewController.h
//  Tasbih
//
//  Created by Hanief Cahya on 02/08/13.
//  Copyright (c) 2013 Hanief Cahya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MPAdView.h"

@class RBVolumeButtons;

@interface HCUViewController : UIViewController <MPAdViewDelegate, UITextFieldDelegate> {
    float launchVolume;
    RBVolumeButtons *_buttonStealer;
}

@property (weak, nonatomic) IBOutlet UISlider *speedSlider;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (retain) RBVolumeButtons *buttonStealer;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UISlider *amountSlider;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *roundLabel;
@property (weak, nonatomic) IBOutlet UILabel *sumLabel;
@property (weak, nonatomic) IBOutlet FUIButton *setButton;
@property (weak, nonatomic) IBOutlet FUIButton *tapButton;
@property (weak, nonatomic) IBOutlet FUIButton *resetButton;
@property (nonatomic, retain) MPAdView *adView;
@property (weak) NSTimer *repeatingTimer;
@property NSUInteger timerCount;

- (IBAction)startRepeatingTimer:sender;
- (IBAction)stopRepeatingTimer:sender;
- (NSDictionary *)userInfo;
- (IBAction)resetButtonPressed:(id)sender;
- (IBAction)upButtonPressed:(id)sender;
- (IBAction)sliderValueChanged:(UISlider*)sender;
- (IBAction)playPauseButtonPressed:(id)sender;
- (IBAction)backgroundButtonPressed:(id)sender;


@end
