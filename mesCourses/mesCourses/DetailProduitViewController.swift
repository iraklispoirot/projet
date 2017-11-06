//
//  DetailProduitViewController.swift
//  mesCourses
//
//  Created by etudiant on 17/10/2017.
//  Copyright © 2017 etudiant. All rights reserved.
//

import UIKit
import AssetsLibrary

class DetailProduitViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    var produit: Produit!
    var urlLienPhoto: URL?
   
    @IBOutlet weak var tfPrix: UITextField!
    @IBOutlet weak var tfNom: UITextField!
    @IBOutlet weak var tfPoids: UITextField!
    @IBOutlet weak var imvPhoto: UIImageView!
    @IBOutlet weak var tvDescription: UITextView!
    
    @IBAction func lienMagasinAction(_ sender: UIButton) {
    // test before sending Segue
       if produit != nil
       {
         performSegue(withIdentifier: "lienMagasinSegue", sender: self)
       }
    }

    @IBAction func photoAction(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
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
        imvPhoto.contentMode = .scaleAspectFit
        imvPhoto.image = selectedImage
        self.dismiss(animated: true)
     
    }


    @IBAction func doneAction(_ sender: Any) {
      if checkFields()
        {
           saveProduitObject()
           performSegue(withIdentifier: "versListeProduitsSegue", sender: self)
        }
        else
        {
            self.present(alert(titre: "Erreur", message: "Dénomination manquante", boutonTitre: "ok"), animated: true, completion: nil)
        }
    }
    
    // https://stackoverflow.com/questions/30330319/try-to-get-a-uiimage-from-asset-library-url
    // https://stackoverflow.com/questions/33871575/get-nsdata-from-assets-library-url
    
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
      let check1 = tfNom.text ?? ""
      return check1 == "" ? false:true
    
     }
    func clearFields()
    {
      tfNom.text         = ""
      tfPrix.text        = ""
      tfPoids.text       = ""
      tvDescription.text = ""
    }
    
    func fillFields()
    {
      if let produit = produit
      {
        tfNom.text         = produit.nom
        tfPrix.text        = "\(produit.prix)"
        tfPoids.text       = "\(produit.poids)"
        tvDescription.text = produit.description
        urlLienPhoto       =  URL(string: produit.lienPhoto)
        if let url = urlLienPhoto
        {
            print("let url:::" + url.absoluteString)
            getUIImagefromAsseturl (url: url)
            // imvPhoto.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "moviePlaceHolder"))
        }

      }
    }

   func saveProduitObject()
   {
    print("saveProduitObjet:::" + ((urlLienPhoto?.absoluteString) ?? "urlLienPhoto vide"))
    if produit == nil
    {
      produit = Produit.init(
            nom: tfNom.text!,
            marque: "", description: tvDescription.text,
            prix: Float(tfPrix.text ?? "")  ?? 0,
            poids: Float(tfPoids.text ?? "") ?? 0,
            lienPhoto: urlLienPhoto?.absoluteString ?? "")
      ProduitDao.addProduit(produit: produit)
    }
    else
    {
      produit.nom            = tfNom.text!
      produit.prix           = Float(tfPrix.text ?? "")  ?? 0
      produit.poids          = Float(tfPoids.text ?? "") ?? 0
      produit.description    = tvDescription.text
      produit.lienPhoto      = urlLienPhoto?.absoluteString ?? ""
    
        // updateDao pas nécessaire
    }

   }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "lienMagasinSegue"
        {
           if let lienMagasinVc = segue.destination as? ListeMagasinsPourLiensTableViewController
           {
             lienMagasinVc.produit = produit
           }
        }
    }
}
