class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :email, uniqueness: true

  after_create :new_student_registered
  after_save :details_verified, if: :saved_change_to_verified?


  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "date_of_birth", "email", "encrypted_password", "id", "id_value", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at", "verified"]
  end

  def self.import_csv(file)
    ActiveRecord::Base.transaction do
      CSV.foreach(file.path, headers: true) do |row|
        student = Student.find_or_initialize_by(email: row["email"] || row["Email"])
        student.name =  row["name"] || row["Name"]
        student.address = row["address"] || row["Address"]
        student.password = row["password"] || row['Password'] if row["password"].present? || row['Password'].present?
        student.date_of_birth = row["date_of_birth"] || row['Date of birth']
        student.save!
        StudentMailer.created_by_admin(student).deliver_now if student.save
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    # Handle any validation errors or exceptions here
    "Transaction failed: #{e.message}"
  end

  def details_verified
    StudentMailer.student_details_verified_mail(self).deliver_now if self.verified?
  end

  def new_student_registered
    StudentMailer.new_student_registered_mail(self).deliver_now
  end

end
