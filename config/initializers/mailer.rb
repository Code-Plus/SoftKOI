ActionMailer::Base.smtp_settings = {
	:address              => "smtp.gmail.com",
	:port                 => 587,
	:user_name            => 'softkoiapp@gmail.com',
	:password             => '123456789jesus',
	:authentication       => 'plain',
	:enable_starttls_auto => true
}
