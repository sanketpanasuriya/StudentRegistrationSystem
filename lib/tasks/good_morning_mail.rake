task :good_morning_mail => :environment do
  Student.where(verified: true).each do |student|
    StudentMailer.good_morning_mail(student).deliver_now
  end
end
