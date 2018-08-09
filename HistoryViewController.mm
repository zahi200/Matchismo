// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Zahi Ajami.

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@end


@implementation HistoryViewController

- (void)setHistoryAttributedString:(NSAttributedString *)historyAttributedString {
  _historyAttributedString = historyAttributedString;
  [self.historyTextView setAttributedText:historyAttributedString];
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.historyTextView setAttributedText:self.historyAttributedString];
}

@end

