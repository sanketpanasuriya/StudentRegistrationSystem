task :good_morning_mail => :environment do
  Student.where(date_of_birth: Date.today).each do |student|
    StudentMailer.birthday_mail(student).deliver_now
  end
end
