CarrierWave::SecureFile.configure do |config|
	config.cypher = ("qxJrQcLRxEUltNzEDulYqG7pVYMKhYcpgNZEFADGxlOM5xK2bdyJqYJI")[0..55]
	# Optional: specify the encrpytion_type.  This can be blowfish, rijndael, or gost.
	config.encryption_type = "blowfish"
end
