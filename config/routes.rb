Rails.application.routes.draw do

  # homepage
  get("/", { :controller => "acquisition_criteria", :action => "index" })

  # create connection
  get("/connect/:path_id", { :controller => "messages", :action => "connection" })


  # Routes for the Message resource:

  # CREATE
  post("/insert_message", { :controller => "messages", :action => "create" })
  
  post("/insert_message/:criteria_id/:sender_id", { :controller => "messages", :action => "createThread" })
          
  # READ
  get("/messages", { :controller => "messages", :action => "index" })
  
  get("/messages/:criteria_id/:sender_id", { :controller => "messages", :action => "conversations" })
  
  # UPDATE
  
  post("/modify_message/:path_id", { :controller => "messages", :action => "update" })
  
  # DELETE
  get("/delete_message/:path_id", { :controller => "messages", :action => "destroy" })

  #------------------------------

  # Routes for the View resource:

  # CREATE
  post("/insert_view", { :controller => "views", :action => "create" })
          
  # READ
  get("/views", { :controller => "views", :action => "index" })
  
  get("/views/:path_id", { :controller => "views", :action => "show" })
  
  # UPDATE
  
  post("/modify_view/:path_id", { :controller => "views", :action => "update" })
  
  # DELETE
  get("/delete_view/:path_id", { :controller => "views", :action => "destroy" })

  #------------------------------

  # Routes for the Acquisition criterium resource:

  # CREATE
  post("/insert_acquisition_criterium", { :controller => "acquisition_criteria", :action => "create" })
          
  # READ
  get("/acquisition_criteria", { :controller => "acquisition_criteria", :action => "index" })
  
  get("/acquisition_criteria/:path_id", { :controller => "acquisition_criteria", :action => "show" })
  
  # UPDATE
  
  post("/modify_acquisition_criterium/:path_id", { :controller => "acquisition_criteria", :action => "update" })
  
  # DELETE
  get("/delete_acquisition_criterium/:path_id", { :controller => "acquisition_criteria", :action => "destroy" })

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

end
