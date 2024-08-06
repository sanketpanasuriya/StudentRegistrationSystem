class StudentMailer < ApplicationMailer
  def student_details_verified_mail(student)
    @student = student
    mail(to: @student.email, subject: 'Your Account has been verified')
  end

  def created_by_admin(student)
    @student = student
    mail(to: @student.email, subject: 'Your Account has been created by Admin')
  end

  def new_student_registered_mail(student)
    emails = AdminUser.pluck(:email)
    @student = student
    mail(to: emails, subject: 'Student has been created')
  end

  def good_morning_mail(student)
    @student = student
    mail(to: @student.email, subject: 'Good Morning!')
  end

  def birthday_mail(student)
    @student = student
    mail(to: @student.email, subject: 'HaPpY BiRtHdAy!!')
  end
end
