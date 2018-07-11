# CustomExtensionKeyboard: 
Custom keyboard using Swift and App extension APIs.

Applications can extend custom functionalities to users when they are using other applications as well from iOS 8 onwards. Custom keyboard is one among them.

Once you run the app, your extensions would be loaded to the device. But you need to add it in Settings as below,
Navigate to Settings > General > Keyboard > Keyboards > Add New Keyboard and select iOS Custom Keyboard. This will add it to the list of available keyboards. Go back to your app and bring up the keyboard by tapping the text view. Tap and hold the globe key and select iOS Custom Keyboard from the list that pops up.

If Custom keyboard extension doesnt show up in the real device, please cross check iOS version of the device & the deployment target version set for the CustomExtensionKeyboard under Targets->General->Deployment Target

### Reference
Project is rewritten in Swift 4.1 referring the below link which was written in Swift 2.x. Appcoda tutorial by Joyce Echessa does gives a very good information on what a keyboard extension can do, what it can't do, and what it should to get approved for the App Store. 
1. https://www.appcoda.com/custom-keyboard-tutorial/
