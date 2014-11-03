//
//  LYRUIAddresBarView.m
//  Pods
//
//  Created by Kevin Coleman on 10/27/14.
//
//

#import "LYRUIAddressBarTextView.h"
#import "LYRUIConstants.h"
#import "LYRUIMessagingUtilities.h"

NSString *const LYRUIPlaceHolder = @"Enter Name";

@interface LYRUIAddressBarTextView ()

@property (nonatomic) UILabel *toLabel;
@property (nonatomic) NSUInteger maxHeight;

@end

@implementation LYRUIAddressBarTextView

static NSUInteger const LYRUILineSpacingConstant = 6;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.textContainerInset = UIEdgeInsetsZero;

        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setFirstLineHeadIndent:28.0f];
        [paragraphStyle setHeadIndent:0];
        [paragraphStyle setLineSpacing:LYRUILineSpacingConstant];
        self.attributedText = [[NSAttributedString alloc] initWithString:@" " attributes:@{NSParagraphStyleAttributeName : paragraphStyle,
                                                                                           NSForegroundColorAttributeName: [UIColor blackColor],
                                                                                           }];
        
        self.toLabel = [[UILabel alloc] init];
        self.toLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.toLabel.text = @"To:";
        self.toLabel.font = [UIFont systemFontOfSize:14];
        self.toLabel.textColor = LSGrayColor();
        [self.toLabel sizeToFit];
        [self addSubview:self.toLabel];
        
        [self updateConstraints];
        [self layoutSubviews];
        [self sizeToFit];
        
    }
    return self;
}

- (void)setUpMaxHeight
{
    CGSize size = LYRUITextPlainSize(self.text, self.font);
    if (!self.maxHeight) {
        self.maxHeight = size.height * 2 + LYRUILineSpacingConstant;
    }
}

- (CGSize)intrinsicContentSize
{
    if (self.contentSize.height > self.maxHeight) {
        return CGSizeMake(self.contentSize.width, self.maxHeight);
    }
    return self.contentSize;
}

- (void)updateConstraints
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.toLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:12]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.toLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.font = [UIFont systemFontOfSize:14];
    [self setUpMaxHeight];
    [self invalidateIntrinsicContentSize];
    

}
@end
