
import UIKit
import SDWebImage
import MobileCoreServices
import Alamofire

class EditUserProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imguser: UIImageView!
    var img = UIImage()
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var mobilenumber: UITextField!
    @IBOutlet weak var username: UITextField!
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imguser.sd_setImage(with: URL(string: D_Get_LoginData?.data?.image ?? ""), completed: nil)
        self.firstname.text = D_Get_LoginData?.data?.first_name
        self.lastname.text = D_Get_LoginData?.data?.last_name
        self.mobilenumber.text = D_Get_LoginData?.data?.phone
        self.username.text = D_Get_LoginData?.data?.username
        if self.imguser.image == nil {
            self.imguser.image = UIImage(named: "dummy.jpg")
        }
        self.img = self.imguser.image!
//         myImageUploadRequest()
    }
    func postupadte() {
        myImageUploadRequest()
    }
    @IBAction func addimg(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    //MARK: - Choose image from camera roll
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func submitbtn(_ sender: Any) {
        postupadte()
    }
    @IBAction func bckbtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let editedImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.editedImage.rawValue)] as? UIImage{
            self.img = editedImage
            self.imguser.image = editedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    func myImageUploadRequest() {
       // let myUrl = NSURL(string:  APIList.shared.updateProfile);
        let myUrl = NSURL(string:  "http://52.66.253.186/ballerspotapi/index.php/webapi/app/profileupdate");

        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        var dict = [String:String]()
        dict["user_id"] = "\(D_Get_LoginData?.data?.id ?? "")"
        dict["first_name"] = self.firstname.text
        dict["last_name"] = self.lastname.text
        dict["mobile"] = self.mobilenumber.text
        dict["username"] = self.username.text
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData = self.img.jpegData(compressionQuality: 1)
        if imageData == nil  {
            return
        }
        request.httpBody = createBodyWithParameters(parameters: dict, filePathKey: "image", imageDataKey: imageData! as NSData, boundary: boundary, imgKey: "image") as Data
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error != nil {
                print("error=\(error!)")
                return
            }
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("response data = \(responseString!)")
            do{
                let jsondata = try JSONSerialization.jsonObject(with: data! as Data, options: [])as! NSDictionary
                if jsondata["status"] as! String == "error"{
                    DispatchQueue.main.async {
        BallerSpotSingleton.sharedInstance.showAlert(title: BallerSpotSingleton.sharedInstance.appName, msg: "\(jsondata["message"] as! String)", VC: self, cancel_action: false)
                    }}
                if jsondata["status"] as! String == "Success"{
                    DispatchQueue.main.async {
                   let data1 = jsondata["data"] as! [String: Any]
                     D_Save_LoginData =  LoginDataDict.init(data:  LoginModel.init(email: (data1["email"] as! String), id: (data1["id"] as! String), message: "test", name: (data1["first_name"] as! String), phone: (data1["phone"] as! String), pin: "", status: "status", pool_amount: (data1["pool_amount"] as! String), first_name: (data1["first_name"] as! String), ranking: "", image: (data1["image"] as! String), last_name: (data1["last_name"] as! String),username: (data1["username"] as! String)))
                         self.navigationController?.popViewController(animated: true)
                     }
                  }
              
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String, imgKey: String) -> NSData {
        let body = NSMutableData();
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        let filename = "\(imgKey).jpg"
        let mimetype = "image/jpg"
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        body.appendString(string: "--\(boundary)--\r\n")
        return body
    }
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}
extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

