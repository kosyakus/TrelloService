//
//  LoginViewController.swift
//  KRTestTask
//
//  Created by Admin on 22.11.2017.
//  Copyright © 2017 NS. All rights reserved.
//

import UIKit
import OAuthSwift
import Alamofire

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.doOAuthTrello()
        //self.someAuth()
    }
    
  
    
    
    
    
    // oauth swift object (retain)
    var oauthswift: OAuthSwift?
    
    // MARK: Trello
    func doOAuthTrello() {
        let oauthswift = OAuth1Swift(
            consumerKey:    "4be5ef10a4d5a83d6c5d04c5a2f19450",
            consumerSecret: "0309112d1564ffe3fae8fb59104aa2c5850643f16847a8f8c081aa3e8825fedb",
            requestTokenUrl: "https://trello.com/1/OAuthGetRequestToken?scope=read,write,account&expiration=never&name=KRTestTask",
            authorizeUrl:    "https://trello.com/1/OAuthAuthorizeToken?scope=read,write,account&expiration=never&name=KRTestTask",
            accessTokenUrl:  "https://trello.com/1/OAuthGetAccessToken?scope=read,write,account&expiration=never&name=KRTestTask"
        )
        
        //self.oauthswift = oauthswift
        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: "NS.KRTestTask://oauth-callback/trello")!,
            success: { credential, response, parameters in
                //self.showTokenAlert(name: serviceParameters["name"], credential: credential)
                self.testTrello(oauthswift)
                print(credential.oauthToken)
                
                print(credential.oauthTokenSecret)
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)//главный сториборд
                let BoardsTableViewController = mainStoryboard.instantiateViewController(withIdentifier: "BoardsTableViewController")
                self.present(BoardsTableViewController, animated: true, completion: nil)
                print("You passed to Boards!")
                
        },
            failure: { error in
                print(error.localizedDescription, terminator: "")
        }
        )
        
    }
    
    func testTrello(_ oauthswift: OAuth1Swift) {
        let _ = oauthswift.client.get(
            "https://trello.com/1/members/me/boards",
            success: { response in
                let dataString = response.string!
                print(dataString)
        }, failure: { error in
            print(error)
        }
        )
    }
 
}







// JUST for me to practice with OAuth:
let loginUrl = "https://trello.com/1/authorize?expiration=never&name=KRTestTask&key=4be5ef10a4d5a83d6c5d04c5a2f19450"


/*
 /*  func doOauth() {
 // create an instance and retain it
 let oauthswift = OAuth1Swift(
 consumerKey:    "4be5ef10a4d5a83d6c5d04c5a2f19450",
 consumerSecret: "0309112d1564ffe3fae8fb59104aa2c5850643f16847a8f8c081aa3e8825fedb",
 requestTokenUrl: "https://trello.com/1/OAuthGetRequestToken?scope=read,write,account&expiration=never&name=KRTestTask",
 authorizeUrl:    "https://trello.com/1/OAuthAuthorizeToken?scope=read,write,account&expiration=never&name=KRTestTask",
 accessTokenUrl:  "https://trello.com/1/OAuthGetAccessToken?scope=read,write,account&expiration=never&name=KRTestTask"
 )
 // authorize
 self.oauthswift = oauthswift
 //oauthswift.authorizeURLHandler = getURLHandler()
 //oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
 //self.oauthswift = oauthswift
 oauthswift.authorize(
 withCallbackURL: URL(string: "oauth-swift://oauth-callback/trello")!,
 success: { credential, response, parameters in
 print(credential.oauthToken)
 print(credential.oauthTokenSecret)
 //print(parameters["user_id"])
 // Do your request
 
 },
 failure: { error in
 print(error.localizedDescription)
 }
 )
 
 
 }*/
 
 
 
 
 
 func doLogin() {
 
 let oauthswift = OAuth2Swift(
 consumerKey:    "4be5ef10a4d5a83d6c5d04c5a2f19450",
 consumerSecret: "0309112d1564ffe3fae8fb59104aa2c5850643f16847a8f8c081aa3e8825fedb",
 authorizeUrl:    "https://trello.com/1/OAuthAuthorizeToken",
 accessTokenUrl:  "https://trello.com/1/OAuthGetAccessToken",
 responseType: "code"
 )
 
 let state = generateState(withLength: 20)
 
 self.oauthswift = oauthswift
 //oauthswift.authorizeURLHandler = getURLHandler()
 
 oauthswift.authorize(
 withCallbackURL: URL(string: "oauth-swift://oauth-callback/trello")!,
 scope: "profile",
 state: state,
 success: { credential, response, parameters in
 print(credential.oauthToken)
 },
 failure: { error in
 print(error.localizedDescription)
 }
 )
 }
 
 func sendLoginAndPass() {
 
 let user = loginTextField.text!
 let password = passwordTextField.text!
 
 Alamofire.request("https://trello.com/1/client.js?key=a4be5ef10a4d5a83d6c5d04c5a2f19450")
 .authenticate(user: user, password: password)
 .responseJSON { response in
 debugPrint(response)
 }
 
 }
 
 
 
 
 
 
 
 
 
 //Initialize auth session
 func someAuth() {
 //Typedef block to handle response
 let handler:SFAuthenticationSession.CompletionHandler = { (callBack:URL?, error:Error? ) in
 guard error == nil, let successURL = callBack else {
 return
 }
 
 let oauthToken = NSURLComponents(string: (successURL.absoluteString))?.queryItems?.filter({$0.name == "oauth_token"}).first
 // Do what you now that you've got the token, or use the callBack URL
 print("\(String(describing: oauthToken))")
 }
 //OAuth Provider URL
 let authURL = NSURL(string: "https://trello.com/1/authorize?expiration=never&key=4be5ef10a4d5a83d6c5d04c5a2f19450")
 let authSession = SFAuthenticationSession(url: authURL! as URL, callbackURLScheme: nil, completionHandler: handler)
 
 //Kick it off
 authSession.start()
 }
 
 
func showAlertView(title: String, message: String) {
    #if os(iOS)
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    #elseif os(OSX)
        let alert = NSAlert()
        alert.messageText = title
        alert.informativeText = message
        alert.addButton(withTitle: "Close")
        alert.runModal()
    #endif
}

func showTokenAlert(name: String?, credential: OAuthSwiftCredential) {
    var message = "oauth_token:\(credential.oauthToken)"
    if !credential.oauthTokenSecret.isEmpty {
        message += "\n\noauth_toke_secret:\(credential.oauthTokenSecret)"
    }
    self.showAlertView(title: name ?? "Service", message: message)
    
    if let service = name {
        //services.updateService(service, dico: ["authentified":"1"])
        // TODO refresh graphic
    }
}

 // MARK: handler
 let formData = Semaphore<FormViewControllerData>()
 lazy var internalWebViewController: WebViewController = {
 let controller = WebViewController()
 #if os(OSX)
 controller.view = NSView(frame: NSRect(x:0, y:0, width: 450, height: 500)) // needed if no nib or not loaded from storyboard
 #elseif os(iOS)
 controller.view = UIView(frame: UIScreen.main.bounds) // needed if no nib or not loaded from storyboard
 #endif
 controller.delegate = self
 controller.viewDidLoad() // allow WebViewController to use this ViewController as parent to be presented
 return controller
 }()
 
 func getURLHandler() -> OAuthSwiftURLHandlerType {
 guard let type = self.formData.data?.handlerType else {
 return OAuthSwiftOpenURLExternally.sharedInstance
 }
 switch type {
 case .external :
 return OAuthSwiftOpenURLExternally.sharedInstance
 case .`internal`:
 if internalWebViewController.parent == nil {
 self.addChildViewController(internalWebViewController)
 }
 return internalWebViewController
 case .safari:
 #if os(iOS)
 if #available(iOS 9.0, *) {
 let handler = SafariURLHandler(viewController: self, oauthSwift: self.oauthswift!)
 handler.presentCompletion = {
 print("Safari presented")
 }
 handler.dismissCompletion = {
 print("Safari dismissed")
 }
 return handler
 }
 #endif
 return OAuthSwiftOpenURLExternally.sharedInstance
 }
 
 #if os(OSX)
 // a better way is
 // - to make this ViewController implement OAuthSwiftURLHandlerType and assigned in oauthswift object
 /* return self */
 // - have an instance of WebViewController here (I) or a segue name to launch (S)
 // - in handle(url)
 //    (I) : affect url to WebViewController, and  self.presentViewControllerAsModalWindow(self.webViewController)
 //    (S) : affect url to a temp variable (ex: urlForWebView), then perform segue
 /* performSegueWithIdentifier("oauthwebview", sender:nil) */
 //         then override prepareForSegue() to affect url to destination controller WebViewController
 
 #endif
 }
 
 
 
 // include whatever version of jquery you want to use first
 //<script src="https://api.trello.com/1/client.js?key=[your application key]" type="text/javascript"></script>
 // call this whenever you want to make sure Trello is authenticated, and get a key.
 // USE with js script
 func AuthenticateTrello() {
 Trello.authorize({
 name: "your project name",
 type: "popup",
 interactive: true,
 expiration: "never",
 success: function () { onAuthorizeSuccessful(); },
 error: function () { onFailedAuthorization(); },
 scope: { write: true, read: true },
 });
 }
 
 func onAuthorizeSuccessful() {
 var token = Trello.token();
 // whatever you want to do with your token.
 // if you can do everything client-side, there are other wrapper functions
 // so you never need to use the token directly if you don't want to.
 }
 
 func onFailedAuthorization() {
 // whatever
 }
 
 
 
 
*/
