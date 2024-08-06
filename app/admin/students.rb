ActiveAdmin.register Student do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :date_of_birth, :address, :verified, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :date_of_birth, :address, :verified, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :date_of_birth
    column :address
    column :verified
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :address
      f.input :date_of_birth
      f.input :verified
    end
    f.actions
  end

  collection_action :import, method: :get do
    # Render an import form
    render 'admin/students/import'
  end

  collection_action :import_csv, method: :post do
    if params[:file].present?
      error = Student.import_csv(params[:file])
      if error.present?
        redirect_to collection_path, alert: error
      else
        redirect_to collection_path, notice: "Students imported successfully."
      end
    else
      redirect_to collection_path, alert: "Please upload a file."
    end
  end

  # Customize the sidebar to include the import link
  action_item :import_csv, only: :index do
     link_to 'Import CSV', :action => 'import'
  end
end
