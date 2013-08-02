//
//  HCUViewController.m
//  Tasbih
//
//  Created by Hanief Cahya on 02/08/13.
//  Copyright (c) 2013 Hanief Cahya. All rights reserved.
//

#import "HCUViewController.h"

@interface HCUViewController ()

@end

@implementation HCUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.amountSlider.value = 33;
    self.counterLabel.text = self.amountTextField.text = @"33";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetButtonPressed:(id)sender {
    self.counterLabel.text = @"0";
}

- (IBAction)upButtonPressed:(id)sender {
    if ([self.counterLabel.text integerValue] < [self.amountTextField.text integerValue]) {
        self.counterLabel.text = [NSString stringWithFormat:@"%d",[self.counterLabel.text integerValue]+1];
    }
}

- (IBAction)downButtonPressed:(id)sender {
    if ([self.counterLabel.text integerValue] > 0) 
        self.counterLabel.text = [NSString stringWithFormat:@"%d",[self.counterLabel.text integerValue]-1];
}

- (IBAction)sliderValueChanged:(UISlider*)sender {
    int rounded = sender.value;
    [sender setValue:rounded animated:NO];
    self.amountTextField.text = [NSString stringWithFormat:@"%d",rounded];
}

@end
