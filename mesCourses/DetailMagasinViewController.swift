//
//  DetailMagasinViewController.swift
//  
//
//  Created by etudiant on 17/10/2017.
//
//

import UIKit
import AssetsLibrary

class DetailMagasinViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    var magasin: Magasin!
    var urlLienPhoto: URL?
    
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    @IBOutlet weak var tfNomMagasin: UITextField!
    @IBOutlet weak var tfAdresse: UITextField!
    @IBOutlet weak var tfLongitude: UITextField!
    @IBOutlet weak var tfLatitude: UITextField!
    @IBOutlet weak var imvPhoto: UIImageView!
    @IBOutlet weak var tvDescription: UITextView!

    @IBAction func lienProduitAction(_ sender: UIButton) {
       if magasin != nil
       {
        performSegue(withIdentifier: "lienProduitSegue", sender: self)
       }
    }
    
    @IBAction func photoAction(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        //pop-up
        let alertControl = UIAlertController()
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel){ (alertAction) in }
        
        alertControl.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            
            let cameraAction = UIAlertAction(title: "camera", style: .default, handler: { (_) in  imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)})
            alertControl.addAction(cameraAction)
            
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            
            let photoLibraryAction = UIAlertAction(title: "photo library", style: .default, handler: { (_) in  imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)})
            alertControl.addAction(photoLibraryAction)
            
        }
        present(alertControl, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            
            return
        }
        
        urlLienPhoto         = info[UIImagePickerControllerReferenceURL] as? URL
        print("urlienphoto:::" + urlLienPhoto!.absoluteString)
        imvPhoto.contentMode = .scaleAspectFit
        imvPhoto.image = selectedImage
        self.dismiss(animated: true)
    }

    @IBAction func doneAction(_ sender: Any) {
     
      if checkFields()
       {
         SaveMagasinObject()
         performSegue(withIdentifier: "versListeMagasinSegue", sender: self)
       }
      else
       {
         self.present(alert(titre: "Erreur", message: "Dénomination manquante", boutonTitre: "ok"), animated: true, completion: nil)
       }
    }
    
    func getUIImagefromAsseturl (url: URL) {
        let asset = ALAssetsLibrary()
        asset.asset(for: url as URL!, resultBlock: { asset in
            if let ast = asset {
                let assetRep = ast.defaultRepresentation()
                let iref = assetRep?.fullResolutionImage().takeUnretainedValue()
                let image = UIImage(cgImage: iref!)
                DispatchQueue.main.async(execute: {
                    self.imvPhoto.image = image
                })
            }
        }, failureBlock: { error in
            print("Error: \(String(describing: error))")
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        clearFields()
        fillFields()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func checkFields() -> Bool
    {
        let check1 = tfNomMagasin.text ?? ""
        return check1 == "" ? false:true
        
    }
    func clearFields()
    {
        tfNomMagasin.text = ""
        tfAdresse.text    = ""
        tfLongitude.text  = ""
        tfLatitude.text   = ""
        tvDescription.text = ""
    }
    
    func SaveMagasinObject()
    {
        if magasin == nil
        {
          magasin = Magasin.init(
            nom: tfNomMagasin.text!, adresse: tfAdresse.text ?? "", description: tvDescription.text ?? "", pos_latitude: Float.init(tfLatitude.text ?? "") ?? 0, pos_longitude: Float.init(tfLongitude.text ?? "") ?? 0, lienPhoto: urlLienPhoto?.absoluteString ?? ""
            )
          MagasinDao.addMagasin(magasin: magasin)
        }
        else
        {
          magasin.nom            = tfNomMagasin.text!
          magasin.adresse        = tfAdresse.text ?? ""
          magasin.pos_longitude  = Float.init(tfLongitude.text ?? "") ?? 0
          magasin.pos_latitude   = Float.init(tfLatitude.text ?? "") ?? 0
          magasin.description    = tvDescription.text ?? ""
          magasin.lienPhoto      = urlLienPhoto?.absoluteString ?? ""
          // updateDao pas nécessaire
        }
    }
    func fillFields()
    {
      if let magasin = magasin
      {
        tfNomMagasin.text = magasin.nom
        tfAdresse.text    = magasin.adresse
        tfLongitude.text  = "\(magasin.pos_longitude)"
        tfLatitude.text   = "\(magasin.pos_latitude)"
        urlLienPhoto      = URL(string: magasin.lienPhoto)
        print("magasin lien photo:::" + magasin.lienPhoto)
        if let url = urlLienPhoto
        {
          print("let url:::" + url.absoluteString)
          getUIImagefromAsseturl(url: urlLienPhoto!)
          // imvPhoto.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "moviePlaceHolder"))
        }
        
        tvDescription.text = magasin.description
      }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "lienProduitSegue"
        {
            if let lienProduitVc = segue.destination as? ListeProduitsPourLiensTableViewController
            {
                lienProduitVc.magasin = magasin
            }
        }
     }
    @IBAction func unwindFromCarteMagasins(segue: UIStoryboardSegue)
    {
        if let vc = segue.source as? FindMagasinViewController {
           tfNomMagasin.text =  vc.selectedMagasinNameLabel.text
           tfAdresse.text    =  vc.selectedMagasinAdressLabel.text
        }
        
    }
}
