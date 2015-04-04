//
//  ViewController.m
//  ZoboonTask
//
//  Created by Iman Adly on 3/25/15.
//  Copyright (c) 2015 Iman Adly. All rights reserved.
//

#import "ProductsViewController.h"
#define CELL_IDENTIFIER @"customCell"

@interface ProductsViewController ()
{
    NSInteger pageNumber;
    NSMutableArray * productsArray;

}
@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    productsArray = [[NSMutableArray alloc]init];

    pageNumber = 1;
    //load products by page number
    [self loadProductsDataOfpageNumber:pageNumber];
   
    _productsCollectionView.delegate = self;
    _productsCollectionView.dataSource = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - convert the products dictionary retrieved from webservice to array
-(void)convertProductsDictionarytoArray:(NSMutableArray*)productsArr
{

    for(int i=0 ; i< productsArr.count ; i++)
    {
        Product * productObj = [[Product alloc]init];
        productObj.productImageURL = [[[productsArr objectAtIndex:i] objectForKey:@"image"] objectForKey:@"url"];
        productObj.productLikesCount = [[[productsArr objectAtIndex:i] objectForKey:@"likes_count"] integerValue];
        productObj.productTitle = [[productsArr objectAtIndex:i] objectForKey:@"title"];
        productObj.imageHeight = [[[[productsArr objectAtIndex:i] objectForKey:@"image"] objectForKey:@"height"] floatValue];
        [productsArray addObject:productObj];
        
    }
    [_productsCollectionView reloadData];
}

#pragma mark - Collectionview methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return productsArray.count ;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductCollectionViewCell *cell =
    (ProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                           forIndexPath:indexPath];
    
    
     Product * product = [productsArray objectAtIndex:indexPath.row];
    [cell.productImageView sd_setImageWithURL:[NSURL URLWithString:product.productImageURL]
                      placeholderImage:[UIImage imageNamed:@"zoboon.jpeg"]];
    cell.productTitle.text = product.productTitle;
    

    cell.productNumberOfLikesLabel.text = [NSString stringWithFormat:@"%ld Likes",(long)product.productLikesCount];
 
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(ProductsCollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Product * product = [productsArray objectAtIndex:indexPath.row];
    return CGSizeMake(self.view.frame.size.width - 5, product.imageHeight);
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height)
    {
        pageNumber ++;
       [self loadProductsDataOfpageNumber:pageNumber];
        
        _activityIndicator.hidden = NO;

    }

}

#pragma mark - load data

-(void)loadProductsDataOfpageNumber:(NSInteger)pageNum
{
    [[ConnectUsingAFNetworking sharedInstance] getProductsFromUrl:KProducts page:pageNum onCompletion:^(NSMutableArray *returnResponse) {
        
        [self convertProductsDictionarytoArray:returnResponse];
        _activityIndicator.hidden = YES;

    }];
}



@end
