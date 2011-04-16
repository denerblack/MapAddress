//
//  MapAddressViewController.h
//  MapAddress
//
//  Created by Dener Wilian Pereira do Carmo on 04/04/11.
//  Copyright 2011 Agence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>




@interface MapAddressViewController : UIViewController {
  IBOutlet MKMapView *mapView;
  IBOutlet UISegmentedControl *segmentControlMapType;
  IBOutlet UISearchBar *searchBar;
}

@property(nonatomic,retain) IBOutlet MKMapView *mapView;
@property(nonatomic,retain) IBOutlet UISegmentedControl *segmentControlMapType;
@property(nonatomic,retain) IBOutlet UISearchBar *searchBar;

-(IBAction) changeMapType:(id)sender;
-(void) searchCoordinatesByAddress:(NSString*)address;
-(void) zoomMapAndCenterAtLatitude:(double) latitude andLongitude:(double) longitude;

@end

