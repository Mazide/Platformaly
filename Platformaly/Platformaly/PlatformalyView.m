//
//  SelectOperatorView.m
//  PlatformalyExample
//


#import "PlatformalyView.h"
#import "Operator.h"
#import "PhoneNumberCell.h"
#import "OperatorCell.h"
#import "WebViewController.h"
#import "Platformaly.h"
#import "JTHamburgerButton.h"

typedef enum : NSUInteger {
    Operators,
    PhoneNumber,
} SelectOperatorViewState;

typedef enum : NSUInteger {
    Authed,
    NotAuthed,
} AuthState;

static const int phoneNumberSection = 0;
static const int operatorSection    = 1;

static   NSString* const phoneNumberCellIdentifier = @"PhoneNumberCell";
static   NSString* const operatorCellIdentifier    = @"OperatorCell";

@interface PlatformalyView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView* collectionView;
@property (weak, nonatomic) IBOutlet UIView* mainView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* changeTypeButtonWeidthContraint;
@property (weak, nonatomic) IBOutlet JTHamburgerButton* changeStateButton;

@property (strong, nonatomic) NSArray* operators;
@property (strong, nonatomic) PlatformalyData* platformalyData;
@property (nonatomic) SelectOperatorViewState state;

@property (weak, nonatomic) id<PlatformalyViewDelegate> delegate;

@end

@implementation PlatformalyView



#pragma mark - init

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) [self setup];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self setup];
    return self;
}



#pragma mark - setup

- (void)setup
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.mainView];
    [self stretchToSuperView:self.mainView];
    
    self.platformalyData = nil;
    self.changeStateButton.transform = CGAffineTransformMakeScale(-1.0, 1.0);
    
    UINib* phoneCellNib    = [UINib nibWithNibName:phoneNumberCellIdentifier bundle:nil];
    UINib* operatorCellNib = [UINib nibWithNibName:operatorCellIdentifier bundle:nil];
    [self.collectionView registerNib:phoneCellNib forCellWithReuseIdentifier:phoneNumberCellIdentifier];
    [self.collectionView registerNib:operatorCellNib forCellWithReuseIdentifier:operatorCellIdentifier];
}

- (void)configureWithOperators:(NSArray *)operators platformalyData:(PlatformalyData *)platformalyData delegate:(id<PlatformalyViewDelegate>)delegate
{
    self.operators = operators;
    self.delegate = delegate;
    [self.collectionView reloadData];
    
    self.platformalyData = platformalyData;
    
    AuthState authState = platformalyData.authed ? Authed : NotAuthed;
    [self setupAuthState:authState];
}

- (void)setupAuthState:(AuthState)state
{
    if (state == Authed) {
        [self setupAuthedState];
    } else {
        [self setupNotAuthState];
    }
}

- (void)setupAuthedState
{
    self.changeStateButton.hidden = NO;
    [self setupState:PhoneNumber animated:NO];
}

- (void)setupNotAuthState
{
    self.changeTypeButtonWeidthContraint.constant = 0;
    self.changeStateButton.hidden = YES;
    [self layoutIfNeeded];
    [self setupState:Operators animated:NO];
}

- (void)orientationChanged
{
    [self.collectionView reloadData];
    [self setupState:self.state animated:NO];
}

#pragma mark - IBInspectable

- (void)setPlatformalyBackgoundColor:(UIColor *)platformalyBackgoundColor
{
    self.mainView.backgroundColor = platformalyBackgoundColor;
}

- (void)setChangeStateButtonLinesColor:(UIColor *)changeStateButtonLinesColor
{
    self.changeStateButton.lineColor = changeStateButtonLinesColor;
}

- (void)setChangeStateButtonBackgroundColor:(UIColor *)changeStateButtonBackgroundColor
{
    self.changeStateButton.backgroundColor = changeStateButtonBackgroundColor;
}


#pragma mark - UI actions

- (IBAction)changeStateTapped:(id)sender
{
    SelectOperatorViewState state = self.state == Operators ? PhoneNumber : Operators;
    [self setupState:state animated:YES];
}

- (void)setupState:(SelectOperatorViewState)state animated:(BOOL)animated
{
    if (self.operators.count == 0) return;
    
    NSInteger section;
    self.state = state;
    UICollectionViewScrollPosition scrollPosition;
    if (state == Operators) {
        section = operatorSection;
        scrollPosition = UICollectionViewScrollPositionLeft;
        [self.changeStateButton setCurrentModeWithAnimation:JTHamburgerButtonModeArrow];
    } else {
        section = phoneNumberSection;
        scrollPosition = UICollectionViewScrollPositionRight;
        [self.changeStateButton setCurrentModeWithAnimation:JTHamburgerButtonModeHamburger];
    }
    
    NSIndexPath* destinationIndexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    [self.collectionView scrollToItemAtIndexPath:destinationIndexPath atScrollPosition:scrollPosition animated:animated];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numberOfItems = 0;
    switch (section) {
        case phoneNumberSection:
            numberOfItems = self.platformalyData.authed ? 1 : 0;
            break;
        case operatorSection:
            numberOfItems = self.operators.count;
            break;
        default:
            break;
    }
    return numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* identifier = [self identifierFotIndexPath:indexPath];
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}



#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == operatorSection)
    {
        Operator* selectedOperator = self.operators[indexPath.row];
        if (self.delegate && [self.delegate respondsToSelector:@selector(platformalyView:didSelectOperator:)])
            [self.delegate platformalyView:self didSelectOperator:selectedOperator];
    }
    else if (indexPath.section == phoneNumberSection)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(platformalyView:didSelectPlatformalyData:)])
            [self.delegate platformalyView:self didSelectPlatformalyData:self.platformalyData];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeZero;
    if (indexPath.section == phoneNumberSection) {
        size = CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
    } else if (indexPath.section == operatorSection){
        size = CGSizeMake(collectionView.frame.size.width/4, collectionView.frame.size.height);
    }
    return size;
}



#pragma mark - collectionview cell configure

- (NSString*)identifierFotIndexPath:(NSIndexPath*)indexPath
{
    NSString* identifier = @"";
    switch (indexPath.section) {
        case phoneNumberSection:
            identifier = [phoneNumberCellIdentifier copy];
            break;
        case operatorSection:
            identifier = [operatorCellIdentifier copy];
            break;
        default:
            break;
    }
    
    return identifier;
}

- (void)configureCell:(UICollectionViewCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    switch (indexPath.section) {
        case phoneNumberSection:
            [self configurePhoneCell:cell forIndexPath:indexPath];
            break;
        case operatorSection:
            [self configureOperatorCell:cell forIndexPath:indexPath];
            break;
        default:
            break;
    }
}

- (void)configureOperatorCell:(UICollectionViewCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    OperatorCell* operatorCell = (OperatorCell*)cell;
    Operator* operator = self.operators[indexPath.row];
    operatorCell.backgroundColor = self.operatorCellBackgroundColor;
    [operatorCell configureWithOperator:operator];
}

- (void)configurePhoneCell:(UICollectionViewCell*)cell forIndexPath:(NSIndexPath*)indexPath
{
    PhoneNumberCell* phoneCell = (PhoneNumberCell*)cell;
    [phoneCell configureWithPlatformalyData:self.platformalyData];
    phoneCell.phoneLabel.textColor = self.phoneTextColor;
    phoneCell.backgroundColor = self.phoneCellBackgroundColor;
    phoneCell.authByNumberLabel.textColor = self.phoneLabelTextColor;
}



#pragma mark - autoLayout update

- (void) stretchToSuperView:(UIView*) view
{
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *bindings = NSDictionaryOfVariableBindings(view);
    NSString *formatTemplate = @"%@:|[view]|";
    for (NSString * axis in @[@"H",@"V"]) {
        NSString * format = [NSString stringWithFormat:formatTemplate,axis];
        NSArray * constraints = [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:bindings];
        [view.superview addConstraints:constraints];
    }
}

@end
