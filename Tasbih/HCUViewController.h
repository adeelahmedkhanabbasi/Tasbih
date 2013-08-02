//
//  HCUViewController.h
//  Tasbih
//
//  Created by Hanief Cahya on 02/08/13.
//  Copyright (c) 2013 Hanief Cahya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCUViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;
@property (weak, nonatomic) IBOutlet UISlider *amountSlider;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
- (IBAction)resetButtonPressed:(id)sender;
- (IBAction)upButtonPressed:(id)sender;
- (IBAction)downButtonPressed:(id)sender;
- (IBAction)sliderValueChanged:(UISlider*)sender;

@end
