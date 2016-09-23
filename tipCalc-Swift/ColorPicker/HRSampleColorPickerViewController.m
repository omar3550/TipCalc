/*-
 * Copyright (c) 2011 Ryota Hayashi
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR(S) ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR(S) BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $FreeBSD$
 */

#import "HRSampleColorPickerViewController.h"
#import "HRColorPickerView.h"

@interface HRSampleColorPickerViewController () {
    id <HRColorPickerViewControllerDelegate> __weak delegate;
}

@property (nonatomic, weak) IBOutlet HRColorPickerView *colorPickerView;

@end

@implementation HRSampleColorPickerViewController {
    UIColor *_color;
}

@synthesize delegate;

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    _per1.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"per1"]];
    _per2.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"per2"]];
    _per3.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"per3"]];
//    [_segment setTitle:[NSString stringWithFormat:@"%@%%",[[NSUserDefaults standardUserDefaults] valueForKey:@"per1"]] forSegmentAtIndex:0];
//    [_segment setTitle:[NSString stringWithFormat:@"%@%%",[[NSUserDefaults standardUserDefaults] valueForKey:@"per2"]] forSegmentAtIndex:1];
//    [_segment setTitle:[NSString stringWithFormat:@"%@%%",[[NSUserDefaults standardUserDefaults] valueForKey:@"per3"]] forSegmentAtIndex:2];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorPickerView.color = [UIColor blueColor];
    [self.colorPickerView addTarget:self
                             action:@selector(colorDidChange:)
                   forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.delegate) {
        [self.delegate setSelectedColor:self.color];
    }
}

- (void)colorDidChange:(HRColorPickerView *)colorPickerView {
    _color = colorPickerView.color;
    
}

- (IBAction)actionDone:(id)sender {
    
    NSData *colorData = [NSKeyedArchiver archivedDataWithRootObject:_color];
    
    [[NSUserDefaults standardUserDefaults] setObject:colorData forKey:@"theme"];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnSave:(id)sender {
    
    if (_per1.text.length > 0 && _per2.text.length > 0 && _per3.text.length > 0) {
        [self.view endEditing:YES];
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
//        NSNumber *myNumber = [f numberFromString:@"42"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[f numberFromString:_per1.text] forKey:@"per1"];
        [[NSUserDefaults standardUserDefaults] setObject:[f numberFromString:_per2.text] forKey:@"per2"];
        [[NSUserDefaults standardUserDefaults] setObject:[f numberFromString:_per3.text] forKey:@"per3"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Values Stored Successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else{
        //alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Please fill up all values." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    
}
@end

