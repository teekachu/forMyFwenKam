//
//  DetailViewController.swift
//  Project16
//
//  Created by meekam okeke on 11/18/20.
//

import UIKit
import MapKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate, MKMapViewDelegate {
    
    var webView: WKWebView!
    //    var mapView: MKMapView!
    var selectedCityName: String?
    
    
    /// everything in your loadview can be moved to viewDidLoad.
    //    override func loadView() {
    //        webView = WKWebView()
    //        webView.navigationDelegate = self
    //        view = webView
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// The url for wikipedia page of London is below: https://en.wikipedia.org/wiki/London
        /// So we can put this in a constant and use it to load the different capitals.
        let wikiPageHeader = "https://en.wikipedia.org/wiki/"
        
        /// putting the title as the selectedCity's name for user feedback
        title = selectedCityName
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        
        /// i am not sure what this is
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(webView.goBack))
        
        if let selectedCity = selectedCityName {
            if let url = URL(string: wikiPageHeader + "\(selectedCity)") {
                
                /// load the url
                webView.load(URLRequest(url: url))
                
                /// i think this is what you are trying to do in the navigation button to go back ?
                webView.allowsBackForwardNavigationGestures = true
            }
        }
        
        
        /// you don't need this, see how to load url above. 
        //    func openPage(action: UIAlertAction){
        //        guard let actionTitle = action.title else {return}
        //        guard let url = URL(string: "https://" + actionTitle) else{
        //            return
        //        }
        //        webView.load(URLRequest(url: url))
        //    }
        
        
        /// you can just do this in viewDidLoad
        //    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //        title = webView.title
        //    }
    }

}
